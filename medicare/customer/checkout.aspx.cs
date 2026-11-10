using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.customer
{
    public partial class checkout : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customer"] == null && Session["admin"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                getCon();
                loadCustomerAddress();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        int getCustomerId()
        {
            if (Session["customerId"] != null)
            {
                int cid = 0;
                if (int.TryParse(Session["customerId"].ToString(), out cid)) return cid;
            }
            if (Session["customer"] != null)
            {
                getCon();
                cmd = new SqlCommand("SELECT Id FROM regi_tbl WHERE Email='" + Session["customer"] + "'", con);
                object oId = cmd.ExecuteScalar();
                if (oId != null) return Convert.ToInt32(oId);
            }
            return 1;
        }

        void loadCustomerAddress()
        {
            try
            {
                getCon();
                string email = (Session["customer"] ?? "").ToString();
                da = new SqlDataAdapter("SELECT * FROM regi_tbl WHERE Email='" + email + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow r = ds.Tables[0].Rows[0];
                    txtShipName.Text = (r["FirstName"] + " " + r["LastName"]).Trim();
                    txtShipPhone.Text = r["Phone"].ToString();
                    txtShipAddr1.Text = r["Address"] != DBNull.Value ? r["Address"].ToString() : "";
                }
            }
            catch { }
        }

        protected void btnSaveShipAddress_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                string email = (Session["customer"] ?? "").ToString();
                string fullAddr = (txtShipAddr1.Text + " " + txtShipAddr2.Text + " " + txtShipCity.Text + " " + txtShipState.Text + " " + txtShipPin.Text).Trim();
                cmd = new SqlCommand("UPDATE regi_tbl SET Address='" + fullAddr + "' WHERE Email='" + email + "'", con);
                cmd.ExecuteNonQuery();
                ClientScript.RegisterStartupScript(GetType(), "addrSaved", "showToast('Address saved successfully!','success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "addrErr", "showToast('Error saving address: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                int custId = getCustomerId();
                string email = (Session["customer"] ?? "").ToString();

                string fullName = txtShipName.Text.Trim();
                if (string.IsNullOrEmpty(fullName))
                {
                    cmd = new SqlCommand("SELECT FirstName + ' ' + LastName FROM regi_tbl WHERE Id='" + custId + "'", con);
                    object fn = cmd.ExecuteScalar();
                    fullName = fn != null ? fn.ToString().Trim() : "Customer";
                }

                // Calculate subtotal from Cart table
                da = new SqlDataAdapter(
                    "SELECT c.Quantity, m.Price FROM Cart c " +
                    "JOIN medicines_tbl m ON c.MedicineID = m.MedicineID " +
                    "WHERE c.CustomerID='" + custId + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                decimal subtotal = 0;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        int q = Convert.ToInt32(row["Quantity"]);
                        decimal p = Convert.ToDecimal(row["Price"]);
                        subtotal += (q * p);
                    }
                }
                if (subtotal <= 0)
                {
                    subtotal = 300.00m; // Default minimum if cart was processed in browser
                }

                decimal gst = Math.Round(subtotal * 0.18m, 2);
                decimal totalAmount = subtotal + gst;

                string orderCode = "ORD-" + DateTime.Now.ToString("yyyyMMdd") + new Random().Next(1000, 9999).ToString();
                string paymentMethod = rblPaymentMethod.SelectedValue;
                string notes = ("Delivery: " + txtShipAddr1.Text + " " + txtShipCity.Text).Trim();

                cmd = new SqlCommand(
                    "INSERT INTO Orders (OrderCode, CustomerID, FullName, TotalAmount, Status, PaymentStatus, Notes, OrderDate, CreatedAt) " +
                    "VALUES ('" + orderCode + "', '" + custId + "', '" + fullName + "', '" + totalAmount + "', 'Pending', '" + paymentMethod + "', '" + notes + "', GETDATE(), GETDATE())", con);
                cmd.ExecuteNonQuery();

                // If prescription file uploaded, save and insert into prescriptions_tbl
                if (rxFile.HasFile)
                {
                    try
                    {
                        string fileName = Path.GetFileName(rxFile.FileName);
                        string saveDir = Server.MapPath("~/m_images/");
                        if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
                        string savedPath = Path.Combine(saveDir, fileName);
                        rxFile.SaveAs(savedPath);

                        string rxCode = "RX-" + DateTime.Now.ToString("yyyyMMdd") + new Random().Next(100, 999).ToString();
                        cmd = new SqlCommand(
                            "INSERT INTO prescriptions_tbl (PrescriptionCode, CustomerID, DoctorName, Status, Notes, CreatedAt) " +
                            "VALUES ('" + rxCode + "', '" + custId + "', 'Self-Uploaded', 'Pending', 'Prescription for order " + orderCode + " (" + fileName + ")', GETDATE())", con);
                        cmd.ExecuteNonQuery();
                    }
                    catch { }
                }

                // Clear items from Cart
                cmd = new SqlCommand("DELETE FROM Cart WHERE CustomerID='" + custId + "'", con);
                cmd.ExecuteNonQuery();

                lblOrderCodeConfirm.Text = "#" + orderCode;
                ClientScript.RegisterStartupScript(GetType(), "orderPlaced",
                    "if (window.Cart) Cart.save([]); new bootstrap.Modal(document.getElementById('orderModal')).show();", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "orderErr",
                    "alert('Could not place order: " + ex.Message.Replace("'", "") + "');", true);
            }
        }
    }
}

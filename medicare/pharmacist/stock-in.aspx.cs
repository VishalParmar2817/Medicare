using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class stockIn : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["pharmacist"] != null)
            {
                getCon();
                if (!IsPostBack)
                {
                    txtStockInReceivedDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    fillDropdowns();
                    fillgrid();
                   
                }
            }
            else
            {
                Response.Redirect("~/customer/login.aspx");
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillDropdowns()
        {
            getCon();
            // Medicines
            da = new SqlDataAdapter("SELECT MedicineID, Name FROM medicines_tbl WHERE Status='Active' ORDER BY Name", con);
            DataTable dtMeds = new DataTable();
            da.Fill(dtMeds);
            ddlStockInMed.Items.Clear();
            ddlStockInMed.Items.Add(new ListItem("-- Select Medicine --", ""));
            foreach (DataRow row in dtMeds.Rows)
            {
                ddlStockInMed.Items.Add(new ListItem(row["Name"].ToString(), row["MedicineID"].ToString()));
            }

            // Suppliers
            da = new SqlDataAdapter("SELECT SupplierID, CompanyName FROM suppliers_tbl WHERE Status='Active' ORDER BY CompanyName", con);
            DataTable dtSups = new DataTable();
            da.Fill(dtSups);
            ddlStockInSupplier.Items.Clear();
            ddlStockInSupplier.Items.Add(new ListItem("-- Select Supplier --", ""));
            foreach (DataRow row in dtSups.Rows)
            {
                ddlStockInSupplier.Items.Add(new ListItem(row["CompanyName"].ToString(), row["SupplierID"].ToString()));
            }
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT TOP 10 si.*, m.Name , ISNULL(s.CompanyName, 'Direct') AS SupplierName FROM stockin_tbl si JOIN medicines_tbl m ON si.MedicineID = m.MedicineID LEFT JOIN suppliers_tbl s ON si.SupplierID = s.SupplierID ", con);
            ds = new DataSet();
            da.Fill(ds);
            gvStockIn.DataSource = ds;
            gvStockIn.DataBind();
        }



        protected void btnStockInSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlStockInMed.SelectedValue) || string.IsNullOrEmpty(txtStockInQty.Text))
            {
                ClientScript.RegisterStartupScript(GetType(), "err", "showToast('Please select medicine and quantity','warning');", true);
                return;
            }

            getCon();
            int medId = Convert.ToInt32(ddlStockInMed.SelectedValue);
            int supId = string.IsNullOrEmpty(ddlStockInSupplier.SelectedValue) ? 0 : Convert.ToInt32(ddlStockInSupplier.SelectedValue);
            int qty = Convert.ToInt32(txtStockInQty.Text);
            decimal price = 0;
            decimal.TryParse(txtStockInPrice.Text, out price);

            string batch = txtStockInBatch.Text.Trim();
            string expiry = txtStockInExpiry.Text;
            string rcvDate = string.IsNullOrEmpty(txtStockInReceivedDate.Text) ? DateTime.Now.ToString("yyyy-MM-dd") : txtStockInReceivedDate.Text;
            string notes = txtStockInNotes.Text;

            // Insert into StockIn
            string sqlInsert = "INSERT INTO stockin_tbl (MedicineID, SupplierID, BatchNumber, Quantity, PurchasePrice, ExpiryDate, ReceivedDate, Notes) VALUES ('" + medId + "','" + supId + "','" + batch + "','" + qty + "','" + price + "','" + expiry + "','" + rcvDate + "','" + notes + "');";

            // Update Medicine Stock
            string sqlUpdate = "UPDATE medicines_tbl SET Stock = Stock + " + qty + " WHERE MedicineID='" + medId + "';";

            // Optional insert into MedicineBatches if batch & expiry provided
            string sqlBatch = "";
            if (!string.IsNullOrEmpty(batch) && !string.IsNullOrEmpty(expiry))
            {
                sqlBatch = "INSERT INTO medicinebatches_tbl (MedicineID, BatchNumber, Quantity, PurchasePrice, ExpiryDate, Status) VALUES ('" + medId + "','" + batch + "','" + qty + "','" + price + "','" + expiry + "','Active');";
            }

            cmd = new SqlCommand(sqlInsert + sqlUpdate + sqlBatch, con);
            cmd.ExecuteNonQuery();

            // Clear inputs
            txtStockInBatch.Text = "";
            txtStockInQty.Text = "";
            txtStockInPrice.Text = "";
            txtStockInNotes.Text = "";

            fillgrid();
         

            ClientScript.RegisterStartupScript(GetType(), "success", "showToast('Stock received and updated successfully!','success');", true);
        }
    }
}
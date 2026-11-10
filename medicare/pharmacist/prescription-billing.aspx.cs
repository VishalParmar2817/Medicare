using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class prescriptionBilling : System.Web.UI.Page
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

        void fillgrid()
        {
            getCon();
            string sql = @"
                SELECT p.PrescriptionID, p.PrescriptionCode, p.DoctorName, p.Status, p.CreatedAt,
                       ISNULL((r.FirstName + ' ' + r.LastName), 'Customer') AS CustomerName
                FROM prescriptions_tbl p
                LEFT JOIN regi_tbl r ON p.CustomerID = r.Id
                WHERE p.Status IN ('Pending', 'Approved', 'Under Review')
                ORDER BY p.PrescriptionID DESC";

            da = new SqlDataAdapter(sql, con);
            ds = new DataSet();
            da.Fill(ds);
            gvPrescriptions.DataSource = ds;
            gvPrescriptions.DataBind();
        }

        protected void gvPrescriptions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_select")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                getCon();
                da = new SqlDataAdapter("SELECT p.*, ISNULL((r.FirstName + ' ' + r.LastName), 'Customer') AS CustomerName, ISNULL(r.Phone, '—') AS PhoneNumber FROM prescriptions_tbl p LEFT JOIN regi_tbl r ON p.CustomerID = r.Id WHERE p.PrescriptionID='" + id + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].Rows[0];
                    string code = dr["PrescriptionCode"] != DBNull.Value ? dr["PrescriptionCode"].ToString() : ("#RX-" + id);
                    string cust = dr["CustomerName"].ToString();
                    string phone = dr["PhoneNumber"].ToString();
                    string doc = dr["DoctorName"] != DBNull.Value ? dr["DoctorName"].ToString() : "Dr. S. Mehta";

                    ClientScript.RegisterStartupScript(GetType(), "selectRx",
                        "document.getElementById('activeRxTitle').textContent = 'Prescription: " + code + "';" +
                        "document.getElementById('rxDetailsBox').innerHTML = '<div class=\"p-3 bg-light rounded\"><h6>" + cust + " (" + phone + ")</h6><p class=\"mb-1\">Prescribed by: " + doc + "</p><span class=\"badge bg-primary\">Ready for Billing</span></div>';", true);
                }
            }
        }

        protected void btnApproveCurrentRx_Click(object sender, EventArgs e)
        {
            if (ViewState["Id"] == null)
            {
                ClientScript.RegisterStartupScript(GetType(), "warn", "showToast('Please select a prescription first!','warning');", true);
                return;
            }

            getCon();
            cmd = new SqlCommand("UPDATE prescriptions_tbl SET Status='Approved', VerifiedAt=GETDATE() WHERE PrescriptionID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
            ClientScript.RegisterStartupScript(GetType(), "approved", "showToast('Prescription approved!','success');", true);
        }

        protected void btnRejectRx_Click(object sender, EventArgs e)
        {
            if (ViewState["Id"] == null)
            {
                ClientScript.RegisterStartupScript(GetType(), "warn", "showToast('Please select a prescription first!','warning');", true);
                return;
            }

            getCon();
            string reason = rejectReason.SelectedValue + ": " + txtRejectNotes.Text.Trim();
            cmd = new SqlCommand("UPDATE prescriptions_tbl SET Status='Rejected', Notes='" + reason + "' WHERE PrescriptionID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
            ClientScript.RegisterStartupScript(GetType(), "rejected", "showToast('Prescription rejected.','danger');", true);
        }

        protected void btnFinalizeBill_Click(object sender, EventArgs e)
        {
            if (ViewState["Id"] == null)
            {
                ClientScript.RegisterStartupScript(GetType(), "warn", "showToast('Please select a prescription first!','warning');", true);
                return;
            }

            getCon();
            string invCode = "INV-" + DateTime.Now.Ticks.ToString().Substring(11);

            // Fetch prescription info
            da = new SqlDataAdapter("SELECT CustomerID FROM prescriptions_tbl WHERE PrescriptionID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            int custId = ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["CustomerID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["CustomerID"]) : 0;

            // Insert Invoice
            string sqlInv = "INSERT INTO invoices_tbl (InvoiceCode, CustomerID, TotalAmount, PaymentMethod, PaymentStatus, InvoiceDate) VALUES ('" + invCode + "','" + custId + "','450.00','Cash','Paid',GETDATE());";
            // Update Prescription Status
            string sqlRx = "UPDATE prescriptions_tbl SET Status='Billed' WHERE PrescriptionID='" + ViewState["Id"] + "';";

            cmd = new SqlCommand(sqlInv + sqlRx, con);
            cmd.ExecuteNonQuery();

            fillgrid();
            ClientScript.RegisterStartupScript(GetType(), "billed", "showToast('Invoice " + invCode + " generated successfully!','success');", true);
        }
    }
}
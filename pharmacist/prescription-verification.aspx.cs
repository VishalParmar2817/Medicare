using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class prescriptionVerification : System.Web.UI.Page
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
                    fillStats();
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
                       ISNULL((r.FirstName + ' ' + r.LastName), 'Customer') AS CustomerName,
                       ISNULL(r.Phone, '—') AS PhoneNumber
                FROM prescriptions_tbl p
                LEFT JOIN regi_tbl r ON p.CustomerID = r.Id";

            string status = rxStatus.SelectedValue;
            if (!string.IsNullOrEmpty(status))
            {
                sql += " WHERE p.Status = '" + status + "'";
            }

            sql += " ORDER BY p.PrescriptionID DESC";

            da = new SqlDataAdapter(sql, con);
            ds = new DataSet();
            da.Fill(ds);
            gvRx.DataSource = ds;
            gvRx.DataBind();
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM prescriptions_tbl WHERE Status='Pending'", con);
                lblPendingRx.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM prescriptions_tbl WHERE Status='Under Review'", con);
                lblReviewRx.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM prescriptions_tbl WHERE Status='Approved'", con);
                lblApprovedRx.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM prescriptions_tbl WHERE Status='Rejected'", con);
                lblRejectedRx.Text = cmd.ExecuteScalar().ToString();
            }
            catch { }
        }

        protected void applyFilters_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void gvRx_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rxId = Convert.ToInt32(e.CommandArgument);
            getCon();

            if (e.CommandName == "cmd_approve")
            {
                cmd = new SqlCommand("UPDATE prescriptions_tbl SET Status='Approved', VerifiedAt=GETDATE() WHERE PrescriptionID='" + rxId + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                fillStats();
                ClientScript.RegisterStartupScript(GetType(), "approved", "showToast('Prescription #" + rxId + " approved for dispensing!','success');", true);
            }
            else if (e.CommandName == "cmd_reject")
            {
                cmd = new SqlCommand("UPDATE prescriptions_tbl SET Status='Rejected' WHERE PrescriptionID='" + rxId + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                fillStats();
                ClientScript.RegisterStartupScript(GetType(), "rejected", "showToast('Prescription #" + rxId + " rejected.','danger');", true);
            }
        }
    }
}
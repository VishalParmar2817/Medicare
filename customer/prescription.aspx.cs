using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace medicare.customer
{
    public partial class prescription : System.Web.UI.Page
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
                fillPrescriptions();
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

        void fillPrescriptions()
        {
            try
            {
                getCon();
                int custId = getCustomerId();
                da = new SqlDataAdapter("SELECT * FROM prescriptions_tbl WHERE CustomerID='" + custId + "' ORDER BY PrescriptionID DESC", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    rptPrescriptions.DataSource = ds;
                    rptPrescriptions.DataBind();
                    lblNoRx.Visible = false;
                }
                else
                {
                    rptPrescriptions.DataSource = null;
                    rptPrescriptions.DataBind();
                    lblNoRx.Visible = true;
                }
            }
            catch
            {
                lblNoRx.Visible = true;
            }
        }

        protected void btnSubmitRx_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                int custId = getCustomerId();
                string notes = txtRxNotes.Text.Trim().Replace("'", "''");

                string fileName = "";
                if (rxUpload.HasFile)
                {
                    fileName = Path.GetFileName(rxUpload.FileName);
                    string saveDir = Server.MapPath("~/m_images/");
                    if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
                    rxUpload.SaveAs(Path.Combine(saveDir, fileName));
                }

                string rxCode = "RX-" + DateTime.Now.ToString("yyyyMMdd") + new Random().Next(100, 999).ToString();
                string docNotes = (!string.IsNullOrEmpty(fileName) ? "[" + fileName + "] " : "") + notes;

                cmd = new SqlCommand(
                    "INSERT INTO prescriptions_tbl (PrescriptionCode, CustomerID, DoctorName, Status, Notes, CreatedAt) " +
                    "VALUES ('" + rxCode + "', '" + custId + "', 'Self-Uploaded', 'Pending', '" + docNotes + "', GETDATE())", con);
                cmd.ExecuteNonQuery();

                txtRxNotes.Text = "";
                fillPrescriptions();
                ClientScript.RegisterStartupScript(GetType(), "rxSuccess",
                    "new bootstrap.Modal(document.getElementById('successModal')).show();", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "rxErr",
                    "alert('Could not submit prescription: " + ex.Message.Replace("'", "") + "');", true);
            }
        }
    }
}

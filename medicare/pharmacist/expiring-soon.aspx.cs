using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class expiringSoon : System.Web.UI.Page
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
            string query = @"
                SELECT b.BatchID, m.Name AS MedicineName, b.BatchNumber, b.Quantity, b.ExpiryDate, 
                       DATEDIFF(DAY, GETDATE(), b.ExpiryDate) AS DaysLeft, b.Status 
                FROM medicinebatches_tbl b 
                JOIN medicines_tbl m ON b.MedicineID = m.MedicineID 
                WHERE b.ExpiryDate <= DATEADD(DAY, 60, GETDATE()) 
                  AND b.ExpiryDate >= GETDATE()
                ORDER BY b.ExpiryDate ASC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            gvExpiring.DataSource = ds;
            gvExpiring.DataBind();
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM medicinebatches_tbl WHERE ExpiryDate <= DATEADD(DAY, 30, GETDATE()) AND ExpiryDate >= GETDATE()", con);
                lblWithin30.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicinebatches_tbl WHERE ExpiryDate <= DATEADD(DAY, 14, GETDATE()) AND ExpiryDate >= GETDATE()", con);
                lblWithin14.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicinebatches_tbl WHERE ExpiryDate <= DATEADD(DAY, 60, GETDATE()) AND ExpiryDate >= GETDATE()", con);
                lblWithin60.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(Quantity), 0) FROM medicinebatches_tbl WHERE ExpiryDate <= DATEADD(DAY, 60, GETDATE()) AND ExpiryDate >= GETDATE()", con);
                lblTotalQty.Text = cmd.ExecuteScalar().ToString();
            }
            catch { }
        }

        protected void gvExpiring_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_review")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                ClientScript.RegisterStartupScript(GetType(), "review", "showToast('Batch ID #" + id + " selected for discount/clearance review','info');", true);
            }
        }
    }
}
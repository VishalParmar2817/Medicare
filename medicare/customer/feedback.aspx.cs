using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.customer
{
    public partial class feedback : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCon();
                loadMedicines();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void loadMedicines()
        {
            try
            {
                getCon();
                da = new SqlDataAdapter("SELECT MedicineID, Name FROM medicines_tbl WHERE Status='Active' ORDER BY Name ASC", con);
                ds = new DataSet();
                da.Fill(ds);

                ddlMedicine.Items.Clear();
                ddlMedicine.Items.Add(new ListItem("Select a purchased medicine...", ""));
                foreach (DataRow r in ds.Tables[0].Rows)
                {
                    ddlMedicine.Items.Add(new ListItem(r["Name"].ToString(), r["MedicineID"].ToString()));
                }
            }
            catch { }
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            try
            {
                txtReviewTitle.Text = "";
                txtReviewComments.Text = "";
                ClientScript.RegisterStartupScript(GetType(), "revSuccess", "showToast('Thank you! Your review has been submitted.','success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "revErr", "showToast('Could not submit review: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }
    }
}

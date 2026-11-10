using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace medicare.customer
{
    public partial class forgotPassword : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void btnSendResetLink_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtResetEmail.Text.Trim();
                if (string.IsNullOrEmpty(email))
                {
                    ClientScript.RegisterStartupScript(GetType(), "emailEmpty", "showToast('Please enter your email address.','error');", true);
                    return;
                }

                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM regi_tbl WHERE Email='" + email + "'", con);
                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count > 0)
                {
                    Response.Redirect("reset-password.aspx?email=" + Server.UrlEncode(email));
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "emailNotFound", "showToast('No account registered with this email address.','error');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "resetErr", "showToast('Error: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }
    }
}

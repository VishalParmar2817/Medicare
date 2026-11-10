using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace medicare.customer
{
    public partial class resetPassword : System.Web.UI.Page
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

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            try
            {
                string email = Request.QueryString["email"];
                if (string.IsNullOrEmpty(email))
                {
                    ClientScript.RegisterStartupScript(GetType(), "noEmail", "showToast('Missing email reference. Please try again.','error');", true);
                    return;
                }

                string newPwd = txtNewPassword.Text.Trim();
                string confirmPwd = txtConfirmPassword.Text.Trim();

                if (string.IsNullOrEmpty(newPwd) || newPwd != confirmPwd)
                {
                    ClientScript.RegisterStartupScript(GetType(), "pwdMismatch", "showToast('Passwords do not match or are empty.','error');", true);
                    return;
                }

                getCon();
                cmd = new SqlCommand("UPDATE regi_tbl SET Password='" + newPwd + "' WHERE Email='" + email + "'", con);
                cmd.ExecuteNonQuery();

                Response.Redirect("login.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "errReset", "showToast('Failed to reset password: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }
    }
}

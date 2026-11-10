using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace medicare.customer
{
    public partial class login : Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        int i;
        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
           getCon();
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            if (!(string.IsNullOrEmpty(txtEmail.Text) && !(string.IsNullOrEmpty(txtPassword.Text))))
            {
                cmd = new SqlCommand("select Role from regi_tbl where Email='" + txtEmail.Text + "' and Password='" + txtPassword.Text + "'", con);
                string Role = Convert.ToString(cmd.ExecuteScalar());

                //if (i > 0)
                //{
                //    //Session["admin"] = txtEmail.Text;
                //    Session["pharmacist"] = txtEmail.Text;
                //    Response.Redirect("~/pharmacist/dashboard.aspx");

                //    //Response.Redirect("~/customer/medicines.aspx");

                //    //Response.Redirect("~/admin/dashboard.aspx");
                //}
                //else
                //{
                //    Response.Redirect("Invalid User Name or Password");
                //}


                if (Role == "Admin")
                {
                    Session["admin"] = txtEmail.Text;
                    Response.Redirect("~/admin/dashboard.aspx");
                }
                else if (Role == "pharmacist")
                {
                    Session["pharmacist"] = txtEmail.Text;
                    Response.Redirect("~/pharmacist/dashboard.aspx");
                }
                else
                {
                    Session["customer"] = txtEmail.Text;
                    Response.Redirect("~/customer/dashboard.aspx");
                }

            }
        }
    }
}

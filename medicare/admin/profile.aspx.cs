using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.admin
{
    public partial class profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    filldata();
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

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM regi_tbl WHERE Email='" + Session["admin"].ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                string fName = row["FirstName"].ToString();
                string lName = row["LastName"].ToString();
                string fullName = (fName + " " + lName).Trim();

                txtFirstName.Text = fName;
                txtLastName.Text = lName;
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                txtRole.Text = row["Role"].ToString();
                txtAccountId.Text = "ADM-" + row["Id"].ToString().PadLeft(4, '0');
                txtAccessLevel.Text = "Full Administrator";

                lblLastLogin.Text = DateTime.Now.ToString("dd MMM yyyy HH:mm");

                string initials = "";
                if (!string.IsNullOrEmpty(fName)) initials += fName[0];
                if (!string.IsNullOrEmpty(lName)) initials += lName[0];
                if (string.IsNullOrEmpty(initials)) initials = "SA";

                lblInitials.Text = initials.ToUpper();
                lblProfileName.Text = fullName;
                lblProfileEmail.Text = row["Email"].ToString();
            }
            con.Close();
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("UPDATE regi_tbl SET FirstName='" + txtFirstName.Text + "', LastName='" + txtLastName.Text + "', Phone='" + txtPhone.Text + "' WHERE Email='" + Session["admin"].ToString() + "'", con);
            cmd.ExecuteNonQuery();
            con.Close();
            filldata();
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            // Password change handled client-side or redirect; no extra fields in designer
        }
    }
}
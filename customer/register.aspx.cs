using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace medicare.customer
{
    public partial class register : System.Web.UI.Page
    {

        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            fillgrid();
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillgrid()
        {

            getCon();
            da = new SqlDataAdapter("SELECT Id, FirstName, LastName, Email, Phone, DOB, Gender FROM regi_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

        }

        void clear()
        {
            regFirstName.Text = "";
            regLastName.Text = "";
            regEmail.Text = "";
            regPhone.Text = "";
            regDob.Text = "";
            regGender.SelectedIndex = 0;
            regPass.Text = "";
            regPass2.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("insert into regi_tbl (FirstName, LastName, Email, Phone, DOB, Gender, Password) VALUES ('" + regFirstName.Text + "', '" + regLastName.Text + "', '" + regEmail.Text + "', '" + regPhone.Text + "', '" + regDob.Text + "', '" + regGender.SelectedValue + "', '" + regPass.Text + "')", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            clear();

        }
    }
}
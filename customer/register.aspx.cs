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
            if (!IsPostBack)
            {
                getCon();
                fillgrid();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Display the data in gridview
        void fillgrid()
        {
            try
            {
                getCon();
                da = new SqlDataAdapter("SELECT Id, FirstName, LastName, Email, Phone, DOB, Gender, Address FROM regi_tbl", con);
                ds = new DataSet();
                da.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
            catch { }
        }

        // to clear the form after register
        void clear()
        {
            txtfname.Text = "";
            txtlname.Text = "";
            txtemail.Text = "";
            txtphone.Text = "";
            txtdob.Text = "";
            rblg.SelectedIndex = -1;
            txtaddress.Text = "";
            txtpass.Text = "";
            txtpass2.Text = "";
        }

        // register button click event
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                cmd = new SqlCommand("INSERT INTO regi_tbl (FirstName, LastName, Email, Phone, DOB, Gender, Address, Password) VALUES ('" + txtfname.Text.Trim() + "', '" + txtlname.Text.Trim() + "', '" + txtemail.Text.Trim() + "', '" + txtphone.Text.Trim() + "', '" + txtdob.Text.Trim() + "', '" + rblg.SelectedValue + "', '" + txtaddress.Text.Trim() + "', '" + txtpass.Text.Trim() + "')", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                clear();
            }
            catch { }
        }
    }
}

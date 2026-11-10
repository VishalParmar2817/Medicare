<<<<<<< HEAD
﻿using System;
=======
using System;
>>>>>>> 79e3113 (Initial commit)
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
<<<<<<< HEAD

=======
            getCon();
>>>>>>> 79e3113 (Initial commit)
            fillgrid();
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

<<<<<<< HEAD
=======
        // Display the data in gridview
>>>>>>> 79e3113 (Initial commit)
        void fillgrid()
        {

            getCon();
<<<<<<< HEAD
            da = new SqlDataAdapter("SELECT Id, FirstName, LastName, Email, Phone, DOB, Gender FROM regi_tbl", con);
=======
            da = new SqlDataAdapter("select Id, FirstName, LastName, Email, Phone, DOB, Gender, Address from regi_tbl", con);
>>>>>>> 79e3113 (Initial commit)
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

        }

<<<<<<< HEAD
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
=======
        // to clear the form after register
        void clear()
        {
            txtfname.Text = "";
            txtlname.Text = "";
            txtemail.Text = "";
            txtphone.Text = "";
            txtdob.Text = "";
            rblg.SelectedIndex = -1;
            txtpass.Text = "";
            txtpass2.Text = "";
        }

        //register button click event
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("insert into regi_tbl (FirstName, LastName, Email, Phone, DOB, Gender , Address, Password) values ('" + txtfname.Text + "', '" + txtlname.Text + "', '" + txtemail.Text + "', '" + txtphone.Text + "', '" + txtdob.Text + "', '" + rblg.SelectedValue + "', '" + txtaddress.Text + "', '" + txtpass.Text + "')", con);
>>>>>>> 79e3113 (Initial commit)
            cmd.ExecuteNonQuery();
            fillgrid();
            clear();

        }
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 79e3113 (Initial commit)

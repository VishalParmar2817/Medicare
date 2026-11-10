using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace medicare.admin
{
    public partial class customers : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string img, nm;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                getCon();
                totalcust();
                fillgrid();
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

        void totalcust()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from regi_tbl", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalCust.Text = i.ToString();

            try
            {
                cmd = new SqlCommand("select count(*) from regi_tbl where Status='Active'", con);
                int active = Convert.ToInt32(cmd.ExecuteScalar());
                lblActiveCust.Text = active.ToString();

                cmd = new SqlCommand("select count(*) from regi_tbl where Status='Inactive'", con);
                int inactive = Convert.ToInt32(cmd.ExecuteScalar());
                lblInactiveCust.Text = inactive.ToString();
            }
            catch
            {
                lblActiveCust.Text = i.ToString();
                lblInactiveCust.Text = "0";
            }

            cmd = new SqlCommand("select count(*) from Orders", con);
            int orders = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalOrdersCust.Text = orders.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from regi_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("select * from regi_tbl where id='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            txtEditFirstName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();
            txtEditLastName.Text = ds.Tables[0].Rows[0]["LastName"].ToString();
            txtEditEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            txtEditPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
            txtEditDOB.Text = ds.Tables[0].Rows[0]["DOB"].ToString();

            if (ds.Tables[0].Rows[0]["Gender"].ToString() == "Male")
            {
                ddlEditGender.SelectedValue = "Male";
            }
            else
            {
                ddlEditGender.SelectedValue = "Female";
            }

            txtEditAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();

        }

        protected void gvCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
             
                ClientScript.RegisterStartupScript(GetType(), "showEditCustomer",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editCustomerModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("delete from regi_tbl where Id='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalcust();
            }
        }

      

        protected void btnUpdateCustomer_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("update regi_tbl set FirstName='" + txtEditFirstName.Text + "',LastName='" + txtEditLastName.Text + "',Email='" + txtEditEmail.Text + "',Phone='" + txtEditPhone.Text + "',DOB='" + txtEditDOB.Text + "',Gender='" + ddlEditGender.SelectedItem.Text + "',Address='" + txtEditAddress.Text + "'  where id='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}
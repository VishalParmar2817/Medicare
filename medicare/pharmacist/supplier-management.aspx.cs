using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class supplierManagement : System.Web.UI.Page
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
                totalsuppliers();
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

        void totalsuppliers()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from suppliers_tbl", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalSuppliers.Text = i.ToString();

            cmd = new SqlCommand("select count(*) from suppliers_tbl where Status='Active'", con);
            int active = Convert.ToInt32(cmd.ExecuteScalar());
            lblActiveSuppliers.Text = active.ToString();

            cmd = new SqlCommand("select count(*) from suppliers_tbl where Status='Inactive'", con);
            int inactive = Convert.ToInt32(cmd.ExecuteScalar());
            lblInactiveSuppliers.Text = inactive.ToString();

            cmd = new SqlCommand("select count(distinct City) from suppliers_tbl", con);
            int cities = Convert.ToInt32(cmd.ExecuteScalar());
            lblCitiesSuppliers.Text = cities.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from suppliers_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSuppliers.DataSource = ds;
            gvSuppliers.DataBind();
        }

        protected void btnSaveSup_Click(object sender, EventArgs e)
        {
            getCon();
            string supCode = "S" + DateTime.Now.Ticks.ToString().Substring(10);
            cmd = new SqlCommand("insert into suppliers_tbl (SupplierCode, CompanyName, ContactPerson, PhoneNumber, Email, City, GSTNumber, DrugLicense, Status, Address, Notes) values ('" + supCode + "','" + supName.Text + "','" + supContact.Text + "','" + supPhone.Text + "','" + supEmail.Text + "','" + supCity.Text + "','" + txtSupGst.Text + "','" + txtSupLicense.Text + "','" + supStatus.SelectedValue + "','" + txtSupAddress.Text + "','" + txtSupNotes.Text + "')", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            totalsuppliers();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("select * from suppliers_tbl where SupplierID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            txtEditSupName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
            txtEditSupContact.Text = ds.Tables[0].Rows[0]["ContactPerson"].ToString();
            txtEditSupPhone.Text = ds.Tables[0].Rows[0]["PhoneNumber"].ToString();
            txtEditSupEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            txtEditSupCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            txtEditSupGst.Text = ds.Tables[0].Rows[0]["GSTNumber"].ToString();
            txtEditSupLicense.Text = ds.Tables[0].Rows[0]["DrugLicense"].ToString();

            if (ds.Tables[0].Rows[0]["Status"].ToString() == "Active")
            {
                ddlEditSupStatus.SelectedValue = "Active";
            }
            else
            {
                ddlEditSupStatus.SelectedValue = "Inactive";
            }

            txtEditSupAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            txtEditSupNotes.Text = ds.Tables[0].Rows[0]["Notes"].ToString();
        }

        protected void gvSuppliers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showEditSupplier",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editSupModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("delete from suppliers_tbl where SupplierID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalsuppliers();
            }
        }

        protected void btnUpdateSup_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("update suppliers_tbl set CompanyName='" + txtEditSupName.Text + "',ContactPerson='" + txtEditSupContact.Text + "',PhoneNumber='" + txtEditSupPhone.Text + "',Email='" + txtEditSupEmail.Text + "',City='" + txtEditSupCity.Text + "',GSTNumber='" + txtEditSupGst.Text + "',DrugLicense='" + txtEditSupLicense.Text + "',Status='" + ddlEditSupStatus.SelectedValue + "',Address='" + txtEditSupAddress.Text + "',Notes='" + txtEditSupNotes.Text + "' where SupplierID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}
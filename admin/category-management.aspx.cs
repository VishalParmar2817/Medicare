using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace medicare.admin
{
    public partial class categoryManagement : System.Web.UI.Page
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
                totalcategories();
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

        void totalcategories()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from categories_tbl", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalCategories.Text = i.ToString();

            cmd = new SqlCommand("select count(*) from categories_tbl where Status='Active'", con);
            int active = Convert.ToInt32(cmd.ExecuteScalar());
            lblActiveCategories.Text = active.ToString();

            cmd = new SqlCommand("select count(*) from categories_tbl where Status='Inactive'", con);
            int inactive = Convert.ToInt32(cmd.ExecuteScalar());
            lblInactiveCategories.Text = inactive.ToString();

            cmd = new SqlCommand("select count(*) from medicines_tbl", con);
            int prod = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalProducts.Text = prod.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from categories_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            gvCategories.DataSource = ds;
            gvCategories.DataBind();
        }

        protected void btnSaveCat_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("insert into categories_tbl (Name, Icon, Description, Status) values ('" + catName.Text + "','" + catIcon.Text + "','" + txtCatDesc.Text + "','" + ddlCatStatus.SelectedValue + "')", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            totalcategories();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("select * from categories_tbl where CategoryID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            txtEditCatName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
            txtEditCatIcon.Text = ds.Tables[0].Rows[0]["Icon"].ToString();
            txtEditCatDesc.Text = ds.Tables[0].Rows[0]["Description"].ToString();

            if (ds.Tables[0].Rows[0]["Status"].ToString() == "Active")
            {
                ddlEditCatStatus.SelectedValue = "Active";
            }
            else
            {
                ddlEditCatStatus.SelectedValue = "Inactive";
            }
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showEditCategory",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editCatModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("delete from categories_tbl where CategoryID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalcategories();
            }
        }

        protected void btnUpdateCat_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("update categories_tbl set Name='" + txtEditCatName.Text + "',Icon='" + txtEditCatIcon.Text + "',Description='" + txtEditCatDesc.Text + "',Status='" + ddlEditCatStatus.SelectedValue + "' where CategoryID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}

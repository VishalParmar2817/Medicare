using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace medicare.admin
{
    public partial class brands : System.Web.UI.Page
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
                totalbrands();
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

        void totalbrands()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from brands_tbl", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalBrands.Text = i.ToString();

            cmd = new SqlCommand("select count(*) from brands_tbl where Status='Active'", con);
            int active = Convert.ToInt32(cmd.ExecuteScalar());
            lblActiveBrands.Text = active.ToString();

            cmd = new SqlCommand("select count(*) from brands_tbl where Status='Inactive'", con);
            int inactive = Convert.ToInt32(cmd.ExecuteScalar());
            lblInactiveBrands.Text = inactive.ToString();

            cmd = new SqlCommand("select count(*) from medicines_tbl", con);
            int prod = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalProducts.Text = prod.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from brands_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            gvBrands.DataSource = ds;
            gvBrands.DataBind();
        }

        protected void btnAddBrandSubmit_Click(object sender, EventArgs e)
        {
            getCon();
         
            cmd = new SqlCommand("insert into brands_tbl (Name, Country, Description, Status) values ('" + txtBrandName.Text + "','" + txtBrandCountry.Text + "','" + txtBrandDesc.Text + "','" + ddlBrandStatus.SelectedValue + "')", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            totalbrands();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("select * from  brands_tbl   where BrandID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            txtEditBrandName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
            txtEditBrandCountry.Text = ds.Tables[0].Rows[0]["Country"].ToString();
            txtEditBrandDesc.Text = ds.Tables[0].Rows[0]["Description"].ToString();

            if (ds.Tables[0].Rows[0]["Status"].ToString() == "Active")
            {
                ddlEditBrandStatus.SelectedValue = "Active";
            }
            else
            {
                ddlEditBrandStatus.SelectedValue = "Inactive";
            }
        }

        protected void gvBrands_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showEditBrand",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editBrandModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("delete from brands_tbl where BrandID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalbrands();
            }
        }

        protected void btnEditBrandSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            cmd = new SqlCommand("update brands_tbl set Name='" + txtEditBrandName.Text + "',Country='" + txtEditBrandCountry.Text + "',Description='" + txtEditBrandDesc.Text + "',Status='" + ddlEditBrandStatus.SelectedValue + "' where BrandID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}
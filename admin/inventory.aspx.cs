using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace medicare.admin
{
    public partial class inventory : System.Web.UI.Page
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

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select m.*, c.Name as CategoryName from medicines_tbl m left join categories_tbl c on m.CategoryID = c.CategoryID", con);
            ds = new DataSet();
            da.Fill(ds);
            gvInventory.DataSource = ds;
            gvInventory.DataBind();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("select * from medicines_tbl where MedicineID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            adjMedName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
            adjCurrent.Text = ds.Tables[0].Rows[0]["Stock"].ToString();
        }

        protected void gvInventory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showAdjustModal",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('adjustModal')).show();", true);
                filldata();
            }
        }

        protected void btnSaveAdjust_Click(object sender, EventArgs e)
        {
            getCon();
            int qty = Convert.ToInt32(adjQty.Text);
            string type = adjType.SelectedValue;

            da = new SqlDataAdapter("select * from medicines_tbl where MedicineID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

                int currentStock = Convert.ToInt32(ds.Tables[0].Rows[0]["Stock"]);

                int newStock = currentStock;
                if (type == "Add Stock") newStock = currentStock + qty;
                else if (type == "Remove Stock") newStock = currentStock - qty;
                else if (type == "Set Stock") newStock = qty;

                if (newStock < 0) newStock = 0;

            cmd = new SqlCommand("update medicines_tbl set Stock='" + newStock + "' where MedicineID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}
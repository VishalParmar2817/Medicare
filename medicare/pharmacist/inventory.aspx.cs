using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class inventory : System.Web.UI.Page
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
                if (!IsPostBack)
                {
                    fillgrid();
                    fillStats();
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

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT m.MedicineID, m.Name, m.Stock, ISNULL(m.MinStockLevel, 10) AS MinStockLevel, m.Status, ISNULL(c.Name, 'General') AS CategoryName FROM medicines_tbl m LEFT JOIN categories_tbl c ON m.CategoryID = c.CategoryID ORDER BY m.Stock ASC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvInventory.DataSource = ds;
            gvInventory.DataBind();
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT ISNULL(SUM(Stock), 0) FROM medicines_tbl", con);
                lblTotalStock.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock > ISNULL(MinStockLevel, 10)", con);
                lblInStock.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock > 0 AND Stock <= ISNULL(MinStockLevel, 10)", con);
                lblLowStock.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock <= 0", con);
                lblOutStock.Text = cmd.ExecuteScalar().ToString();
            }
            catch { }
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM medicines_tbl WHERE MedicineID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                adjMedName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                adjCurrent.Text = ds.Tables[0].Rows[0]["Stock"].ToString();
                adjQty.Text = "";
                txtAdjReason.Text = "";
            }
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
            int qty = 0;
            int.TryParse(adjQty.Text, out qty);

            string type = adjType.SelectedValue;
            string sql = "";

            if (type == "Add Stock")
            {
                sql = "UPDATE medicines_tbl SET Stock = Stock + " + qty + " WHERE MedicineID='" + ViewState["Id"] + "'";
            }
            else if (type == "Remove Stock")
            {
                sql = "UPDATE medicines_tbl SET Stock = CASE WHEN Stock >= " + qty + " THEN Stock - " + qty + " ELSE 0 END WHERE MedicineID='" + ViewState["Id"] + "'";
            }
            else // Set Stock
            {
                sql = "UPDATE medicines_tbl SET Stock = " + qty + " WHERE MedicineID='" + ViewState["Id"] + "'";
            }

            cmd = new SqlCommand(sql, con);
            cmd.ExecuteNonQuery();

            fillgrid();
            fillStats();
        }
    }
}
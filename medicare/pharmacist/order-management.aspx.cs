using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class orderManagement : System.Web.UI.Page
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
            string sql = @"
                SELECT o.OrderID, o.OrderCode, o.TotalAmount, o.Status, ISNULL(o.FullName, ISNULL(r.FirstName + ' ' + r.LastName, 'Customer')) AS FullName 
                FROM Orders o 
                LEFT JOIN regi_tbl r ON o.CustomerID = r.Id ";

            if (!string.IsNullOrEmpty(ddlStatusFilter.SelectedValue))
            {
                sql += " WHERE o.Status='" + ddlStatusFilter.SelectedValue + "'";
            }

            sql += " ORDER BY o.OrderID DESC";

            da = new SqlDataAdapter(sql, con);
            ds = new DataSet();
            da.Fill(ds);
            gvOrders.DataSource = ds;
            gvOrders.DataBind();
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE Status='Pending'", con);
                lblPending.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE Status='Processing'", con);
                lblProcessing.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE Status='Delivered'", con);
                lblDelivered.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount), 0) FROM Orders WHERE Status='Delivered'", con);
                decimal rev = Convert.ToDecimal(cmd.ExecuteScalar());
                lblRevenue.Text = "₹" + rev.ToString("N0");
            }
            catch { }
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillgrid();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Orders WHERE OrderID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string status = ds.Tables[0].Rows[0]["Status"].ToString();
                if (ddlEditOrderStatus.Items.FindByValue(status) != null)
                {
                    ddlEditOrderStatus.SelectedValue = status;
                }
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showEditOrder",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editOrderModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("DELETE FROM Orders WHERE OrderID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                fillStats();
            }
        }

        protected void btnEditOrderSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            string status = ddlEditOrderStatus.SelectedValue;
            cmd = new SqlCommand("UPDATE Orders SET Status='" + status + "' WHERE OrderID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
            fillStats();

            ClientScript.RegisterStartupScript(GetType(), "orderUpdated", "showToast('Order status updated to " + status + "!','success');", true);
        }
    }
}
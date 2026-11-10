using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace medicare.admin
{
    public partial class orders : System.Web.UI.Page
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
                totalorders();
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

        void totalorders()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from Orders", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalOrders.Text = i.ToString();

            cmd = new SqlCommand("select count(*) from Orders where Status='Delivered'", con);
            int del = Convert.ToInt32(cmd.ExecuteScalar());
            lblDelivered.Text = del.ToString();

            cmd = new SqlCommand("select count(*) from Orders where Status='Pending'", con);
            int pen = Convert.ToInt32(cmd.ExecuteScalar());
            lblPending.Text = pen.ToString();

            cmd = new SqlCommand("select count(*) from Orders where Status='Cancelled'", con);
            int can = Convert.ToInt32(cmd.ExecuteScalar());
            lblCancelled.Text = can.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from Orders order by OrderID desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvOrders.DataSource = ds;
            gvOrders.DataBind();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("select * from Orders where OrderID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlEditOrderStatus.SelectedValue = ds.Tables[0].Rows[0]["Status"].ToString();
            txtEditOrderNotes.Text = ds.Tables[0].Rows[0]["Notes"] != DBNull.Value ? ds.Tables[0].Rows[0]["Notes"].ToString() : "";
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
                cmd = new SqlCommand("delete from Orders where OrderID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalorders();
            }
        }

        protected void btnEditOrderSubmit_Click(object sender, EventArgs e)
        {
            if (ViewState["Id"] == null) return;
            getCon();
            cmd = new SqlCommand("update Orders set Status='" + ddlEditOrderStatus.SelectedValue + "', Notes='" + txtEditOrderNotes.Text + "' where OrderID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}
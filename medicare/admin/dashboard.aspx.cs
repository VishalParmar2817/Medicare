using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.admin
{
    public partial class dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    getCon();
                    lblAdminName.Text = Session["admin"].ToString();
                    fillStats();
                    fillRecentOrders();
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

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders", con);
                lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount),0) FROM Orders WHERE Status='Delivered'", con);
                lblRevenue.Text = Convert.ToDecimal(cmd.ExecuteScalar()).ToString("N2");

                cmd = new SqlCommand("SELECT COUNT(*) FROM regi_tbl WHERE Role='Customer'", con);
                lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl", con);
                lblTotalMedicines.Text = cmd.ExecuteScalar().ToString();
            }
            catch { }
        }

        void fillRecentOrders()
        {
            try
            {
                getCon();
                da = new SqlDataAdapter("SELECT TOP 5 * FROM Orders ORDER BY OrderID DESC", con);
                ds = new DataSet();
                da.Fill(ds);
                gvRecentOrders.DataSource = ds;
                gvRecentOrders.DataBind();
            }
            catch { }
        }
    }
}
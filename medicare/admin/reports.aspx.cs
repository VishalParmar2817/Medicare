using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.admin
{
    public partial class reports : System.Web.UI.Page
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

        void fillStats()
        {
            getCon();

            // Revenue Stats
            try
            {
                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount),0) FROM Orders WHERE Status='Delivered'", con);
                decimal totalRev = Convert.ToDecimal(cmd.ExecuteScalar());
                lblTotalRevenue.Text = "₹" + totalRev.ToString("N2");

                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE MONTH(OrderDate)=MONTH(GETDATE()) AND YEAR(OrderDate)=YEAR(GETDATE())", con);
                lblMonthOrders.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(AVG(TotalAmount),0) FROM Orders WHERE Status='Delivered'", con);
                decimal avgOrder = Convert.ToDecimal(cmd.ExecuteScalar());
                lblAvgOrder.Text = "₹" + avgOrder.ToString("N2");

                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount),0) FROM Orders WHERE PaymentStatus='Pending'", con);
                decimal pendingRev = Convert.ToDecimal(cmd.ExecuteScalar());
                lblPendingRev.Text = "₹" + pendingRev.ToString("N2");
            }
            catch { }

            // Inventory Stats
            cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock > MinStockLevel", con);
            lblRptInStock.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock <= MinStockLevel AND Stock > 0", con);
            lblRptLowStock.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock = 0", con);
            lblRptOutStock.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("SELECT COUNT(*) FROM brands_tbl WHERE Status='Active'", con);
            lblRptBrands.Text = cmd.ExecuteScalar().ToString();

            // Customer Stats
            cmd = new SqlCommand("SELECT COUNT(*) FROM regi_tbl", con);
            lblRptTotalCust.Text = cmd.ExecuteScalar().ToString();

            

            con.Close();
        }
    }
}
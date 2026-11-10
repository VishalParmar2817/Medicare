using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
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
            if (Session["pharmacist"] != null)
            {
                if (!IsPostBack)
                {
                    getCon();
                    lblPharmacistName.Text = Session["pharmacist"].ToString();
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
                // Total Medicines
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl", con);
                lblTotalMeds.Text = cmd.ExecuteScalar().ToString();

                // Orders Today
                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE)", con);
                lblOrdersToday.Text = cmd.ExecuteScalar().ToString();

                // Stock Alerts (low stock count)
                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock <= MinStockLevel", con);
                lblStockAlerts.Text = cmd.ExecuteScalar().ToString();

                // Revenue Today
                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount), 0) FROM Orders WHERE Status='Delivered' AND CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE)", con);
                decimal revToday = Convert.ToDecimal(cmd.ExecuteScalar());
                lblRevenueToday.Text = "₹" + (revToday >= 1000 ? (revToday / 1000).ToString("N0") + "K" : revToday.ToString("N0"));

                // Pending Prescriptions
                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE Status='Pending'", con);
                lblPendingRx.Text = cmd.ExecuteScalar().ToString();

                // Expired / Out of Stock
                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock = 0", con);
                lblExpiredMeds.Text = cmd.ExecuteScalar().ToString();

                // Active Customers
                cmd = new SqlCommand("SELECT COUNT(*) FROM regi_tbl WHERE Role='Customer'", con);
                lblActiveCustomers.Text = cmd.ExecuteScalar().ToString();
            }
            catch { }
        }

        void fillRecentOrders()
        {
            try
            {
                getCon();
                string sql = @"
                    SELECT TOP 5
                        o.OrderID,
                        o.OrderCode,
                        o.TotalAmount,
                        o.Status,
                        ISNULL(o.FullName, ISNULL(r.FirstName + ' ' + r.LastName, 'Customer')) AS FullName,
                        UPPER(LEFT(ISNULL(o.FullName, 'CU'), 2)) AS CustomerInitials,
                        1 AS ItemsCount
                    FROM Orders o
                    LEFT JOIN regi_tbl r ON o.CustomerID = r.Id
                    ORDER BY o.OrderID DESC";

                da = new SqlDataAdapter(sql, con);
                ds = new DataSet();
                da.Fill(ds);
                gvRecentOrders.DataSource = ds;
                gvRecentOrders.DataBind();
            }
            catch { }
        }

        protected void gvRecentOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("order-management.aspx");
            }
        }
    }
}
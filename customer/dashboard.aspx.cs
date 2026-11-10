using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.customer
{
    public partial class dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customer"] != null || Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    getCon();
                    loadUser();
                    loadStatsAndOrders();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        int getCustomerId()
        {
            if (Session["customerId"] != null)
            {
                int cid = 0;
                if (int.TryParse(Session["customerId"].ToString(), out cid)) return cid;
            }
            if (Session["customer"] != null)
            {
                getCon();
                cmd = new SqlCommand("SELECT Id FROM regi_tbl WHERE Email='" + Session["customer"] + "'", con);
                object oId = cmd.ExecuteScalar();
                if (oId != null) return Convert.ToInt32(oId);
            }
            return 1;
        }

        void loadUser()
        {
            try
            {
                getCon();
                string email = (Session["customer"] ?? Session["admin"]).ToString();
                da = new SqlDataAdapter("SELECT * FROM regi_tbl WHERE Email='" + email + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow r = ds.Tables[0].Rows[0];
                    string fname = r["FirstName"] != DBNull.Value ? r["FirstName"].ToString().Trim() : "";
                    string lname = r["LastName"] != DBNull.Value ? r["LastName"].ToString().Trim() : "";
                    string fullName = (fname + " " + lname).Trim();
                    if (string.IsNullOrEmpty(fullName)) fullName = "Customer";

                    lblCustomerEmail.Text = email;
                    lblProfileEmail.Text = email;
                    lblProfileFullName.Text = fullName;
                    lblRoleDetail.Text = r["Role"] != DBNull.Value ? r["Role"].ToString() : "Customer";

                    string phone = r["Phone"] != DBNull.Value ? r["Phone"].ToString().Trim() : "";
                    lblDetailPhone.Text = !string.IsNullOrEmpty(phone) ? phone : "Not provided";

                    string dob = r["DOB"] != DBNull.Value ? r["DOB"].ToString().Trim() : "";
                    lblDetailDOB.Text = !string.IsNullOrEmpty(dob) ? dob : "Not provided";

                    string gender = r["Gender"] != DBNull.Value ? r["Gender"].ToString().Trim() : "";
                    lblDetailGender.Text = !string.IsNullOrEmpty(gender) ? gender : "Not specified";

                    string addr = r["Address"] != DBNull.Value ? r["Address"].ToString().Trim() : "";
                    lblDetailAddress.Text = !string.IsNullOrEmpty(addr) ? addr : "No delivery address saved yet. Update your address in Profile settings.";

                    string initials = "CU";
                    if (!string.IsNullOrEmpty(fname))
                    {
                        initials = fname.Substring(0, 1).ToUpper() + (!string.IsNullOrEmpty(lname) ? lname.Substring(0, 1).ToUpper() : "");
                    }
                    lblAvatarInitials.Text = initials;
                }
                else
                {
                    lblCustomerEmail.Text = email;
                    lblProfileEmail.Text = email;
                    lblProfileFullName.Text = email;
                    lblRoleDetail.Text = "Customer";
                    lblAvatarInitials.Text = "CU";
                    lblDetailPhone.Text = "Not provided";
                    lblDetailDOB.Text = "Not provided";
                    lblDetailGender.Text = "Not specified";
                    lblDetailAddress.Text = "No delivery address saved yet.";
                }
            }
            catch
            {
                lblCustomerEmail.Text = (Session["customer"] ?? "").ToString();
                lblProfileEmail.Text = lblCustomerEmail.Text;
                lblProfileFullName.Text = "Customer";
                lblRoleDetail.Text = "Customer";
                lblAvatarInitials.Text = "CU";
                lblDetailPhone.Text = "Not provided";
                lblDetailDOB.Text = "Not provided";
                lblDetailGender.Text = "Not specified";
                lblDetailAddress.Text = "No delivery address saved yet.";
            }
        }

        void loadStatsAndOrders()
        {
            try
            {
                getCon();
                int custId = getCustomerId();

                // Order Count
                cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE CustomerID='" + custId + "'", con);
                object orderCountObj = cmd.ExecuteScalar();
                int orderCount = orderCountObj != null ? Convert.ToInt32(orderCountObj) : 0;
                lblStatOrders.Text = orderCount.ToString();

                // Prescription Count
                cmd = new SqlCommand("SELECT COUNT(*) FROM prescriptions_tbl WHERE CustomerID='" + custId + "'", con);
                object rxCountObj = cmd.ExecuteScalar();
                int rxCount = rxCountObj != null ? Convert.ToInt32(rxCountObj) : 0;
                lblStatRx.Text = rxCount.ToString();

                // Cart Count
                cmd = new SqlCommand("SELECT COUNT(*) FROM Cart WHERE CustomerID='" + custId + "'", con);
                object cartCountObj = cmd.ExecuteScalar();
                int cartCount = cartCountObj != null ? Convert.ToInt32(cartCountObj) : 0;
                lblStatCart.Text = cartCount.ToString();

                // Recent Orders (Top 5)
                da = new SqlDataAdapter("SELECT TOP 5 OrderID, OrderCode, TotalAmount, Status, PaymentStatus, OrderDate FROM Orders WHERE CustomerID='" + custId + "' ORDER BY OrderID DESC", con);
                DataTable dtOrders = new DataTable();
                da.Fill(dtOrders);

                if (dtOrders.Rows.Count > 0)
                {
                    rptRecentOrders.DataSource = dtOrders;
                    rptRecentOrders.DataBind();
                    rptRecentOrders.Visible = true;
                    pnlNoOrders.Visible = false;
                }
                else
                {
                    rptRecentOrders.Visible = false;
                    pnlNoOrders.Visible = true;
                }
            }
            catch
            {
                lblStatOrders.Text = "0";
                lblStatRx.Text = "0";
                lblStatCart.Text = "0";
                pnlNoOrders.Visible = true;
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace medicare.customer
{
    public partial class orders : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        public string ordersJson = "[]";

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customer"] == null && Session["admin"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                getCon();
                loadOrders();
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

        void loadOrders()
        {
            try
            {
                getCon();
                int custId = getCustomerId();
                da = new SqlDataAdapter("SELECT * FROM Orders WHERE CustomerID='" + custId + "' ORDER BY OrderID DESC", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count == 0)
                {
                    // Fallback to check by email name
                    string email = (Session["customer"] ?? "").ToString();
                    da = new SqlDataAdapter("SELECT o.* FROM Orders o JOIN regi_tbl r ON o.CustomerID = r.Id WHERE r.Email='" + email + "' ORDER BY o.OrderID DESC", con);
                    ds = new DataSet();
                    da.Fill(ds);
                }

                List<string> itemsList = new List<string>();
                foreach (DataRow r in ds.Tables[0].Rows)
                {
                    string id = r["OrderCode"] != DBNull.Value ? r["OrderCode"].ToString() : ("ORD-" + r["OrderID"]);
                    string date = r["OrderDate"] != DBNull.Value ? Convert.ToDateTime(r["OrderDate"]).ToString("yyyy-MM-dd") : DateTime.Now.ToString("yyyy-MM-dd");
                    string status = r["Status"] != DBNull.Value ? r["Status"].ToString() : "Pending";
                    decimal total = r["TotalAmount"] != DBNull.Value ? Convert.ToDecimal(r["TotalAmount"]) : 0.00m;
                    string note = r["Notes"] != DBNull.Value && !string.IsNullOrEmpty(r["Notes"].ToString()) ? r["Notes"].ToString().Replace("\"", "") : "Medicines";

                    string jsonItem = "{\"id\":\"" + id + "\",\"date\":\"" + date + "\",\"status\":\"" + status + "\",\"total\":" + total.ToString("F2") + ",\"items\":[{\"name\":\"" + note + "\",\"qty\":1,\"price\":" + total.ToString("F2") + "}]}";
                    itemsList.Add(jsonItem);
                }

                if (itemsList.Count > 0)
                {
                    ordersJson = "[" + string.Join(",", itemsList) + "]";
                }
                else
                {
                    ordersJson = "[]";
                }
            }
            catch
            {
                ordersJson = "[]";
            }
        }
    }
}

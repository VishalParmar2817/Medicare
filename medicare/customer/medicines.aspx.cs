using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.customer
{
    public partial class medicines : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCon();
                filldatalist();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void filldatalist()
        {
            getCon();
            da = new SqlDataAdapter(
                "SELECT m.MedicineID, m.Name, m.ImageUrl, m.Price, m.MRP, c.Name AS CategoryName " +
                "FROM medicines_tbl m " +
                "LEFT JOIN categories_tbl c ON m.CategoryID = c.CategoryID " +
                "WHERE m.Status = 'Active' AND m.Stock > 0", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_vd")
            {
                string medId = e.CommandArgument.ToString();
                Response.Redirect("medicine-details.aspx?id=" + medId);
            }
            else
            {
                if (Session["customer"] == null && Session["customerId"] == null && Session["admin"] == null)
                {
                    Response.Redirect("login.aspx");
                    return;
                }

                getCon();
                int medId = Convert.ToInt32(e.CommandArgument);
                int custId = 1;
                if (Session["customerId"] != null)
                {
                    int.TryParse(Session["customerId"].ToString(), out custId);
                }
                else if (Session["customer"] != null)
                {
                    cmd = new SqlCommand("SELECT Id FROM regi_tbl WHERE Email='" + Session["customer"] + "'", con);
                    object oId = cmd.ExecuteScalar();
                    if (oId != null) custId = Convert.ToInt32(oId);
                }

                cmd = new SqlCommand("SELECT CartID, Quantity FROM Cart WHERE CustomerID='" + custId + "' AND MedicineID='" + medId + "'", con);
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    int cartId = Convert.ToInt32(ds.Tables[0].Rows[0]["CartID"]);
                    cmd = new SqlCommand("UPDATE Cart SET Quantity = Quantity + 1 WHERE CartID='" + cartId + "'", con);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd = new SqlCommand("INSERT INTO Cart (CustomerID, MedicineID, Quantity, AddedAt) VALUES ('" + custId + "', '" + medId + "', 1, GETDATE())", con);
                    cmd.ExecuteNonQuery();
                }

                ClientScript.RegisterStartupScript(GetType(), "added", "alert('Medicine added to cart!');", true);
            }
        }
    }
}

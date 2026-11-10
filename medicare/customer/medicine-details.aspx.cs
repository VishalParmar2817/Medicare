using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.customer
{
    public partial class medicine_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string img;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customer"] != null || Session["admin"] != null || Session["user"] != null)
            {
                getCon();
                filldatalist();
                string userEmail = (Session["customer"] ?? Session["user"] ?? Session["admin"]).ToString();
                da = new SqlDataAdapter("select * from regi_tbl where Email='" + userEmail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string nm = ds.Tables[0].Rows[0]["FirstName"].ToString();
                    Label1.Text = "Welcome ... " + nm;
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

        void filldatalist()
        {
            getCon();
            da = new SqlDataAdapter(
                "select m.*, c.Name as CategoryName, b.Name as BrandName from medicines_tbl m " +
                "left join categories_tbl c on m.CategoryID = c.CategoryID " +
                "left join brands_tbl b on m.BrandID = b.BrandID " +
                "where m.MedicineID='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
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

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_cart")
            {
                getCon();
                int medId = Convert.ToInt32(e.CommandArgument);
                int custId = getCustomerId();
                cmd = new SqlCommand(
                    "INSERT INTO Cart (CustomerID, MedicineID, Quantity, AddedAt) " +
                    "VALUES ('" + custId + "', '" + medId + "', 1, GETDATE())", con);
                cmd.ExecuteNonQuery();
                Response.Redirect("cart.aspx");
            }
            else if (e.CommandName == "cmd_buynow")
            {
                getCon();
                int medId = Convert.ToInt32(e.CommandArgument);
                int custId = getCustomerId();
                cmd = new SqlCommand(
                    "INSERT INTO Cart (CustomerID, MedicineID, Quantity, AddedAt) " +
                    "VALUES ('" + custId + "', '" + medId + "', 1, GETDATE())", con);
                cmd.ExecuteNonQuery();
                Response.Redirect("checkout.aspx");
            }
        }
    }
}

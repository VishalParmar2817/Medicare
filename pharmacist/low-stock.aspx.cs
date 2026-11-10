using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class lowStock : System.Web.UI.Page
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
                    fillDropdowns();
                    fillgrid();
            
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

        void fillDropdowns()
        {
            getCon();
            da = new SqlDataAdapter("SELECT SupplierID, CompanyName FROM suppliers_tbl WHERE Status='Active' ORDER BY CompanyName", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            modalSupplier.Items.Clear();
            foreach (DataRow row in dt.Rows)
            {
                modalSupplier.Items.Add(new ListItem(row["CompanyName"].ToString(), row["SupplierID"].ToString()));
            }
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT MedicineID, Name, Stock, ISNULL(MinStockLevel, 10) AS MinStockLevel, (ISNULL(MinStockLevel, 10) - Stock) AS Shortage FROM medicines_tbl WHERE Stock < ISNULL(MinStockLevel, 10) ORDER BY (ISNULL(MinStockLevel, 10) - Stock) DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvLowStock.DataSource = ds;
            gvLowStock.DataBind();
        }


        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("SELECT MedicineID, Name, Stock, ISNULL(MinStockLevel, 10) AS MinStockLevel, (ISNULL(MinStockLevel, 10) - Stock) AS Shortage FROM medicines_tbl WHERE MedicineID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                modalMedName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                int shortage = Convert.ToInt32(ds.Tables[0].Rows[0]["Shortage"]);
                modalQty.Text = (shortage > 0 ? shortage * 2 : 50).ToString();
            }
        }

        protected void gvLowStock_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_reorder")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showReorderModal",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('reorderModal')).show();", true);
                filldata();
            }
        }

        protected void btnSubmitReorder_Click(object sender, EventArgs e)
        {
            getCon();
            int qty = 0;
            int.TryParse(modalQty.Text, out qty);
            int supId = string.IsNullOrEmpty(modalSupplier.SelectedValue) ? 0 : Convert.ToInt32(modalSupplier.SelectedValue);
            string priority = modalPriority.SelectedValue;
            string notes = modalNotes.Text.Trim();

            cmd = new SqlCommand("INSERT INTO stockalerts_tbl (MedicineID, SupplierID, OrderQuantity, Priority, Notes, Status, CreatedAt) VALUES ('" + ViewState["Id"] + "','" + supId + "','" + qty + "','" + priority + "','" + notes + "','Pending',GETDATE())", con);
            cmd.ExecuteNonQuery();

            fillgrid();
     
            ClientScript.RegisterStartupScript(GetType(), "reorderSuccess", "showToast('Purchase reorder created successfully!','success');", true);
        }

        protected void btnReorderAll_Click(object sender, EventArgs e)
        {
            getCon();
            // Automatically insert reorder alerts for all items below min stock level
            string sql = @"
                INSERT INTO stockalerts_tbl (MedicineID, SupplierID, OrderQuantity, Priority, Notes, Status, CreatedAt)
                SELECT m.MedicineID, 
                       ISNULL((SELECT TOP 1 SupplierID FROM suppliers_tbl WHERE Status='Active'), 0),
                       (ISNULL(m.MinStockLevel, 10) - m.Stock) * 2,
                       'Urgent',
                       'Auto bulk reorder for low stock',
                       'Pending',
                       GETDATE()
                FROM medicines_tbl m
                WHERE m.Stock < ISNULL(m.MinStockLevel, 10);";

            cmd = new SqlCommand(sql, con);
            int count = cmd.ExecuteNonQuery();

            fillgrid();
      

            ClientScript.RegisterStartupScript(GetType(), "reorderAllSuccess", "showToast('Reorder requests placed for all low stock items!','success');", true);
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class stockAlerts : System.Web.UI.Page
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

        void fillDropdowns()
        {
            getCon();
            da = new SqlDataAdapter("SELECT SupplierID, CompanyName FROM suppliers_tbl WHERE Status='Active' ORDER BY CompanyName", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSupplierAlerts.Items.Clear();
            foreach (DataRow row in dt.Rows)
            {
                ddlSupplierAlerts.Items.Add(new ListItem(row["CompanyName"].ToString(), row["SupplierID"].ToString()));
            }
        }

        void fillgrid()
        {
            getCon();
            // 1. Expired batches
            string sqlExpired = @"
                SELECT b.BatchID, m.Name AS MedicineName, b.BatchNumber, ISNULL(c.Name, 'General') AS CategoryName, 
                       b.ExpiryDate, b.Quantity 
                FROM medicinebatches_tbl b 
                JOIN medicines_tbl m ON b.MedicineID = m.MedicineID 
                LEFT JOIN categories_tbl c ON m.CategoryID = c.CategoryID 
                WHERE b.ExpiryDate < GETDATE() AND b.Status='Active'
                ORDER BY b.ExpiryDate DESC";
            da = new SqlDataAdapter(sqlExpired, con);
            DataSet dsExp = new DataSet();
            da.Fill(dsExp);
            gvExpired.DataSource = dsExp;
            gvExpired.DataBind();

            // 2. Low stock items
            string sqlLow = @"
                SELECT m.MedicineID, m.Name AS MedicineName, m.Stock, ISNULL(m.MinStockLevel, 10) AS MinStockLevel, 
                       (ISNULL(m.MinStockLevel, 10) - m.Stock) AS Shortage 
                FROM medicines_tbl m 
                WHERE m.Stock < ISNULL(m.MinStockLevel, 10) 
                ORDER BY (ISNULL(m.MinStockLevel, 10) - m.Stock) DESC";
            da = new SqlDataAdapter(sqlLow, con);
            DataSet dsLow = new DataSet();
            da.Fill(dsLow);
            gvAlerts.DataSource = dsLow;
            gvAlerts.DataBind();
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM medicines_tbl WHERE Stock < ISNULL(MinStockLevel, 10)", con);
                int lowCount = Convert.ToInt32(cmd.ExecuteScalar());
                lblLowStockCount.Text = lowCount.ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicinebatches_tbl WHERE ExpiryDate <= DATEADD(DAY, 30, GETDATE()) AND ExpiryDate >= GETDATE()", con);
                int nearExpCount = Convert.ToInt32(cmd.ExecuteScalar());
                lblNearExpiryCount.Text = nearExpCount.ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM medicinebatches_tbl WHERE ExpiryDate < GETDATE() AND Status='Active'", con);
                int expiredCount = Convert.ToInt32(cmd.ExecuteScalar());
                lblExpiredCount.Text = expiredCount.ToString();

                lblTotalAlerts.Text = (lowCount + nearExpCount + expiredCount).ToString();
            }
            catch { }
        }

        protected void gvExpired_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_remove")
            {
                int batchId = Convert.ToInt32(e.CommandArgument);
                getCon();
                // Mark batch as Disposed
                cmd = new SqlCommand("UPDATE medicinebatches_tbl SET Status='Disposed' WHERE BatchID='" + batchId + "'", con);
                cmd.ExecuteNonQuery();

                fillgrid();
                fillStats();
                ClientScript.RegisterStartupScript(GetType(), "removed", "showToast('Expired batch marked as disposed and removed from active inventory','info');", true);
            }
        }

        protected void gvAlerts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_reorder")
            {
                int medId = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = medId;

                getCon();
                da = new SqlDataAdapter("SELECT MedicineID, Name, Stock, ISNULL(MinStockLevel, 10) AS MinStockLevel, (ISNULL(MinStockLevel, 10) - Stock) AS Shortage FROM medicines_tbl WHERE MedicineID='" + medId + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    reorderMed.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                    int shortage = Convert.ToInt32(ds.Tables[0].Rows[0]["Shortage"]);
                    txtOrderQtyAlerts.Text = (shortage > 0 ? shortage * 2 : 50).ToString();
                }

                ClientScript.RegisterStartupScript(GetType(), "showReorderModal",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('reorderModal')).show();", true);
            }
        }

        protected void btnPlaceReorderAlerts_Click(object sender, EventArgs e)
        {
            getCon();
            int qty = 0;
            int.TryParse(txtOrderQtyAlerts.Text, out qty);
            int supId = string.IsNullOrEmpty(ddlSupplierAlerts.SelectedValue) ? 0 : Convert.ToInt32(ddlSupplierAlerts.SelectedValue);
            string priority = ddlPriorityAlerts.SelectedValue;
            string notes = txtNotesAlerts.Text.Trim();

            cmd = new SqlCommand("INSERT INTO stockalerts_tbl (MedicineID, SupplierID, OrderQuantity, Priority, Notes, Status, CreatedAt) VALUES ('" + ViewState["Id"] + "','" + supId + "','" + qty + "','" + priority + "','" + notes + "','Pending',GETDATE())", con);
            cmd.ExecuteNonQuery();

            fillgrid();
            fillStats();
            ClientScript.RegisterStartupScript(GetType(), "orderPlaced", "showToast('Reorder successfully placed!','success');", true);
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class stockOut : System.Web.UI.Page
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
                    txtStockOutDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
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
            da = new SqlDataAdapter("SELECT MedicineID, Name, Stock FROM medicines_tbl WHERE Status='Active' ORDER BY Name", con);
            DataTable dtMeds = new DataTable();
            da.Fill(dtMeds);

            outMedicine.Items.Clear();
            outMedicine.Items.Add(new ListItem("-- Select Medicine --", ""));
            foreach (DataRow row in dtMeds.Rows)
            {
                ListItem item = new ListItem(row["Name"].ToString() + " (In Stock: " + row["Stock"].ToString() + ")", row["MedicineID"].ToString());
                outMedicine.Items.Add(item);
            }
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT TOP 10 so.*, m.Name AS MedicineName FROM stockout_tbl so JOIN medicines_tbl m ON so.MedicineID = m.MedicineID ORDER BY so.StockOutID DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvStockOut.DataSource = ds;
            gvStockOut.DataBind();
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM stockout_tbl WHERE CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)", con);
                lblIssuesToday.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(Quantity), 0) FROM stockout_tbl WHERE Reason LIKE '%order%' AND CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)", con);
                lblDispensedToday.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(Quantity), 0) FROM stockout_tbl WHERE (Reason LIKE '%waste%' OR Reason LIKE '%disposal%') AND CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)", con);
                lblWastageToday.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(Quantity), 0) FROM stockout_tbl", con);
                lblTotalUnitsIssued.Text = cmd.ExecuteScalar().ToString();
            }
            catch { }
        }

        protected void btnStockOutSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(outMedicine.SelectedValue) || string.IsNullOrEmpty(outQuantity.Text))
            {
                ClientScript.RegisterStartupScript(GetType(), "err", "showToast('Please select medicine and quantity','warning');", true);
                return;
            }

            getCon();
            int medId = Convert.ToInt32(outMedicine.SelectedValue);
            int qty = Convert.ToInt32(outQuantity.Text);

            // Check current stock
            cmd = new SqlCommand("SELECT Stock FROM medicines_tbl WHERE MedicineID='" + medId + "'", con);
            object objStock = cmd.ExecuteScalar();
            int currentStock = objStock != null ? Convert.ToInt32(objStock) : 0;

            if (qty > currentStock)
            {
                ClientScript.RegisterStartupScript(GetType(), "err", "showToast('Cannot issue more than available stock (" + currentStock + ")!','danger');", true);
                return;
            }

            string batch = txtStockOutBatch.Text.Trim();
            string reason = ddlStockOutReason.SelectedValue;
            string refNo = txtStockOutRef.Text.Trim();
            string notes = txtStockOutNotes.Text.Trim();

            // Insert into stockout_tbl
            string sqlInsert = "INSERT INTO stockout_tbl (MedicineID, BatchNumber, Quantity, Reason, ReferenceNo, Notes, CreatedAt) VALUES ('" + medId + "','" + batch + "','" + qty + "','" + reason + "','" + refNo + "','" + notes + "',GETDATE());";

            // Decrement Stock
            string sqlUpdate = "UPDATE medicines_tbl SET Stock = CASE WHEN Stock >= " + qty + " THEN Stock - " + qty + " ELSE 0 END WHERE MedicineID='" + medId + "';";

            cmd = new SqlCommand(sqlInsert + sqlUpdate, con);
            cmd.ExecuteNonQuery();

            // Reset inputs
            outQuantity.Text = "";
            txtStockOutBatch.Text = "";
            txtStockOutRef.Text = "";
            txtStockOutNotes.Text = "";

            fillDropdowns();
            fillgrid();
            fillStats();

            ClientScript.RegisterStartupScript(GetType(), "success", "showToast('Stock issue recorded and inventory deducted!','success');", true);
        }
    }
}
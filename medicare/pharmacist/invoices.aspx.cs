using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class invoices : System.Web.UI.Page
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

        void fillgrid()
        {
            getCon();
            string sql = @"
                SELECT i.InvoiceID, ISNULL(i.InvoiceCode, 'INV-' + CAST(i.InvoiceID AS VARCHAR)) AS InvoiceNo,
                       ISNULL(o.OrderCode, 'ORD-' + CAST(i.OrderID AS VARCHAR)) AS OrderCode,
                       ISNULL(r.FirstName + ' ' + r.LastName, 'Walk-in Customer') AS CustomerName,
                       ISNULL(r.Phone, '—') AS CustomerPhone,
                       i.InvoiceDate,
                       1 AS ItemsCount,
                       i.TotalAmount,
                       ISNULL(i.PaymentMethod, 'Cash') AS PaymentMethod,
                       ISNULL(i.PaymentStatus, 'Paid') AS Status
                FROM invoices_tbl i
                LEFT JOIN Orders o ON i.OrderID = o.OrderID
                LEFT JOIN regi_tbl r ON i.CustomerID = r.Id
                WHERE 1=1";

            if (!string.IsNullOrEmpty(paymentStatus.SelectedValue))
            {
                sql += " AND i.PaymentStatus = '" + paymentStatus.SelectedValue + "'";
            }

            if (!string.IsNullOrEmpty(paymentMethod.SelectedValue))
            {
                sql += " AND i.PaymentMethod = '" + paymentMethod.SelectedValue + "'";
            }

            if (!string.IsNullOrEmpty(dateFrom.Text))
            {
                sql += " AND i.InvoiceDate >= '" + dateFrom.Text + "'";
            }

            if (!string.IsNullOrEmpty(dateTo.Text))
            {
                sql += " AND i.InvoiceDate <= '" + dateTo.Text + " 23:59:59'";
            }

            sql += " ORDER BY i.InvoiceID DESC";

            da = new SqlDataAdapter(sql, con);
            ds = new DataSet();
            da.Fill(ds);
            gvInvoices.DataSource = ds;
            gvInvoices.DataBind();

            invoiceCount.Text = "Showing " + ds.Tables[0].Rows.Count + " invoices";
        }

        void fillStats()
        {
            try
            {
                getCon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM invoices_tbl", con);
                lblTotalInvoices.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount), 0) FROM invoices_tbl WHERE PaymentStatus='Paid'", con);
                decimal paid = Convert.ToDecimal(cmd.ExecuteScalar());
                lblPaidAmount.Text = "₹" + paid.ToString("N0");

                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount), 0) FROM invoices_tbl WHERE PaymentStatus='Pending'", con);
                decimal pending = Convert.ToDecimal(cmd.ExecuteScalar());
                lblPendingAmount.Text = "₹" + pending.ToString("N0");

                cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount), 0) FROM invoices_tbl WHERE PaymentStatus='Refunded'", con);
                decimal refunded = Convert.ToDecimal(cmd.ExecuteScalar());
                lblRefundedAmount.Text = "₹" + refunded.ToString("N0");
            }
            catch { }
        }

        protected void filterInvoices_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void clearFilters_Click(object sender, EventArgs e)
        {
            invoiceSearch.Text = "";
            paymentStatus.SelectedIndex = 0;
            invoiceStatus.SelectedIndex = 0;
            paymentMethod.SelectedIndex = 0;
            dateFrom.Text = "";
            dateTo.Text = "";
            fillgrid();
        }

        protected void exportInvoices_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "export", "showToast('Invoice export initiated!','info');", true);
        }

        protected void gvInvoices_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int invId = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "cmd_view" || e.CommandName == "cmd_print" || e.CommandName == "cmd_download")
            {
                ClientScript.RegisterStartupScript(GetType(), "invAction", "showToast('Invoice #" + invId + " action: " + e.CommandName + "','info');", true);
            }
        }

        protected void btnCreateInvoiceSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            string code = "INV-" + DateTime.Now.Ticks.ToString().Substring(11);
            decimal amt = 0;
            decimal.TryParse(newAmount.Text, out amt);
            string method = newPayment.SelectedValue;

            string sql = "INSERT INTO invoices_tbl (InvoiceCode, TotalAmount, PaymentMethod, PaymentStatus, InvoiceDate) VALUES ('" + code + "','" + amt + "','" + method + "','Paid',GETDATE())";
            cmd = new SqlCommand(sql, con);
            cmd.ExecuteNonQuery();

            newCustomer.Text = "";
            newOrder.Text = "";
            newAmount.Text = "";

            fillgrid();
            fillStats();

            ClientScript.RegisterStartupScript(GetType(), "invCreated", "showToast('Invoice " + code + " created successfully!','success');", true);
        }
    }
}
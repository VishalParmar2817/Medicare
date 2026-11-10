using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.admin
{
    public partial class settings : System.Web.UI.Page
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
                    loadSettings();
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

        void loadSettings()
        {
            getCon();
            da = new SqlDataAdapter("SELECT SettingKey, SettingValue FROM PharmacySettings", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                string key = row["SettingKey"].ToString();
                string val = row["SettingValue"].ToString();
                switch (key)
                {
                    case "PharmacyName":    txtPharmacyName.Text = val; break;
                    case "Tagline":         txtTagline.Text = val; break;
                    case "ContactEmail":    txtContactEmail.Text = val; break;
                    case "ContactPhone":    txtContactPhone.Text = val; break;
                    case "Address":         txtAddress.Text = val; break;
                    case "GSTIN":           txtGSTIN.Text = val; break;
                    case "DrugLicenseNo":   txtDrugLicense.Text = val; break;
                    case "EmailNotifications": chkEmailNotif.Checked = val.ToLower() == "true"; break;
                    case "SMSNotifications":   chkSMSNotif.Checked = val.ToLower() == "true"; break;
                    case "LowStockAlerts":     chkLowStockAlert.Checked = val.ToLower() == "true"; break;
                    case "ExpiryAlerts":       chkExpiryAlert.Checked = val.ToLower() == "true"; break;
                    case "TwoFAEnabled":        chkTwoFA.Checked = val.ToLower() == "true"; break;
                    case "MinPasswordLength":   txtMinPwdLen.Text = val; break;
                    case "SessionTimeoutMins":  txtSessionTimeout.Text = val; break;
                    case "DefaultTaxRate":      txtTaxRate.Text = val; break;
                    case "CODEnabled":          chkCOD.Checked = val.ToLower() == "true"; break;
                    case "CardPayEnabled":      chkCard.Checked = val.ToLower() == "true"; break;
                    case "UPIEnabled":          chkUPI.Checked = val.ToLower() == "true"; break;
                    case "FontFamily":          txtFontFamily.Text = val; break;
                    case "PrimaryColor":        txtPrimaryColor.Text = val; break;
                    case "AccentColor":         txtAccentColor.Text = val; break;
                    case "Currency":
                        if (ddlCurrency.Items.FindByValue(val) != null)
                            ddlCurrency.SelectedValue = val;
                        break;
                    case "SidebarStyle":
                        if (ddlSidebarStyle.Items.FindByValue(val) != null)
                            ddlSidebarStyle.SelectedValue = val;
                        break;
                }
            }
        }

        void saveSetting(string key, string val)
        {
            getCon();
            cmd = new SqlCommand(
                "IF EXISTS (SELECT 1 FROM PharmacySettings WHERE SettingKey='" + key + "') " +
                "UPDATE PharmacySettings SET SettingValue='" + val + "', UpdatedAt=GETDATE() WHERE SettingKey='" + key + "' " +
                "ELSE INSERT INTO PharmacySettings (SettingKey, SettingValue) VALUES ('" + key + "','" + val + "')", con);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btnSaveGeneral_Click(object sender, EventArgs e)
        {
            saveSetting("PharmacyName", txtPharmacyName.Text);
            saveSetting("Tagline", txtTagline.Text);
            saveSetting("ContactEmail", txtContactEmail.Text);
            saveSetting("ContactPhone", txtContactPhone.Text);
            saveSetting("Address", txtAddress.Text);
            saveSetting("GSTIN", txtGSTIN.Text);
            saveSetting("DrugLicenseNo", txtDrugLicense.Text);
            loadSettings();
        }

        protected void btnSaveNotif_Click(object sender, EventArgs e)
        {
            saveSetting("EmailNotifications", chkEmailNotif.Checked ? "true" : "false");
            saveSetting("SMSNotifications", chkSMSNotif.Checked ? "true" : "false");
            saveSetting("LowStockAlerts", chkLowStockAlert.Checked ? "true" : "false");
            saveSetting("ExpiryAlerts", chkExpiryAlert.Checked ? "true" : "false");
            loadSettings();
        }

        protected void btnSaveSecurity_Click(object sender, EventArgs e)
        {
            saveSetting("TwoFAEnabled", chkTwoFA.Checked ? "true" : "false");
            saveSetting("MinPasswordLength", txtMinPwdLen.Text);
            saveSetting("SessionTimeoutMins", txtSessionTimeout.Text);
            loadSettings();
        }

        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            saveSetting("DefaultTaxRate", txtTaxRate.Text);
            saveSetting("Currency", ddlCurrency.SelectedValue);
            saveSetting("CODEnabled", chkCOD.Checked ? "true" : "false");
            saveSetting("CardPayEnabled", chkCard.Checked ? "true" : "false");
            saveSetting("UPIEnabled", chkUPI.Checked ? "true" : "false");
            loadSettings();
        }

        protected void btnSaveAppearance_Click(object sender, EventArgs e)
        {
            saveSetting("FontFamily", txtFontFamily.Text);
            saveSetting("PrimaryColor", txtPrimaryColor.Text);
            saveSetting("AccentColor", txtAccentColor.Text);
            saveSetting("SidebarStyle", ddlSidebarStyle.SelectedValue);
            loadSettings();
        }
    }
}
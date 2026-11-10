using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace medicare.customer
{
    public partial class profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

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
                loadProfile();
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

        void loadProfile()
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
                    string fname = r["FirstName"] != DBNull.Value ? r["FirstName"].ToString() : "";
                    string lname = r["LastName"] != DBNull.Value ? r["LastName"].ToString() : "";
                    string fullName = (fname + " " + lname).Trim();

                    txtFirstName.Text = fname;
                    txtLastName.Text = lname;
                    txtEmail.Text = email;
                    txtPhone.Text = r["Phone"] != DBNull.Value ? r["Phone"].ToString() : "";
                    txtDOB.Text = r["DOB"] != DBNull.Value ? r["DOB"].ToString() : "";

                    string g = r["Gender"] != DBNull.Value ? r["Gender"].ToString().Trim() : "";
                    if (ddlGender.Items.FindByText(g) != null)
                    {
                        ddlGender.SelectedValue = g;
                    }

                    lblProfileName.Text = !string.IsNullOrEmpty(fullName) ? fullName : "Customer";
                    lblProfileEmail.Text = email;
                    lblProfilePhone.Text = !string.IsNullOrEmpty(txtPhone.Text) ? txtPhone.Text : "—";

                    string initials = "CU";
                    if (!string.IsNullOrEmpty(fname))
                    {
                        initials = fname.Substring(0, 1).ToUpper() + (!string.IsNullOrEmpty(lname) ? lname.Substring(0, 1).ToUpper() : "");
                    }
                    lblAvatarInitials.Text = initials;

                    string savedAddr = r["Address"] != DBNull.Value ? r["Address"].ToString() : "";
                    lblSavedAddress.Text = !string.IsNullOrEmpty(savedAddr) ? savedAddr : "No address on file. Click 'Add New' to add one.";

                    int custId = getCustomerId();
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE CustomerID='" + custId + "'", con);
                    lblProfileOrderCount.Text = cmd.ExecuteScalar().ToString();

                    cmd = new SqlCommand("SELECT COUNT(*) FROM prescriptions_tbl WHERE CustomerID='" + custId + "'", con);
                    lblProfileRxCount.Text = cmd.ExecuteScalar().ToString();
                }
            }
            catch { }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                string email = (Session["customer"] ?? Session["admin"]).ToString();
                cmd = new SqlCommand(
                    "UPDATE regi_tbl SET FirstName='" + txtFirstName.Text.Trim() + "', LastName='" + txtLastName.Text.Trim() + "', Phone='" + txtPhone.Text.Trim() + "', DOB='" + txtDOB.Text.Trim() + "', Gender='" + ddlGender.SelectedValue + "' WHERE Email='" + email + "'", con);
                cmd.ExecuteNonQuery();

                loadProfile();
                ClientScript.RegisterStartupScript(GetType(), "profUpdated", "showToast('Profile updated successfully!','success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "profErr", "showToast('Update failed: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtNewPassword.Text) || txtNewPassword.Text != txtConfirmPassword.Text)
                {
                    ClientScript.RegisterStartupScript(GetType(), "pwdMismatch", "showToast('New passwords do not match or is empty.','error');", true);
                    return;
                }

                getCon();
                string email = (Session["customer"] ?? Session["admin"]).ToString();
                cmd = new SqlCommand("SELECT Password FROM regi_tbl WHERE Email='" + email + "'", con);
                object currPwd = cmd.ExecuteScalar();

                if (currPwd != null && currPwd.ToString() != txtCurrentPassword.Text.Trim())
                {
                    ClientScript.RegisterStartupScript(GetType(), "pwdWrong", "showToast('Current password is incorrect.','error');", true);
                    return;
                }

                cmd = new SqlCommand("UPDATE regi_tbl SET Password='" + txtNewPassword.Text.Trim() + "' WHERE Email='" + email + "'", con);
                cmd.ExecuteNonQuery();

                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
                ClientScript.RegisterStartupScript(GetType(), "pwdSuccess", "showToast('Password changed successfully!','success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "pwdErr", "showToast('Password update failed: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }

        protected void btnSaveAddress_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                string email = (Session["customer"] ?? Session["admin"]).ToString();
                string addr = (txtAddrLine1.Text + " " + txtAddrLine2.Text + ", " + txtAddrCity.Text + " - " + txtAddrPinCode.Text + ", " + txtAddrState.Text).Trim();

                cmd = new SqlCommand("UPDATE regi_tbl SET Address='" + addr + "' WHERE Email='" + email + "'", con);
                cmd.ExecuteNonQuery();

                loadProfile();
                ClientScript.RegisterStartupScript(GetType(), "addrUpdated", "showToast('Address saved successfully!','success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "addrErr", "showToast('Address save failed: " + ex.Message.Replace("'", "") + "','error');", true);
            }
        }
    }
}

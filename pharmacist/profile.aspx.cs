using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
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
            if (Session["pharmacist"] != null)
            {
                getCon();
                if (!IsPostBack)
                {
                    filldata();
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

        void filldata()
        {
            try
            {
                getCon();
                string email = Session["pharmacist"].ToString();

                string sql = @"
                    SELECT r.Id, r.FirstName, r.LastName, (r.FirstName + ' ' + r.LastName) AS FullName, r.Email, r.Phone AS PhoneNumber,
                           ph.LicenseNumber, ph.Specialization, ph.Department
                    FROM regi_tbl r
                    LEFT JOIN pharmacists_tbl ph ON r.Id = ph.Id
                    WHERE r.Email = '" + email + "'";

                da = new SqlDataAdapter(sql, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].Rows[0];
                    string fullName = dr["FullName"].ToString();
                    lblProfileName.Text = fullName;
                    lblProfileEmail.Text = dr["Email"].ToString();

                    string[] parts = fullName.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    if (parts.Length > 0)
                    {
                        txtFirstName.Text = parts[0];
                        txtLastName.Text = parts.Length > 1 ? string.Join(" ", parts, 1, parts.Length - 1) : "";
                        lblInitials.Text = (parts[0].Substring(0, 1) + (parts.Length > 1 ? parts[1].Substring(0, 1) : "")).ToUpper();
                    }

                    txtEmail.Text = dr["Email"].ToString();
                    txtPhone.Text = dr["PhoneNumber"] != DBNull.Value ? dr["PhoneNumber"].ToString() : "";

                    if (dr["Department"] != DBNull.Value && ddlDept.Items.FindByText(dr["Department"].ToString()) != null)
                    {
                        ddlDept.SelectedValue = dr["Department"].ToString();
                    }

                    if (dr["LicenseNumber"] != DBNull.Value)
                    {
                        txtLicense.Text = dr["LicenseNumber"].ToString();
                    }
                }
            }
            catch { }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            try
            {
                getCon();
                string email = Session["pharmacist"].ToString();
                string fullName = (txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim()).Trim();
                string phone = txtPhone.Text.Trim();
                string dept = ddlDept.SelectedValue;
                string license = txtLicense.Text.Trim();

                string[] parts = fullName.Split(new char[] { ' ' }, 2);
                string fName = parts[0];
                string lName = parts.Length > 1 ? parts[1] : "";

                // 1. Update regi_tbl
                string sqlUser = "UPDATE regi_tbl SET FirstName='" + fName + "', LastName='" + lName + "', Phone='" + phone + "' WHERE Email='" + email + "';";

                // 2. Update pharmacists_tbl
                string sqlPharm = @"
                    IF EXISTS (SELECT 1 FROM pharmacists_tbl ph JOIN regi_tbl r ON ph.Id = r.Id WHERE r.Email = '" + email + @"')
                        UPDATE pharmacists_tbl SET Department='" + dept + "', LicenseNumber='" + license + @"' WHERE Id=(SELECT Id FROM regi_tbl WHERE Email='" + email + @"');
                    ELSE
                        INSERT INTO pharmacists_tbl (Id, LicenseNumber, Department, Status, CreatedAt) VALUES ((SELECT Id FROM regi_tbl WHERE Email='" + email + @"'), '" + license + @"', '" + dept + @"', 'Active', GETDATE());";

                cmd = new SqlCommand(sqlUser + sqlPharm, con);
                cmd.ExecuteNonQuery();

                filldata();
                ClientScript.RegisterStartupScript(GetType(), "profileSaved", "showToast('Profile updated successfully!','success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "profileError", "showToast('Error updating profile: " + ex.Message.Replace("'", "") + "','danger');", true);
            }
        }
    }
}
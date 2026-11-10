using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace medicare.admin
{
    public partial class pharmacists : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string img, nm;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                getCon();
                totalph();
                fillgrid();
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

        void totalph()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from pharmacists_tbl", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalPh.Text = i.ToString();

            cmd = new SqlCommand("select count(*) from pharmacists_tbl where Status='Active'", con);
            int active = Convert.ToInt32(cmd.ExecuteScalar());
            lblActivePh.Text = active.ToString();

            cmd = new SqlCommand("select count(*) from pharmacists_tbl where Status='Inactive'", con);
            int inactive = Convert.ToInt32(cmd.ExecuteScalar());
            lblInactivePh.Text = inactive.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT p.*, r.FirstName, r.LastName, r.Email, r.Phone AS PhoneNumber FROM pharmacists_tbl p LEFT JOIN regi_tbl r ON p.Id = r.Id", con);
            ds = new DataSet();
            da.Fill(ds);
            gvPharmacists.DataSource = ds;
            gvPharmacists.DataBind();
        }

        protected void btnAddPhSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            string[] nameParts = txtPhName.Text.Trim().Split(new char[] { ' ' }, 2);
            string firstName = nameParts[0];
            string lastName = nameParts.Length > 1 ? nameParts[1] : "";
            string pwd = string.IsNullOrEmpty(txtPhPassword.Text) ? "Pharma@123" : txtPhPassword.Text;

            cmd = new SqlCommand("insert into regi_tbl (FirstName, LastName, Email, Phone, DOB, Gender, Password, Address, Role) values ('" + firstName + "','" + lastName + "','" + txtPhEmail.Text + "','" + txtPhPhone.Text + "','','Other','" + pwd + "','','Pharmacist'); SELECT SCOPE_IDENTITY();", con);
            int newUserId = Convert.ToInt32(cmd.ExecuteScalar());

            string phCode = "PH-" + DateTime.Now.Ticks.ToString().Substring(14);
            cmd = new SqlCommand("insert into pharmacists_tbl (Id, PharmacistCode, LicenseNumber, Specialization, Status, JoinedDate, CreatedAt) values ('" + newUserId + "','" + phCode + "','" + txtPhLicense.Text + "','" + txtPhSpec.Text + "','" + ddlPhStatus.SelectedValue + "',CAST(GETDATE() AS DATE),GETDATE())", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            totalph();
        }

        void filldata()
        {
            getCon();
            da = new SqlDataAdapter("SELECT p.*, r.FirstName, r.LastName, r.Email, r.Phone AS PhoneNumber FROM pharmacists_tbl p LEFT JOIN regi_tbl r ON p.Id = r.Id WHERE p.PharmacistID='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                ViewState["UserId"] = row["Id"].ToString();
                txtEditPhName.Text = (row["FirstName"].ToString() + " " + row["LastName"].ToString()).Trim();
                txtEditPhEmail.Text = row["Email"].ToString();
                txtEditPhPhone.Text = row["PhoneNumber"].ToString();
                txtEditPhLicense.Text = row["LicenseNumber"].ToString();
                txtEditPhSpec.Text = row["Specialization"].ToString();

                if (row["Status"].ToString() == "Active")
                {
                    ddlEditPhStatus.SelectedValue = "Active";
                }
                else
                {
                    ddlEditPhStatus.SelectedValue = "Inactive";
                }
            }
        }

        protected void gvPharmacists_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showEditPharmacist",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editPhModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("delete from pharmacists_tbl where PharmacistID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalph();
            }
        }

        protected void btnEditPhSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            string[] nameParts = txtEditPhName.Text.Trim().Split(new char[] { ' ' }, 2);
            string firstName = nameParts[0];
            string lastName = nameParts.Length > 1 ? nameParts[1] : "";

            cmd = new SqlCommand("update pharmacists_tbl set LicenseNumber='" + txtEditPhLicense.Text + "', Specialization='" + txtEditPhSpec.Text + "', Status='" + ddlEditPhStatus.SelectedValue + "' where PharmacistID='" + ViewState["Id"] + "'", con);
            cmd.ExecuteNonQuery();

            if (ViewState["UserId"] != null)
            {
                cmd = new SqlCommand("update regi_tbl set FirstName='" + firstName + "', LastName='" + lastName + "', Email='" + txtEditPhEmail.Text + "', Phone='" + txtEditPhPhone.Text + "' where Id='" + ViewState["UserId"] + "'", con);
                cmd.ExecuteNonQuery();
            }
            fillgrid();
        }
    }
}
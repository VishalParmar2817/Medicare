using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medicare.pharmacist
{
    public partial class medicineManagement : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
        string img;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["pharmacist"] != null)
            {
                getCon();
                if (!IsPostBack)
                {
                    fillDropdowns();
                }
                totalmed();
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

        void totalmed()
        {
            getCon();
            cmd = new SqlCommand("select count(*) from medicines_tbl", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalMed.Text = i.ToString();

            cmd = new SqlCommand("select count(*) from medicines_tbl where Stock > MinStockLevel", con);
            int inStock = Convert.ToInt32(cmd.ExecuteScalar());
            lblInStock.Text = inStock.ToString();

            cmd = new SqlCommand("select count(*) from medicines_tbl where Stock <= MinStockLevel and Stock > 0", con);
            int lowStock = Convert.ToInt32(cmd.ExecuteScalar());
            lblLowStock.Text = lowStock.ToString();

            cmd = new SqlCommand("select count(*) from medicines_tbl where RxRequired='True' or RxRequired='1'", con);
            int rx = Convert.ToInt32(cmd.ExecuteScalar());
            lblRxRequired.Text = rx.ToString();
        }

        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from medicines_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            gvMedicines.DataSource = ds;
            gvMedicines.DataBind();
        }

        //void fillDropdowns()
        //{
        //    getCon();
        //    da = new SqlDataAdapter("select * from brands_tbl", con);
        //    ds = new DataSet();
        //    da.Fill(ds);
        //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //    {
        //        ddlMedBrand.Items.Add(ds.Tables[0].Rows[i]["Name"].ToString());
        //    }


        //    getCon();
        //    da = new SqlDataAdapter("select * from categories_tbl", con);
        //    ds = new DataSet();
        //    da.Fill(ds);
        //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //    {
        //        ddlMedCategory.Items.Add(ds.Tables[0].Rows[i]["Name"].ToString());
        //    }
        //}

        void fillDropdowns()
        {
            // Brand Dropdown
            getCon();
            da = new SqlDataAdapter("select * from brands_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlMedBrand.DataSource = ds;
            ddlMedBrand.DataTextField = "Name";
            ddlMedBrand.DataValueField = "BrandID";
            ddlMedBrand.DataBind();

            ddlEditMedBrand.DataSource = ds;
            ddlEditMedBrand.DataTextField = "Name";
            ddlEditMedBrand.DataValueField = "BrandID";
            ddlEditMedBrand.DataBind();

            getCon();
            da = new SqlDataAdapter("select * from categories_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlMedCategory.DataSource = ds;
            ddlMedCategory.DataTextField = "Name";
            ddlMedCategory.DataValueField = "CategoryID";
            ddlMedCategory.DataBind();

            ddlEditMedCategory.DataSource = ds;
            ddlEditMedCategory.DataTextField = "Name";
            ddlEditMedCategory.DataValueField = "CategoryID";
            ddlEditMedCategory.DataBind();
        }


        void imgupload()
        {
            img = "~/m_images/" + FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath(img));
        }

   
        protected void btnAddMedSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            imgupload();
            cmd = new SqlCommand("insert into medicines_tbl (Name,GenericName,BrandID,CategoryID,MedicineType,DosageForm,Strength,PackSize,Price,MRP,Discount,Stock,MinStockLevel,RxRequired,ImageUrl,Description,Uses,Dosage,SideEffects,Interactions,Precautions,Composition,InactiveIngredients,Storage,Manufacturer,CountryOfOrigin,Status) values ('" + txtMedName.Text + "','" + txtGenericName.Text + "','" + ddlMedBrand.SelectedValue + "','" + ddlMedCategory.SelectedValue + "','" + txtMedType.Text + "','" + txtMedDosageForm.Text + "','" + txtMedStrength.Text + "','" + txtMedPackSize.Text + "','" + txtMedPrice.Text + "','" + txtMedMRP.Text + "','" + txtMedDiscount.Text + "','" + txtMedStock.Text + "','" + txtMedMinStockLevel.Text + "','" + chkRxRequired.Checked + "','" + img + "','" + txtMedDesc.Text + "','" + txtMedUses.Text + "','" + txtMedDosage.Text + "','" + txtMedSideEffects.Text + "','" + txtMedInteractions.Text + "','" + txtMedPrecautions.Text + "','" + txtMedComposition.Text + "','" + txtMedInactiveIngredients.Text + "','" + txtMedStorage.Text + "','" + txtMedManufacturer.Text + "','" + txtMedCountry.Text + "','" + ddlMedStatus.SelectedValue + "')", con); cmd.ExecuteNonQuery();
            cmd.ExecuteNonQuery();
            fillgrid();
            totalmed();
        }

        void filldata()
        {
            getCon();

            da = new SqlDataAdapter(
                "select * from medicines_tbl  where MedicineID='" + ViewState["Id"] + "'", con);

            ds = new DataSet();
            da.Fill(ds);

            txtEditMedName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
            txtEditGenericName.Text = ds.Tables[0].Rows[0]["GenericName"].ToString();
            ddlEditMedBrand.SelectedValue = ds.Tables[0].Rows[0]["BrandID"].ToString();
            ddlEditMedCategory.SelectedValue = ds.Tables[0].Rows[0]["CategoryID"].ToString();

            txtEditMedType.Text = ds.Tables[0].Rows[0]["MedicineType"].ToString();
            txtEditMedDosageForm.Text = ds.Tables[0].Rows[0]["DosageForm"].ToString();
            txtEditMedStrength.Text = ds.Tables[0].Rows[0]["Strength"].ToString();
            txtEditMedPackSize.Text = ds.Tables[0].Rows[0]["PackSize"].ToString();

            txtEditMedPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();
            txtEditMedMRP.Text = ds.Tables[0].Rows[0]["MRP"].ToString();
            txtEditMedDiscount.Text = ds.Tables[0].Rows[0]["Discount"].ToString();
            txtEditMedStock.Text = ds.Tables[0].Rows[0]["Stock"].ToString();
            txtEditMedMinStockLevel.Text = ds.Tables[0].Rows[0]["MinStockLevel"].ToString();

            chkEditRxRequired.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["RxRequired"]);

            img = ds.Tables[0].Rows[0]["ImageUrl"].ToString();
            txtEditMedDesc.Text = ds.Tables[0].Rows[0]["Description"].ToString();
            txtEditMedUses.Text = ds.Tables[0].Rows[0]["Uses"].ToString();
            txtEditMedDosage.Text = ds.Tables[0].Rows[0]["Dosage"].ToString();
            txtEditMedSideEffects.Text = ds.Tables[0].Rows[0]["SideEffects"].ToString();
            txtEditMedInteractions.Text = ds.Tables[0].Rows[0]["Interactions"].ToString();
            txtEditMedPrecautions.Text = ds.Tables[0].Rows[0]["Precautions"].ToString();
            txtEditMedComposition.Text = ds.Tables[0].Rows[0]["Composition"].ToString();
            txtEditMedInactiveIngredients.Text = ds.Tables[0].Rows[0]["InactiveIngredients"].ToString();
            txtEditMedStorage.Text = ds.Tables[0].Rows[0]["Storage"].ToString();
            txtEditMedManufacturer.Text = ds.Tables[0].Rows[0]["Manufacturer"].ToString();
            txtEditMedCountry.Text = ds.Tables[0].Rows[0]["CountryOfOrigin"].ToString();

            ddlEditMedStatus.SelectedValue = ds.Tables[0].Rows[0]["Status"].ToString();
        }

        protected void gvMedicines_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;

                ClientScript.RegisterStartupScript(GetType(), "showEditMedicine",
                    "bootstrap.Modal.getOrCreateInstance(document.getElementById('editMedModal')).show();", true);
                filldata();
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["Id"] = id;
                getCon();
                cmd = new SqlCommand("delete from medicines_tbl where MedicineID='" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                totalmed();
            }
        }

        protected void btnEditMedSubmit_Click(object sender, EventArgs e)
        {
            getCon();
            imgupload();
            cmd = new SqlCommand("update medicines_tbl set " +
                "Name='" + txtEditMedName.Text + "'," +
                "GenericName='" + txtEditGenericName.Text + "'," +
                "BrandID='" + ddlEditMedBrand.SelectedValue + "'," +
                "CategoryID='" + ddlEditMedCategory.SelectedValue + "'," +
                "MedicineType='" + txtEditMedType.Text + "'," +
                "DosageForm='" + txtEditMedDosageForm.Text + "'," +
                "Strength='" + txtEditMedStrength.Text + "'," +
                "PackSize='" + txtEditMedPackSize.Text + "'," +
                "Price='" + txtEditMedPrice.Text + "'," +
                "MRP='" + txtEditMedMRP.Text + "'," +
                "Discount='" + txtEditMedDiscount.Text + "'," +
                "Stock='" + txtEditMedStock.Text + "'," +
                "MinStockLevel='" + txtEditMedMinStockLevel.Text + "'," +
                "RxRequired='" + chkEditRxRequired.Checked + "'," +
                "ImageUrl='" + img + "'," +
                "Description='" + txtEditMedDesc.Text + "'," +
                "Uses='" + txtEditMedUses.Text + "'," +
                "Dosage='" + txtEditMedDosage.Text + "'," +
                "SideEffects='" + txtEditMedSideEffects.Text + "'," +
                "Interactions='" + txtEditMedInteractions.Text + "'," +
                "Precautions='" + txtEditMedPrecautions.Text + "'," +
                "Composition='" + txtEditMedComposition.Text + "'," +
                "InactiveIngredients='" + txtEditMedInactiveIngredients.Text + "'," +
                "Storage='" + txtEditMedStorage.Text + "'," +
                "Manufacturer='" + txtEditMedManufacturer.Text + "'," +
                "CountryOfOrigin='" + txtEditMedCountry.Text + "'," +
                "Status='" + ddlEditMedStatus.SelectedValue + "'" +
                " where MedicineID='" + ViewState["Id"] + "'", con);
            
            cmd.ExecuteNonQuery();
            fillgrid();
        }
    }
}
using System;
using System.Web.UI;

namespace medicare.customer
{
    public partial class contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSendContact_Click(object sender, EventArgs e)
        {
            txtContactName.Text = "";
            txtContactEmail.Text = "";
            txtContactMessage.Text = "";
            ClientScript.RegisterStartupScript(GetType(), "contactSent",
                "document.getElementById('contactStatus').classList.remove('d-none'); showToast('Thank you! Message received.','success');", true);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas.MasterPages
{
    public partial class Cabecera : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            // Limpiamos la sesión y redirigimos al Home
            Session.Clear();
            Response.Redirect("Inicio.aspx");
        }
    }
}
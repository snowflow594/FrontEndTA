using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class DireccionesGuardadas : System.Web.UI.Page
    {
        private PersonaClient personaWSClient = new PersonaClient();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void CargarDirecciones()
        {
            try
            {
                if (Session["idPersona"] == null)
                {
                    lblMensaje.Text = "No se encontró la sesión de persona.";
                    return;
                }

                int idPersona = Convert.ToInt32(Session["idPersona"]);
                var persona = personaWSClient.obtenerPorIdPersona(idPersona);

                if (persona != null && persona.direcciones != null && persona.direcciones.Length > 0)
                {
                    var direcciones = persona.direcciones.Select(d => new { direccion = d }).ToList();

                    rptDirecciones.DataSource = direcciones;
                    rptDirecciones.DataBind();
                }
                else
                {
                    lblMensaje.Text = "No tienes direcciones guardadas.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar direcciones: " + ex.Message;
            }
        }

        protected void btnUsarDireccion_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                int idDireccion = Convert.ToInt32(btn.CommandArgument);

                Session["idDireccionSeleccionada"] = idDireccion; //lo gurdamos en session

                Response.Redirect("DireccionEnvio.aspx");
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al seleccionar la dirección: " + ex.Message;
            }
        }
    }
}
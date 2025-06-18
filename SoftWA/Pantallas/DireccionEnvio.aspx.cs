using SoftWA.DireccionWSClient;
using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class DireccionEnvio : System.Web.UI.Page
    {
        private ItemCarritoClient itemCarritoWSClient = new ItemCarritoClient();
        private SoftWA.DireccionWSClient.DireccionClient direccionWSClient = new DireccionWSClient.DireccionClient();
        private CarritoClient carritoWSClient = new CarritoClient();
        private PersonaClient personaWSClient = new PersonaClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarResumenCarrito();
            }
        }

        private void CargarResumenCarrito()
        {
            int idCarrito = Convert.ToInt32(Session["idCarrito"]);
            var carrito = carritoWSClient.obtenerPorIdCarrito(idCarrito);

            double subtotal = 0;

            if (carrito != null && carrito.items != null)
            {
                foreach (var item in carrito.items)
                {
                    subtotal += item.subtotal;
                }

                double igv = subtotal * 0.18;
                double total = subtotal + igv;

                lblSubtotal.Text = subtotal.ToString("F2");
                lblIGV.Text = igv.ToString("F2");
                lblTotal.Text = total.ToString("F2");
            }
            else
            {
                lblSubtotal.Text = "0.00";
                lblIGV.Text = "0.00";
                lblTotal.Text = "0.00";
            }
        }

        protected void btnGuardarDireccion_Click(object sender, EventArgs e)
        {
            if (Session["idPersona"] != null)
            {
                int idPersona = Convert.ToInt32(Session["idPersona"]);
                int idUsuario = Convert.ToInt32(Session["idUsuario"]);

                var nuevaDireccion = new DireccionWSClient.direccionDTO
                {
                    personaId = new DireccionWSClient.personaDTO { id = idPersona },
                    alias = txtAlias.Text,
                    direccion = txtDireccion.Text,
                    ciudad = txtCiudad.Text,
                    referencia = txtReferencia.Text,
                    usuarioCreacion = new DireccionWSClient.usuarioDTO { id = idUsuario }
                };

                int i = direccionWSClient.insertarDireccion(nuevaDireccion); //aquí hay un error, creo que se duplican las clases o algo así porque sale direccionDTO y direccionDTO1 con el servicio completo agrupado

                // Obtener la última dirección registrada por esa persona y usuario
                var listaDirecciones = direccionWSClient.listarTodosDireccion();

                var ultimaDireccion = listaDirecciones?
                    .Where(d => d != null &&
                                d.personaId != null && d.personaId.id == idPersona &&
                                d.usuarioCreacion != null && d.usuarioCreacion.id == idUsuario &&
                                d.direccion == txtDireccion.Text && d.alias == txtAlias.Text)
                    .OrderByDescending(d => d.id)
                    .FirstOrDefault();

                if (ultimaDireccion != null)
                {
                    Session["idDireccionSelececionada"] = ultimaDireccion.id;
                    lblMensaje.CssClass = "text-success mt-2 d-block";
                    lblMensaje.Text = "¡Dirección guardada con éxito!";
                }
                else
                {
                    lblMensaje.CssClass = "text-danger mt-2 d-block";
                    lblMensaje.Text = "No se pudo guardar la dirección. Intenta nuevamente.";
                }
                Response.Redirect("DireccionEnvio.aspx");
            }
        }


        protected void btnVerDirecciones_Click(object sender, EventArgs e)
        {
            Response.Redirect("DireccionesGuardadas.aspx");
        }

        protected void btnContinuarPago_Click(object sender, EventArgs e)
        {
            if (Session["idDireccionSelececionada"] == null)
            {
                lblMensaje.Text = "Por favor selecciona o registra una dirección antes de continuar.";
                return;
            }

            Response.Redirect("DatosDePago.aspx");
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static bool SeleccionarDireccion(int idDireccion)
        {
            HttpContext.Current.Session["idDireccionSelececionada"] = idDireccion;
            return true;
        }
    }
}
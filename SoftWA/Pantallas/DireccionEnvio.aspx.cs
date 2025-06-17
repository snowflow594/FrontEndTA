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
        private DireccionClient direccionWSClient = new DireccionClient();
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

            foreach(var item in carrito.items)
            {
                subtotal += item.subtotal;
            }

            double igv = subtotal * 0.18;
            double total = subtotal + igv; // sin sumar envío aún

            lblSubtotal.Text = subtotal.ToString("F2");
            lblIGV.Text = igv.ToString("F2");
            lblTotal.Text = total.ToString("F2");
        }

        protected void btnGuardarDireccion_Click(object sender, EventArgs e)
        {
            if (Session["idPersona"] != null)
            {
                int idPersona = Convert.ToInt32(Session["idPersona"]);
                int idUsuario = Convert.ToInt32(Session["idUsuario"]);

                var nuevaDireccion = new SoftWA.ServiciosWSClient.direccionDTO1
                {
                    personaId = new SoftWA.ServiciosWSClient.personaDTO1 { id = idPersona},
                    alias = txtAlias.Text,
                    direccion = txtDireccion.Text,
                    ciudad = txtCiudad.Text,
                    referencia = txtReferencia.Text,
                    usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO1 { id = idUsuario}
                };

                int i = direccionWSClient.insertarDireccion(nuevaDireccion);
                lblMensaje.CssClass = "text-success mt-2 d-block";
                lblMensaje.Text = "¡Dirección guardada con éxito!";

                //aquí falta guardar el id en session

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

            Response.Redirect("DatosPago.aspx");
        }
    }
}
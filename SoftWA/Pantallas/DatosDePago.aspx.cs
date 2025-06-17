using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class DatosDePago : System.Web.UI.Page
    {
        private CarritoClient carritoWSClient = new CarritoClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["direccion"] != null)
                {
                    var direccion = (SoftWA.ServiciosWSClient.direccionDTO)Session["direccion"];
                    lblAlias.Text = direccion.alias;
                    lblDireccion.Text = direccion.direccion;
                    lblCiudad.Text = direccion.ciudad;
                }
                else
                {
                    lblAlias.Text = "(no definida)";
                    lblDireccion.Text = "-";
                    lblCiudad.Text = "-";
                }
                CargarResumenPedido();
            }
        }

        private void CargarResumenPedido()
        {
            if (Session["idCarrito"] != null)
            {
                int idCarrito = Convert.ToInt32(Session["idCarrito"]);
                var carrito = carritoWSClient.obtenerPorIdCarrito(idCarrito);

                double subtotal = carrito.items.Sum(i => i.subtotal);
                double impuesto = subtotal * 0.18;
                double total = subtotal + impuesto;

                lblSubtotal.Text = subtotal.ToString("F2");
                lblImpuesto.Text = impuesto.ToString("F2");
                lblEnvio.Text = "-"; // Puedes modificar esto si luego calculas envío
                lblTotal.Text = total.ToString("F2");
            }
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtNumeroTarjeta.Text) ||
                string.IsNullOrWhiteSpace(txtFechaExp.Text) ||
                string.IsNullOrWhiteSpace(txtCVV.Text))
            {
                lblMensaje.Text = "Completa todos los campos para continuar.";
                return;
            }

            try
            {
                lblMensaje.CssClass = "text-success mt-2 d-block";
                lblMensaje.Text = "Pago procesado exitosamente. ";

                Session["idCarrito"] = null;

                // Response.Redirect("ConfirmacionPedido.aspx");
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al procesar el pago: " + ex.Message;
            }
        }
    }
}
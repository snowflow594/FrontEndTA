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
                double subtotal = 0;
                double total = 0;
                double IGV = 0;

                if (carrito != null && carrito.items != null)
                {
                    foreach (var item in carrito.items)
                    {
                        subtotal += item.subtotal;
                    }

                    IGV = subtotal * 0.18;
                    total = subtotal + IGV;

                    lblSubtotal.Text = subtotal.ToString("F2");
                    lblIGV.Text = IGV.ToString("F2");
                    lblTotal.Text = total.ToString("F2");
                }
                else
                {
                    lblSubtotal.Text = "0.00";
                    lblIGV.Text = "0.00";
                    lblTotal.Text = "0.00";
                }

                subtotal = carrito.items.Sum(i => i.subtotal);
                IGV = subtotal * 0.18;
                total = subtotal + IGV;

                lblSubtotal.Text = subtotal.ToString("F2");
                lblIGV.Text = IGV.ToString("F2");
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
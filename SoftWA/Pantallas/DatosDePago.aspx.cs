using MySql.Data.Types;
using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NodaTime;

namespace SoftWA.Pantallas
{
    public partial class DatosDePago : System.Web.UI.Page
    {
        private CarritoClient carritoWSClient = new CarritoClient();
        private ItemCarritoClient itemCarritoWSClient = new ItemCarritoClient();
        private PedidoClient pedidoWSClient = new PedidoClient();
        private PagoClient pagoWSClient = new PagoClient();
        private double totalAPagar;

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
                var todosLosItems = itemCarritoWSClient.listarTodosItemCarrito();
                var items = todosLosItems
                    .Where(item => item.carrito != null && item.carrito.idCarrito == idCarrito && item.producto != null)
                    .ToList();
                double subtotal = 0;
                double total = 0;
                double IGV = 0;

                if (items != null)
                {
                    foreach (var item in items)
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

                subtotal = items.Sum(i => i.subtotal);
                IGV = subtotal * 0.18;
                total = subtotal + IGV;

                lblSubtotal.Text = subtotal.ToString("F2");
                lblIGV.Text = IGV.ToString("F2");
                lblEnvio.Text = "-";
                lblTotal.Text = total.ToString("F2");
                totalAPagar = total;
            }
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            int idCarrito = Convert.ToInt32(Session["idCarrito"]);
            var carrito = carritoWSClient.obtenerPorIdCarrito(idCarrito);
            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtNumeroTarjeta.Text) ||
                string.IsNullOrWhiteSpace(txtFechaExp.Text) ||
                string.IsNullOrWhiteSpace(txtCVV.Text))
            {
                lblMensaje.Text = "Completa todos los campos para continuar.";
                return;
            }

            if (rblTipoComprobante.SelectedValue == "factura")
            {
                if (string.IsNullOrWhiteSpace(txtRUC.Text) || string.IsNullOrWhiteSpace(txtRazonSocial.Text))
                {
                    lblMensaje.Text = "Completa todos los campos requeridos para emitir factura.";
                    return;
                }
            }

            try
            {
                var fechaActual = new SoftWA.ServiciosWSClient.localDateTime();
                var nuevoPedido = new SoftWA.ServiciosWSClient.pedidoDTO
                {
                    persona = new SoftWA.ServiciosWSClient.personaDTO { id = 1 },
                    fechaPedido = fechaActual,
                    total = totalAPagar,
                    estado = "Empquetado",
                    usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4 }
                };
                int i = pedidoWSClient.insertarPedido(nuevoPedido);
                var todosLosPedidos = pedidoWSClient.listarTodosPedido();
                var ultimo = todosLosPedidos?
                    .Where(c => c != null &&
                                    c.persona.id == 1 &&
                                    c.usuarioCreacion.id == 4)
                    .OrderByDescending(c => c.idPedido)
                    .FirstOrDefault();
                var nuevoPago = new SoftWA.ServiciosWSClient.pagoDTO
                {
                    pedido = ultimo,
                    metodo = "tarjeta",
                    monto = totalAPagar,
                    fechaPago = fechaActual,
                    usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4}
                };
                i = pagoWSClient.insertarPago(nuevoPago);
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

        protected void rblTipoComprobante_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Mostrar campos de Factura solo si está seleccionada
            if (rblTipoComprobante.SelectedValue == "factura")
            {
                phFactura.Visible = true;
            }
            else
            {
                phFactura.Visible = false;
            }
        }
    }
}
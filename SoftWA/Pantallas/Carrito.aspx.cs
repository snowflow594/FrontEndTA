using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class Carrito : System.Web.UI.Page
    {
        private ItemCarritoClient itemCarritoWS = new ItemCarritoClient();
        private ProductosClient productoWS = new ProductosClient();
        private CarritoClient carritoWS = new CarritoClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCarrito();
            }
        }
        private void CargarCarrito()
        {
            if (Session["idCarrito"] != null)
            {
                int idCarrito = Convert.ToInt32(Session["idCarrito"]);
                var carrito = carritoWS.obtenerPorIdCarrito(idCarrito);

                if (carrito != null && carrito.items != null)
                {
                    rptCarrito.DataSource = carrito.items;
                    rptCarrito.DataBind();

                    double subtotal = 0;
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
        }

        protected void rptCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idItem = Convert.ToInt32(e.CommandArgument);

            var item = itemCarritoWS.obtenerPorIdItemCarrito(idItem); 

            if (item != null)
            {
                if (e.CommandName == "Aumentar")
                {
                    item.cantidad += 1;
                    item.subtotal = item.cantidad * item.producto.precio;
                    item.usuarioActualizacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4 };
                    itemCarritoWS.modificarItemCarrito(item);
                }
                else if (e.CommandName == "Disminuir")
                {
                    if (item.cantidad > 1)
                    {
                        item.cantidad -= 1;
                        item.subtotal = item.cantidad * item.producto.precio;
                        item.usuarioActualizacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4 };
                        itemCarritoWS.modificarItemCarrito(item);
                    }
                    else
                    {
                        itemCarritoWS.eliminarItemCarrito(item);
                        ScriptManager.RegisterStartupScript(this, GetType(), "eliminado", "alert('Producto eliminado del carrito.');", true);
                    }
                }
            }
            CargarCarrito();
        }
    }
}
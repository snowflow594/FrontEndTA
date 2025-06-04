using SoftWA.Carrito;
using SoftWA.ItemCarrito;
using SoftWA.Producto;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCarrito();
            }
        }
        protected void rptCarrito_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int idItemCarrito = Convert.ToInt32(e.CommandArgument);
            var item = itemCarritoWS.listarTodosItemCarrito().FirstOrDefault(i => i.idItemCarrito == idItemCarrito);

            int? idCarrito = Session["idCarrito"] as int?;
            if (item == null || idCarrito == null) return;

            var productoCompleto = productoWS.obtenerPorIdProducto(item.producto.idProducto);
            double precio = productoCompleto.precio;

            if (e.CommandName == "Aumentar")
            {
                item.cantidad++;
            }
            else if (e.CommandName == "Disminuir" && item.cantidad > 1)
            {
                item.cantidad--;
            }

            item.subtotal = precio * item.cantidad;

            var itemNuevo = new SoftWA.ItemCarrito.itemCarritoDTO
            {
                idItemCarrito = idItemCarrito,
                cantidad = item.cantidad,
                subtotal = item.subtotal,
                carrito = new SoftWA.ItemCarrito.carritoDTO { idCarrito = idCarrito.Value },
                usuarioActualizacion = new SoftWA.ItemCarrito.usuarioDTO { id = 5 }
            };

            int k = itemCarritoWS.modificarItemCarrito(itemNuevo);

            CargarCarrito();
        }

        private void CargarCarrito()
        {
            int? idCarrito = Session["idCarrito"] as int?;
            if (idCarrito == null)
            {
                Response.Redirect("Inicio.aspx");
                return;
            }

            var todosLosItems = itemCarritoWS.listarTodosItemCarrito();

            // Filtrar los items del carrito actual
            var items = todosLosItems
                .Where(i => i.carrito != null && i.carrito.idCarrito == idCarrito.Value)
                .ToList();

            // Cargar detalles completos de producto
            foreach (var item in items)
            {
                if (item.producto != null && item.producto.idProducto > 0)
                {
                    var productoCompleto = productoWS.obtenerPorIdProducto(item.producto.idProducto);
                    item.producto.nombre = productoCompleto.nombre;
                    item.producto.descripcion = productoCompleto.descripcion;
                    item.producto.precio = productoCompleto.precio;
                }
            }

            rptCarrito.DataSource = items;
            rptCarrito.DataBind();

            // Calcular montos
            double subtotal = items.Sum(i => i.subtotal);
            double impuesto = subtotal * 0.12;
            double total = subtotal + impuesto;

            lblSubtotal.Text = $"S/ {subtotal:N2}";
            lblImpuesto.Text = $"S/ {impuesto:N2}";
            lblTotal.Text = $"S/ {total:N2}";
        }
    }
}
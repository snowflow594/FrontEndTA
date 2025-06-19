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
                var todosLosItems = itemCarritoWS.listarTodosItemCarrito();
                var items = todosLosItems
                    .Where(item => item.carrito != null && item.carrito.idCarrito == idCarrito && item.producto != null)
                    .ToList();
                var itemsAgrupados = items
                    .GroupBy(i => i.producto.idProducto)
                    .Select(grupo =>
                    {
                        int idProducto = grupo.Key;
                        var productoCompleto = productoWS.obtenerPorIdProducto(idProducto);

                        return new itemCarritoDTO
                        {
                            producto = new productoDTO
                            {
                                idProducto = productoCompleto.idProducto,
                                nombre = productoCompleto.nombre,
                                descripcion = productoCompleto.descripcion,
                                precio = productoCompleto.precio,
                                stock = productoCompleto.stock
                            },
                            cantidad = grupo.Sum(i => i.cantidad),
                            subtotal = grupo.Sum(i => i.subtotal)
                        };
                    })
                    .ToList();

                rptCarrito.DataSource = itemsAgrupados;
                rptCarrito.DataBind();

                double subtotal = itemsAgrupados.Sum(i => i.subtotal);
                double igv = subtotal * 0.18;
                double total = subtotal + igv;

                lblSubtotal.Text = subtotal.ToString("F2");
                lblIGV.Text = igv.ToString("F2");
                lblTotal.Text = total.ToString("F2");
            }
        }

        protected void rptCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idProducto = Convert.ToInt32(e.CommandArgument);

            int idCarrito = Convert.ToInt32(Session["idCarrito"]);
            var todosLosItems = itemCarritoWS.listarTodosItemCarrito();

            var item = todosLosItems
                .FirstOrDefault(i => i.carrito != null
                                  && i.carrito.idCarrito == idCarrito
                                  && i.producto != null
                                  && i.producto.idProducto == idProducto);

            if (item != null)
            {
                var productoCompleto = productoWS.obtenerPorIdProducto(item.producto.idProducto);

                if (e.CommandName == "Aumentar")
                {
                    var nuevoItem = new itemCarritoDTO
                    {
                        idItemCarrito = item.idItemCarrito,
                        cantidad = item.cantidad + 1,
                        subtotal = (item.cantidad + 1) * productoCompleto.precio,
                        usuarioActualizacion = new usuarioDTO { id = 4 }
                    };

                    itemCarritoWS.modificarItemCarrito(nuevoItem);
                }
                else if (e.CommandName == "Disminuir")
                {
                    if (item.cantidad > 1)
                    {
                        var nuevoItem = new itemCarritoDTO
                        {
                            idItemCarrito = item.idItemCarrito,
                            cantidad = item.cantidad - 1,
                            subtotal = (item.cantidad - 1) * productoCompleto.precio,
                            usuarioActualizacion = new usuarioDTO { id = 4 }
                        };

                        itemCarritoWS.modificarItemCarrito(nuevoItem);
                    }
                    else
                    {
                        //si cantidad = 1, se elimina
                        var eliminarItem = new itemCarritoDTO
                        {
                            idItemCarrito = item.idItemCarrito,
                            usuarioActualizacion = new usuarioDTO { id = 4 }
                        };

                        itemCarritoWS.eliminarItemCarrito(eliminarItem);
                    }
                }
                else if (e.CommandName == "Eliminar")
                {
                    // Eliminar directamente
                    var cambiarCantidad = new itemCarritoDTO
                    {
                        idItemCarrito = item.idItemCarrito,
                        cantidad = 1,
                        subtotal = productoCompleto.precio,
                        usuarioActualizacion = new usuarioDTO { id = 4 }
                    };
                    itemCarritoWS.modificarItemCarrito(cambiarCantidad);
                    var eliminarCompleto = new itemCarritoDTO
                    {
                        idItemCarrito = item.idItemCarrito,
                        usuarioActualizacion = new usuarioDTO { id = 4 }
                    };

                    itemCarritoWS.eliminarItemCarrito(eliminarCompleto);
                    ScriptManager.RegisterStartupScript(this, GetType(), "eliminado", "alert('Producto eliminado del carrito.');", true);
                }
            }
            CargarCarrito(); // recarga la vista con los cambios
        }

    }
}
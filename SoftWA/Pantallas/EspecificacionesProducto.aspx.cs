using SoftWA.Carrito;
using SoftWA.ItemCarrito;
using SoftWA.Producto;
using SoftWA.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class EspecificacionesProducto : System.Web.UI.Page
    {
        private ProductosClient productoWSClient = new ProductosClient();
        private ItemCarritoClient itemCarritoWSClient = new ItemCarritoClient();
        private CarritoClient carritoWSClient = new CarritoClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProducto();
            }
        }

        private void CargarProducto()
        {
            if (Request.QueryString["id"] != null)
            {
                int idProducto;
                if (int.TryParse(Request.QueryString["id"], out idProducto))
                {
                    var producto = productoWSClient.obtenerPorIdProducto(idProducto);
                    if (producto != null)
                    {
                        lblId.Text = producto.idProducto.ToString();
                        lblNombre.Text = producto.nombre;
                        lblDescripcion.Text = producto.descripcion;
                        lblStock.Text = producto.stock.ToString();
                    }
                }
            }
        }

        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            int? idCarrito = Session["idCarrito"] as int?;
            if (idCarrito == null)
            {
                Response.Redirect("Inicio.aspx");
                return;
            }

            int idProducto = int.Parse(lblId.Text);

            var productoCompleto = productoWSClient.obtenerPorIdProducto(idProducto);

            var producto = new SoftWA.ItemCarrito.productoDTO
            {
                idProducto = productoCompleto.idProducto
            };

            var carrito = new SoftWA.ItemCarrito.carritoDTO
            {
                idCarrito = idCarrito.Value
            };

            var usuario = new SoftWA.ItemCarrito.usuarioDTO
            {
                id = 1
            };

            var nuevoItem = new ItemCarrito.itemCarritoDTO
            {
                carrito = carrito,
                producto = producto,
                cantidad = 1,
                subtotal = productoCompleto.precio,
                activo = 1,
                fechaCreacion = DateTime.Now.ToLocalTime(),
                usuarioCreacion = usuario
            };

            itemCarritoWSClient.insertarItemCarrito(nuevoItem);
            Response.Redirect("Carrito.aspx");
        }
    }
}
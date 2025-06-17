using SoftWA.ServiciosWSClient;
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
                        lblCodigo.Text = producto.idProducto.ToString();
                        lblNombre.Text = producto.nombre;
                        lblDescripcion.Text = producto.descripcion;
                        lblStock.Text = producto.stock.ToString();
                        lblPrecio.Text = producto.precio.ToString();
                    }
                }
            }
        }

        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            int idCarrito = Convert.ToInt32(Session["idCarrito"]);
            try
            {
                int idProducto = int.Parse(lblCodigo.Text);

                var productoCompleto = productoWSClient.obtenerPorIdProducto(idProducto);

                var producto = new SoftWA.ServiciosWSClient.productoDTO
                {
                    idProducto = productoCompleto.idProducto
                };

                var carrito = carritoWSClient.obtenerPorIdCarrito(idCarrito);

                var carritoDeItems = new SoftWA.ServiciosWSClient.carritoDTO
                {
                    idCarrito = carrito.idCarrito
                };

                var nuevoItem = new SoftWA.ServiciosWSClient.itemCarritoDTO
                {
                    carrito = carritoDeItems,
                    producto = producto,
                    cantidad = 1,
                    subtotal = productoCompleto.precio,
                    usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4 },
                };

                int i = itemCarritoWSClient.insertarItemCarrito(nuevoItem);
                Response.Redirect("Carrito.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar productos: " + ex.Message + "');</script>");
                Response.Redirect("Inicio.aspx");
            }

            
        }
    }
}
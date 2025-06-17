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
                        lblCategoria.Text = producto.categoria.ToString();
                        lblPrecio.Text = producto.precio.ToString();
                        imgProducto = new Image();
                    }
                }
            }
        }

        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            if (Session["idCarrito"] == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No hay carrito activo.');", true);
                return;
            }

            try
            {
                int idCarrito = Convert.ToInt32(Session["idCarrito"]);
                int idProducto = int.Parse(lblCodigo.Text);

                var producto = productoWSClient.obtenerPorIdProducto(idProducto);

                var nuevoItem = new itemCarritoDTO
                {
                    carrito = new carritoDTO { idCarrito = idCarrito },
                    producto = new productoDTO { idProducto = idProducto },
                    cantidad = 1,
                    subtotal = producto.precio,
                    usuarioCreacion = new usuarioDTO { id = 4 } // temporal
                };

                itemCarritoWSClient.insertarItemCarrito(nuevoItem);
                Response.Redirect("Carrito.aspx");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }
    }
}
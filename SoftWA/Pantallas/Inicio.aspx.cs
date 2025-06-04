using SoftWA.Carrito;
using SoftWA.Producto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class Inicio : System.Web.UI.Page
    {
        private ProductosClient productoWSClient = new ProductosClient();
        private CarritoClient carritoWSClient = new CarritoClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
            if (Session["idCarrito"] == null)
            {
                // Crear nuevo carrito
                var nuevoCarrito = new SoftWA.Carrito.carritoDTO
                {
                    persona = new SoftWA.Carrito.personaDTO { id = 5 }, // ids de la base de datos
                    total = 0,
                    usuarioCreacion = new SoftWA.Carrito.usuarioDTO { id = 4 },
                };

                int i = carritoWSClient.insertarCarrito(nuevoCarrito);
                var todosLosCarritos = carritoWSClient.listarTodosCarrito();
                var ultimo = todosLosCarritos
                    .Where(c => c.persona != null && c.persona.id == 5)
                    .OrderByDescending(c => c.idCarrito)
                    .FirstOrDefault();

                if (ultimo != null)
                    Session["idCarrito"] = ultimo.idCarrito;
            }
        }

        private void CargarProductos()
        {
            List<SoftWA.Producto.productoDTO> productos = productoWSClient.listarTodosProducto().ToList();
            rptProductos.DataSource = productos;
            rptProductos.DataBind();
        }
    }
}
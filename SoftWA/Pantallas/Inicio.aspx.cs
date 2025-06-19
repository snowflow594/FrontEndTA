using SoftWA.ServiciosWSClient;
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
        private PersonaClient personaWSClient = new PersonaClient();
        private UsuarioClient usuarioWSClient = new UsuarioClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
                CargarBestSellers();
            }
        }

        private void CargarProductos()
        {
            try
            {
                //----------------------ACA HE MODIFICADO ALGUNOS VALORES O AREGUE-------------------------------
                // 1) Obtienes todos
                var productos = productoWSClient
                                  .listarTodosProducto()
                                  .ToList();

                // 2) Te quedas con los 3 primeros
                var primerosTres = productos
                                      .Take(3)
                                      .ToList();

                // 3) Bind de tu carrusel a esos 3
                Repeater1.DataSource = primerosTres;
                Repeater1.DataBind();

                rptCategoriasCarousel.DataSource = primerosTres;
                rptCategoriasCarousel.DataBind();

                //----------------------HASTA AQUI EH MODIFICADO ALGUNOS VALORES O AREGUE-------------------------------
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar productos: " + ex.Message + "');</script>");
            }
        }

        protected void CargarBestSellers()
        {
            try
            {
                // 1) Obtengo todos los productos
                var productos = productoWSClient.listarProductosPorRangoPrecio(0, 800).ToList();

                // 2) Ordeno por la métrica que quieras; p.ej. los menos vendidos:
                //    Aquí asumo que tu DTO tiene una propiedad 'cantidadVendida'
                var menosVendidos = productos.Take(6).ToList();

                // 3) Bind al repeater de “Productos de Remate”
                rptBestSellers.DataSource = menosVendidos;
                rptBestSellers.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(),
                    "errBest", $"alert('Error al cargar Best Sellers: {ex.Message}');", true);
            }
        }
    }
}
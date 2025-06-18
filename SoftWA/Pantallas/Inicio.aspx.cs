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
                CargarProductosDestacados();
            }
        }

        private void CargarProductosDestacados()
        {
            var productos = productoWSClient.listarTodosProducto();
            var destacados = productos.Take(4).ToList(); // Mostrar solo los primeros 4

            rptCategorias.DataSource = destacados;
            rptCategorias.DataBind();
        }
    }
}
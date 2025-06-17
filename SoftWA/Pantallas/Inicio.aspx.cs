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
            }
        }

        private void CargarProductos()
        {
            try
            {
                var productos = productoWSClient.listarTodosProducto().ToList();
                rptCategorias.DataSource = productos;
                rptCategorias.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar productos: " + ex.Message + "');</script>");
            }
        }
    }
}
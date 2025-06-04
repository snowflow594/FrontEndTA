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
                List<productoDTO> productos = productoWSClient.listarTodosProducto().ToList();
                rptProductos.DataSource = productos;
                rptProductos.DataBind();
            }
            catch (Exception ex)
            {
                //errir en la carga de productos
            }
        }
    }
}
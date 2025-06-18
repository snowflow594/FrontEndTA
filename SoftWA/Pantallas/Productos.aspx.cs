using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class Productos : System.Web.UI.Page
    {
        private ProductosClient productosWSClient = new ProductosClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string termino = Request.QueryString["busqueda"];
                string categoria = Request.QueryString["categoria"];

                txtBuscar.Text = termino;
                ddlCategoria.SelectedValue = categoria ?? "";

                CargarProductos(termino, categoria);
            }
        }

        private void CargarProductos(string termino, string categoria)
        {
            var productos = productosWSClient.listarTodosProducto();
            var productosFiltrados = productos.AsEnumerable();

            if (!string.IsNullOrEmpty(termino))
            {
                string terminoLower = termino.ToLower();
                productosFiltrados = productosFiltrados.Where(p =>
                    (!string.IsNullOrEmpty(p.nombre) && p.nombre.ToLower().Contains(terminoLower)) ||
                    (!string.IsNullOrEmpty(p.descripcion) && p.descripcion.ToLower().Contains(terminoLower)) ||
                    (int.TryParse(termino, out int idBuscado) && p.idProducto == idBuscado)
                );
            }

            if (!string.IsNullOrEmpty(categoria))
            {
                productosFiltrados = productosFiltrados.Where(p =>
                    !string.IsNullOrEmpty(p.nombre) && p.categoria.ToLower().Contains(categoria.ToLower())
                );
            }

            rptProductos.DataSource = productosFiltrados.ToList();
            rptProductos.DataBind();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            string termino = txtBuscar.Text.Trim();
            string categoria = ddlCategoria.SelectedValue;

            string url = "~/Pantallas/Productos.aspx?busqueda=" + Server.UrlEncode(termino)
                       + "&categoria=" + Server.UrlEncode(categoria);

            Response.Redirect(url);
        }
    }
}

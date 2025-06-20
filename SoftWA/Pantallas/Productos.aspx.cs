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
        private int tamañoPagina = 9;

        protected void Page_Load(object sender, EventArgs e)
        {
            int paginaActual = 1;
            if (int.TryParse(Request.QueryString["pagina"], out int pagina))
            {
                paginaActual = pagina;
            }

            if (!IsPostBack)
            {
                string termino = Request.QueryString["busqueda"];
                string categoria = Request.QueryString["categoria"];
                string precioMin = Request.QueryString["preciomin"];
                string precioMax = Request.QueryString["preciomax"];

                txtBuscar.Text = termino;
                ddlCategoria.SelectedValue = categoria ?? "";
                txtPrecioMin.Text = precioMin;
                txtPrecioMax.Text = precioMax;

                CargarProductos(termino, categoria, paginaActual, precioMin, precioMax);
            }
        }

        private void CargarProductos(string termino, string categoria, int paginaActual = 1, string precioMin = null, string precioMax = null)
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

            if (double.TryParse(precioMin, out double min))
            {
                productosFiltrados = productosFiltrados.Where(p => p.precio >= min);
            }

            if (double.TryParse(precioMax, out double max))
            {
                productosFiltrados = productosFiltrados.Where(p => p.precio <= max);
            }

            int cantidadProductos = productosFiltrados.Count();
            int totalPaginas = (int)Math.Ceiling((double)cantidadProductos / tamañoPagina);

            var productosPagina = productosFiltrados
                .Skip((paginaActual - 1) * tamañoPagina)
                .Take(tamañoPagina)
                .ToList();

            rptProductos.DataSource = productosPagina;
            rptProductos.DataBind();

            GenerarPaginacion(totalPaginas, paginaActual, termino, categoria, precioMin, precioMax);
        }

        private void GenerarPaginacion(int totalPaginas, int paginaActual, string termino, string categoria, string precioMin, string precioMax)
        {
            var paginas = new List<object>();

            if (paginaActual > 1)
                paginas.Add(new { NumeroPagina = paginaActual - 1, Texto = "« Anterior", CssClass = "btn btn-outline-secondary mx-1" });

            for (int i = 1; i <= totalPaginas; i++)
            {
                paginas.Add(new
                {
                    NumeroPagina = i,
                    Texto = i.ToString(),
                    CssClass = i == paginaActual ? "btn btn-primary mx-1" : "btn btn-outline-secondary mx-1"
                });
            }

            if (paginaActual < totalPaginas)
                paginas.Add(new { NumeroPagina = paginaActual + 1, Texto = "Siguiente »", CssClass = "btn btn-outline-secondary mx-1" });

            rptPaginacion.DataSource = paginas;
            rptPaginacion.DataBind();
        }

        protected void rptPaginacion_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CambiarPagina")
            {
                int nuevaPagina = Convert.ToInt32(e.CommandArgument);
                string termino = txtBuscar.Text.Trim();
                string categoria = ddlCategoria.SelectedValue;
                string precioMin = txtPrecioMin.Text.Trim();
                string precioMax = txtPrecioMax.Text.Trim();

                CargarProductos(termino, categoria, nuevaPagina, precioMin, precioMax);
            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            string termino = txtBuscar.Text.Trim();
            string categoria = ddlCategoria.SelectedValue;
            string precioMin = txtPrecioMin.Text.Trim();
            string precioMax = txtPrecioMax.Text.Trim();

            string url = "~/Pantallas/Productos.aspx?busqueda=" + Server.UrlEncode(termino)
                       + "&categoria=" + Server.UrlEncode(categoria)
                       + "&pagina=1"
                       + "&preciomin=" + Server.UrlEncode(precioMin)
                       + "&preciomax=" + Server.UrlEncode(precioMax);

            Response.Redirect(url);
        }
    }
}


using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class ReporteProductos : System.Web.UI.Page
    {
        private BindingList<productoDTO1> productos;
        private ProductosClient productoBO;


        protected void Page_Load(object sender, EventArgs e)
        {
            //productoBO = new ProductosClient();
            //productoDTO1[] arrProductos = productoBO.listarTodosProducto();
            //productos = new BindingList<productoDTO1>(arrProductos.ToList());

            LoadProductData();

        }

        private void LoadProductData()
        {
            //DATOS DE EJEMPLO
            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Categoria", typeof(string));
            dt.Columns.Add("CantidadVendida", typeof(int));
            dt.Columns.Add("PrecioUnitario", typeof(decimal));
            dt.Columns.Add("Stock", typeof(int));
            dt.Columns.Add("TotalVendido", typeof(decimal));

            // PRODUCTOS DE EJEMPLO
            dt.Rows.Add("111", "Cuchillo Facusa", "Cuchillos", 50, 60.00m, 90, 3000.00m);
            dt.Rows.Add("112", "Cuchillo Tramontina", "Cuchillos", 30, 80.00m, 120, 2400.00m);
            dt.Rows.Add("113", "Helado para hornear", "Repostería", 40, 100.00m, 200, 4000.00m);
            dt.Rows.Add("114", "Olla de acero", "Ollas", 20, 300.00m, 100, 6000.00m);

            gvProductos.DataSource = dt;
            gvProductos.DataBind();

            //gvProductos.DataSource = productos;
            //gvProductos.DataBind();

        }

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            string fechaInicio = txtFechaInicio.Text;
            string fechaFin = txtFechaFin.Text;

            // Acá se implementa la lógica de generación de reporte

            // MENSAJE DE EJEMPLO
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                $"alert('Generando reporte desde {fechaInicio} hasta {fechaFin}');", true);

            // Recarga los datos con el rango
            LoadProductDataWithDateRange(fechaInicio, fechaFin);
        }

        private void LoadProductDataWithDateRange(string fechaInicio, string fechaFin)
        {
            LoadProductData(); // Por ahora solo recarga los mismos datos
        }

        protected void gvProductos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProductos.PageIndex = e.NewPageIndex;
            LoadProductData();
        }

        // Custom pagination event handlers
        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            // Get current page from ViewState or calculate it
            int currentPage = GetCurrentPage();
            if (currentPage > 1)
            {
                SetCurrentPage(currentPage - 1);
                LoadProductData();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = GetCurrentPage();
            int totalPages = 3;

            if (currentPage < totalPages)
            {
                SetCurrentPage(currentPage + 1);
                LoadProductData();
            }
        }

        protected void lnkPage_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int pageNumber = Convert.ToInt32(btn.CommandArgument);

            UpdatePaginationUI(pageNumber);
            SetCurrentPage(pageNumber);

            LoadCustomerDataForPage(pageNumber);
        }

        private void LoadCustomerDataForPage(int pageNumber)
        {
            LoadProductData();
        }

        private void UpdatePaginationUI(int currentPage)
        {
            // MUESTRA DE PAGINACIÓN


            lnkPage1.CssClass = "pagination-btn";
            lnkPage2.CssClass = "pagination-btn";
            lnkPage3.CssClass = "pagination-btn";


            switch (currentPage)
            {
                case 1:
                    lnkPage1.CssClass = "pagination-btn active";
                    break;
                case 2:
                    lnkPage2.CssClass = "pagination-btn active";
                    break;
                case 3:
                    lnkPage3.CssClass = "pagination-btn active";
                    break;
            }

            lnkPrevious.Enabled = currentPage > 1;
            lnkNext.Enabled = currentPage < 3;
        }

        private int GetCurrentPage()
        {
            return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1;
        }

        private void SetCurrentPage(int page)
        {
            ViewState["CurrentPage"] = page;
            UpdatePaginationUI(page);
        }

        protected void gvProductos_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        // Métodos adicionales
        public void ExportToExcel()
        {
            // Acá se implementa la exportación a excel
            // Se pueden usar librerías como EPPlus o ClosedXML
        }

        protected void btnBorrarFiltros_Click(object sender, EventArgs e)
        {
            //borra los campos de datos de entrada para los filtros
            txtFechaInicio.Text = string.Empty;
            txtFechaFin.Text = string.Empty;
            txtBuscarNombre.Text = string.Empty;
            ddlCategoria.SelectedIndex = 0;
            txtBuscarStock.Text = string.Empty;
            txtPrecioMin.Text = string.Empty;
            txtPrecioMax.Text = string.Empty;

            // Recarga los datos sin filtros
            LoadProductData();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {

        }
    }
}
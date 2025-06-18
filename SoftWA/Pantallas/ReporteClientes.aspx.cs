using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class ReporteClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCustomerData();
            }
        }

        private void LoadCustomerData()
        {
            // COLUMNAS DE MUESTRA
            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("CantidadPedidos", typeof(int));
            dt.Columns.Add("TotalGastado", typeof(decimal));

            // DATOS DE MUESTRA
            dt.Rows.Add("111", "EMPRESAS123", 125, 2432.00m);
            dt.Rows.Add("112", "Javier Santacoloma", 80, 2154.00m);
            dt.Rows.Add("113", "Elizabeth Garcia", 70, 1232.00m);
            dt.Rows.Add("114", "Josue Mendoza", 20, 231.00m);

            gvClientes.DataSource = dt;
            gvClientes.DataBind();
        }

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            string fechaInicio = txtFechaInicio.Text;
            string fechaFin = txtFechaFin.Text;

            // Acá se implementa la lógica de reporte

            // MENSAJE DE MUESTRA
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                $"alert('Generando reporte de clientes desde {fechaInicio} hasta {fechaFin}');", true);

            // Recarga los datos con el rango de fechas
            LoadCustomerDataWithDateRange(fechaInicio, fechaFin);
        }

        private void LoadCustomerDataWithDateRange(string fechaInicio, string fechaFin)
        {
            // Ejemplo de lo que sería el SELECT en SQL de la consulta que se haría a la base de datos
            /*
            SELECT 
                c.CustomerID as ID,
                c.CustomerName as Nombre,
                COUNT(o.OrderID) as CantidadPedidos,
                SUM(o.TotalAmount) as TotalGastado
            FROM Customers c
            INNER JOIN Orders o ON c.CustomerID = o.CustomerID
            WHERE o.OrderDate BETWEEN @fechaInicio AND @fechaFin
            GROUP BY c.CustomerID, c.CustomerName
            ORDER BY COUNT(o.OrderID) DESC, SUM(o.TotalAmount) DESC
            */

            LoadCustomerData();
        }

        protected void gvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvClientes.PageIndex = e.NewPageIndex;
            LoadCustomerData();
        }

        // METODOS QUE MANEJAN LA PAGINACIÓN DE MUESTRA
        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            int currentPage = GetCurrentPage();
            if (currentPage > 1)
            {
                SetCurrentPage(currentPage - 1);
                LoadCustomerData();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = GetCurrentPage();
            int totalPages = 3;

            if (currentPage < totalPages)
            {
                SetCurrentPage(currentPage + 1);
                LoadCustomerData();
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
            LoadCustomerData();
        }

        private void UpdatePaginationUI(int currentPage)
        {
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

        // Métodos adicionales
        protected void ExportToExcel()
        {
            // Acá se implementa la exportación a excel
            // Se pueden usar librerías como EPPlus o ClosedXML
        }

        protected void gvClientes_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {

        }

        protected void btnBorrarFiltros_Click(object sender, EventArgs e)
        {

        }
    }
}
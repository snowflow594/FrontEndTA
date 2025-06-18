using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class ReporteIngresos : System.Web.UI.Page
    {
        private string SortExpression
        {
            get { return ViewState["SortExpression"] as string ?? "Mes"; } //si no hay valor, devuelve "Mes" por defecto
            set { ViewState["SortExpression"] = value; }
        }

        private string SortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadIncomeData();
            }
        }

        private void LoadIncomeData()
        {
            // Obtiene año seleccionado
            int selectedYear = Convert.ToInt32(ddlYear.SelectedValue);

            // DATOS DE EJEMPLO
            DataTable dt = new DataTable();
            dt.Columns.Add("Mes", typeof(string));
            dt.Columns.Add("CantidadPedidos", typeof(int));
            dt.Columns.Add("IngresosGenerados", typeof(decimal));

            // DATOS DE EJEMPLO
            if (selectedYear == 2025)
            {
                dt.Rows.Add("Enero", 123, 2432.00m);
                dt.Rows.Add("Febrero", 80, 2154.00m);
                dt.Rows.Add("Marzo", 70, 1232.00m);
                dt.Rows.Add("Abril", 20, 231.00m);
                dt.Rows.Add("Mayo", 45, 890.00m);
                dt.Rows.Add("Junio", 65, 1340.00m);
                dt.Rows.Add("Julio", 85, 1750.00m);
                dt.Rows.Add("Agosto", 95, 1950.00m);
                dt.Rows.Add("Septiembre", 75, 1580.00m);
                dt.Rows.Add("Octubre", 55, 1120.00m);
                dt.Rows.Add("Noviembre", 105, 2180.00m);
                dt.Rows.Add("Diciembre", 125, 2650.00m);
            }
            else if (selectedYear == 2024)
            {
                dt.Rows.Add("Enero", 110, 2100.00m);
                dt.Rows.Add("Febrero", 95, 1950.00m);
                dt.Rows.Add("Marzo", 85, 1800.00m);
                dt.Rows.Add("Abril", 75, 1500.00m);
                dt.Rows.Add("Mayo", 90, 1850.00m);
                dt.Rows.Add("Junio", 100, 2000.00m);
                dt.Rows.Add("Julio", 120, 2300.00m);
                dt.Rows.Add("Agosto", 115, 2250.00m);
                dt.Rows.Add("Septiembre", 105, 2100.00m);
                dt.Rows.Add("Octubre", 95, 1900.00m);
                dt.Rows.Add("Noviembre", 130, 2500.00m);
                dt.Rows.Add("Diciembre", 150, 3000.00m);
            }
            else if (selectedYear == 2023)
            {
                dt.Rows.Add("Enero", 90, 1800.00m);
                dt.Rows.Add("Febrero", 85, 1700.00m);
                dt.Rows.Add("Marzo", 75, 1500.00m);
                dt.Rows.Add("Abril", 65, 1300.00m);
                dt.Rows.Add("Mayo", 80, 1600.00m);
                dt.Rows.Add("Junio", 90, 1800.00m);
                dt.Rows.Add("Julio", 100, 2000.00m);
                dt.Rows.Add("Agosto", 95, 1900.00m);
                dt.Rows.Add("Septiembre", 85, 1700.00m);
                dt.Rows.Add("Octubre", 75, 1500.00m);
                dt.Rows.Add("Noviembre", 110, 2200.00m);
                dt.Rows.Add("Diciembre", 130, 2600.00m);
            }

            // se aplica el ordenamiento
            DataView dv = dt.DefaultView;
            dv.Sort = SortExpression + " " + SortDirection;

            gvIngresos.DataSource = dv;
            gvIngresos.DataBind();
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadIncomeData();
        }

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            int selectedYear = Convert.ToInt32(ddlYear.SelectedValue);

            // Se implemnta la lógica de reporte acá

            // MENSAJE DE EJEMPLO
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                $"alert('Generando reporte de ingresos para el año {selectedYear}');", true);

        }

        protected void gvIngresos_Sorting(object sender, GridViewSortEventArgs e)
        {
            // EL SORTING DE ACÁ ES DE MUESTRA
            if (SortExpression == e.SortExpression)
            {
                SortDirection = (SortDirection == "ASC") ? "DESC" : "ASC";
            }
            else
            {
                SortDirection = "ASC";
                SortExpression = e.SortExpression;
            }

            // Recarga los datos ordenados
            LoadIncomeData();
        }

        protected void gvIngresos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Código comentado porque no sirve a menos que se cambie el estilo del gv, ya que no se aprecia el ordenamiento visualmente, solo en los datos
            //es decir, no se ve el ícono que cambia

            /*
            if (e.Row.RowType == DataControlRowType.Header)
            {
                // Cambia el estilo del header para mostrar la dirección del ordenamiento
                foreach (DataControlField field in gvIngresos.Columns)
                {
                    if (field is BoundField boundField && !string.IsNullOrEmpty(boundField.SortExpression))
                    {
                        int columnIndex = gvIngresos.Columns.IndexOf(field);
                        TableCell headerCell = e.Row.Cells[columnIndex];

                        // busca el link button dentro de la celda del header
                        foreach (Control control in headerCell.Controls)
                        {
                            if (control is LinkButton linkButton)
                            {
                                if (boundField.SortExpression == SortExpression)
                                {
                                    // cambia el estilo del botón
                                    string sortClass = (SortDirection == "ASC") ? "sorted-asc" : "sorted-desc";
                                    linkButton.CssClass = sortClass;
                                }
                                else
                                {
                                    // quita el estilo si no es la columna ordenada
                                    linkButton.CssClass = "";
                                }
                                break;
                            }
                        }
                    }
                }
            }
            */
        }

        public void ExportToExcel()
        {
            // Busqué un ejemplo de cómo exportar a Excel con EPPlus, está comentado
            /*
            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("Ingresos " + ddlYear.SelectedValue);
                
                // Add headers
                worksheet.Cells[1, 1].Value = "Mes";
                worksheet.Cells[1, 2].Value = "Cantidad de pedidos";
                worksheet.Cells[1, 3].Value = "Ingresos generados";
                
                // Add data
                int row = 2;
                foreach (GridViewRow gvRow in gvIngresos.Rows)
                {
                    if (gvRow.RowType == DataControlRowType.DataRow)
                    {
                        worksheet.Cells[row, 1].Value = gvRow.Cells[0].Text;
                        worksheet.Cells[row, 2].Value = gvRow.Cells[1].Text;
                        worksheet.Cells[row, 3].Value = gvRow.Cells[2].Text;
                        row++;
                    }
                }
                
                // Set response headers for download
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", $"attachment; filename=Ingresos_{ddlYear.SelectedValue}.xlsx");
                Response.BinaryWrite(package.GetAsByteArray());
                Response.End();
            }
            */
        }

        protected void btnBorrarFiltros_Click(object sender, EventArgs e)
        {

        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {

        }
    }
}
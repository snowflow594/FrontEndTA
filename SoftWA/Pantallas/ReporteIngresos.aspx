<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ReporteIngresos.aspx.cs" Inherits="SoftWA.Pantallas.ReporteIngresos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphTitulo" runat="server">
    Reporte de Ingresos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="content-container">
        <h1 class="page-title">Ingresos totales por mes</h1>

        <!-- Selector de año -->
        <div class="filtros-container">
            <div class="filtros-izquierda">
                <!-- ddl de año -->
                <div class="filtro-item">
                    <div class="year-selector-container">
                        <span class="year-label">Año:</span>
                        <asp:DropDownList ID="ddlYear" runat="server" CssClass="year-dropdown" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                            <asp:ListItem Text="2025" Value="2025" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                            <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <!-- rango de cantidad de pedidos -->
                <div class="filtro-item">
                    <span class="form-label">Cantidad de pedidos: </span>
                    <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="number-input" placeholder="Mín" Style="margin-left: 6px; width: 70px;"></asp:TextBox>
                    <span class="date-separator" style="margin: 0 6px;">-</span>
                    <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="number-input" placeholder="Máx" Style="width: 70px;"></asp:TextBox>
                </div>
                <!-- rango de ingresos generados -->
                <div class="filtro-item">
                    <span class="form-label">Ingresos Generados: </span>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="number-input" placeholder="Mín" Style="margin-left: 6px; width: 70px;"></asp:TextBox>
                    <span class="date-separator" style="margin: 0 6px;">-</span>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="number-input" placeholder="Máx" Style="width: 70px;"></asp:TextBox>
                </div>
            </div>
            <div class="filtros-derecha">
                <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-primary" OnClick="btnFiltrar_Click" />
                <asp:Button ID="btnBorrarFiltros" runat="server" Text="Borrar filtros" CssClass="btn btn-secondary" OnClick="btnBorrarFiltros_Click" />
            </div>
        </div>
        <!-- Tabla de ingresos -->
        <asp:GridView ID="gvIngresos" runat="server" AutoGenerateColumns="False" CssClass="gridview-centered"
            Width="100%" GridLines="Both" HeaderStyle-BackColor="#007BFF" HeaderStyle-ForeColor="White" RowStyle-BackColor="#f9f9f9"
            AlternatingRowStyle-BackColor="#eef2f7" BorderStyle="Double" CellPadding="10"
            AllowSorting="true"
            OnSorting="gvIngresos_Sorting"
            OnRowDataBound="gvIngresos_RowDataBound">
            <HeaderStyle CssClass="table-header" />
            <Columns>
                <asp:BoundField DataField="Mes" HeaderText="Mes" ItemStyle-CssClass="text-left" HeaderStyle-Width="200px" SortExpression="Mes" />
                <asp:BoundField DataField="CantidadPedidos" HeaderText="Cantidad de pedidos" ItemStyle-CssClass="text-center" HeaderStyle-Width="200px" SortExpression="CantidadPedidos" />
                <asp:BoundField DataField="IngresosGenerados" HeaderText="Ingresos generados" ItemStyle-CssClass="text-right" DataFormatString="{0:C}" SortExpression="IngresosGenerados" />
            </Columns>
            <EmptyDataTemplate>
                <div style="text-align: center; padding: 20px;">No hay datos disponibles para el año seleccionado</div>
            </EmptyDataTemplate>
        </asp:GridView>

        <!-- Botón de reporte -->
        <div class="generate-report-container mt-3">
            <asp:Button ID="btnGenerarReporte" runat="server" 
                Text="Generar reporte" 
                CssClass="generate-report-btn"
                OnClick="btnGenerarReporte_Click" />
        </div>
    </div>
</asp:Content>

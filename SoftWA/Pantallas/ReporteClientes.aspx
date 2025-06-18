<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ReporteClientes.aspx.cs" Inherits="SoftWA.Pantallas.ReporteClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphTitulo" runat="server">
    Reporte de Clientes
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="content-container">
        <h1 class="page-title">Clientes más frecuentes</h1>

        <!-- Filtros -->
        <div class="filtros-container">
            <div class="filtros-izquierda">
                <!-- rango de fechas -->
                <div class="filtro-item">
                    <span class="form-label">Desde: </span>
                    <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="date-input" Style="margin-left: 6px;"></asp:TextBox>
                </div>
                <div class="filtro-item">
                    <span class="form-label">Hasta: </span>
                    <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="date-input" Style="margin-left: 6px;"></asp:TextBox>
                </div>
                <!-- ddl de categoría -->
                <div class="filtro-item">
                    <asp:Label class="form-label" runat="server" Text="Tipo de Cliente:"></asp:Label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="dropdown-input" AppendDataBoundItems="true" Style="margin-left: 6px;">
                        <asp:ListItem Text="Todos" Value="" />
                        <asp:ListItem Text="Persona Natural" Value="" />
                        <asp:ListItem Text="Persona Jurídica" Value="" />
                    </asp:DropDownList>
                </div>
                <!-- rango de precio unitario -->
                <div class="filtro-item">
                    <span class="form-label">Cantidad de pedidos: </span>
                    <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="number-input" placeholder="Mín" Style="margin-left: 6px; width: 70px;"></asp:TextBox>
                    <span class="date-separator" style="margin: 0 6px;">-</span>
                    <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="number-input" placeholder="Máx" Style="width: 70px;"></asp:TextBox>
                </div>
                <!-- rango de precio unitario -->
                <div class="filtro-item">
                    <span class="form-label">Total Gastado: </span>
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
        <!-- Tabla de clientes -->
        <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" CssClass="gridview-centered"
            Width="100%" GridLines="Both" HeaderStyle-BackColor="#007BFF" HeaderStyle-ForeColor="White" RowStyle-BackColor="#f9f9f9"
            AlternatingRowStyle-BackColor="#eef2f7" BorderStyle="Double" CellPadding="10"
            AllowSorting="true"
            OnSorting="gvClientes_Sorting"
            OnPageIndexChanging="gvClientes_PageIndexChanging">
            <HeaderStyle CssClass="table-header text-center" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ItemStyle-CssClass="text-center" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" ItemStyle-CssClass="text-left" />
                <asp:BoundField DataField="CantidadPedidos" HeaderText="Cantidad de pedidos" ItemStyle-CssClass="text-center" />
                <asp:BoundField DataField="TotalGastado" HeaderText="Total Gastado" ItemStyle-CssClass="text-center" DataFormatString="{0:C}" />
            </Columns>
            <EmptyDataTemplate>
                <div style="text-align: center; padding: 20px;">No hay datos disponibles</div>
            </EmptyDataTemplate>
        </asp:GridView>

        <!-- Botón de generacion de reporte -->
        <div class="generate-report-container mt-3">
            <asp:Button ID="btnGenerarReporte" runat="server" 
                Text="Generar reporte" 
                CssClass="generate-report-btn"
                OnClick="btnGenerarReporte_Click" />
        </div>

        <!-- Paginación de muestra -->
        <div class="pagination-container">
            <asp:LinkButton ID="lnkPrevious" runat="server" CssClass="pagination-btn" OnClick="lnkPrevious_Click">‹</asp:LinkButton>
            <asp:LinkButton ID="lnkPage1" runat="server" CssClass="pagination-btn active" OnClick="lnkPage_Click" CommandArgument="1">1</asp:LinkButton>
            <asp:LinkButton ID="lnkPage2" runat="server" CssClass="pagination-btn" OnClick="lnkPage_Click" CommandArgument="2">2</asp:LinkButton>
            <asp:LinkButton ID="lnkPage3" runat="server" CssClass="pagination-btn" OnClick="lnkPage_Click" CommandArgument="3">3</asp:LinkButton>
            <asp:LinkButton ID="lnkNext" runat="server" CssClass="pagination-btn" OnClick="lnkNext_Click">›</asp:LinkButton>
        </div>
    </div>
</asp:Content>

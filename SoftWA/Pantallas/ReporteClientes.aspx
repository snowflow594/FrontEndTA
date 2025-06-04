<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/CabeceraReporte.master" AutoEventWireup="true" CodeBehind="ReporteClientes.aspx.cs" Inherits="SoftWA.Pantallas.ReporteClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphTitulo" runat="server">
    Reporte de Clientes
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/Estilos/SiteReportes.css" rel="stylesheet" />

    <div class="content-container">
        <h1 class="page-title">Clientes más frecuentes</h1>

        <!-- Selector de rango de fechas -->
        <div class="date-range-container">
            <span class="date-range-label">Custom range:</span>
            <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
            <span class="date-separator">to</span>
            <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
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

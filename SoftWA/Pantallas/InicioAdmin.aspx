<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/SiteAdmin.master" AutoEventWireup="true" CodeBehind="InicioAdmin.aspx.cs" Inherits="SoftWA.Pantallas.InicioAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphTitulo" runat="server">
    Página de Inicio
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="alert alert-success" role="alert">
        Bienvenido a tu sistema.
    </div>

     <div style="text-align: center; margin-top: 50px;">
    <h1 style="font-size: 36px;">Bienvenido al Sistema de Gestión </h1>
    <p style="font-size: 18px; margin-top: 20px;">
      Administra fácilmente productos, pedidos, usuarios y reportes desde un solo lugar.
    </p>

    <div style="margin-top: 40px;">
      <asp:Button ID="btnVerProductos" runat="server" Text="Ver Productos" CssClass="btn btn-primary" OnClick="btnVerProductos_Click" />
      <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar Producto" CssClass="btn btn-success" OnClick="btnAgregarProducto_Click" style="margin-left: 15px;" />
    </div>

    <img src="https://cdn-icons-png.flaticon.com/512/1170/1170627.png" alt="Productos" width="150" style="margin-top: 40px; opacity: 0.7;" />
  </div>
</asp:Content>

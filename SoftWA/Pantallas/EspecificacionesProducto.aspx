<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="EspecificacionesProducto.aspx.cs" Inherits="SoftWA.Pantallas.EspecificacionesProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row">
            <div class="col-md-6">
                <asp:Image ID="imgProducto" runat="server" CssClass="img-fluid rounded shadow-sm" ImageUrl="https://via.placeholder.com/500" />
            </div>
            <div class="col-md-6">
                <h2><asp:Label ID="lblNombre" runat="server" Text="Nombre del producto"></asp:Label></h2>
                <p class="text-muted"><asp:Label ID="lblDescripcion" runat="server" Text="Descripción"></asp:Label></p>
                <p><strong>ID:</strong> <asp:Label ID="lblId" runat="server"></asp:Label></p>
                <p><strong>Stock:</strong> <asp:Label ID="lblStock" runat="server"></asp:Label></p>
                <asp:Button ID="btnAgregarCarrito" runat="server" Text="Agregar al carrito" CssClass="btn btn-success mt-3" OnClick="btnAgregarCarrito_Click" />
            </div>
        </div>
    </div>
</asp:Content>

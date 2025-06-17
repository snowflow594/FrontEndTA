<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="EspecificacionesProducto.aspx.cs" Inherits="SoftWA.Pantallas.EspecificacionesProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row">
            <!-- imagen del producto -->
            <div class="col-md-6 mb-4">
                <asp:Image ID="imgProducto" runat="server" CssClass="img-fluid rounded shadow-sm" />
            </div>

            <!-- info del producto -->
            <div class="col-md-6">
                <h2 class="mb-3"><asp:Label ID="lblNombre" runat="server" /></h2>
                <p><strong>Código:</strong> <asp:Label ID="lblCodigo" runat="server" /></p>
                <p><strong>Stock:</strong> <asp:Label ID="lblStock" runat="server"></asp:Label></p>
                <p><strong>Precio:</strong> <asp:Label ID="lblPrecio" runat="server"></asp:Label></p>
                <p><strong>Categoría:</strong> <asp:Label ID="lblCategoria" runat="server" /></p>
                <p><strong>Descripción:</strong></p>
                <p><asp:Label ID="lblDescripcion" runat="server" /></p>
                <asp:Button ID="btnAgregarCarrito" runat="server" Text="Agregar al Carrito" CssClass="btn btn-cta mt-3" OnClick="btnAgregarCarrito_Click" />
            </div>
        </div>
    </div>
</asp:Content>

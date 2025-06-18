<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="SoftWA.Pantallas.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h2 class="mb-4">Catálogo de Productos</h2>

        <div class="row mb-3">
            <div class="col-md-4">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Buscar por nombre o ID..." />
            </div>
            <div class="col-md-4">
                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todas las Categorías" Value="" />
                    <asp:ListItem Text="Ollas" Value="OLLA" />
                    <asp:ListItem Text="Sartenes" Value="SARTEN" />
                    <asp:ListItem Text="Cuchillos" Value="CUCHILLOS" />
                    <asp:ListItem Text="Accesorio" Value="ACCESORIO" />
                    <asp:ListItem Text="Electrodomésticos" Value="ELECTRODOMESTICO" />
                    <asp:ListItem Text="Utensilios" Value="UTENSILIO" />
                </asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:Button ID="btnFiltrar" runat="server" CssClass="btn btn-primary w-100" Text="Filtrar" OnClick="btnFiltrar_Click" />
            </div>
        </div>

        <asp:Repeater ID="rptProductos" runat="server">
            <ItemTemplate>
                <div class="card mb-3 shadow-sm">
                    <div class="row g-0">
                        <div class="col-md-3">
                            <img src="../Content/Imagenes/olla.png" class="img-fluid p-3" style="max-height: 160px; object-fit: contain;" alt="Imagen del producto" />
                        </div>
                        <div class="col-md-6">
                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("nombre") %></h5>
                                <p class="card-text"><%# Eval("descripcion") %></p>
                                <p class="card-text fw-bold text-success">S/ <%# Eval("precio", "{0:F2}") %></p>
                            </div>
                        </div>
                        <div class="col-md-3 d-flex align-items-center justify-content-center">
                            <asp:HyperLink ID="lnkVerMas" runat="server" CssClass="btn btn-outline-primary"
                                NavigateUrl='<%# Eval("idProducto", "EspecificacionesProducto.aspx?id={0}") %>'>
                                Ver más
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

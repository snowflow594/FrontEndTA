<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="SoftWA.Pantallas.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h2 class="mb-4">Catálogo de Productos</h2>

        <div class="row justify-content-center mb-4">
            <div class="col-md-3">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Buscar por nombre o ID..." />
            </div>
            <div class="col-md-2">
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
            <div class="col-md-2">
                <asp:TextBox ID="txtPrecioMin" runat="server" CssClass="form-control" placeholder="Precio mínimo" />
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtPrecioMax" runat="server" CssClass="form-control" placeholder="Precio máximo" />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnFiltrar" runat="server" CssClass="btn btn-primary w-100" Text="Filtrar" OnClick="btnFiltrar_Click" />
            </div>
        </div>


        <!--Productos 9. 9 en total por página-->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <asp:Repeater ID="rptProductos" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="../Content/Imagenes/olla.png" class="card-img-top p-3" style="height: 200px; object-fit: contain;" alt="Imagen del producto" />
                            <div class="card-body d-flex flex-column justify-content-between">
                                <h5 class="card-title text-truncate"><%# Eval("nombre") %></h5>
                                <p class="card-text small text-muted text-truncate"><%# Eval("descripcion") %></p>
                                <p class="text-success fw-bold">S/ <%# Eval("precio", "{0:F2}") %></p>
                                <asp:HyperLink ID="lnkVerMas" runat="server" CssClass="btn btn-outline-dark w-100 mt-auto"
                                    NavigateUrl='<%# Eval("idProducto", "EspecificacionesProducto.aspx?id={0}") %>'>
                            Ver más detalles
                                </asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Paginación -->
        <div class="d-flex justify-content-center mt-4">
            <asp:Repeater ID="rptPaginacion" runat="server" OnItemCommand="rptPaginacion_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton
                        runat="server"
                        CommandName="CambiarPagina"
                        CommandArgument='<%# Eval("NumeroPagina") %>'
                        CssClass='<%# Eval("CssClass") %>'
                        Text='<%# Eval("Texto") %>' />
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

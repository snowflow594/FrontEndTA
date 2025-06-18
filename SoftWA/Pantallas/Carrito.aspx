<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="SoftWA.Pantallas.Carrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row">
            <!-- Lista de productos -->
            <div class="col-lg-8">
                <h3 class="mb-4">Tu Carrito</h3>
                <asp:Repeater ID="rptCarrito" runat="server" OnItemCommand="rptCarrito_ItemCommand">
                    <ItemTemplate>
                        <div class="card mb-3 shadow-sm">
                            <div class="row g-0">
                                <div class="col-md-3">
                                    <img src="../Content/Imagenes/olla.png" class="img-fluid rounded-start p-2" style="max-height: 140px; object-fit: contain;" alt="Imagen del producto" />
                                </div>
                                <div class="col-md-6">
                                    <div class="card-body">
                                        <h5 class="card-title"><%# Eval("producto.nombre") %></h5>
                                        <p class="card-text"><%# Eval("producto.descripcion") %></p>
                                        <p class="card-text mb-0"><strong>Precio:</strong> S/ <%# Eval("producto.precio", "{0:F2}") %></p>
                                        <p class="card-text"><strong>Subtotal:</strong> S/ <%# Eval("subtotal", "{0:F2}") %></p>
                                    </div>
                                </div>
                                <div class="col-md-3 d-flex align-items-center justify-content-center">
                                    <div class="btn-group">
                                        <asp:Button runat="server" CssClass="btn btn-outline-secondary" Text="–" CommandName="Disminuir" CommandArgument='<%# Eval("producto.idProducto") %>' />
                                        <asp:Label ID="lblCantidad" runat="server" Text='<%# Eval("cantidad") %>' CssClass="mx-2 align-self-center" />
                                        <asp:Button runat="server" CssClass="btn btn-outline-secondary" Text="+" CommandName="Aumentar" CommandArgument='<%# Eval("producto.idProducto") %>' />
                                        <asp:Button runat="server" CssClass="btn btn-outline-danger" Text="🗑" CommandName="Eliminar" CommandArgument='<%# Eval("producto.idProducto") %>' ToolTip="Eliminar producto" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Resumen de compra -->
            <div class="col-lg-4">
                <div class="card shadow-sm p-4">
                    <h4 class="mb-3">Resumen</h4>
                    <p><strong>Subtotal:</strong> S/
                        <asp:Label ID="lblSubtotal" runat="server" /></p>
                    <p><strong>IGV (18%):</strong> S/
                        <asp:Label ID="lblIGV" runat="server" /></p>
                    <p><strong>Total:</strong> S/
                        <asp:Label ID="lblTotal" runat="server" CssClass="fw-bold" /></p>
                    <hr />
                    <asp:Button ID="btnContinuar" runat="server" CssClass="btn btn-cta w-100" Text="Continuar con la Compra" PostBackUrl="DireccionEnvio.aspx" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

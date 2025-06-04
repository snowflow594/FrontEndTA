<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="SoftWA.Pantallas.Carrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/Estilos/carritostyle.css" rel="stylesheet" />
     <div class="container py-5">
        <div class="row g-4">
            <!-- lista de productos -->
            <div class="col-lg-8">
                <div class="card p-4">
                    <h4 class="mb-4">Tu Carrito</h4>
                    <asp:Repeater ID="rptCarrito" runat="server" OnItemCommand="rptCarrito_ItemCommand">
                        <ItemTemplate>
                            <div class="card p-3 mb-3">
                                <div class="row g-3 align-items-center">
                                    <div class="col-3 col-md-2">
                                        <img src="https://via.placeholder.com/100" class="product-img" alt="Producto" />
                                    </div>
                                    <div class="col-9 col-md-4">
                                        <h5><%# Eval("producto.nombre") %></h5>
                                        <p class="mb-0 text-muted"><%# Eval("producto.descripcion") %></p>
                                    </div>
                                    <div class="col-12 col-md-3 d-flex align-items-center justify-content-start justify-content-md-center">
                                        <asp:Button runat="server" CssClass="btn btn-outline-secondary me-2" CommandName="Disminuir" CommandArgument='<%# Eval("idItemCarrito") %>' Text="-" />
                                        <span><%# Eval("cantidad") %></span>
                                        <asp:Button runat="server" CssClass="btn btn-outline-secondary ms-2" CommandName="Aumentar" CommandArgument='<%# Eval("idItemCarrito") %>' Text="+" />
                                    </div>
                                    <div class="col-12 col-md-3 text-md-end">
                                        <strong>S/ <%# Eval("subtotal", "{0:N2}") %></strong>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Rsumen del carrito -->
            <div class="col-lg-4">
                <div class="card resumen-carrito p-4 shadow-sm rounded">
                    <h5 class="fw-bold">Resumen del Pedido</h5>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Subtotal</span>
                        <asp:Label ID="lblSubtotal" runat="server" CssClass="fw-normal"></asp:Label>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Impuesto</span>
                        <asp:Label ID="lblImpuesto" runat="server" CssClass="fw-normal"></asp:Label>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Total</span>
                        <asp:Label ID="lblTotal" runat="server" CssClass="fw-bold"></asp:Label>
                    </div>
                    <a href="DireccionEnvio.aspx" class="btn btn-success w-100 mt-3">Proceder al pago</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

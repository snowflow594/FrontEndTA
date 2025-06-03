<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="SoftWA.Pantallas.Carrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/Estilos/carritostyle.css" rel="stylesheet" />
    <div class="container py-5">
        <div class="row d-flex align-items-stretch">
            <div class="col-lg-8 h-100">
                <div class="card p-4 mb-4">
                    <h3 class="mb-4">Carrito de Compras</h3>
                    <!--productos-->
                    <div class="col-lg-8">
                        <asp:Repeater ID="rptCarrito" runat="server" OnItemCommand="rptCarrito_ItemCommand">
                            <ItemTemplate>
                                <div class="card p-3 mb-3">
                                    <div class="row g-3 align-items-center">
                                        <div class="col-3 col-md-2">
                                            <img src='<%# Eval("imagenUrl") %>' class="product-img img-fluid" alt="Producto" />
                                        </div>
                                        <div class="col-9 col-md-4">
                                            <h5><%# Eval("producto.nombre") %></h5>
                                            <p class="mb-0 text-muted"><%# Eval("producto.descripcion") %></p>
                                        </div>
                                        <div class="col-12 col-md-3 d-flex align-items-center justify-content-start justify-content-md-center">
                                            <asp:Button ID="btnMenos" runat="server" CssClass="btn btn-outline-secondary me-2" Text="-"
                                                CommandName="Disminuir" CommandArgument='<%# Eval("idItemCarrito") %>' />
                                            <span><%# Eval("cantidad") %></span>
                                            <asp:Button ID="btnMas" runat="server" CssClass="btn btn-outline-secondary ms-2" Text="+"
                                                CommandName="Aumentar" CommandArgument='<%# Eval("idItemCarrito") %>' />
                                        </div>
                                        <div class="col-12 col-md-3 text-md-end mt-2 mt-md-0">
                                            <strong>S/ <%# (Convert.ToDecimal(Eval("subtotal")) * Convert.ToInt32(Eval("cantidad"))).ToString("F2") %></strong>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Resumen del carrito -->
                    <div class="col-lg-4">
                        <div class="resumen-carrito shadow-sm p-4 rounded">
                            <h5 class="fw-bold">Resumen del Pedido</h5>
                            <div class="d-flex justify-content-between mt-3">
                                <span>Subtotal</span>
                                <asp:Label ID="lblSubtotal" runat="server" CssClass="fw-normal" />
                            </div>
                            <div class="d-flex justify-content-between mt-3">
                                <span>Impuesto </span>
                                <asp:Label ID="lblImpuestos" runat="server" CssClass="fw-normal" />
                            </div>
                            <hr />
                            <div class="d-flex justify-content-between total-section fw-bold">
                                <span>Total</span>
                                <asp:Label ID="lblTotal" runat="server" CssClass="fw-bold" />
                            </div>
                            <asp:Button ID="btnProcederPago" runat="server" Text="Proceder al pago" CssClass="btn btn-success w-100 mt-3"
                                PostBackUrl="~/DireccionEnvio.aspx" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

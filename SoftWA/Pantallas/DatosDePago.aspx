<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="DatosDePago.aspx.cs" Inherits="SoftWA.Pantallas.DatosDePago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h3 class="mb-4">Datos de Pago</h3>
        <!-- Dirección de envío actual -->
        <div class="card mb-4 p-3 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-1">Dirección de Envío:</h5>
                    <p class="mb-0"><strong>Alias:</strong>
                        <asp:Label ID="lblAlias" runat="server" /></p>
                    <p class="mb-0"><strong>Dirección:</strong>
                        <asp:Label ID="lblDireccion" runat="server" /></p>
                    <p class="mb-0"><strong>Ciudad:</strong>
                        <asp:Label ID="lblCiudad" runat="server" /></p>
                </div>
                <div>
                    <a href="DireccionEnvio.aspx" class="btn btn-outline-secondary">Modificar Dirección</a>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Formulario de Tarjeta -->
            <div class="col-md-7">
                <div class="card p-4 shadow-sm">
                    <div class="mb-3">
                        <label for="txtNombre" class="form-label">Nombre en la tarjeta</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtNumeroTarjeta" class="form-label">Número de tarjeta</label>
                        <asp:TextBox ID="txtNumeroTarjeta" runat="server" CssClass="form-control" MaxLength="16" />
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="txtFechaExp" class="form-label">Fecha de Expiración (MM/AA)</label>
                            <asp:TextBox ID="txtFechaExp" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="txtCVV" class="form-label">CVV</label>
                            <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" MaxLength="4" />
                        </div>
                    </div>
                    <asp:Button ID="btnPagar" runat="server" Text="Pagar y Finalizar Pedido" CssClass="btn btn-success" OnClick="btnPagar_Click" />
                    <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-2 d-block"></asp:Label>
                </div>
            </div>

            <!-- Resumen del Pedido -->
            <div class="col-md-5">
                <div class="card p-4 shadow-sm">
                    <h5 class="mb-3">Resumen de Pedido</h5>
                    <p><strong>Subtotal:</strong> S/
                        <asp:Label ID="lblSubtotal" runat="server" Text="0.00" /></p>
                    <p><strong>Impuesto (18%):</strong> S/
                        <asp:Label ID="lblIGV" runat="server" Text="0.00" /></p>
                    <p><strong>Envío:</strong> S/
                        <asp:Label ID="lblEnvio" runat="server" Text="-" /></p>
                    <hr />
                    <p class="fs-5"><strong>Total:</strong> S/
                        <asp:Label ID="lblTotal" runat="server" Text="0.00" /></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

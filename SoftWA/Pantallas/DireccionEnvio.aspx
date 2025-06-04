<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="DireccionEnvio.aspx.cs" Inherits="SoftWA.Pantallas.DireccionEnvio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row g-4">
            <!-- formulario de dirección -->
            <div class="col-lg-8">
                <div class="card p-4">
                    <h4 class="mb-4">Dirección de Envío</h4>

                    <!-- correo electrónico -->
                    <div class="mb-3">
                        <label for="txtCorreo" class="form-label">Correo electrónico (para el comprobante):</label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" Placeholder="ejemplo@correo.com" TextMode="Email" />
                    </div>

                    <!-- alias de la direccion -->
                    <div class="mb-3">
                        <label for="txtAlias" class="form-label">Alias de la dirección:</label>
                        <asp:TextBox ID="txtAlias" runat="server" CssClass="form-control" Placeholder="Casa, Oficina, etc." />
                    </div>

                    <!-- direccion tal cual -->
                    <div class="mb-3">
                        <label for="txtDireccion" class="form-label">Dirección:</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" Placeholder="Av. Siempre Viva 123" />
                    </div>

                    <!-- ciudad -->
                    <div class="mb-3">
                        <label for="txtCiudad" class="form-label">Ciudad:</label>
                        <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control" Placeholder="Lima, Arequipa, etc." />
                    </div>

                    <!-- referencia -->
                    <div class="mb-3">
                        <label for="txtReferencia" class="form-label">Referencia:</label>
                        <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control" Placeholder="Frente al parque, al costado del banco..." />
                    </div>

                    <!-- botones -->
                    <div class="d-flex gap-3 mt-4">
                        <asp:Button ID="btnGuardarDireccion" runat="server" CssClass="btn btn-primary" Text="Guardar Dirección" OnClick="btnGuardarDireccion_Click" />
                        <asp:Button ID="btnVerDirecciones" runat="server" CssClass="btn btn-outline-secondary" Text="Direcciones Guardadas" OnClick="btnVerDirecciones_Click" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="mt-3 d-block"></asp:Label>
                </div>
            </div>

            <!-- resumen con costo de envío -->
            <div class="col-lg-4">
                <div class="card resumen-carrito p-4 shadow-sm rounded">
                    <h5 class="fw-bold">Resumen del Pedido</h5>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Subtotal</span>
                        <asp:Label ID="lblSubtotal" runat="server" Text="S/ 0.00" />
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Impuesto</span>
                        <asp:Label ID="lblImpuesto" runat="server" Text="S/ 0.00" />
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Costo de Envío</span>
                        <asp:Label ID="lblEnvio" runat="server" Text="-" />
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Total</span>
                        <asp:Label ID="lblTotal" runat="server" Text="S/ 0.00" />
                    </div>
                    <asp:Button ID="btnContinuarPago" runat="server" CssClass="btn btn-success w-100 mt-3" Text="Continuar con método de pago" OnClick="btnContinuarPago_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

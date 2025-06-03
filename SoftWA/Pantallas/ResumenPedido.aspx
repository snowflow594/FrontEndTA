<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="ResumenPedido.aspx.cs" Inherits="SoftWA.Pantallas.ResumenPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <!-- Encabezado -->
        <div class="text-center mb-4">
            <h4>✔️ Pedido #131217312</h4>
            <h2 class="fw-bold">Gracias por tu compra,
                <asp:Label ID="lblNombreUsuario" runat="server" Text="Kenny"></asp:Label>!</h2>
            <p>Hemos aceptado tu orden y estamos trabajando en ella.</p>
        </div>

        <hr />

        <!-- Información del Cliente -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h5>Información del cliente</h5>
                <p>
                    <strong>Dirección de envío:</strong><br />
                    <asp:Label ID="lblDireccionEnvio" runat="server" Text="12 Waldo Point Road, NY 11200"></asp:Label>
                </p>
                <p>
                    <strong>Dirección de facturación:</strong><br />
                    <asp:Label ID="lblDireccionFacturacion" runat="server" Text="12 Waldo Point Road, NY 11200"></asp:Label>
                </p>
                <p>
                    <strong>Método de pago:</strong><br />
                    💳 Terminación
                    <asp:Label ID="lblPagoTarjeta" runat="server" Text="3217"></asp:Label>
                    — $<asp:Label ID="lblTotalPago" runat="server" Text="23.60"></asp:Label>
                </p>
                <p>
                    <strong>Fecha:</strong>
                    <asp:Label ID="lblFecha" runat="server" Text=""></asp:Label>
                </p>
            </div>
        </div>

        <!-- Productos -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h5>Productos del pedido</h5>
                <div class="card mb-2 p-2">
                    <div class="row">
                        <div class="col-3">
                            <img src="imagenes/producto1.jpg" class="img-fluid" />
                        </div>
                        <div class="col-7">
                            <strong>Cute Kids Cardigan - 6T</strong><br />
                            <span>Pink lorem ipsum dolor sit amet...</span>
                        </div>
                        <div class="col-2 text-end">
                            <span>$55.99</span><br />
                            <span>Cantidad: 1</span>
                        </div>
                    </div>
                </div>

                <div class="card mb-2 p-2">
                    <div class="row">
                        <div class="col-3">
                            <img src="imagenes/producto2.jpg" class="img-fluid" />
                        </div>
                        <div class="col-7">
                            <strong>Nombre del segundo producto</strong><br />
                            <span>Descripción del producto</span>
                        </div>
                        <div class="col-2 text-end">
                            <span>$55.99</span><br />
                            <span>Cantidad: 1</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Resumen del pedido -->
            <div class="col-lg-4">
                <div class="card resumen-carrito shadow-sm p-4 rounded sticky-top" style="top: 20px;">
                    <h5 class="fw-bold">Resumen(2 ítems)</h5>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Subtotal</span>
                        <span>$20.00</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Impuestos estimados</span>
                        <span>$1.40</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Total</span>
                        <span>$23.60</span>
                    </div>
                    <hr />
                    <p>
                        <strong>Fecha estimada de llegada:</strong><br />
                        20 de mayo de 2025 (7 días desde hoy)
                    </p>
                    <p>
                        <strong>Comprobante electrónico:</strong><br />
                        <input type="text" class="form-control mb-2" value="131217312-03-ER8901289" readonly />
                        <button class="btn btn-outline-primary w-100">Ver Comprobante</button>
                    </p>

                    <!-- Estado del pedido -->
                    <p class="mt-3"><strong>Estado del pedido:</strong></p>
                    <div class="progress" role="progressbar">
                        <div class="progress-bar progress-bar-striped bg-info" style="width: 60%;">Procesando...</div>
                    </div>
                    <small class="text-muted">Estamos preparando tu producto para el envío.</small>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

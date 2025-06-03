<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="DatosDePago.aspx.cs" Inherits="SoftWA.Pantallas.DatosDePago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row g-5">
            <!-- formulario de pago -->
            <div class="col-lg-8">
                <div class="card p-4 mb-4">
                    <h3 class="mb-3">Datos de Pago</h3>

                    <!-- dirección ingresada -->
                    <div class="mb-4">
                        <h5 class="fw-bold">Dirección de envío:</h5>
                        <p class="mb-0">Juan Pérez, Av. Ejemplo 123, Lima, Perú</p>
                        <small><a href="DireccionEnvio.aspx">Modificar</a></small>
                    </div>

                    <!-- formulario datos de la tarjeta -->
                    <div class="mb-3">
                        <label class="form-label">Número de tarjeta</label>
                        <input type="text" class="form-control" placeholder="1234 5678 9012 3456" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nombre en la tarjeta</label>
                        <input type="text" class="form-control" placeholder="Juan Pérez" required />
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Fecha de vencimiento</label>
                            <input type="text" class="form-control" placeholder="MM/AA" required />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">CVV</label>
                            <input type="text" class="form-control" placeholder="123" required />
                        </div>
                    </div>

                    <!-- Belegir boleta o factura -->
                    <div class="mb-3">
                        <label class="form-label d-block">Comprobante:</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="comprobante" id="boleta" checked />
                            <label class="form-check-label" for="boleta">Boleta</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="comprobante" id="factura" />
                            <label class="form-check-label" for="factura">Factura</label>
                        </div>
                    </div>

                    <!-- guardar tarjeta -->
                    <div class="form-check mb-4">
                        <input class="form-check-input" type="checkbox" id="guardarTarjeta" />
                        <label class="form-check-label" for="guardarTarjeta">Guardar los datos de esta tarjeta</label>
                    </div>
                </div>
            </div>

            <!-- resumen  -->
            <div class="col-lg-4">
                <div class="card resumen-carrito shadow-sm p-4 rounded">
                    <h5 class="fw-bold">Resumen del Pedido</h5>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Subtotal</span>
                        <span>S/ 240.00</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Impuesto</span>
                        <span>S/ 30.00</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>Costo de envío</span>
                        <span>S/ 15.00</span>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Total</span>
                        <span>S/ 285.00</span>
                    </div>
                    <small class="text-muted d-block mt-2">Llegada estimada: entre 3 y 5 días hábiles</small>

                    <a href="ResumenPedido.aspx" class="btn btn-primary w-100 mt-4">Confirmar Pago</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

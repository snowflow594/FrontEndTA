<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="DireccionEnvio.aspx.cs" Inherits="SoftWA.Pantallas.DireccionEnvio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row g-4">
            <!-- Formulario de dirección -->
            <div class="col-lg-8">
                <div class="card p-4">
                    <h4 class="mb-4">Dirección de Envío</h4>

                    <!-- correo electrónico -->
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico (para el comprobante):</label>
                        <input type="email" class="form-control" id="correo" placeholder="ejemplo@correo.com" />
                    </div>

                    <!-- alias de la direccion -->
                    <div class="mb-3">
                        <label for="alias" class="form-label">Alias de la dirección:</label>
                        <input type="text" class="form-control" id="alias" placeholder="Casa, Oficina, etc." />
                    </div>

                    <!-- direccion tal cual -->
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección:</label>
                        <input type="text" class="form-control" id="direccion" placeholder="Av. Siempre Viva 123" />
                    </div>

                    <!-- ciudad -->
                    <div class="mb-3">
                        <label for="ciudad" class="form-label">Ciudad:</label>
                        <input type="text" class="form-control" id="ciudad" placeholder="Lima, Arequipa, etc." />
                    </div>

                    <!-- referencia de la direccion -->
                    <div class="mb-3">
                        <label for="referencia" class="form-label">Referencia:</label>
                        <input type="text" class="form-control" id="referencia" placeholder="Frente al parque, al costado del banco..." />
                    </div>

                    <!-- botones para guardar la direccion y direcciones guardaadas -->
                    <div class="d-flex gap-3 mt-4">
                        <button class="btn btn-primary" type="button">Guardar Dirección</button>
                        <button class="btn btn-outline-secondary" type="button">Direcciones Guardadas</button>
                    </div>
                </div>
            </div>

            <!-- resumen ahora con costo de envío -->
            <div class="col-lg-4">
                <div class="card resumen-carrito p-4 shadow-sm rounded">
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
                        <span>Costo de Envío</span>
                        <span>-</span>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Total</span>
                        <span>S/ 270.00</span>
                    </div>
                    <a href="DatosDePago.aspx" class="btn btn-success w-100 mt-3">Continuar con método de pago</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

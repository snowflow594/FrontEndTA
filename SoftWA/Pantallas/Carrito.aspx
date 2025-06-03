<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="SoftWA.Pantallas.Carrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/Estilos/carritostyle.css" rel="stylesheet" />
    <div class="container py-5">
        <div class="row d-flex align-items-stretch">
            <div class="col-lg-8 h-100">
                <div class="card p-4 mb-4">
                    <h3 class="mb-4">Carrito de Compras</h3>

                    <!-- Producto 1 -->
                    <div class="card p-3 mb-3">
                        <div class="row g-3 align-items-center">
                            <div class="col-3 col-md-2">
                                <img src="https://via.placeholder.com/100" class="product-img" alt="Producto" />
                            </div>
                            <div class="col-9 col-md-4">
                                <h5>Olla de acero</h5>
                                <p class="mb-0 text-muted">Capacidad 5L. Antiadherente. Aquí va toda la descripción de los productos que se venderán en lá página web</p>
                            </div>
                            <div class="col-12 col-md-3 d-flex align-items-center justify-content-start justify-content-md-center">
                                <button class="btn btn-outline-secondary me-2"><i class="fas fa-minus"></i></button>
                                <span>2</span>
                                <button class="btn btn-outline-secondary ms-2"><i class="fas fa-plus"></i></button>
                            </div>
                            <div class="col-12 col-md-3 text-md-end mt-2 mt-md-0">
                                <strong>S/ 120.00</strong>
                            </div>
                        </div>
                    </div>

                    <!-- Producto 2 -->
                    <div class="card p-3 mb-3">
                        <div class="row g-3 align-items-center">
                            <div class="col-3 col-md-2">
                                <img src="https://via.placeholder.com/100" class="product-img" alt="Producto" />
                            </div>
                            <div class="col-9 col-md-4">
                                <h5>Cuchillo Profesional</h5>
                                <p class="mb-0 text-muted">Hoja de acero inoxidable.</p>
                            </div>
                            <div class="col-12 col-md-3 d-flex align-items-center justify-content-start justify-content-md-center">
                                <button class="btn btn-outline-secondary me-2"><i class="fas fa-minus"></i></button>
                                <span>2</span>
                                <button class="btn btn-outline-secondary ms-2"><i class="fas fa-plus"></i></button>
                            </div>
                            <div class="col-12 col-md-3 text-md-end mt-2 mt-md-0">
                                <strong>S/ 60.00</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--resumen del arrito-->
            <div class="col-lg-4">
                <div class="resumen-carrito shadow-sm p-4 rounded">
                    <h5 class="fw-bold">Resumen del Pedido</h5>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Subtotal</span>
                        <span>S/ 240.00</span>
                    </div>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Impuesto (productos importados)</span>
                        <span>S/ 30.00</span>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between total-section fw-bold">
                        <span>Total</span>
                        <span>S/ 270.00</span>
                    </div>
                    <a href="DireccionEnvio.aspx" class="btn btn-success w-100 mt-3">Proceder al pago</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

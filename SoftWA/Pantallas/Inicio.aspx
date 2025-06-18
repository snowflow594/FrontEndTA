<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="SoftWA.Pantallas.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Carousel ancho completo -->
    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://kitchencenter.pe/cdn/shop/files/51206-100.jpg?v=1741210390" class="d-block w-100" alt="Utensilios 1">
                <div class="carousel-caption d-none d-md-block text-start">
                    <h1 class="display-4">Bienvenido a CIAPASA</h1>
                    <p class="lead">Descubre los mejores utensilios para tu cocina.</p>
                    <a href="Productos.aspx" class="btn btn-cta btn-lg">¡Ir a Productos!</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://hogaruniversal.vtexassets.com/arquivos/ids/167580/L37480-OLLA-PRESION-SILVER-EXPRESS-6-L---02.jpg?v=638736004417070000" class="d-block w-100" alt="Utensilios 2">
                <div class="carousel-caption d-none d-md-block text-start">
                    <h1 class="display-4">Calidad y Durabilidad</h1>
                    <p class="lead">Ollas, sartenes y más, al mejor precio.</p>
                    <a href="Productos.aspx" class="btn btn-cta btn-lg">Ver Colección</a>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <!-- Sección de categorías rápidas -->
    <section class="py-5">
        <div class="container">
            <h2 class="mb-4 text-center">Productos Destacados</h2>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                <asp:Repeater ID="rptCategorias" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card h-100 shadow-sm border-0">
                                <img src="../Content/Imagenes/olla.png" class="card-img-top img-fluid" style="object-fit: contain; height: 180px;" alt="Imagen producto" />
                                <div class="card-body d-flex flex-column text-center">
                                    <h6 class="card-title mb-2"><%# Eval("nombre") %></h6>
                                    <p class="text-success fw-bold">S/ <%# Eval("precio", "{0:F2}") %></p>
                                    <a href='EspecificacionesProducto.aspx?id=<%# Eval("idProducto") %>' class="btn btn-outline-dark mt-auto">Ver Detalles</a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="text-center mt-4">
                <a href="Productos.aspx" class="btn btn-cta px-4 py-2">Ver todos los productos</a>
            </div>
        </div>
    </section>

    <!-- Sección de cards de acción rápida -->
    <div class="container py-5">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title">Ver Todos los Productos</h5>
                        <p class="card-text">Navega por nuestro catálogo completo.</p>
                        <a href="Productos.aspx" class="btn btn-cta">Ir a Productos</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title">Mi Carrito</h5>
                        <p class="card-text">Tus artículos guardados para más tarde.</p>
                        <a href="Carrito.aspx" class="btn btn-success">Ver Carrito</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title">Mi Perfil</h5>
                        <p class="card-text">Gestiona tus datos y direcciones.</p>
                        <a href="Perfil.aspx" class="btn btn-warning">Ir a Perfil</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

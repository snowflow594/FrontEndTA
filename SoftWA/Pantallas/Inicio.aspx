<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="SoftWA.Pantallas.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Carousel ancho completo -->
    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <%------------------------Le agregue una carpeta de fotos y asi lo enlace--%>
                <img src="../Content/Imagenes/Presentacion/OllaInicio.jpg" class="d-block w-100" alt="Utensilios 1">
                <div class="carousel-caption d-none d-md-block text-start">
                    <h1 class="display-4">Bienvenido a CIAPASA</h1>
                    <p class="lead">Descubre los mejores utensilios para tu cocina.</p>
                    <a href="Productos.aspx" class="btn btn-cta btn-lg">¡Ir a Productos!</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="../Content/Imagenes/Presentacion/Cuchillos.jpg" class="d-block w-100" alt="Utensilios 2">
                <div class="carousel-caption d-none d-md-block text-start">
                    <h1 class="display-4">Calidad y Durabilidad</h1>
                    <p class="lead">Ollas, sartenes y más, al mejor precio.</p>
                    <a href="Productos.aspx" class="btn btn-cta btn-lg">Ver Colección</a>
                </div>
            </div>
            <%------------------------Le agregue Otro imagen de carrusel aca--%>
            <div class="carousel-item">
                <img src="../Content/Imagenes/Presentacion/Sartenes.jpg" class="d-block w-100" alt="Utensilios 3">
                <div class="carousel-caption d-none d-md-block text-start">
                    <h1 class="display-4">Garantia y Devolución</h1>
                    <p class="lead">Si viene con fallo de fabrica, obtienes un cambio de producto, 100% Garantizable.</p>
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

      <!-- Sección de categorías como carrusel -->
  <section class="py-5 bg-light">
  <div class="container text-center">
    <h2 class="section-title">Categorías Destacadas</h2>

    <div id="carouselCategorias" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="6000">

      <!-- Indicators como puntitos -->
      <div class="carousel-indicators mb-5">
        <asp:Repeater ID="rptCategoriasCarousel" runat="server">
          <ItemTemplate>
            <button
              type="button"
              data-bs-target="#carouselCategorias"
              data-bs-slide-to="<%# Container.ItemIndex %>"
              class="<%# Container.ItemIndex == 0 ? "active" : "" %>"
              aria-current="<%# Container.ItemIndex == 0 ? "true" : "false" %>"
              aria-label="Slide <%# Container.ItemIndex+1 %>"
            ></button>
          </ItemTemplate>
        </asp:Repeater>
      </div>

      <!-- Slides -->
      <div class="carousel-inner">
        <asp:Repeater ID="Repeater1" runat="server">
          <ItemTemplate>
            <div class="carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>">
              <div class="card border-0 shadow mx-auto" style="max-width: 360px; border-radius:1rem;">
                <div class="overflow-hidden" style="border-top-left-radius:1rem; border-top-right-radius:1rem;">
                  <img
                    src="../Content/Imagenes/Productos/Categorias/<%# Eval("idProducto") %>.jpg"
                    class="card-img-top"
                    alt="<%# Eval("nombre") %>"
                  />
                </div>
                <div class="card-body text-center">
                  <h5 class="card-title mb-3 fw-bold"><%# Eval("nombre") %></h5>
                  <a
                    href='EspecificacionesProducto.aspx?id=<%# Eval("idProducto") %>'
                    class="btn btn-cta px-4 py-2 shadow-sm"
                  >Ver Detalles</a>
                </div>
              </div>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>

          <!-- Controles personalizados -->
          <button
            class="carousel-control-prev"
            type="button"
            data-bs-target="#carouselCategorias"
            data-bs-slide="prev"
          >
            <span class="carousel-control-prev-icon custom-icon"></span>
            <span class="visually-hidden">Anterior</span>
          </button>
          <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#carouselCategorias"
            data-bs-slide="next"
          >
            <span class="carousel-control-next-icon custom-icon"></span>
            <span class="visually-hidden">Siguiente</span>
          </button>
        </div>
      </div>
    </section>


    <!-- Sección Productos Precio mas bajo -->
     <!-- Best Sellers: Scroll horizontal -->
  <div class="container py-5" id="bestSellers">
    <h2 class="mb-4 section-title-alt">Productos de Remate</h2>

    <div class="d-flex overflow-auto gap-3 snap-x">
      <asp:Repeater ID="rptBestSellers" runat="server">
        <ItemTemplate>
          <div class="card flex-shrink-0 shadow-sm" style="width: 240px; scroll-snap-align: start;">
            <img
              src="../Content/Imagenes/Productos/Categorias/<%# Eval("idProducto") %>.jpg"
              class="card-img-top"
              alt="<%# Eval("nombre") %>"
              style="height:180px; object-fit:cover;"
            />
            <div class="card-body text-center">
              <h5 class="card-title mb-2"><%# Eval("nombre") %></h5>
              <a
                href='EspecificacionesProducto.aspx?id=<%# Eval("idProducto") %>'
                class="btn btn-cta btn-sm px-3"
              >Ver</a>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </div>

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

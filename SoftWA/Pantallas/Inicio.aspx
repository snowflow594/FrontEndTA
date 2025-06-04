<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/Cabecera.master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="SoftWA.Pantallas.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <!-- información de la empresa -->
        <div class="card p-4 mb-5 shadow-sm">
            <h2 class="fw-bold">Bienvenido a PAGINA</h2>
            <p class="text-muted mb-0">
                En --- nos especializamos en ofrecer productos de cocina de alta calidad a nivel nacional. Nuestro objetivo es facilitarte la mejor experiencia en tu cocina con utensilios resistentes, prácticos y con estilo.
           
            </p>
        </div>

        <!-- catálogo de Productos -->
        <h3 class="mb-4 fw-bold">Catálogo de Productos</h3>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <asp:Repeater ID="rptProductos" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100 shadow-sm">
                            <asp:LinkButton runat="server" PostBackUrl='<%# "EspecificacionesProducto.aspx?id=" + Eval("idProducto") %>' CssClass="text-decoration-none text-dark">
                                <img src="https://via.placeholder.com/150" class="card-img-top" alt='<%# Eval("nombre") %>' />
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("nombre") %></h5>
                                    <p class="card-text text-muted"><%# Eval("descripcion") %></p>
                                </div>
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

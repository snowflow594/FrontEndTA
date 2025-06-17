<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="DireccionesGuardadas.aspx.cs" Inherits="SoftWA.Pantallas.DireccionesGuardadas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h3 class="mb-4">Direcciones Guardadas</h3>
        <asp:Repeater ID="rptDirecciones" runat="server">
            <ItemTemplate>
                <div class="card mb-3 p-3">
                    <h5><%# Eval("direccion.alias") %></h5>
                    <p class="mb-1 text-muted"><strong>Dirección:</strong> <%# Eval("direccion.direccion") %></p>
                    <p class="mb-1 text-muted"><strong>Ciudad:</strong> <%# Eval("direccion.ciudad") %></p>
                    <p class="mb-1 text-muted"><strong>Referencia:</strong> <%# Eval("direccion.referencia") %></p>
                    <asp:Button ID="btnUsarDireccion" runat="server" CommandArgument='<%# Eval("direccion.id") %>' Text="Usar esta dirección" CssClass="btn btn-success mt-2" OnClick="btnUsarDireccion_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>
    </div>
</asp:Content>

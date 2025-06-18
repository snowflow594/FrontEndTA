<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="SoftWA.Pantallas.Perfil" %>
<asp:Content ID="ContentTitle" ContentPlaceHolderID="Title" runat="server">
  Mi Perfil
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadExtras" runat="server">
</asp:Content>


<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">
      <asp:Panel runat="server" CssClass="card p-4 shadow-sm">
      <!-- Campos comunes -->
      <div class="mb-3">
        <asp:Label runat="server" Text="Email" AssociatedControlID="txtEmail" />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" Enabled="false" />
      </div>
      <div class="mb-3">
        <asp:Label runat="server" Text="Nombres" AssociatedControlID="txtNombres" />
        <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label runat="server" Text="Apellidos" AssociatedControlID="txtApellidos" />
        <asp:TextBox ID="txtApellidos" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label runat="server" Text="Teléfono" AssociatedControlID="txtTelefono" />
        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
      </div>

      <!-- SOLO PERSONA NATURAL -->
      <asp:Panel ID="pnlNatural" runat="server" Visible="false">
        <div class="mb-3">
          <asp:Label runat="server" Text="DNI" AssociatedControlID="txtDNI" />
          <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" />
        </div>
        <div class="mb-3">
          <asp:Label runat="server" Text="Fecha de nacimiento" AssociatedControlID="txtFechaNacimiento" />
          <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date" />
        </div>
        <div class="mb-3">
          <asp:Label runat="server" Text="Género" AssociatedControlID="ddlGenero" />
          <asp:DropDownList ID="ddlGenero" runat="server" CssClass="form-select">
            <asp:ListItem Value="M">Masculino</asp:ListItem>
            <asp:ListItem Value="F">Femenino</asp:ListItem>
            <asp:ListItem Value="O">Otro</asp:ListItem>
          </asp:DropDownList>
        </div>
      </asp:Panel>

      <!-- SOLO PERSONA JURÍDICA -->
      <asp:Panel ID="pnlJuridica" runat="server" Visible="false">
        <div class="mb-3">
          <asp:Label runat="server" Text="RUC" AssociatedControlID="txtRUC" />
          <asp:TextBox ID="txtRUC" runat="server" CssClass="form-control" />
        </div>
        <div class="mb-3">
          <asp:Label runat="server" Text="Razón Social" AssociatedControlID="txtRazonSocial" />
          <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" />
        </div>
        <div class="mb-3">
          <asp:Label runat="server" Text="Representante Legal" AssociatedControlID="txtRepresentante" />
          <asp:TextBox ID="txtRepresentante" runat="server" CssClass="form-control" />
        </div>
      </asp:Panel>

      <!-- Botones -->
      <asp:Button ID="btnUpdate" runat="server" Text="Guardar Cambios"
          OnClick="btnUpdate_Click" CssClass="btn btn-cta" />
      <asp:Button ID="btnDelete" runat="server" Text="Eliminar Cuenta"
          OnClientClick="return confirm('¿Seguro que deseas eliminar tu cuenta?');"
          OnClick="btnDelete_Click" CssClass="btn btn-danger" />
      <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 text-success" Visible="false" />
    </asp:Panel>
</asp:Content>

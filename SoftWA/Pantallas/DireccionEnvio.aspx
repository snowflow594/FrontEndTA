<%@ Page Title="" Language="C#" MasterPageFile="~/Pantallas/MasterPages/PaginaMaster.Master" AutoEventWireup="true" CodeBehind="DireccionEnvio.aspx.cs" Inherits="SoftWA.Pantallas.DireccionEnvio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h3 class="mb-4">Dirección de Envío</h3>
        <div class="row">
            <!-- Formulario de Dirección -->
            <div class="col-md-7">
                <div class="card p-4 shadow-sm">
                    <div class="mb-3">
                        <label for="txtAlias" class="form-label">Alias</label>
                        <asp:TextBox ID="txtAlias" runat="server" CssClass="form-control" placeholder="Casa, trabajo, etc." />
                    </div>
                    <div class="mb-3">
                        <label for="txtDireccion" class="form-label">Dirección</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtCiudad" class="form-label">Ciudad</label>
                        <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtReferencia" class="form-label">Referencia</label>
                        <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control" />
                    </div>
                    <div class="d-flex gap-2 mt-3">
                        <asp:Button ID="btnGuardarDireccion" runat="server" CssClass="btn btn-success" Text="Guardar Dirección" OnClick="btnGuardarDireccion_Click" />
                        <asp:Button ID="btnVerDirecciones" runat="server" CssClass="btn btn-outline-dark" Text="Ver Direcciones Guardadas"
                            OnClientClick="$('#modalDirecciones').modal('show'); return false;" />
                    </div>
                    <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-2 d-block"></asp:Label>
                </div>
            </div>

            <!-- Resumen del Pedido -->
            <div class="col-md-5">
                <div class="card p-4 shadow-sm">
                    <h5 class="mb-3">Resumen de Pedido</h5>
                    <p>
                        <strong>Subtotal:</strong> S/
                        <asp:Label ID="lblSubtotal" runat="server" Text="0.00" />
                    </p>
                    <p>
                        <strong>Impuesto (18%):</strong> S/
                        <asp:Label ID="lblIGV" runat="server" Text="0.00" />
                    </p>
                    <p><strong>Envío:</strong> -</p>
                    <hr />
                    <p class="fs-5">
                        <strong>Total:</strong> S/
                        <asp:Label ID="lblTotal" runat="server" Text="0.00" />
                    </p>
                </div>
            </div>

            <div class="text-end mt-4">
                <asp:Button ID="btnContinuarPago" runat="server" CssClass="btn btn-success"
                    Text="Continuar con el pago"
                    OnClick="btnContinuarPago_Click" />
            </div>
        </div>
    </div>

    <!-- modal de Direcciones Guardadas -->
    <div class="modal fade" id="modalDirecciones" tabindex="-1" aria-labelledby="modalDireccionesLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalDireccionesLabel">Direcciones Guardadas</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <iframe src="DireccionesGuardadas.aspx" style="width: 100%; height: 400px; border: none;"></iframe>
                </div>
            </div>
        </div>
    </div>

    <!--este es un script para poder mostrar la pantalla de direccioensguardadas encima de la pantalla de direccionevio actual-->
    <script>
        window.addEventListener("message", function (event) {
            if (event.data.startsWith("direccionSeleccionada:")) {
                const id = event.data.split(":")[1];

                // Llamar al servidor con AJAX para actualizar la sesión
                fetch("DireccionEnvio.aspx/SeleccionarDireccion", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ idDireccion: parseInt(id) })
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.d && data.d === true) {
                            alert("Dirección seleccionada correctamente.");
                            $('#modalDirecciones').modal('hide');
                        }
                    });
            }
        });
</script>

</asp:Content>



<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrarUsuario.aspx.cs" Inherits="SoftWA.Pantallas.RegistrarUsuario" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Registro de Usuario</title>
    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        :root {
            --bg-page: #fafafa;
            --card-bg: #ffffff;
            --text-color: #333;
            --primary: #28a745; /* Verde principal */
            --primary-dark: #218838;
            --secondary: #6c757d;
            --error: #dc3545;
        }

        body {
            background-color: var(--bg-page);
            color: var(--text-color);
            font-family: 'Segoe UI', sans-serif;
        }

        .card {
            background: var(--card-bg);
            border: none;
            border-radius: .75rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

            .card h3 {
                color: var(--primary);
            }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 .2rem rgba(40,167,69,.25);
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

        .btn-success {
            background-color: var(--primary);
            border-color: var(--primary);
        }

            .btn-success:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: none;
            border-radius: .5rem;
        }

        .step-panel {
            display: none;
        }

            .step-panel.active {
                display: block;
            }
        /* OVERLAY */
        #loadingOverlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: var(--overlay-bg);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .d-flex {
            display: flex !important;
        }
    </style>
</head>
<body>
    <div
        id="loadingOverlay"
        class="d-none position-fixed top-0 start-0 vw-100 vh-100 bg-white bg-opacity-75 align-items-center justify-content-center"
        style="z-index: 2000;">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Cargando…</span>
        </div>
    </div>
    <form id="form1" runat="server">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <asp:Literal ID="litMensaje" runat="server" EnableViewState="false" Mode="PassThrough" Visible="false"></asp:Literal>

                    <!-- Paso 1: Datos y envío del código -->
                    <div id="step1" class="step-panel active card p-4">
                        <h3 class="mb-4">Registro de Usuario</h3>
                        <div class="mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold"><i class="fa-solid fa-user-tag"></i>Tipo de Usuario: </label>
                            <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control input-neumorph" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlRol_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <!-- PANEL Administrador -->
                        <asp:Panel ID="panelAdmin" runat="server" CssClass="card p-3 mb-3" Visible="false">
                            <div class="border-start border-4 border-primary ps-3 mb-3">
                                <h5>Datos de Administrador</h5>
                                <!-- Nombre Administrador -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblNombreAdmi" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-id-badge me-1"></i>Nombre Administrador
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtAdminCode" runat="server" CssClass="form-control" placeholder="Ingresa el nombre de administrador" />
                                    </div>
                                </div>

                                <!-- Cargo -->
                                <div class="row mb-0 align-items-center">
                                    <label id="lblCargo" runat="server" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-briefcase me-1"></i>Cargo
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" placeholder="Cargo del administrador" />
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- PANEL Persona Natural -->
                        <asp:Panel ID="panelNatural" runat="server" CssClass="card p-3 mb-3" Visible="false">
                            <div class="border-start border-4 border-primary ps-3 mb-3">
                                <h5>Datos Persona Natural</h5>
                                <!-- DNI -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblDNI" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-id-card me-1"></i>DNI
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtDNINatural" runat="server" CssClass="form-control" placeholder="Ingresa tu DNI" />
                                    </div>
                                </div>

                                <!-- Nombre Completo -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblNombre" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-signature me-1"></i>Nombre Completo
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombres" />
                                    </div>
                                </div>


                                <!-- Apellidos -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblApellidos" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-signature me-1"></i>Apellidos
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtApellidos" runat="server" CssClass="form-control" placeholder="Apellidos" />
                                    </div>
                                </div>

                                <!-- Teléfono -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblTelefono" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-phone me-1"></i>Teléfono
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtTelefonoNatural" runat="server" CssClass="form-control" placeholder="Ej. 912345678" />
                                    </div>
                                </div>
                                <!-- Genero -->
                                <div class="row mb-3 align-items-center">
                                    <label class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-venus-mars me-1"></i>Género
                                    </label>
                                    <div class="col-sm-8">
                                        <div class="form-check form-check-inline">
                                            <input type="radio" name="Genero" runat="server" id="rbMasculino" class="form-check-input" />
                                            <label class="form-check-label" runat="server" for="cphContenido_rbMasculino">Masculino</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input type="radio" name="Genero" runat="server" id="rbFemenino" class="form-check-input" />
                                            <label class="form-check-label" runat="server" for="cphContenido_rbFemenino">Femenino</label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Fecha de Nacimiento -->
                                <div class="row mb-0 align-items-center">
                                    <label id="dateFecha" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-calendar-days me-1"></i>Fecha Nacimiento
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="dtpFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date" />
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- PANEL Persona Jurídica -->
                        <asp:Panel ID="panelJuridica" runat="server" CssClass="card p-3 mb-3" Visible="false">
                            <div class="border-start border-4 border-primary ps-3 mb-3">
                                <h5>Datos Empresa</h5>
                                <!-- RUC -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblRuc" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-id-card me-1"></i>RUC     
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtRUC" runat="server" CssClass="form-control" placeholder="Ej. 12345678901" />
                                    </div>
                                </div>

                                <!-- Razón Social -->
                                <div class="row mb-3 align-items-center">
                                    <label id="lblRazonSocial" class="col-sm-4 col-form-label fw-semibold">
                                        <i class="fa-solid fa-building-user me-1"></i>Razón Social</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" placeholder="Nombre de la empresa" />
                                    </div>
                                </div>

                                <!-- Representante Legal -->
                                <div class="row mb-3 align-items-center">
                                    <asp:Label ID="lblRepresentante" runat="server" AssociatedControlID="txtRepresentante" CssClass="col-sm-4 col-form-label fw-semibold">
                    <i class="fa-solid fa-user-tie me-1"></i>Representante Legal
                                    </asp:Label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtRepresentante" runat="server" CssClass="form-control" placeholder="Nombre del representante" />
                                    </div>
                                </div>

                                <!-- Nombre Empresa -->
                                <div class="row mb-3 align-items-center">
                                    <asp:Label
                                        ID="lblNombreEmpresa" runat="server" AssociatedControlID="txtNombreEmpresa" CssClass="col-sm-4 col-form-label fw-semibold">
                    <i class="fa-solid fa-building me-1"></i>Nombre Empresa  </asp:Label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtNombreEmpresa" runat="server" CssClass="form-control" placeholder="Razón social completa" />
                                    </div>
                                </div>

                                <!-- Dirección -->
                                <div class="row mb-3 align-items-center">
                                    <asp:Label
                                        ID="lblDireccion" runat="server" AssociatedControlID="txtDireccion"
                                        CssClass="col-sm-4 col-form-label fw-semibold">
                    <i class="fa-solid fa-location-dot me-1"></i>Dirección
                                    </asp:Label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Calle, ciudad, país" />
                                    </div>
                                </div>

                                <!-- Teléfono -->
                                <div class="row mb-0 align-items-center">
                                    <asp:Label ID="lblTelfJuridica" runat="server"
                                        AssociatedControlID="txtTelfJuridica" CssClass="col-sm-4 col-form-label fw-semibold">
                    <i class="fa-solid fa-phone me-1"></i>Teléfono</asp:Label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtTelfJuridica" runat="server" CssClass="form-control" placeholder="Ej. 012-345678" />
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>


                        <div class="mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold"><i class="fa-solid fa-envelope me-1"></i>Correo electrónico</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control input-neumorph" TextMode="Email" Placeholder="usuario.rol@dominio.com" />
                        </div>
                        <div class="mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold"><i class="fa-solid fa-key me-1"></i>Contraseña</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control input-neumorph" />
                        </div>

                        <div class="d-grid">
                            <asp:Button ID="btnEnviarCodigo" runat="server" Text="Enviar código de verificación" CssClass="btn btn-primary" OnClick="btnEnviarCodigo_Click" />
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <asp:HyperLink ID="hlVuelta" runat="server" NavigateUrl="~/Inicio.aspx"
                            CssClass="btn btn-outline-secondary">Regresar</asp:HyperLink>
                    </div>

                    <!-- Paso 2: Validar el código -->
                    <div id="step2" class="step-panel card p-4">
                        <h3 class="mb-4">Verifica tu correo</h3>
                        <p>Hemos enviado un código de verificación a tu email. Ingrésalo a continuación:</p>
                        <!-- Aquí mostramos el código generado -->
                        <p>
                            Tu código es:  
                  <asp:Label ID="litCodigo" runat="server" CssClass="fw-bold text-primary" />
                        </p>

                        <div class="mb-3">
                            <label class="form-label">Código de verificación</label>
                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" />
                        </div>
                        <div class="d-grid">
                            <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar y completar registro" CssClass="btn btn-success" OnClick="btnConfirmar_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // función para cambiar de paso
            function showStep(n) {
                document.querySelectorAll('.step-panel').forEach(p => p.classList.remove('active'));
                document.getElementById('step' + n).classList.add('active');
            }
        </script>

        <script>
            // Cuando el form se envíe (submit), activamos el overlay
            $('#form1').on('submit', function () {
                $('#loadingOverlay')
                    .removeClass('d-none')  // lo mostramos
                    .addClass('d-flex');    // y lo convertimos en flex para centrar
            });
        </script>

    </form>


</body>
</html>

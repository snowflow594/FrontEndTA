<%@ Page Language="C#" UnobtrusiveValidationMode="None" AutoEventWireup="true" CodeBehind="Autentificacion.aspx.cs" Inherits="SoftWA.Pantallas.Autentificacion" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
  <meta charset="utf-8" />
  <title>Inicio de Sesión</title>

  <!-- Bootstrap CSS + FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        rel="stylesheet" />

  <style>
    :root {
      --bg-page:      #f0f2f5;
      --card-bg:      #ffffff;
      --text-color:   #343a40;
      --primary:      #17a2b8;
      --primary-dark: #138496;
      --overlay-bg:   rgba(255,255,255,0.8);
    }
    body {
      background-color: var(--bg-page);
      color: var(--text-color);
      font-family: 'Segoe UI', sans-serif;
    }
    #loadingOverlay {
      display: none;
      position: fixed; top:0; left:0;
      width:100vw; height:100vh;
      background: var(--overlay-bg);
      z-index:2000;
      align-items:center; justify-content:center;
    }
    .d-flex { display:flex!important; }
    .login-container { margin-top:6rem; }
    .login-card {
      background:var(--card-bg);
      border:none;
      border-radius:.75rem;
      box-shadow:0 4px 12px rgba(0,0,0,0.08);
    }
    .login-card .card-title { color:var(--primary); }
    .form-control:focus {
      border-color:var(--primary);
      box-shadow:0 0 0 .2rem rgba(23,162,184,.25);
    }
    .btn-primary {
      background-color: var(--primary);
      border-color: var(--primary);
    }
    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }
    .alert-danger { margin-bottom:1rem; }
    .step-panel { display:none; }
    .step-panel.active { display:block; }
  </style>
</head>
<body>

  <!-- overlay de carga -->
  <div id="loadingOverlay" class="d-none position-fixed top-0 start-0 vw-100 vh-100 bg-white bg-opacity-75">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Cargando…</span>
    </div>
  </div>

  <form id="form1" runat="server">
    <div class="container login-container">
      <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

          <!-- Mensajes de error -->
          <asp:Literal ID="litMensaje" runat="server" Visible="false" Mode="PassThrough" />

          <!-- Paso 1: credenciales -->
          <div id="step1" class="step-panel active">
            <div class="card login-card p-4">
              <h3 class="card-title text-center mb-4">Iniciar Sesión</h3>

              <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                             TextMode="Email" Placeholder="usuario@dominio.com" />
              </div>

              <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                             TextMode="Password" Placeholder="••••••••••" />
              </div>

              <div class="text-end mb-3">
                <asp:HyperLink ID="hlOlvide" runat="server"
                              NavigateUrl="RecuperarContrasena.aspx"
                              CssClass="small text-decoration-none">
                  ¿Olvidaste tu contraseña?
                </asp:HyperLink>
              </div>

              <div class="d-grid mb-3">
                <asp:Button ID="btnLogin" runat="server"
                            CssClass="btn btn-primary btn-lg w-100"
                            Text="Ingresar" OnClick="btnLogin_Click" />
              </div>

              <div class="text-center">
                <small>¿No tienes cuenta?
                  <asp:HyperLink runat="server" NavigateUrl="RegistrarUsuario.aspx">Regístrate aquí</asp:HyperLink>
                </small>
              </div>
            </div>
                <!-- Ingresar como invitado -->
                <div class="text-center mt-3">
                    <asp:HyperLink  ID="hlInvitado" runat="server" NavigateUrl="~/Inicio.aspx"
                        CssClass="btn btn-outline-secondary">Entrar como invitado</asp:HyperLink>
                </div>
          </div>

          <!-- Paso 2: verificación de código -->
          <div id="step2" class="step-panel">
            <div class="card login-card p-4">
              <h3 class="card-title text-center mb-4">Verifica tu correo</h3>
              <p>Hemos enviado un código de verificación a <strong><asp:Label ID="lblEmailDest" runat="server"/></strong>.</p>
              <p class="small text-muted">Tu código (sólo para debug): <asp:Label ID="litCodigoLogin" runat="server" CssClass="fw-bold text-primary"/></p>

              <div class="mb-3">
                <label class="form-label">Código de verificación</label>
                <asp:TextBox ID="txtCodigoLogin" runat="server" CssClass="form-control" />
              </div>

              <div class="d-grid mb-3">
                <asp:Button ID="btnConfirmLogin" runat="server"
                            CssClass="btn btn-primary btn-lg w-100"
                            Text="Confirmar" OnClick="btnConfirmLogin_Click" />
              </div>

              <div class="text-center">
                <small>
                  <asp:LinkButton runat="server" OnClick="VolverPaso1" CssClass="text-decoration-none">Volver</asp:LinkButton>
                </small>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
      <!-- scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // muestra el paso n (1 o 2)
            function showStep(n) {
                document.querySelectorAll('.step-panel').forEach(p => p.classList.remove('active'));
                document.getElementById('step' + n).classList.add('active');
            }
            // spinner al postback
            $('#form1').on('submit', () => $('#loadingOverlay').removeClass('d-none').addClass('d-flex'));
        </script>
  </form>
  
</body>
</html>

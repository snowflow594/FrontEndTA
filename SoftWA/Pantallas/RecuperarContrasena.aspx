<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarContrasena.aspx.cs" Inherits="SoftWA.Pantallas.RecuperarContrasena" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
  <meta charset="utf-8" />
  <title>Recuperar Contraseña – CocinaPro</title>

  <!-- Bootstrap CSS + FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        rel="stylesheet" />

  <style>
    :root {
      --bg-page:    #f0f2f5;
      --card-bg:    #ffffff;
      --text-color: #343a40;
      --primary:    #17a2b8;
      --primary-dark:#138496;
      --error:      #dc3545;
      --overlay-bg: rgba(255,255,255,0.8);
    }

    body {
      background-color: var(--bg-page);
      color: var(--text-color);
      font-family: 'Segoe UI', sans-serif;
    }
    /* contenedor centrado */
    .login-container {
      margin-top: 6rem;
    }
    /* tarjeta */
    .login-card {
      background: var(--card-bg);
      border: none;
      border-radius: .75rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }
    .login-card .card-title {
      color: var(--primary);
    }
    .form-control:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 .2rem rgba(23,162,184,.25);
    }
    .btn-primary {
      background-color: var(--primary);
      border-color: var(--primary);
    }
    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }
    .alert-danger {
      background-color: #f8d7da;
      color: #721c24;
      border: none;
      border-radius: .5rem;
      position: relative;
      padding-right: 3rem;
    }
    .alert .btn-close {
      position: absolute;
      top: .5rem;
      right: 1rem;
    }
    /* OVERLAY */
    #loadingOverlay {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100vw; height: 100vh;
      background: var(--overlay-bg);
      z-index: 2000;
      align-items: center;
      justify-content: center;
    }
    .d-flex { display: flex !important; }

    /* pasos */
    .step-panel { display: none; }
    .step-panel.active { display: block; }
  </style>
</head>
<body>

  <!-- overlay de carga -->
  <div id="loadingOverlay" class="d-none position-fixed top-0 start-0 vw-100 vh-100
       bg-white bg-opacity-75 align-items-center justify-content-center">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Cargando…</span>
    </div>
  </div>

  <form id="form1" runat="server">
    <div class="container login-container">
      <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

          <!-- mensaje genérico -->
          <asp:Literal ID="litMensaje" runat="server" Visible="false" Mode="PassThrough" />

          <!-- ===== PASO 1: pedir correo ===== -->
          <div id="step1" class="step-panel active">
            <div class="card login-card p-4">
              <h3 class="card-title text-center mb-4">Recuperar Contraseña</h3>
              <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <asp:TextBox ID="txtEmailRec" runat="server" CssClass="form-control"
                  TextMode="Email" Placeholder="usuario@dominio.com" />
              </div>
              <div class="d-grid">
                <asp:Button ID="btnEnviarRec" runat="server" CssClass="btn btn-primary btn-lg"
                  Text="Enviar código" OnClick="btnEnviarRec_Click" />
              </div>
              <div class="text-center mt-3">
                <asp:HyperLink NavigateUrl="~/Autentificacion.aspx" runat="server"
                  CssClass="small text-decoration-none">
                  Volver al inicio de sesión
                </asp:HyperLink>
              </div>
            </div>
          </div>

          <!-- ===== PASO 2: validar código y nueva clave ===== -->
          <div id="step2" class="step-panel">
            <div class="card login-card p-4">
              <h3 class="card-title text-center mb-4">Crear nueva contraseña</h3>
              <p>Hemos enviado un código a <strong><asp:Label ID="lblEmailDest" runat="server" /></strong></p>
              <div class="mb-3">
                  <p> El código es: <asp:Label ID="litCodigo"  runat="server"  CssClass="fw-bold text-primary" /></p>
                <label class="form-label">Tu código de verificación</label>
                <asp:TextBox ID="txtCodigoRec" runat="server" CssClass="form-control" />
              </div>
              <div class="mb-3">
                <label class="form-label">Nueva contraseña</label>
                <asp:TextBox ID="txtNuevaPass" runat="server" CssClass="form-control" />
              </div>
              <div class="mb-3">
                <label class="form-label">Confirmar contraseña</label>
                <asp:TextBox ID="txtConfPass" runat="server" CssClass="form-control" />
              </div>
              <div class="d-grid">
                <asp:Button ID="btnConfirmRec" runat="server" CssClass="btn btn-primary btn-lg"
                  Text="Restablecer contraseña" OnClick="btnConfirmRec_Click" />
              </div>
              <div class="text-center mt-3">
                <asp:HyperLink NavigateUrl="~/Autentificacion.aspx" runat="server"
                  CssClass="small text-decoration-none">
                  Volver al inicio
                </asp:HyperLink>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // mostrar overlay al enviar
      $('#form1').on('submit', () => {
        $('#loadingOverlay').removeClass('d-none').addClass('d-flex');
      });
      // cambiar de paso
      function showStep(n) {
        $('.step-panel').removeClass('active');
        $('#step' + n).addClass('active');
      }
    </script>
  </form>
</body>
</html>

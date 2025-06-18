using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class Autentificacion : System.Web.UI.Page
    {
        private UsuarioClient usuarioBO;
        private RolClient rolBO;

        private const string VS_CODIGO = "vcodigoLogin";
        private string CodigoLogin
        {
            get => ViewState[VS_CODIGO] as string ?? "";
            set => ViewState[VS_CODIGO] = value;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                usuarioBO = new UsuarioClient();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            litMensaje.Visible = false;
            var email = txtEmail.Text.Trim();
            var pass = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pass))
            {
                ShowError("Completa usuario y contraseña.");
                return;
            }
            usuarioBO = new UsuarioClient();
            var usuario2 = usuarioBO.autenticarUsuario(email, pass);

            if (usuario2 == null)
            {
                ShowError("Usuario o contraseña incorrectos.");
                return;
            }

            // guardamos DTO en Session provisional por si necesitamos después
            Session["UsuarioAutenticado"] = usuario2;

            // generamos y mostramos el código
            CodigoLogin = new Random().Next(100000, 999999).ToString();
            // (aquí enviarías el email con ese código)
            litCodigoLogin.Text = CodigoLogin;      // sólo para debug
            lblEmailDest.Text = email;            // muestra el destino

            // avanzamos al paso 2
            ScriptManager.RegisterStartupScript(this, GetType(),
                "step2", "showStep(2);", true);
        }


        protected void btnConfirmLogin_Click(object sender, EventArgs e)
        {
            litMensaje.Visible = false;
            if (txtCodigoLogin.Text.Trim() != CodigoLogin)
            {
                ShowError("Código de verificación incorrecto.");
                return;
            }

            // Ya validado: redirigimos a Inicio.aspx
            Response.Redirect("Inicio.aspx");
        }

        protected void VolverPaso1(object sender, EventArgs e)
        {
            // vuelve al paso 1 sin perder datos
            ScriptManager.RegisterStartupScript(this, GetType(),
                "step1", "showStep(1);", true);
        }

        private void ShowError(string msg)
        {
            litMensaje.Visible = true;
            litMensaje.Text = $@"
    <div class='alert alert-danger alert-dismissible fade show' role='alert'>
      <i class='fas fa-exclamation-triangle me-2'></i>{msg}
      <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
    </div>";
        }
    }
}
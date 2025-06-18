using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class RecuperarContrasena : System.Web.UI.Page
    {
        private const string VS_CODIGO = "vcodigoRec";
        private UsuarioClient bousuario;
        private usuarioDTO1 usuBuscado;
        private string CodigoEnviado
        {
            get => ViewState[VS_CODIGO] as string ?? "";
            set => ViewState[VS_CODIGO] = value;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviarRec_Click(object sender, EventArgs e)
        {
            litMensaje.Visible = false;
            var email = txtEmailRec.Text.Trim();
            bousuario = new UsuarioClient();
            usuBuscado = new usuarioDTO1();
            usuBuscado = bousuario.buscarPorEmailUsuario(email);
            if (string.IsNullOrEmpty(email) || usuBuscado == null)
            {
                ShowError("Por favor ingresa un correo válido.");
                return;
            }

            // Generar código aleatorio de 6 dígitos
            var rnd = new Random();
            CodigoEnviado = rnd.Next(100000, 999999).ToString();
            litCodigo.Text = CodigoEnviado;

            // Mostrar email de destino en el paso 2:
            lblEmailDest.Text = email;

            // Cambiar a la vista del paso 2
            ScriptManager.RegisterStartupScript(this, GetType(), "step2", "showStep(2);", true);
        }

        protected void btnConfirmRec_Click(object sender, EventArgs e)
        {
            litMensaje.Visible = false;

            // verificar código
            if (txtCodigoRec.Text.Trim() != CodigoEnviado)
            {
                ShowError("Código de verificación incorrecto.");
                return;
            }

            // verificar que ambas contraseñas coincidan
            var nueva = txtNuevaPass.Text;
            var conf = txtConfPass.Text;
            if (string.IsNullOrEmpty(nueva) || nueva != conf)
            {
                ShowError("Las contraseñas no coinciden o están vacías.");
                return;
            }

            // Llamar al web service para actualizar la contraseña
            try
            {
                bousuario = new UsuarioClient();
                usuBuscado = new usuarioDTO1();
                usuBuscado = bousuario.buscarPorEmailUsuario(txtEmailRec.Text);
                if (usuBuscado == null)
                {
                    ShowError("El usuario buscado es no existe");
                    return;
                }

                usuBuscado.contraseña = txtNuevaPass.Text;
                bousuario.modificarUsuario(usuBuscado);
            }
            catch (Exception ex)
            {
                ShowError("No se pudo cambiar la contraseña: " + ex.Message);
                return;
            }

            // Si todo OK, redirigir al login con un mensajito
            litMensaje.Visible = true;
            litMensaje.Text = @"
        <div class='alert alert-success'>
          Tu contraseña ha sido restablecida. <a href='Autentificacion.aspx'>Inicia sesión</a>.
        </div>";
            // Opcional: ocultar el step2
            ScriptManager.RegisterStartupScript(
              this, GetType(), "hideSteps",
              "showStep(0);", true
            );



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
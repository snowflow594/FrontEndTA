using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class RegistrarUsuario : System.Web.UI.Page
    {
        private RolClient rolBO;
        private UsuarioClient usuarioBO;
        private JuridicaClient juridicaBO;
        private NaturalClient naturalBO;
        private AdministradorClient administradorBO;
        private string CodigoEnviado
        {
            get => ViewState["vcodigo"] as string ?? "";
            set => ViewState["vcodigo"] = value;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rolBO = new RolClient();
                CargarRoles();
                usuarioBO = new UsuarioClient();
                juridicaBO = new JuridicaClient();
                naturalBO = new NaturalClient();
                administradorBO = new AdministradorClient();

            }
        }
        // Se dispara al cambiar de rol
        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Asume: rol 1=Admin, 2=Natural, 3=Juridica
            panelAdmin.Visible = ddlRol.SelectedValue == "1";
            panelJuridica.Visible = ddlRol.SelectedValue == "2";
            panelNatural.Visible = ddlRol.SelectedValue == "3";

        }
        private void CargarRoles()
        {
            try
            {

                var roles = rolBO.listarTodosRoles();

                ddlRol.DataSource = roles;
                ddlRol.DataTextField = "nombre";  // propiedad que muestra
                ddlRol.DataValueField = "id";      // propiedad que toma como Value
                ddlRol.DataBind();

                // Insertar al inicio un item por defecto
                ddlRol.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem("-- Seleccione un Rol --", ""));
            }
            catch (Exception ex)
            {
                // mostrar error si falla la llamada
                litMensaje.Visible = true;
                litMensaje.Text = $@" <div class='alert alert-danger'>Error cargando roles: {ex.Message} </div>";
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            litMensaje.Visible = false;
            if (txtCodigo.Text.Trim() != CodigoEnviado)
            {
                ShowError("Código incorrecto, verifica tu correo.");
                return;
            }

            // TODO: invocar tu WS de registro pasándole (nombre, email, pass)
            // var cliente = new UsuarioWSClient();
            // Cliente.registrarUsuario(...);
            usuarioDTO1 usuarioDTO3 = new usuarioDTO1();
            rolDTO1 rolDTO3 = new rolDTO1();
            rolDTO3.id = Int32.Parse(ddlRol.SelectedValue);
            usuarioDTO3.rol = rolDTO3;
            usuarioDTO3.email = txtEmail.Text;
            usuarioDTO3.contraseña = txtPassword.Text; // aca tuve que quitarle en su Box del aspx su txtmode xq no me guardaba la contra
            usuarioDTO3.activo = 1;
            usuarioBO = new UsuarioClient();
            int idUsuarioInsertado = usuarioBO.insertarUsuario(usuarioDTO3);

            if (ddlRol.SelectedValue == "1")
            {
                administradorDTO admiDTO = new administradorDTO();
                admiDTO.nombreUsuario = txtAdminCode.Text;
                // 3) Lo asignamos
                admiDTO.cargo = txtCargo.Text;
                admiDTO.activo = 1;
                usuarioDTO1 usInsertado = new usuarioDTO1();
                usInsertado.id = idUsuarioInsertado;
                admiDTO.usuarioCreacion = usInsertado;
                admiDTO.usuario = usInsertado;
                administradorBO = new AdministradorClient();
                try
                {

                    administradorBO.insertarAdministrador(admiDTO);
                }
                catch (Exception ex)
                {
                    ShowError("Ocurrio un error al validar sus datos");
                    usuarioBO = new UsuarioClient();
                    usuarioBO.eliminarUsuario(usInsertado);
                }


            }
            else if (ddlRol.SelectedValue == "2")
            {

                juridicaDTO juridicaDTO = new juridicaDTO();
                juridicaDTO.ruc = txtRUC.Text;
                juridicaDTO.razonSocial = txtRazonSocial.Text;
                juridicaDTO.representanteLegal = txtRepresentante.Text;
                usuarioDTO1 us = new usuarioDTO1();
                us.id = idUsuarioInsertado;
                juridicaDTO.usuario = us;
                juridicaDTO.usuarioCreacion = us;
                juridicaDTO.activo = 1;
                juridicaDTO.nombres = txtNombreEmpresa.Text;
                juridicaDTO.apellidos = txtRepresentante.Text;
                juridicaDTO.telefono = txtTelfJuridica.Text;
                juridicaBO = new JuridicaClient();
                try
                {

                    int i = juridicaBO.insertarJuridica(juridicaDTO);
                    if (i == 0)
                    {
                        ShowError("Ocurrio un error al validar sus datos");
                        usuarioBO = new UsuarioClient();
                        usuarioBO.eliminarUsuario(us);
                    }

                }
                catch
                {
                    ShowError("Ocurrio un error al validar sus datos");
                    usuarioBO = new UsuarioClient();
                    usuarioBO.eliminarUsuario(us);
                }

            }
            else if (ddlRol.SelectedValue == "3")
            {
                naturalDTO natural = new naturalDTO();

                natural.nombres = txtNombre.Text;
                natural.apellidos = txtApellidos.Text;
                natural.telefono = txtTelefonoNatural.Text;
                natural.dni = Int32.Parse(txtDNINatural.Text);
                natural.fechaNacimiento = DateTime.Parse(dtpFechaNacimiento.Text);
                natural.fechaNacimientoSpecified = true;
                if (rbFemenino.Checked)
                {
                    natural.genero = "FEMENINO";
                }
                else
                {
                    natural.genero = "MASCULINO";
                }
                usuarioDTO1 us = new usuarioDTO1();
                us.id = idUsuarioInsertado;
                us.email = "ejemplo";
                us.contraseña = "ejmplo";
                natural.usuarioCreacion = us;
                natural.usuario = us;
                naturalBO = new NaturalClient();
                try
                {
                    naturalBO.insertarNatural(natural);
                }
                catch
                {
                    ShowError("Ocurrio un error al validar sus datos");
                    usuarioBO = new UsuarioClient();
                    usuarioBO.eliminarUsuario(us);
                }

            }



            // Redirigir a login o mostrar éxito
            Response.Redirect("Autentificacion.aspx");
        }

        protected void btnEnviarCodigo_Click(object sender, EventArgs e)
        {
            litMensaje.Visible = false;
            var rol = ddlRol.SelectedValue;
            var email = txtEmail.Text.Trim();
            var pass = txtPassword.Text;

            if (string.IsNullOrEmpty(rol) ||
               string.IsNullOrEmpty(email) ||
               string.IsNullOrEmpty(pass))
            {
                ShowError("Completa todos los campos.");
                return;
            }



            usuarioDTO1 us = new usuarioDTO1();
            usuarioBO = new UsuarioClient();
            us = usuarioBO.buscarPorEmailUsuario(email);
            if (us != null)
            {
                ShowError("El correo ya ha sido registrado");
                return;
            }

            // Generar un código aleatorio de 6 dígitos
            var rnd = new Random();
            CodigoEnviado = rnd.Next(100000, 999999).ToString();

            litCodigo.Text = CodigoEnviado;
            // Mostrar panel de verificación
            ScriptManager.RegisterStartupScript(this, GetType(), "step2", "showStep(2);", true);
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
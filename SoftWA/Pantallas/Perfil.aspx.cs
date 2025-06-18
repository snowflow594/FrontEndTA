using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class Perfil : System.Web.UI.Page
    {
        private UsuarioClient usuarioBO;
        private JuridicaClient juridicaBO;
        private NaturalClient naturalBO;
        private AdministradorClient administradorBO;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar autenticación
            if (Session["UsuarioAutenticado"] == null)
            {
                Response.Redirect("Autentificacion.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Cargar datos según rol
                var user = (usuarioDTO1)Session["UsuarioAutenticado"];
                // Email inmutable
                txtEmail.Text = user.email;
                int entero = user.id;

                pnlNatural.Visible = user.rol.id == 3;
                pnlJuridica.Visible = user.rol.id == 2;


                if (pnlNatural.Visible)
                {
                    naturalBO = new NaturalClient();
                    naturalDTO nat = new naturalDTO();
                    try
                    {
                        nat = naturalBO.obtenerPorIdNatural(user.id);
                        txtNombres.Text = nat.nombres;
                        txtApellidos.Text = nat.apellidos;
                        txtTelefono.Text = nat.telefono;
                        txtDNI.Text = nat.dni.ToString();
                        txtFechaNacimiento.Text = nat.fechaNacimiento.ToString("yyyy-MM-dd");
                        ddlGenero.SelectedValue = nat.genero;
                    }
                    catch
                    {
                        nat = null;
                        return;
                    }

                }
                if (pnlJuridica.Visible)
                {
                    juridicaBO = new JuridicaClient();
                    juridicaDTO jur = new juridicaDTO();
                    try
                    {

                        jur = juridicaBO.obtenerPorIdJuridica(user.id);
                        txtNombres.Text = jur.nombres;
                        txtApellidos.Text = jur.apellidos;
                        txtTelefono.Text = jur.telefono;
                        txtRUC.Text = jur.ruc;
                        txtRazonSocial.Text = jur.razonSocial;
                        txtRepresentante.Text = jur.representanteLegal;
                    }
                    catch
                    {
                        jur = null;
                        return;
                    }


                }

                // Solo clientes (natural o jurídica) pueden editar
                if (user.rol.id == 1)
                {
                    // Administrador: no mostrar sección de perfil
                    btnUpdate.Enabled = btnDelete.Enabled = false;
                    lblMessage.Text = "Los administradores no pueden editar aquí.";
                    lblMessage.CssClass = "mt-3 text-danger";
                    lblMessage.Visible = true;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            var user = (usuarioDTO1)Session["UsuarioAutenticado"];
            pnlNatural.Visible = user.rol.id == 3;
            pnlJuridica.Visible = user.rol.id == 2;
            int result = 0;
            // Actualiza extras según rol
            if (pnlNatural.Visible)
            {

                naturalDTO nat = new naturalDTO();
                try
                {
                    nat = naturalBO.obtenerPorIdNatural(user.id);
                    nat.nombres = txtNombres.Text;
                    nat.apellidos = txtApellidos.Text;
                    nat.telefono = txtTelefono.Text;
                    nat.dni = int.Parse(txtDNI.Text);
                    nat.fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                    nat.genero = ddlGenero.SelectedValue;
                    nat.usuarioActualizacion = user;
                    naturalBO = new NaturalClient();
                    naturalBO.modificarNatural(nat);
                    Response.Redirect("Inicio.aspx");
                }
                catch
                {
                    lblMessage.Text = "Datos Naturales no actualizados.";
                }


            }
            if (user.rol.id == 2)
            {
                juridicaBO = new JuridicaClient();
                juridicaDTO jur = new juridicaDTO();
                //jur = null;
                try
                {
                    jur = juridicaBO.obtenerPorIdJuridica(user.id);
                    juridicaDTO juridicoPe = new juridicaDTO();
                    usuarioDTO1 usuario12 = new usuarioDTO1();
                    usuario12 = user;
                    juridicoPe.id_juridica = jur.id;
                    juridicoPe.ruc = txtRUC.Text;
                    juridicoPe.razonSocial = txtRazonSocial.Text;
                    juridicoPe.representanteLegal = txtRepresentante.Text;
                    juridicoPe.apellidos = txtApellidos.Text;
                    juridicoPe.nombres = txtNombres.Text;
                    juridicoPe.telefono = txtTelefono.Text;
                    juridicoPe.usuario = usuario12;
                    juridicoPe.usuarioActualizacion = usuario12;
                    juridicoPe.activo = 1;
                    juridicoPe.id = jur.id;
                    result = juridicaBO.modificarJuridica(juridicoPe);
                    Response.Redirect("Inicio.aspx");


                }
                catch
                {
                    result = 0;
                    jur = null;
                    lblMessage.Text = "Datos Juridicos no actualizados .";
                }


            }


            //Session["UsuarioAutenticado"] = user;
            if (result != 0)
            {
                lblMessage.Text = "Datos actualizados correctamente de modificar.";
                lblMessage.CssClass = "mt-3 text-success";
                lblMessage.Visible = true;
            }
            else
            {
                lblMessage.Text = "Datos No se actualizaron de modificar.";
                lblMessage.CssClass = "mt-3 text-success";
                lblMessage.Visible = true;
            }


            Response.Redirect("Inicio.aspx");

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // Llamada al servicio para eliminar al usuario (y en cascada su perfil)
            var client = new UsuarioClient();
            var user = (usuarioDTO1)Session["UsuarioAutenticado"];
            juridicaDTO jur = new juridicaDTO();
            naturalDTO nat = new naturalDTO();
            pnlJuridica.Visible = user.rol.id == 2;
            if (user.rol.id == 3)
            {
                nat = naturalBO.obtenerPorIdNatural(user.id);
                naturalBO.eliminarNatural(nat);
            }
            else
            {
                jur = juridicaBO.obtenerPorIdJuridica(user.id);
                juridicaBO.eliminarJuridica(jur);
            }


            client.eliminarUsuario(user);



            // Limpiamos toda la sesión y redirigimos al login
            ///*Sessio*/n.Clear();
            Response.Redirect("Autentificacion.aspx");
        }
    }
}
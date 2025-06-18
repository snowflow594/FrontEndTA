using Mysqlx.Crud;
using SoftWA.ServiciosWSClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas.MasterPages
{
    public partial class PaginaMaster : System.Web.UI.MasterPage
    {
        private CarritoClient carritoWSClient = new CarritoClient();
        private ItemCarritoClient itemCarritoWSClient = new ItemCarritoClient();
        private UsuarioClient usuarioWSClient = new UsuarioClient();
        private NaturalClient naturalWSClient = new NaturalClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["idCarrito"] == null)
                {
                    CrearCarritoTemporal();
                    CrearSessionCarritoTemporal();
                }
                CargarCantidadCarrito();
            }
        }
        protected void CargarCantidadCarrito()
        {
            int idCarrito = Convert.ToInt32(Session["idCarrito"]);
            try
            {
                if (Session["idCarrito"] == null)
                {
                    lblCantidadItemsCarrito.Text = "0";
                    return;
                }

                var todosLosItems = itemCarritoWSClient.listarTodosItemCarrito();
                var itemsDelCarrito = todosLosItems
                    .Where(item => item.carrito != null && item.carrito.idCarrito == idCarrito)
                    .ToList();

                if (itemsDelCarrito == null)
                {
                    lblCantidadItemsCarrito.Text = "0";
                    return;
                }
                int cantidadItems = 0;
                foreach(var item in itemsDelCarrito)
                {
                    cantidadItems += item.cantidad;
                }
                lblCantidadItemsCarrito.Text = cantidadItems.ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar el carrito: " + ex.Message + "');</script>");
            }
        }
        private void CrearCarritoTemporal()
        {
            int i;
            //var usuarioTemp = new SoftWA.ServiciosWSClient.usuarioDTO1
            //{
            //    email = "invitado@ciapasa",
            //    contraseña = "1234",
            //    rol = new SoftWA.ServiciosWSClient.rolDTO1 { id = 3}
            //};
            //i = usuarioWSClient.insertarUsuario(usuarioTemp);
            //var naturalTemp = new SoftWA.ServiciosWSClient.naturalDTO
            //{
            //    usuario = usuarioTemp,
            //    nombres = "invitado1",
            //    apellidos = "invitado1",
            //    telefono = "1234",
            //    dni = 1234,
            //    fechaNacimiento = DateTime.Now, //solo para prueba
            //    genero = "invitado",
            //    usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO1 { id = 1}
            //};
            //i = naturalWSClient.insertarNatural(naturalTemp);
            if (Session["idCarrito"] == null)
            {
                return;
            }
            var carritoTemp = new SoftWA.ServiciosWSClient.carritoDTO
            {
                persona = new SoftWA.ServiciosWSClient.personaDTO { id = 1 },
                total = 0,
                usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4 }
            };
            i = carritoWSClient.insertarCarrito(carritoTemp);
            Session["idUsuario"] = 4; //estas id están en la base de datos directamente porque todavía falta concectarlo con las pantallas de registrarse inicio sesión, etc. podrían tratarse como invitado
            Session["idPersona"] = 1; /*INSERT INTO usuario(email, contrasena, activo, rol_id) VALUES
                                            ('invitado@ciapasa.com', '1234', 1, 3);

                                        INSERT INTO persona(usuario_id, nombres, apellidos, telefono, activo, usuario_creacion) VALUES
                                            (4, 'Estefano V.', 'Quispe V.', 982842547, 1, 2);*/
        }

        private void CrearSessionCarritoTemporal()
        {
            var todosLosCarritos = carritoWSClient.listarTodosCarrito();

            var ultimo = todosLosCarritos?
                .Where(c => c != null &&
                            c.persona != null && c.persona.id == 1 &&
                            c.usuarioCreacion != null && c.usuarioCreacion.id == 4 &&
                            c.total == 0)
                .OrderByDescending(c => c.idCarrito)
                .FirstOrDefault();

            if (ultimo != null)
                Session["idCarrito"] = ultimo.idCarrito;
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string termino = txtBuscar.Text.Trim();
            if (!string.IsNullOrEmpty(termino))
            {
                Response.Redirect("~/Pantallas/Productos.aspx?busqueda=" + Server.UrlEncode(termino));
            }
        }

        protected void linkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Inicio.aspx");
        }

    }
}
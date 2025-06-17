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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CrearUsuarioTemporal();
                if (Session["idCarrito"] == null)
                {
                    CrearCarritoTemporal();
                }
                CargarCantidadCarrito();
            }
        }
        protected void CargarCantidadCarrito()
        {
            int idCarrito = Convert.ToInt32(Session["idCarrito"]);
            try
            {
                var carrito = carritoWSClient.obtenerPorIdCarrito(idCarrito);
                int cantidadItems = 0;
                foreach (var item in carrito.items)
                {
                    cantidadItems++;
                }
                lblCantidadItemsCarrito.Text = cantidadItems.ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar el carrito: " + ex.Message + "');</script>");
            }
        }
        private void CrearUsuarioTemporal()
        {
            //var carritoTemp = new SoftWA.ServiciosWSClient.carritoDTO
            //{
            //    persona = new SoftWA.ServiciosWSClient.personaDTO { id = 1 },
            //    total = 0,
            //    usuarioCreacion = new SoftWA.ServiciosWSClient.usuarioDTO { id = 4 }
            //};
            //int i = carritoWSClient.insertarCarrito(carritoTemp);
            var carritoTemp = carritoWSClient.obtenerPorIdCarrito(1);
            Session["idUsuario"] = 4;
            Session["idPersona"] = 1;
            Session["idCarrito"] = carritoTemp.idCarrito;
        }

        private void CrearCarritoTemporal()
        {
            //    var todosLosCarritos = carritoWSClient.listarTodosCarrito();

            //    var ultimo = todosLosCarritos?
            //        .Where(c => c != null &&
            //                    c.persona != null && c.persona.id == 1 &&
            //                    c.usuarioCreacion != null && c.usuarioCreacion.id == 4 &&
            //                    c.total == 0)
            //        .OrderByDescending(c => c.idCarrito)
            //        .FirstOrDefault();

            //    if (ultimo != null)
            //        Session["idCarrito"] = ultimo.idCarrito;
        }
    }
}
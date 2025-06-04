using SoftWA.ItemCarrito;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftWA.Pantallas
{
    public partial class DireccionEnvio : System.Web.UI.Page
    {
        private ItemCarritoClient itemCarritoWSClient = new ItemCarritoClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarResumenCarrito();
            }
        }

        private void CargarResumenCarrito()
        {
            int? idCarrito = Session["idCarrito"] as int?;
            if (idCarrito == null)
            {
                Response.Redirect("Inicio.aspx");
                return;
            }

            var items = itemCarritoWSClient.listarTodosItemCarrito().ToList();
            var itemsFiltrados = items.Where(i => i.carrito.idCarrito == idCarrito.Value).ToList();

            double subtotal = itemsFiltrados.Sum(i => i.subtotal);
            double impuesto = subtotal * 0.12;
            double total = subtotal + impuesto;

            lblSubtotal.Text = $"S/ {subtotal:N2}";
            lblImpuesto.Text = $"S/ {impuesto:N2}";
            lblEnvio.Text = "-";
            lblTotal.Text = $"S/ {total:N2}";
        }

        protected void btnGuardarDireccion_Click(object sender, EventArgs e)
        {
            // Por ahora se puede guardar en Session[]
            Session["correo"] = txtCorreo.Text;
            Session["alias"] = txtAlias.Text;
            Session["direccion"] = txtDireccion.Text;
            Session["ciudad"] = txtCiudad.Text;
            Session["referencia"] = txtReferencia.Text;
        }

        protected void btnVerDirecciones_Click(object sender, EventArgs e)
        {
            Response.Redirect("DireccionesGuardadas.aspx");
        }

        protected void btnContinuarPago_Click(object sender, EventArgs e)
        {
            // Puedes validar aquí que todos los campos estén completos si lo deseas
            Response.Redirect("DatosDePago.aspx");
        }
    }
}
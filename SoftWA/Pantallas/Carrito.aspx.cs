using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SoftWA.ItemCarrito;
using SoftWA.Carrito;
using System.ComponentModel;

namespace SoftWA.Pantallas
{
    public partial class Carrito : System.Web.UI.Page
    {
        private ItemCarritoClient itemCarritoWS = new ItemCarritoClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCarrito();
            }
        }
        protected void rptCarrito_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int idItemCarrito = Convert.ToInt32(e.CommandArgument);
            var item = itemCarritoWS.listarTodosItemCarrito().FirstOrDefault(i => i.idItemCarrito == idItemCarrito);

            if (item != null)
            {
                if (e.CommandName == "Aumentar")
                {
                    item.cantidad++;
                }
                else if (e.CommandName == "Disminuir" && item.cantidad > 1)
                {
                    item.cantidad--;
                }

                // Recalcular subtotal
                item.subtotal = item.producto.precio * item.cantidad;

                // Actualizar item en el backend
                itemCarritoWS.modificarItemCarrito(item);
            }

            CargarCarrito();
        }

        private void CargarCarrito()
        {
            int? idCarrito = Session["idCarrito"] as int?;
            if (idCarrito == null)
            {
                Response.Redirect("Inicio.aspx");
                return;
            }

            // btener todos los ítems del carrito y filtrarlos por ID del carrito actual
            var items = itemCarritoWS.listarTodosItemCarrito()?.ToList() ?? new List<SoftWA.ItemCarrito.itemCarritoDTO>();

            rptCarrito.DataSource = items;
            rptCarrito.DataBind();

            // calcular montos
            double subtotal = items.Sum(i => i.subtotal);
            double impuesto = subtotal * 0.12; //eso es sel procentaje de impuetos
            double total = subtotal + impuesto;

            lblSubtotal.Text = $"S/ {subtotal:N2}";
            lblImpuesto.Text = $"S/ {impuesto:N2}";
            lblTotal.Text = $"S/ {total:N2}";
        }
    }
}
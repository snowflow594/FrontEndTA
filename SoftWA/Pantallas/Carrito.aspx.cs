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
        private ItemCarritoClient itemCarritoWSClient;
        private CarritoClient carritoWSClient;
        
        protected void Page_Init(object sender, EventArgs e)
        {
            itemCarritoWSClient = new ItemCarritoClient();
            carritoWSClient = new CarritoClient();
                    
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                CargarCarrito();
            }
        }

        protected void CargarCarrito()
        {
            int? idCarrito = Session["idCarrito"] as int?;
            if(idCarrito == null)
            {
                
            }
            List<SoftWA.ItemCarrito.itemCarritoDTO> itemsCarrito = itemCarritoWSClient.listarTodosItemCarrito().ToList();

            Session["ItemsCarrito"] = itemsCarrito;
            rptCarrito.DataSource = itemsCarrito;
            rptCarrito.DataBind();

            CalcularTotal(itemsCarrito);
            
        }

        private void CalcularTotal(List<SoftWA.ItemCarrito.itemCarritoDTO> itemsCarrito)
        {
            double subtotal=0;
            foreach (var item in itemsCarrito)
            {
                subtotal += item.subtotal * item.cantidad;
            }
            double impuestos = 15;
            double total = subtotal + impuestos;

            lblSubtotal.Text = "S/ " + subtotal.ToString("F2");
            lblImpuestos.Text = "S/ " + impuestos.ToString("F2");
            lblTotal.Text = "S/ " + total.ToString("F2");
        }

        protected void rptCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idItemCarrito = int.Parse(e.CommandArgument.ToString());
            var item = itemCarritoWSClient.listarTodosItemCarrito().FirstOrDefault(i => i.idItemCarrito == idItemCarrito);

            if (item == null) return;

            if (e.CommandName == "Aumentar")
            {
                item.cantidad += 1;
                itemCarritoWSClient.modificarItemCarrito(item);
            }
            else if (e.CommandName == "Disminuir")
            {
                if (item.cantidad > 1)
                {
                    item.cantidad -= 1;
                    itemCarritoWSClient.modificarItemCarrito(item);
                }
                else //por si llega a 0 se elimina
                {
                    itemCarritoWSClient.eliminarItemCarrito(item);
                }
            }

            CargarCarrito();
        }
    }
}
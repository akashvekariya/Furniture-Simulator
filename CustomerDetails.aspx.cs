using System;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;

public partial class CustomerDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSource1.SelectCommand = "select pu.purchase_id, pu.order_complete, pu.product_id, pr.total_amount, pr.product_filename, c.color_name, c.color_filename, m.material_filename, m.material_name, pu.customer_name, pu.email, pu.phone, pu.customer_address, pu.purchase_date, pu.shipping_date from product_master pr, purchase_master pu, material_master m, color_master c Where pu.product_id = pr.product_id AND pr.user_id = '" + Session["AcquireSession"].ToString() + "' AND pu.user_id = '" + Session["AcquireSession"].ToString() + "' and c.color_id = pr.color_id and m.material_id = pr.material_id;";
        DataList1.DataSource = DataSource1;
        DataList1.DataBind();
    }

    protected void orderComplete_Click(object sender, DataListCommandEventArgs e)
    {
        if(e.CommandName == "complete")
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            try
            {
                connection.Open();
                string order_complete = "UPDATE purchase_master SET order_complete= '1' WHERE purchase_id='" + e.CommandArgument.ToString() + "'";
                SqlCommand order_completeCmd = new SqlCommand(order_complete, connection);

                order_completeCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("Something is wrong! Try again");
            }
            Response.Redirect("CustomerDetails.aspx");
        }

        if (e.CommandName == "revoke")
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            try
            {
                connection.Open();
                string order_complete = "UPDATE purchase_master SET order_complete= '0' WHERE purchase_id='" + e.CommandArgument.ToString() + "'";
                SqlCommand order_completeCmd = new SqlCommand(order_complete, connection);

                order_completeCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("Something is wrong! Try again");
            }
            Response.Redirect("CustomerDetails.aspx");
        }

    }

    protected void changeColor_order(object sender, DataListItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item) || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField hidden = (HiddenField)e.Item.FindControl("orderStatus");
            Panel pan = (Panel)e.Item.FindControl("colorStatus");
            LinkButton complete = (LinkButton)e.Item.FindControl("orderComplete");
            LinkButton revoke = (LinkButton)e.Item.FindControl("orderIncomplete");
            if (Convert.ToInt32(hidden.Value) == 1)
            {
                //e.Item.BackColor = System.Drawing.Color.Green;
                pan.BackColor = System.Drawing.Color.FromArgb(90,212,255,212);
                revoke.Visible = true;
                complete.Visible = false;
            } else
            {
                string colorcode = "#00000020";
                int argb = Int32.Parse(colorcode.Replace("#", ""), NumberStyles.HexNumber);
                pan.BackColor = Color.FromArgb(0, 250, 250, 250);
                revoke.Visible = false;
                complete.Visible = true;
            }
        }
    }
}
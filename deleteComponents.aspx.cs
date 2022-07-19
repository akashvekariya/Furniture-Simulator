using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class deleteComponents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            ChairBackSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Back' AND category_name='Chair' AND user_id='"+ Session["AcquireSession"].ToString() +"'";
            ChairHandrestSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Hand' AND category_name='Chair' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            ChairSeatSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Seat' AND category_name='Chair' AND user_id='"+ Session["AcquireSession"].ToString() +"'";
            ChairLegSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Leg' AND category_name='Chair' AND user_id='" + Session["AcquireSession"].ToString() + "'";

            BedBackSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Back' AND category_name='Bed' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            BedMattressSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Mattress' AND category_name='Bed' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            BedLegSrc.SelectCommand = "SELECT part_filename FROM parts_master WHERE part_name='Leg' AND category_name='Bed' AND user_id='" + Session["AcquireSession"].ToString() + "'";

            materialSrc.SelectCommand = "SELECT material_filename FROM material_master WHERE user_id = '" + Session["AcquireSession"].ToString() + "'";
            colorSrc.SelectCommand = "SELECT color_filename FROM color_master WHERE user_id = '" + Session["AcquireSession"].ToString() + "'";

            DataList1.DataSource = ChairBackSrc;
            DataList1.DataBind();
            DataList2.DataSource = ChairHandrestSrc;
            DataList2.DataBind();
            DataList3.DataSource = ChairSeatSrc;
            DataList3.DataBind();
            DataList4.DataSource = ChairLegSrc;
            DataList4.DataBind();

            DataList5.DataSource = BedBackSrc;
            DataList5.DataBind();
            DataList6.DataSource = BedMattressSrc;
            DataList6.DataBind();
            DataList7.DataSource = BedLegSrc;
            DataList7.DataBind();

            DataList8.DataSource = materialSrc;
            DataList8.DataBind();
            DataList9.DataSource = colorSrc;
            DataList9.DataBind();
        }
    }

    protected void deletePart(object sender, DataListCommandEventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        try
        {
            if (e.CommandName == "Click")
            {
                string deleteRow = "DELETE FROM parts_master WHERE part_filename='" + e.CommandArgument + "'";
                SqlCommand deleteRowCmd = new SqlCommand(deleteRow, connection);
                connection.Open();
                deleteRowCmd.ExecuteNonQuery();
            }
        } 
        catch(Exception ex)
        {
            Response.Write("error");
        }
        finally
        {
            connection.Close();
            Response.Redirect("deleteComponents.aspx");
        }
    }

    protected void deleteMaterial(object sender, DataListCommandEventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        try
        {
            if (e.CommandName == "Click")
            {
                string deleteRow = "DELETE FROM material_master WHERE material_filename='" + e.CommandArgument + "'";
                SqlCommand deleteRowCmd = new SqlCommand(deleteRow, connection);
                connection.Open();
                deleteRowCmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            Response.Write("error");
        }
        finally
        {
            connection.Close();
            Response.Redirect("deleteComponents.aspx");
        }
    }

    protected void deleteColor(object sender, DataListCommandEventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        try
        {
            if (e.CommandName == "Click")
            {
                string deleteRow = "DELETE FROM color_master WHERE color_filename='" + e.CommandArgument + "'";
                SqlCommand deleteRowCmd = new SqlCommand(deleteRow, connection);
                connection.Open();
                deleteRowCmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            Response.Write("error");
        }
        finally
        {
            connection.Close();
            Response.Redirect("deleteComponents.aspx");
        }
    }
}
using System;

public partial class selectCatSimulate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["SimulationCategory"] = null;
    }

    protected void SimulateBtn_Click(object sender, EventArgs e)
    {
        if (chooseCategory.SelectedValue == "Chair")
        {
            Session["SimulationCategory"] = "Chair";
            Response.Redirect("Simulation.aspx");
        }
        if (chooseCategory.SelectedValue == "Bed")
        {
            Session["SimulationCategory"] = "Bed";
            Response.Redirect("Simulation.aspx");
        }
    }
}
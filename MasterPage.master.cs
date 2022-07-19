using System;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AcquireSession"] == null)
        {
            Response.Redirect("Signin.aspx");
        }
    }

    protected void signout_Click(object sender, EventArgs e)
    {
        Session["AcquireSession"] = null;
        Response.Redirect("Signin.aspx");
    }
}

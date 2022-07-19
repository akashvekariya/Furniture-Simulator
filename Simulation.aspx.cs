using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Simulation : System.Web.UI.Page
{
    string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + Guid.NewGuid().ToString();
    static string hiddenValue;
    static string finalImageName;
    static int btn;
    static int ChairBackPrice = 0;
    static int ChairLegPrice = 0;
    static int ChairHandrestPrice = 0;
    static int ChairSeatPrice = 0;
    static int BedBackPrice = 0;
    static int BedMattressPrice = 0;
    static int BedLegPrice = 0;
    static int MaterialPrice = 0;
    static int ColorPrice = 0;
    static int product_id = 0;
    static byte[] finalImage;

    HttpContext CurrentContext = HttpContext.Current;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["SimulationCategory"] == null)
        {
            Response.Redirect("selectCatSimulate.aspx");
        }
        if(Session["SimulationCategory"].ToString() == "Chair")
        {
            partButtonContainerBed.Visible = false;
            ChairBack.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Back' AND category_name='Chair' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            ChairHandrest.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Hand' AND category_name='Chair' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            ChairSeat.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Seat' AND category_name='Chair' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            ChairLeg.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Leg' AND category_name='Chair' AND user_id='" + Session["AcquireSession"].ToString() + "'";

            PostBackTrigger postBackTrigger1 = new PostBackTrigger();
            PostBackTrigger postBackTrigger2 = new PostBackTrigger();
            PostBackTrigger postBackTrigger3 = new PostBackTrigger();
            PostBackTrigger postBackTrigger4 = new PostBackTrigger();
            postBackTrigger1.ControlID = ChairBackBtn.ID;
            postBackTrigger2.ControlID = ChairHandrestBtn.ID;
            postBackTrigger3.ControlID = ChairSeatBtn.ID;
            postBackTrigger4.ControlID = ChairLegBtn.ID;

            simulationBox1.Visible = true;
            simulationBox2.Visible = false;
            removeComponentBtnBed.Visible = false;
            removeComponentBtnChair.Visible = true;
        } 
        else if (Session["SimulationCategory"].ToString() == "Bed")
        {
            partButtonContainerChair.Visible = false;
            BedBack.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Back' AND category_name='Bed' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            BedMattress.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Mattress' AND category_name='Bed' AND user_id='" + Session["AcquireSession"].ToString() + "'";
            BedLeg.SelectCommand = "SELECT part_id, part_filename, amount FROM parts_master WHERE part_name='Leg' AND category_name='Bed' AND user_id='" + Session["AcquireSession"].ToString() + "'";

            PostBackTrigger postBackTrigger1 = new PostBackTrigger();
            PostBackTrigger postBackTrigger2 = new PostBackTrigger();
            PostBackTrigger postBackTrigger3 = new PostBackTrigger();
            postBackTrigger1.ControlID = BedBackBtn.ID;
            postBackTrigger2.ControlID = BedMattressBtn.ID;
            postBackTrigger3.ControlID = BedLegBtn.ID;

            simulationBox1.Visible = false;
            simulationBox2.Visible = true;
            removeComponentBtnBed.Visible = true;
            removeComponentBtnChair.Visible = false;
        }
        titleLabel.Text = Session["SimulationCategory"].ToString() + " Simulation";

        material.SelectCommand = "SELECT material_id, material_filename, material_name, amount FROM material_master WHERE user_id='" + Session["AcquireSession"].ToString() + "'";

        color.SelectCommand = "SELECT color_id, color_filename, color_name, amount FROM color_master WHERE user_id='" + Session["AcquireSession"].ToString() + "'";

        if (!IsPostBack)
        {
            materialDetailBox.Visible = false;
            colorDetailBox.Visible = false;

            Materialid.Value = null;
            Colorid.Value = null;

            ChairBackPrice = 0;
            ChairLegPrice = 0;
            ChairHandrestPrice = 0;
            ChairSeatPrice = 0;
            BedBackPrice = 0;
            BedMattressPrice = 0;
            BedLegPrice = 0;
            MaterialPrice = 0;
            ColorPrice = 0;

            chairPrice.Text = "0 $";
            bedPrice.Text = "0 $";

            CurrentContext.Items.Add("Materialid", Materialid.Value);
            CurrentContext.Items.Add("Colorid", Colorid.Value);
            CurrentContext.Items.Add("ChairAmount", (ChairBackPrice + ChairHandrestPrice + ChairLegPrice + ChairSeatPrice + MaterialPrice + ColorPrice).ToString());
            CurrentContext.Items.Add("BedAmount", (BedBackPrice + BedMattressPrice + BedLegPrice + MaterialPrice + ColorPrice).ToString());
            CurrentContext.Items.Add("productId", product_id);
        }
    }

    protected void ChairBackBtn_Click(object sender, EventArgs e)
    {
        ChairBackBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        ChairHandrestBtn.Style.Remove("color");
        ChairHandrestBtn.Style.Remove("background-color");
        ChairSeatBtn.Style.Remove("color");
        ChairSeatBtn.Style.Remove("background-color");
        ChairLegBtn.Style.Remove("color");
        ChairLegBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = ChairBack;
        DataList1.DataBind();
        btn = 1;
    }

    protected void removeChairBack_Click(object sender, EventArgs e)
    {
        ChairBackImg.Visible = false;
        ChairBackImg.ImageUrl = null;
        ChairBackPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        ChairBackid.Value = null;
    }

    protected void ChairHandrestBtn_Click(object sender, EventArgs e)
    {
        ChairHandrestBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        ChairBackBtn.Style.Remove("color");
        ChairBackBtn.Style.Remove("background-color");
        ChairSeatBtn.Style.Remove("color");
        ChairSeatBtn.Style.Remove("background-color");
        ChairLegBtn.Style.Remove("color");
        ChairLegBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = ChairHandrest;
        DataList1.DataBind();
        btn = 2;
    }

    protected void removeChairHandrest_Click(object sender, EventArgs e)
    {
        ChairHandrestImg.Visible = false;
        ChairHandrestImg.ImageUrl = null;
        ChairHandrestPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        ChairHandrestid.Value = null;
    }

    protected void ChairSeatBtn_Click(object sender, EventArgs e)
    {
        ChairSeatBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        ChairHandrestBtn.Style.Remove("color");
        ChairHandrestBtn.Style.Remove("background-color");
        ChairBackBtn.Style.Remove("color");
        ChairBackBtn.Style.Remove("background-color");
        ChairLegBtn.Style.Remove("color");
        ChairLegBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = ChairSeat;
        DataList1.DataBind();
        btn = 3;
    }

    protected void removeChairSeat_Click(object sender, EventArgs e)
    {
        ChairSeatImg.Visible = false;
        ChairSeatImg.ImageUrl = null;
        ChairSeatPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        ChairSeatid.Value = null;
    }

    protected void ChairLegBtn_Click(object sender, EventArgs e)
    {
        ChairLegBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        ChairHandrestBtn.Style.Remove("color");
        ChairHandrestBtn.Style.Remove("background-color");
        ChairBackBtn.Style.Remove("color");
        ChairBackBtn.Style.Remove("background-color");
        ChairSeatBtn.Style.Remove("color");
        ChairSeatBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = ChairLeg;
        DataList1.DataBind();
        btn = 4;
    }

    protected void removeChairLeg_Click(object sender, EventArgs e)
    {
        ChairLegImg.Visible = false;
        ChairLegImg.ImageUrl = null;
        ChairLegPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        ChairLegid.Value = null;
    }

    protected void BedBackBtn_Click(object sender, EventArgs e)
    {
        BedBackBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        BedMattressBtn.Style.Remove("color");
        BedMattressBtn.Style.Remove("background-color");
        BedLegBtn.Style.Remove("color");
        BedLegBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = BedBack;
        DataList1.DataBind();
        btn = 5;
    }

    protected void removeBedBack_Click(object sender, EventArgs e)
    {
        BedBackImg.Visible = false;
        BedBackImg.ImageUrl = null;
        BedBackPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        BedBackid.Value = null;
    }

    protected void BedMattressBtn_Click(object sender, EventArgs e)
    {
        BedMattressBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        BedBackBtn.Style.Remove("color");
        BedBackBtn.Style.Remove("background-color");
        BedLegBtn.Style.Remove("color");
        BedLegBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = BedMattress;
        DataList1.DataBind();
        btn = 6;
    }

    protected void removeBedMattress_Click(object sender, EventArgs e)
    {
        BedMattressImg.Visible = false;
        BedMattressImg.ImageUrl = null;
        BedMattressPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        BedMattressid.Value = null;
    }

    protected void BedLegBtn_Click(object sender, EventArgs e)
    {
        BedLegBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
        BedMattressBtn.Style.Remove("color");
        BedMattressBtn.Style.Remove("background-color");
        BedBackBtn.Style.Remove("color");
        BedBackBtn.Style.Remove("background-color");
        DataList1.Visible = true;
        DataList1.DataSource = BedLeg;
        DataList1.DataBind();
        btn = 7;
    }

    protected void removeBedLeg_Click(object sender, EventArgs e)
    {
        BedLegImg.Visible = false;
        BedLegImg.ImageUrl = null;
        BedLegPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        BedLegid.Value = null;
    }

    protected void materialBtn_Click(object sender, EventArgs e)
    {
        if (DataList2.Visible == true)
        {
            materialBtn.Style.Remove("color");
            materialBtn.Style.Remove("background-color");
            DataList2.Visible = false;
        }
        else
        {
            materialBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
            colorBtn.Style.Remove("color");
            colorBtn.Style.Remove("background-color");
            DataList2.Visible = true;
            DataList2.DataSource = material;
            DataList2.DataBind();
        }
    }

    protected void removeMaterial_Click(object sender, EventArgs e)
    {
        materialDetailImg.ImageUrl = null;
        materialNameDetail.Text = null;
        materialDetailBox.Visible = false;
        MaterialPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        Materialid.Value = null;
    }

    protected void colorBtn_Click(object sender, EventArgs e)
    {
        if (DataList3.Visible == true)
        {
            colorBtn.Style.Remove("color");
            colorBtn.Style.Remove("background-color");
            DataList3.Visible = false;
        }
        else
        {
            colorBtn.Attributes.Add("Style", "color: white;background-color: #1473e6;");
            DataList3.Visible = true;
            DataList3.DataSource = color;
            DataList3.DataBind();
        }
    }

    protected void removeColor_Click(object sender, EventArgs e)
    {
        colorDetailImg.ImageUrl = null;
        colorNameDetail.Text = null;
        colorDetailBox.Visible = false;
        ColorPrice = 0;
        chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        Colorid.Value = null;
    }

    protected void loadImageToContainer1(object sender, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Click")
        {
            string[] partArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            if (btn == 1)
            {
                ChairBackImg.Visible = true;
                ChairBackImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                ChairBackPrice = Convert.ToInt32(partArgs[2]);
                ChairBackid.Value = partArgs[0];
                confbtn.Visible = true;
            }
            if (btn == 2)
            {
                ChairHandrestImg.Visible = true;
                ChairHandrestImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                ChairHandrestPrice = Convert.ToInt32(partArgs[2]);
                ChairHandrestid.Value = partArgs[0];
                confbtn.Visible = true;
            }
            if (btn == 3)
            {
                ChairSeatImg.Visible = true;
                ChairSeatImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                ChairSeatPrice = Convert.ToInt32(partArgs[2]);
                ChairSeatid.Value = partArgs[0];
                confbtn.Visible = true;
            }
            if (btn == 4)
            {
                ChairLegImg.Visible = true;
                ChairLegImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                ChairLegPrice = Convert.ToInt32(partArgs[2]);
                ChairLegid.Value = partArgs[0];
                confbtn.Visible = true;
            }
            if (btn == 5)
            {
                BedBackImg.Visible = true;
                BedBackImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                BedBackPrice = Convert.ToInt32(partArgs[2]);
                BedBackid.Value = partArgs[0];
                confbtn.Visible = true;
            }
            if (btn == 6)
            {
                BedMattressImg.Visible = true;
                BedMattressImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                BedMattressPrice = Convert.ToInt32(partArgs[2]);
                BedMattressid.Value = partArgs[0];
                confbtn.Visible = true;
            }
            if (btn == 7)
            {
                BedLegImg.Visible = true;
                BedLegImg.ImageUrl = "~/Parts_database/" + partArgs[1].ToString() + ".png";
                BedLegPrice = Convert.ToInt32(partArgs[2]);
                BedLegid.Value = partArgs[0];
                confbtn.Visible = true;
            }

            chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
        }
    }

    protected void materialContainer(object sender, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Click")
        {
            materialDetailBox.Visible = true;
            string[] materialArgs = e.CommandArgument.ToString().Split(new char[] {','});
            materialDetailImg.ImageUrl = "~/materialColor_database/" + materialArgs[1].ToString() + ".png";
            materialNameDetail.Text = materialArgs[2].ToString();
            MaterialPrice = Convert.ToInt32(materialArgs[3]);
            chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
            Materialid.Value = materialArgs[0];
            confbtn.Visible = true;
        }
    }

    protected void colorContainer(object sender, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Click")
        {
            colorDetailBox.Visible = true;
            string[] colorArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            colorDetailImg.ImageUrl = "~/materialColor_database/" + colorArgs[1].ToString() + ".png";
            colorNameDetail.Text = colorArgs[2].ToString();
            ColorPrice = Convert.ToInt32(colorArgs[3]);
            chairPrice.Text = bedPrice.Text = (ChairBackPrice + ChairHandrestPrice + ChairSeatPrice + ChairLegPrice + BedLegPrice + BedBackPrice + BedMattressPrice + MaterialPrice + ColorPrice).ToString() + " $";
            Colorid.Value = colorArgs[0];
            confbtn.Visible = true;
        }
    }

   
    
    protected void context_adding()
    {
        CurrentContext.Items["Materialid"] = Materialid.Value;
        CurrentContext.Items["Colorid"] = Colorid.Value;
        CurrentContext.Items["ChairAmount"] = (ChairBackPrice + ChairHandrestPrice + ChairLegPrice + ChairSeatPrice + MaterialPrice + ColorPrice).ToString();
        CurrentContext.Items["BedAmount"] = (BedBackPrice + BedMattressPrice + BedLegPrice + MaterialPrice + ColorPrice).ToString();
        CurrentContext.Items["productId"] = product_id;
        CurrentContext.Items["imageData"] = hiddenValue;
    }

    protected void buyBtn_Click(object sender, EventArgs e)
    {
        if (chairPrice.Text != "0 $" || bedPrice.Text != "0 $")
        {
            hiddenValue = finalImageHidden.Value;
            context_adding();
            Server.Transfer("Billing.aspx", true);
        }
    }
}
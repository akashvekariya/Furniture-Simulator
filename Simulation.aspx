<%@ Page Language="C#" AutoEventWireup="true" EnableViewStateMac="true" CodeFile="Simulation.aspx.cs" Inherits="Simulation" ClientIDMode="Static" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Simulator</title>
    <link rel="shortcut icon" href="App_Themes/Default/images/LogoFurnitureSimulator.png" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/Simulation.css" />
    <script src="https://kit.fontawesome.com/ffb41c23b7.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="App_Themes/Default/stylesheets/html2canvas.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager EnablePageMethods="true" ID="scriptManager1" runat="server" ScriptMode="Release" LoadScriptsBeforeUI="true"></asp:ScriptManager>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>

                <div class="mainPanelSim">

                    <%-----------------------------------------------left Panel-------------------------------------------------%>
                    <section class="leftPanel">
                        <div class="title">
                            <asp:Label ID="titleLabel" runat="server" CssClass="titleStyle" />
                        </div>
                        <div class="subjectPanel">
                            <div class="simulationBox1" runat="server" id="simulationBox1">
                                <div class="simulationSubBox1" id="simulationSubBox1">
                                    <asp:Image
                                        ID="ChairBackImg"
                                        runat="server"
                                        ImageUrl="null"
                                        alt="Chair Back"
                                        CssClass="ChairImg ChairBackImg"
                                        onerror="this.style.display='none'" />
                                    <asp:Image
                                        ID="ChairHandrestImg"
                                        runat="server"
                                        ImageUrl="null"
                                        alt="Chair Handrest"
                                        CssClass="ChairImg ChairHandrestImg"
                                        onerror="this.style.display='none'" />
                                    <asp:Image
                                        ID="ChairSeatImg"
                                        runat="server"
                                        ImageUrl="null"
                                        CssClass="ChairImg ChairSeatImg"
                                        onerror="this.style.display='none'" />
                                    <asp:Image
                                        ID="ChairLegImg"
                                        runat="server"
                                        ImageUrl="null"
                                        CssClass="ChairImg ChairLegImg"
                                        onerror="this.style.display='none'" />
                                </div>
                                <div class="priceBox">
                                    <asp:Label ID="textPrice" runat="server" Text="Total Amount" CssClass="textPrice"></asp:Label>
                                    <br />
                                    <asp:Label ID="chairPrice" runat="server" CssClass="totalPrice"></asp:Label>
                                </div>
                            </div>

                            <div class="simulationBox2" runat="server" id="simulationBox2">
                                <div class="simulationSubBox2" id="simulationSubBox2">
                                    <asp:Image
                                        ID="BedBackImg"
                                        runat="server"
                                        ImageUrl="null"
                                        alt="Bed Back"
                                        CssClass="BedImg BedBackImg"
                                        onerror="this.style.display='none'" />
                                    <asp:Image
                                        ID="BedMattressImg"
                                        runat="server"
                                        ImageUrl="null"
                                        alt="Bed Mattress"
                                        CssClass="BedImg BedMattressImg"
                                        onerror="this.style.display='none'" />
                                    <asp:Image
                                        ID="BedLegImg"
                                        runat="server"
                                        ImageUrl="null"
                                        alt="Bed Leg"
                                        CssClass="BedImg BedLegImg"
                                        onerror="this.style.display='none'" />
                                </div>
                                <div class="priceBox">
                                    <asp:Label ID="textPrice2" runat="server" Text="Total Amount" CssClass="textPrice"></asp:Label>
                                    <br />
                                    <asp:Label ID="bedPrice" runat="server" CssClass="totalPrice"></asp:Label>
                                </div>
                            </div>

                            <div class="removeComponentBtnChair" runat="server" id="removeComponentBtnChair">
                                <asp:LinkButton class="removeBtnsChair" ForeColor="Black" ID="removeChairBack" OnClick="removeChairBack_Click" runat="server"><i class="fas fa-minus-circle"> Back</i></asp:LinkButton>
                                <asp:LinkButton class="removeBtnsChair" ForeColor="Black" ID="removeHandrestBack" OnClick="removeChairHandrest_Click" runat="server"><i class="fas fa-minus-circle"> Arm-rest</i></asp:LinkButton>
                                <asp:LinkButton class="removeBtnsChair" ForeColor="Black" ID="removeSeatBack" OnClick="removeChairSeat_Click" runat="server"><i class="fas fa-minus-circle"> Seat</i></asp:LinkButton>
                                <asp:LinkButton class="removeBtnsChair" ForeColor="Black" ID="removeLegBack" OnClick="removeChairLeg_Click" runat="server"><i class="fas fa-minus-circle"> Leg</i></asp:LinkButton>
                            </div>

                            <div class="removeComponentBtnBed" runat="server" id="removeComponentBtnBed">
                                <asp:LinkButton class="removeBtnsBed" ForeColor="Black" ID="removeBedBack" OnClick="removeBedBack_Click" runat="server"><i class="fas fa-minus-circle"> Back</i></asp:LinkButton>
                                <asp:LinkButton class="removeBtnsBed" ForeColor="Black" ID="removeBedMattress" OnClick="removeBedMattress_Click" runat="server"><i class="fas fa-minus-circle"> Mattress</i></asp:LinkButton>
                                <asp:LinkButton class="removeBtnsBed" ForeColor="Black" ID="removeBedLeg" OnClick="removeBedLeg_Click" runat="server"><i class="fas fa-minus-circle"> Leg</i></asp:LinkButton>
                            </div>
                            <asp:Button ID="buyBtn" runat="server" Text="Procced to checkout" OnClick="buyBtn_Click" />
                            <button id="confbtn" onclick="take_screenshot();" runat="server">Confirm simulation</button>

                            <asp:HiddenField ID="finalImageHidden" ClientIDMode="Static" runat="server" />

                            <script>
                                function take_screenshot() {
                                    try {
                                        let chair = document.getElementById("simulationSubBox1") || document.getElementById("simulationSubBox2");
                                        html2canvas(chair).then(
                                            function (canvas) {
                                                var data = canvas.toDataURL("image/png");
                                                data = data.replace('data:image/png;base64,', '');
                                                $("[id*=finalImageHidden]").val(data);
                                                $("[id*=buyBtn]").css('display', 'block');
                                                $("#confbtn").css('display', 'none');
                                            }
                                        );
                                    } catch (err) {
                                        console.log("error on screenshot");
                                    }
                                }
                            </script>

                            <div class="detailsBox" runat="server" id="detailsBox">
                                <div class="subDetailBox" runat="server" id="materialDetailBox">
                                    <asp:Image runat="server" ID="materialDetailImg" class="materialDetailImg"></asp:Image>
                                    <div class="textAlign">
                                        <asp:Label ID="materialNameDetail" runat="server" Text="hello" CssClass="materialNameDetail" />
                                        <asp:LinkButton ID="removeMaterial" runat="server" OnClick="removeMaterial_Click" Font-Size="22px"><i class="fas fa-minus-circle" alt="delete"></i></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="subDetailBox" runat="server" id="colorDetailBox">
                                    <asp:Image ID="colorDetailImg" runat="server" class="colorDetailImg"></asp:Image>
                                    <div class="textAlign">
                                        <asp:Label ID="colorNameDetail" runat="server" Text="hello" CssClass="colorNameDetail" />
                                        <asp:LinkButton ID="removeColor" runat="server" OnClick="removeColor_Click" Font-Size="22px"><i class="fas fa-minus-circle" alt="delete"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </section>

                    <%----------------------------------------------hidden fields---------------------------------------------%>

                    <asp:HiddenField ID="ChairBackid" runat="server" />
                    <asp:HiddenField ID="ChairHandrestid" runat="server" />
                    <asp:HiddenField ID="ChairSeatid" runat="server" />
                    <asp:HiddenField ID="ChairLegid" runat="server" />
                    <asp:HiddenField ID="BedBackid" runat="server" />
                    <asp:HiddenField ID="BedMattressid" runat="server" />
                    <asp:HiddenField ID="BedLegid" runat="server" />
                    <asp:HiddenField ID="Materialid" runat="server" />
                    <asp:HiddenField ID="Colorid" runat="server" />


                    <%-----------------------------------------------right Panel-------------------------------------------------%>
                    <section class="rightPanel">
                        <div class="mainPartButtonContainer">
                            <div class="partButtonContainerChair" runat="server" id="partButtonContainerChair">
                                <asp:Button ID="ChairBackBtn" runat="server" CssClass="navChairBtn" Text="Back" OnClick="ChairBackBtn_Click" />
                                <asp:Button ID="ChairHandrestBtn" runat="server" CssClass="navChairBtn" Text="Arm-rest" OnClick="ChairHandrestBtn_Click" />
                                <asp:Button ID="ChairSeatBtn" runat="server" CssClass="navChairBtn" Text="Seat" OnClick="ChairSeatBtn_Click" />
                                <asp:Button ID="ChairLegBtn" runat="server" CssClass="navChairBtn" Text="Leg" OnClick="ChairLegBtn_Click" />
                            </div>

                            <div class="partButtonContainerBed" runat="server" id="partButtonContainerBed">
                                <asp:Button ID="BedBackBtn" runat="server" OnClick="BedBackBtn_Click" CssClass="navBedBtn" Text="Back" />
                                <asp:Button ID="BedMattressBtn" runat="server" OnClick="BedMattressBtn_Click" CssClass="navBedBtn" Text="Mattress" />
                                <asp:Button ID="BedLegBtn" runat="server" OnClick="BedLegBtn_Click" CssClass="navBedBtn" Text="Leg" />
                            </div>
                        </div>

                        <div class="partButtonContainerOther">
                            <asp:Button ID="materialBtn" runat="server" OnClick="materialBtn_Click" CssClass="otherNavBtn" Text="Material" />
                            <asp:Button ID="colorBtn" runat="server" OnClick="colorBtn_Click" CssClass="otherNavBtn" Text="Color" />
                        </div>

                        <%-----------------------------------------------datalist-------------------------------------------------%>

                        <div class="rightDatalistBox">
                            <asp:DataList ID="DataList1" runat="server" OnItemCommand="loadImageToContainer1" RepeatColumns="1" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="imageCover">
                                        <asp:ImageButton ID="Image1" runat="server" CssClass="imageDataList" CommandName="Click" CommandArgument='<%# Eval("part_id") + "," + Eval("part_filename") + "," + Eval("amount")  %>' ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png") %>' />
                                    </div>
                                    <asp:Label ID="amount" runat="server" CssClass="amountDataList" Text='<%# Bind("amount", "{0} $") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                            <div class="extraSpace"></div>
                        </div>

                        <div class="leftDatalistBox1">
                            <asp:DataList ID="DataList2" runat="server" OnItemCommand="materialContainer" RepeatColumns="1" RepeatLayout="Flow" RepeatDirection="Vertical">
                                <ItemTemplate>
                                    <div class="imageCover">
                                        <asp:ImageButton ID="Image2" runat="server" CssClass="imageDataList1" CommandName="Click" CommandArgument='<%# Eval("material_id") + "," + Eval("material_filename") + "," + Eval("material_name") + "," + Eval("amount")  %>' ImageUrl='<%# Bind("material_filename", "~/materialColor_database/{0}.png") %>' />
                                    </div>
                                    <asp:Label ID="amount" runat="server" CssClass="amountDataList" Text='<%# Bind("amount", "{0} $") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                            <div class="extraSpace"></div>
                        </div>

                        <div class="leftDatalistBox2">
                            <asp:DataList ID="DataList3" runat="server" OnItemCommand="colorContainer" RepeatColumns="1" RepeatLayout="Flow" RepeatDirection="Vertical">
                                <ItemTemplate>
                                    <div class="imageCover">
                                        <asp:ImageButton ID="Image3" runat="server" CssClass="imageDataList1" CommandName="Click" CommandArgument='<%# Eval("color_id") + "," + Eval("color_filename") + "," + Eval("color_name") + "," + Eval("amount") %>' ImageUrl='<%# Bind("color_filename", "~/materialColor_database/{0}.png") %>' />
                                    </div>
                                    <asp:Label ID="amount" runat="server" CssClass="amountDataList" Text='<%# Bind("amount", "{0} $") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                            <div class="extraSpace"></div>
                        </div>

                        <%-------------------------------------------end of datalist----------------------------------------------%>
                    </section>
                </div>

            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="buyBtn" />
            </Triggers>
        </asp:UpdatePanel>

        <%-----------------------------------------------datasources------------------------------------------%>

        <asp:SqlDataSource ID="ChairBack" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="ChairHandrest" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="ChairSeat" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="ChairLeg" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="BedBack" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="BedMattress" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="BedLeg" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="material" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <asp:SqlDataSource ID="color" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

        <%--------------------------------------------end of datasources--------------------------------------%>

        <a href="publishParts.aspx" class="backNavigation">< Main Menu</a>

    </form>
</body>
</html>

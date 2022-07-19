<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="publishParts.aspx.cs" Inherits="publishParts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/publishParts.css"/>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="https://kit.fontawesome.com/ffb41c23b7.js" crossorigin="anonymous"></script> 
    <script type="text/javascript">
        function showpreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgpreview').css('visibility', 'visible');
                    $('#imgpreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="mainPage">
        <h1 class="mainTitle">Upload Components</h1>
        <hr />
            <asp:UpdatePanel ID="updatePanel1" runat="server">
                <ContentTemplate>
                    Select category : 
                    <asp:DropDownList
                        ID="Category"
                        runat="server" 
                        CssClass="dropdownStyle"
                        AutoPostBack="true">
                            <asp:ListItem>-- Select --</asp:ListItem>
                            <asp:ListItem>Chair</asp:ListItem>
                            <asp:ListItem>Bed</asp:ListItem>
                    </asp:DropDownList>

                    <br />
                    <%--dropdown list--%>
                    Select position : 
                    <asp:DropDownList
                        ID="partPosition"
                        runat="server" 
                        CssClass="dropdownStyle">
                            <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                            <asp:ListItem Value="Back">Back</asp:ListItem>
                            <asp:ListItem Value="Hand">Hand rest</asp:ListItem>
                            <asp:ListItem Value="Seat">Seat</asp:ListItem>
                            <asp:ListItem Value="Leg">Leg</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator
                        ID="partPositionValidate"
                        runat="server"
                        Display="Dynamic"
                        InitialValue="-1"
                        ControlToValidate="partPosition" 
                        SetFocusOnError="True" 
                        ValidationGroup="partDetails" 
                        ErrorMessage="Please select the position"
                        ForeColor="Red"/>

                    <asp:DropDownList
                        ID="partPosition2"
                        runat="server" 
                        CssClass="dropdownStyle"
                        visible="false">
                            <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                            <asp:ListItem Value="Back">Back</asp:ListItem>
                            <asp:ListItem Value="Mattress">Mattress</asp:ListItem>
                            <asp:ListItem Value="Leg">Leg</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator
                        ID="partPosition2Validate"
                        runat="server"
                        Display="Dynamic" 
                        InitialValue="-1"
                        ControlToValidate="partPosition2" 
                        SetFocusOnError="True" 
                        ValidationGroup="partDetails" 
                        ErrorMessage="Please select the position"
                        ForeColor="Red"/>
                    <br />
                    <br />
                    <asp:FileUpload 
                        ID="uploadImageBox" 
                        runat="server" 
                        onchange="showpreview(this);" 
                        CssClass="fileUpload" />
                    <asp:Label 
                        ID="requiredFIle"
                        runat="server"
                        ForeColor="Red" />
                    <br>
                    
                    <img id="imgpreview" src=""/>
                    
                    <br />
                    <%--part price--%>
                    Select price : 
                    <asp:TextBox 
                        ID="partPrice" 
                        runat="server" 
                        CssClass="partPriceStyle" 
                        MaxLength="8" 
                        TextMode="Number" /> $
                    <asp:RequiredFieldValidator
                        ID="RangeValidator1"
                        runat="server" 
                        ControlToValidate="partPrice" 
                        SetFocusOnError="True" 
                        ValidationGroup="partDetails" 
                        ErrorMessage="Please enter the price"
                        ForeColor="Red"/>
                    <asp:RangeValidator
                        ID="partPriceValidate"
                        runat="server" 
                        ControlToValidate="partPrice" 
                        SetFocusOnError="True" 
                        MaximumValue="99999999" 
                        MinimumValue="0"
                        ValidationGroup="partDetails" 
                        ErrorMessage="Only 8 character allowed"
                        ForeColor="Red"/>
                    <br />
                    <br />
                    <asp:Button 
                        ID="submitAll" 
                        runat="server" 
                        ValidationGroup="partDetails" 
                        OnClick="submitAll_Click" 
                        Text="Submit" 
                        CssClass="submitUploadBtn" />
                    <br />
                    <br />
                    <asp:Label 
                        ID="finalMessage" 
                        runat="server" 
                        ForeColor="Red" 
                        Font-Size="14px" />
                    <pre><img src="App_Themes/Default/images/warning.svg"></img> Prefered sizes are : Chair-Back (650 x 420)px                                 Bed-Back (800 x 300)px                                    Material (450 x 320)px
                                                     Chair-Handrest (650 x 300)px                       Bed-Mattress (800 x 220)px                           Color (450 x 320)px
                                                     Chair-Seat (600 x 75)px                                     Bed-Leg (800 x 330)px              
                                                     Chair-Leg (650 x 535)px
                    </pre>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="submitAll" />
                </Triggers>
            </asp:UpdatePanel>
    </div>
</asp:Content>  
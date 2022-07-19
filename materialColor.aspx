<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="materialColor.aspx.cs" Inherits="materialColor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/materialColor.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    <div class="masterPanel">
        <h1 class="mainTitle">Add Material & Color</h1>
        <hr />
        <div class="subMasterPanel">
            <asp:Wizard ID="wizard" runat="server" DisplaySideBar="false" CssClass="wizard">
                <WizardSteps>
                    <asp:WizardStep ID="wiz1" runat="server" StepType="Complete">
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                Select Category : 
                                <asp:DropDownList
                                    ID="matColDropdown"
                                    runat="server" 
                                    CssClass="dropdownStyle"
                                    AutoPostBack="true">
                                        <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                                        <asp:ListItem Value="Material">Material</asp:ListItem>
                                        <asp:ListItem Value="Color">Color</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator
                                    ID="matColDropdownValidate"
                                    runat="server" 
                                    InitialValue="-1"
                                    ControlToValidate="matColDropdown" 
                                    SetFocusOnError="True" 
                                    ErrorMessage="Please select the category"
                                    ForeColor="Red"/>
                                <br />
                                <br />
                                Enter Name : 
                                <asp:TextBox 
                                    ID="matColName" 
                                    runat="server" 
                                    CssClass="textBox" /> 
                                <asp:RequiredFieldValidator
                                    ID="requiredMatColName"
                                    runat="server" 
                                    ControlToValidate="matColName" 
                                    SetFocusOnError="True" 
                                    ErrorMessage="Please enter name"
                                    ForeColor="Red"/>
                                <br />
                                <br />
                                Enter Amount : 
                                <asp:TextBox 
                                    ID="matColAmount" 
                                    runat="server" 
                                    CssClass="textBox" /> $
                                <asp:RequiredFieldValidator
                                    ID="requiredMatColAmount"
                                    runat="server" 
                                    ControlToValidate="matColAmount" 
                                    SetFocusOnError="True" 
                                    ErrorMessage="Please enter amount"
                                    Display="Dynamic"
                                    ForeColor="Red"/>
                                <asp:RegularExpressionValidator
                                    ID="ExpressionAmountMatCol"
                                    runat="server" 
                                    ControlToValidate="matColAmount" 
                                    SetFocusOnError="True" 
                                    ValidationExpression="^\d{0,5}$"
                                    ErrorMessage="Only 5 numeric characters are allowed"
                                    ForeColor="Red"/>
                                <br />
                                <br />
                                <asp:FileUpload 
                                    ID="uploadImageBox" 
                                    runat="server" 
                                    onchange="showpreview(this);" 
                                    CssClass="fileUpload" />
                                <asp:Label
                                    ID="requiredFile" 
                                    ForeColor="Red"
                                    runat="server"
                                    Visible="false"/>
                                <br />
                                <img
                                    id="imgpreview" 
                                     src=""/>
                                <br />
                                <br />
                                <asp:Button
                                    ID="uploadMatCol" 
                                    runat="server"
                                    Text="Upload"
                                    CssClass="uploadMatCol"
                                    OnClick="uploadMatCol_Click"/>
                                <br />
                                <br />
                                <asp:Label
                                    ID="msgLabel" 
                                    ForeColor="Red"
                                    runat="server"
                                    Visible="false"/>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="uploadMatCol" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </asp:WizardStep>
                </WizardSteps>
            </asp:Wizard>
        </div>
    </div>
</asp:Content>


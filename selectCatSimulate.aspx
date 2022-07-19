<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="selectCatSimulate.aspx.cs" Inherits="selectCatSimulate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/publishParts.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="SimulateMasterBox">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <h1>Simulation</h1>
                <hr />
                <h3 class="subTitle">Select Simulation Category</h3>
                <asp:DropDownList
                    ID="chooseCategory"
                    runat="server"
                    CssClass="dropdownStyle"
                    AutoPostBack="true">
                    <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                    <asp:ListItem Value="Chair">Chair</asp:ListItem>
                    <asp:ListItem Value="Bed">Bed</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator
                    ID="simulateValidate"
                    runat="server"
                    InitialValue="-1"
                    ControlToValidate="chooseCategory"
                    SetFocusOnError="True"
                    ErrorMessage="Please select the category"
                    ForeColor="Red" />
                <br />
                <br />
                <asp:Button
                    ID="SimulateBtn"
                    runat="server"
                    Text="Simulate"
                    OnClick="SimulateBtn_Click"
                    CssClass="SimulateBtn" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="SimulateBtn" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>


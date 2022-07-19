<%@ Page Language="C#" AutoEventWireup="true" EnableViewStateMac="true" CodeFile="Billing.aspx.cs" Inherits="Billing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Simulator</title>
    <link rel="shortcut icon" href="App_Themes/Default/images/LogoFurnitureSimulator.png" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/Billing.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="updatePanel1" runat="server">
                <ContentTemplate>

                    <h1 class="titleBilling">Billing</h1>
                    <div class="billBox">
                        <div class="billFieldContainerName">
                            <asp:Label ID="customeNameLbl" runat="server" CssClass="label" Text="Customer name : "></asp:Label>
                            <asp:TextBox ID="customerNameText" CssClass="customerNameTextBill" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="validateName" runat="server" CausesValidation="true" ValidationGroup="billValidations" Display="Dynamic" ControlToValidate="customerNameText" ErrorMessage="Please enter name" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <div class="billFieldContainerEmail">
                            <asp:Label ID="emailLbl" runat="server" CssClass="label" Text="Email Address : "></asp:Label>
                            <asp:TextBox ID="emailText" CausesValidation="true" CssClass="emailTextBill" TextMode="Email" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="validateEmail" runat="server" ErrorMessage="Enter valid email" ControlToValidate="emailText" ForeColor="Red" Display="Dynamic" ValidationGroup="billValidations" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>

                        <div class="billFieldContainer">
                            <asp:Label ID="customerAddressLbl" runat="server" CssClass="label" Text="Address : "></asp:Label>
                            <asp:TextBox ID="customerAddressText" CssClass="customerAddressTextBill" runat="server"></asp:TextBox>
                        </div>

                        <div class="billFieldContainerPhone">
                            <asp:Label ID="phoneLbl" runat="server" CssClass="label" Text="Phone : "></asp:Label>
                            <asp:TextBox ID="phoneText" TextMode="number" CssClass="phoneTextBill" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="validatePhone" runat="server" ControlToValidate="phoneText" ErrorMessage="Enter valid phone" ValidationExpression="\d{10}" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="billFieldContainerAmount">
                            <asp:Label ID="amountLbl" runat="server" CssClass="label" Text="Amount : "></asp:Label>
                            <asp:TextBox ID="amountText" TextMode="Number" CssClass="number" runat="server"></asp:TextBox>$
                    <asp:RangeValidator ID="validateAmount" CausesValidation="true" runat="server" MaximumValue="99999" ValidationGroup="billValidations" ControlToValidate="amountText" Type="Integer" MinimumValue="0" ErrorMessage="Max amount is 99999" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RangeValidator>
                        </div>

                        <br />

                        <div class="billFieldContainerPurchaseDate">
                            <asp:Label ID="purchaseDateLbl" runat="server" CssClass="label" Text="Purchase Date : "></asp:Label>
                            <asp:TextBox ID="purchaseDateText" TextMode="Date" runat="server"></asp:TextBox>
                        </div>

                        <div class="billFieldContainerShippingDate">
                            <asp:Label ID="ShippingDateLbl" runat="server" CssClass="label" Text="Shipping Date : "></asp:Label>
                            <asp:TextBox ID="ShippingDateText" TextMode="Date" runat="server"></asp:TextBox>
                        </div>


                        <div class="billFieldContainerBtn">
                            <asp:Button ID="purchase" runat="server" Text="Purchase" ValidationGroup="billValidations" CssClass="purchase" OnClick="purchase_Click" />
                            <asp:Button ID="Back" runat="server" Text="Back" CssClass="purchase" UseSubmitBehavior="false" CausesValidation="false" OnClick="back_Click" /><br />
                            <asp:Label ID="message" runat="server" ForeColor="Red" CssClass="message"></asp:Label>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="Back" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>

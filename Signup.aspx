<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Simulator</title>
    <link rel="shortcut icon" href="App_Themes/Default/images/LogoFurnitureSimulator.png" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link type="text/css" rel="stylesheet" href="App_Themes/Default/stylesheets/Signup.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scrManager" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <div class="backgroundImg" runat="server" id="backgroundImg">
                    <div class="mainContainer">
                        <div class="leftSubContainer">
                            <div class="mainLogo">
                                <div class="subMainLogo">
                                    <img src="App_Themes/Default/images/LogoFurnitureSimulator.png">
                                    <p>Furniture Simulator</p>
                                </div>
                            </div>
                            <div class="creditBehance">
                                <img src="App_Themes/Default/images/icon-behnace.png">
                                <p>Behance Inc.</p>
                            </div>
                        </div>
                        <div class="rightSubContainer">
                            <div class="contentBox">
                                <section class="subContentBox">
                                    <div class="SignInTitle">
                                        <h2>Sign up</h2>
                                        <p>Already have an account?</p>
                                        <a href="Signin.aspx">Sign in</a>
                                    </div>
                                    <div class="controlsBox">

                                        <!--First Name-->
                                        <div class="FirstNameText">
                                            <p>First Name</p>
                                            <asp:TextBox
                                                ID="firstname"
                                                runat="server"
                                                ValidateRequestMode="Enabled"
                                                ViewStateMode="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="firstname_required"
                                                runat="server"
                                                CssClass="halfValidation"
                                                ControlToValidate="firstname"
                                                ErrorMessage="Enter first name"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                        </div>

                                        <!--Last Name-->
                                        <div class="LastNameText">
                                            <p>Last Name</p>
                                            <asp:TextBox
                                                ID="lastname"
                                                runat="server"
                                                ValidateRequestMode="Enabled"
                                                ViewStateMode="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="lastname_required"
                                                runat="server"
                                                CssClass="halfValidation"
                                                ControlToValidate="lastname"
                                                ErrorMessage="Enter last name"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                        </div>

                                        <!--Email-->
                                        <div class="emailText">
                                            <p>Email Address</p>
                                            <asp:TextBox
                                                ID="email"
                                                runat="server"
                                                ValidateRequestMode="Enabled"
                                                ViewStateMode="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="email_required"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="email"
                                                ErrorMessage="Enter email"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                            <asp:RegularExpressionValidator
                                                ID="email_expression"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="email"
                                                ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                                                ErrorMessage="Enter valid email"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                        </div>

                                        <!--Phone no-->
                                        <div class="phoneText">
                                            <p>Phone no</p>
                                            <asp:TextBox
                                                ID="phone_no"
                                                runat="server"
                                                ValidateRequestMode="Enabled"
                                                MaxLength="10"
                                                ViewStateMode="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="phone_required"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="phone_no"
                                                ErrorMessage="Enter phone no."
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                            <asp:RegularExpressionValidator
                                                ID="phone_expression"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="phone_no"
                                                ValidationExpression="\d{10}"
                                                ErrorMessage="Enter valid phone no."
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                        </div>

                                        <!--Password-->
                                        <div class="passText">
                                            <p>Password</p>
                                            <asp:TextBox
                                                ID="passcode"
                                                runat="server"
                                                ValidateRequestMode="Enabled"
                                                TextMode="Password"
                                                ViewStateMode="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="passcode_required"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="passcode"
                                                ErrorMessage="Enter passcode"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                        </div>

                                        <!--Confirm Password-->
                                        <div class="confPassText">
                                            <p>Confirm Password</p>
                                            <asp:TextBox
                                                ID="c_passcode"
                                                runat="server"
                                                ValidateRequestMode="Enabled"
                                                TextMode="Password"
                                                ViewStateMode="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="confirmpasscode_required"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="c_passcode"
                                                ErrorMessage="confirm passcode"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                            <asp:CompareValidator
                                                ID="compare_passcode"
                                                runat="server"
                                                CssClass="validation"
                                                ControlToValidate="c_passcode"
                                                ControlToCompare="passcode"
                                                ErrorMessage="passcode did not match"
                                                Operator="Equal"
                                                Type="String"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                        </div>
                                        <div class="mainValidation">
                                            <asp:Label
                                                ID="warning"
                                                runat="server"
                                                EnableViewState="False"
                                                ForeColor="Red" />
                                        </div>
                                        <asp:Button ID="submit_btn" runat="server" Text="Submit" CausesValidation="true" OnClick="submit_btn_Click" />
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>

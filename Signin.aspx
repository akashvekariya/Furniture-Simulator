<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signin.aspx.cs" Inherits="Signin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Simulator</title>
    <link rel="shortcut icon" href="App_Themes/Default/images/LogoFurnitureSimulator.png" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link type="text/css" rel="stylesheet" href="App_Themes/Default/stylesheets/SignIn.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
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

                                        <%-----------------------------------wizard 1 (login)-----------------------------------------%>

                                        <asp:Wizard ID="wizard" runat="server" DisplaySideBar="false" CssClass="wizardSignin">
                                            <WizardSteps>

                                                <asp:WizardStep ID="wiz1" StepType="Complete">
                                                    <div class="SignInTitle">
                                                        <h2>Sign in</h2>
                                                        <p>New user?</p>
                                                        <a href="Signup.aspx">Create an account</a>
                                                    </div>
                                                    <div class="controlsBox">
                                                        <div class="emailText">
                                                            <p>Email address</p>
                                                            <asp:TextBox
                                                                ID="email"
                                                                runat="server"
                                                                CausesValidation="true"
                                                                spellcheck="false"
                                                                ViewStateMode="Disabled" />
                                                            <asp:RequiredFieldValidator
                                                                ID="email_required"
                                                                CssClass="validation"
                                                                runat="server"
                                                                ControlToValidate="email"
                                                                ErrorMessage="Enter email"
                                                                SetFocusOnError="True"
                                                                ForeColor="Red"
                                                                Display="Dynamic" />
                                                            <asp:RegularExpressionValidator
                                                                ID="email_expression"
                                                                CssClass="validation"
                                                                runat="server"
                                                                ControlToValidate="email"
                                                                ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                                                                ErrorMessage="Enter valid email"
                                                                SetFocusOnError="True"
                                                                ForeColor="Red"
                                                                Display="Dynamic" />
                                                        </div>
                                                        <div class="passText">
                                                            <p>Password</p>
                                                            <asp:TextBox
                                                                ID="passcode"
                                                                runat="server"
                                                                TextMode="Password"
                                                                spellcheck="false"
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
                                                            <div class="mainValidation">
                                                                <asp:Label
                                                                    ID="warning"
                                                                    runat="server"
                                                                    EnableViewState="False"
                                                                    ForeColor="Red" />
                                                            </div>
                                                        </div>
                                                        <asp:LinkButton
                                                            ID="forgetPassword"
                                                            runat="server"
                                                            OnClick="forgetPassword_Click"
                                                            Text="Forgot password?"
                                                            CssClass="forgetPassword" />
                                                        <br />
                                                        <br />
                                                        <asp:Button
                                                            ID="login"
                                                            runat="server"
                                                            Text="Log In"
                                                            OnClick="login_Click" />
                                                    </div>
                                                </asp:WizardStep>

                                                <%-------------------------------------wizard 2 (enter email)--------------------------------------------%>

                                                <asp:WizardStep ID="wiz2" StepType="Complete">
                                                    <div class="findEmailBox">
                                                        <h2>Enter your email</h2>

                                                        <div class="marginSignin">
                                                            <asp:TextBox
                                                                ID="findEmail"
                                                                runat="server"
                                                                CssClass="findEmail" />
                                                            <asp:RequiredFieldValidator
                                                                ID="requiredFindEmail"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ControlToValidate="findEmail"
                                                                ErrorMessage="Please enter email"
                                                                Display="Dynamic" />
                                                            <asp:RegularExpressionValidator
                                                                ID="expressionFindEmail"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                                                                ControlToValidate="findEmail"
                                                                ErrorMessage="Enter valid email address"
                                                                Display="Dynamic" />

                                                            <p class="instructionEmail">Enter your email address which you use in application, you will receive an OTP on that email by which you can reset your password. :)</p>

                                                            <br />
                                                            <br />
                                                            <asp:Label ID="msgFindEmail" runat="server" ForeColor="Red" Visible="false"></asp:Label>

                                                            <div class="findEmailBtnBox">
                                                                <asp:Button
                                                                    ID="cancelFindEmail"
                                                                    runat="server"
                                                                    Text="Cancel"
                                                                    CssClass="cancelFindEmail"
                                                                    OnClick="cancelFindEmail_Click"
                                                                    UseSubmitBehavior="false"
                                                                    CausesValidation="false" />
                                                                <asp:Button
                                                                    ID="continueWiz2FindEmail"
                                                                    runat="server"
                                                                    CssClass="continueWiz2FindEmail"
                                                                    OnClick="continueWiz2FindEmail_Click"
                                                                    Text="Continue"
                                                                    UseSubmitBehavior="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:WizardStep>

                                                <%-------------------------------------wizard 3 (enter OTP)--------------------------------------------%>

                                                <asp:WizardStep ID="wiz3" StepType="Complete">
                                                    <div class="findEmailBox">
                                                        <h2>Enter OTP</h2>

                                                        <div class="marginSignin">
                                                            <asp:TextBox
                                                                ID="otpTextBox"
                                                                runat="server"
                                                                Font-Size="20px"
                                                                TextMode="Number"
                                                                CssClass="findEmail" />
                                                            <asp:RequiredFieldValidator
                                                                ID="validateOTP"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ControlToValidate="otpTextBox"
                                                                ErrorMessage="Please enter OTP"
                                                                Display="Dynamic" />
                                                            <asp:RegularExpressionValidator
                                                                ID="expressionOTP"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ValidationExpression="\d{6}"
                                                                ControlToValidate="otpTextBox"
                                                                ErrorMessage="Enter valid OTP"
                                                                Display="Dynamic" />

                                                            <p class="instructionEmail">Enter OTP that is sent to your email.
                                                                <br />
                                                                By entering valid OTP you will be able to reset your account password :)</p>

                                                            <br />
                                                            <br />
                                                            <asp:Label ID="msgOTPbox" runat="server" ForeColor="Red" Visible="false"></asp:Label>

                                                            <div class="findEmailBtnBox">
                                                                <asp:Button
                                                                    ID="backOTP"
                                                                    runat="server"
                                                                    Text="Back"
                                                                    CssClass="cancelFindEmail"
                                                                    OnClick="backOTP_Click"
                                                                    UseSubmitBehavior="false"
                                                                    CausesValidation="false" />
                                                                <asp:Button
                                                                    ID="continueOTP"
                                                                    runat="server"
                                                                    CssClass="continueWiz2FindEmail"
                                                                    OnClick="continueWiz3FOTP_Click"
                                                                    Text="Continue"
                                                                    UseSubmitBehavior="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:WizardStep>

                                                <%-------------------------------------wizard 3 (Reset password)--------------------------------------------%>

                                                <asp:WizardStep ID="wiz4" StepType="Complete">
                                                    <div class="findEmailBox">
                                                        <h2>Reset password</h2>

                                                        <div class="marginSignin">
                                                            <p class="lastWizP">Enter new-password</p>
                                                            <asp:TextBox
                                                                ID="pass1resetPass"
                                                                runat="server"
                                                                TextMode="Password"
                                                                CssClass="resetPass1" />
                                                            <asp:RequiredFieldValidator
                                                                ID="validatepass1resetPass"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ControlToValidate="pass1resetPass"
                                                                ErrorMessage="Please enter new-password"
                                                                Display="Dynamic" />
                                                            <br />
                                                            <p class="lastWizP">Confirm password</p>
                                                            <asp:TextBox
                                                                ID="pass2resetPass"
                                                                runat="server"
                                                                TextMode="Password"
                                                                CssClass="resetPass2" />
                                                            <asp:RequiredFieldValidator
                                                                ID="validatepass2resetPass"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ControlToValidate="pass2resetPass"
                                                                ErrorMessage="Please confirm password"
                                                                Display="Dynamic" />
                                                            <asp:CompareValidator
                                                                ID="compareResetPass"
                                                                runat="server"
                                                                CssClass="validation"
                                                                ForeColor="Red"
                                                                SetFocusOnError="true"
                                                                ControlToValidate="pass2resetPass"
                                                                ControlToCompare="pass1resetPass"
                                                                ErrorMessage="Password did not match"
                                                                Display="Dynamic" />


                                                            <p class="instructionEmail">From now you have to sign in using this new password :)</p>

                                                            <br />
                                                            <br />
                                                            <asp:Label ID="msgResetPass" runat="server" ForeColor="Red" Visible="false"></asp:Label>

                                                            <div class="findEmailBtnBox">
                                                                <asp:Button
                                                                    ID="cancelResetPass"
                                                                    runat="server"
                                                                    Text="Back"
                                                                    CssClass="cancelFindEmail"
                                                                    OnClick="cancelResetPass_Click"
                                                                    UseSubmitBehavior="false"
                                                                    CausesValidation="false" />
                                                                <asp:Button
                                                                    ID="continueResetPass"
                                                                    runat="server"
                                                                    CssClass="continueWiz2FindEmail"
                                                                    OnClick="continueResetPass_Click"
                                                                    Text="Update"
                                                                    UseSubmitBehavior="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:WizardStep>

                                            </WizardSteps>
                                        </asp:Wizard>

                                        <%-----------------------------------end of wizard---------------------------------------------%>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>

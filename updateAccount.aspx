<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="updateAccount.aspx.cs" Inherits="updateAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/updateAccount.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="updatePane">
        <h1 class="mainTitle">Update Account</h1>
        <hr />

        <asp:Wizard ID="wizard" runat="server" DisplaySideBar="false" CssClass="wizard">
            <WizardSteps>
                <asp:WizardStep ID="wiz1" StepType="Complete">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="wiz1Pass">
                                <asp:Panel ID="panel1" runat="server" DefaultButton="nextWiz" autocomplete="off">
                                    <asp:Label ID="currentPass" runat="server" Text="Enter Current Password"></asp:Label>
                                    <asp:TextBox ID="currentPassText" runat="server" TextMode="Password"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="requiredCurrentPass" runat="server" ControlToValidate="currentPassText" ErrorMessage="Enter password first" ForeColor="Red" Display="Dynamic" />
                                    <asp:Label ID="wiz1Warning" runat="server" Visible="false" CssClass="wiz1Warning" ForeColor="Red" />
                                    <br />
                                    <asp:Button ID="nextWiz" runat="server" CssClass="wiz1Button" UseSubmitBehavior="true" Text="Continue" OnClick="continue_Click" />
                                </asp:Panel>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="nextWiz" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:WizardStep>
                <asp:WizardStep ID="wiz2" StepType="Complete">
                    <asp:UpdatePanel ID="updatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="panel2" runat="server" DefaultButton="update" autocomplete="off">
                                <div class="updateControlsPane" runat="server" id="updateControlsPane">
                                    <%--first name--%>
                                    <div class="inlineBox1">
                                        <div class="firstNameUpdate">
                                            <h6>First Name</h6>
                                            <asp:Label ID="firstNameLabel" runat="server"></asp:Label>
                                            <asp:TextBox
                                                ID="firstName"
                                                runat="server"
                                                autocomplete="off"
                                                AutoCompleteType="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="firstname_required"
                                                runat="server"
                                                CssClass="halfValidation"
                                                ControlToValidate="firstName"
                                                ErrorMessage="Enter first name"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                            <asp:Label ID="currentFirstName" runat="server"></asp:Label>
                                        </div>
                                    </div>

                                    <%--last name--%>
                                    <div class="inlineBox2">
                                        <div class="lastNameUpdate">
                                            <h6>Last Name</h6>
                                            <asp:Label ID="lastNameLabel" runat="server"></asp:Label>
                                            <asp:TextBox
                                                ID="lastName"
                                                runat="server"
                                                autocomplete="off"
                                                AutoCompleteType="Disabled" />
                                            <asp:RequiredFieldValidator
                                                ID="lastname_required"
                                                runat="server"
                                                CssClass="halfValidation"
                                                ControlToValidate="lastName"
                                                ErrorMessage="Enter last name"
                                                SetFocusOnError="True"
                                                ForeColor="Red"
                                                Display="Dynamic" />
                                            <asp:Label ID="currentLastName" runat="server"></asp:Label>
                                        </div>
                                    </div>

                                    <%--email--%>
                                    <div class="emailUpdate">
                                        <h6>Email Address</h6>
                                        <asp:Label ID="emailLabel" runat="server"></asp:Label>
                                        <asp:TextBox
                                            ID="email"
                                            runat="server"
                                            autocomplete="off"
                                            AutoCompleteType="Disabled" />
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
                                            ID="validateEmail"
                                            runat="server"
                                            CssClass="validation"
                                            ControlToValidate="Email"
                                            ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                                            ErrorMessage="Enter valid email"
                                            ForeColor="Red"
                                            ViewStateMode="Disabled"
                                            Display="Dynamic"
                                            EnableViewState="False" />
                                        <asp:Label ID="currentEmail" runat="server"></asp:Label>
                                    </div>

                                    <%--phone_no--%>
                                    <div class="phoneUpdate">
                                        <h6>Phone no.</h6>
                                        <asp:Label ID="phoneLabel" runat="server"></asp:Label>
                                        <asp:TextBox
                                            ID="Phone"
                                            runat="server"
                                            autocomplete="nope"
                                            AutoCompleteType="Disabled" />
                                        <asp:RequiredFieldValidator
                                            ID="phone_required"
                                            runat="server"
                                            CssClass="validation"
                                            ControlToValidate="Phone"
                                            ErrorMessage="Enter phone no."
                                            SetFocusOnError="True"
                                            ForeColor="Red"
                                            Display="Dynamic" />
                                        <asp:RegularExpressionValidator
                                            ID="phone_expression"
                                            runat="server"
                                            CssClass="validation"
                                            ControlToValidate="Phone"
                                            ValidationExpression="\d{10}"
                                            ErrorMessage="Enter valid phone no."
                                            SetFocusOnError="True"
                                            ForeColor="Red"
                                            Display="Dynamic" />
                                        <asp:Label ID="currentPhone" runat="server"></asp:Label>
                                    </div>

                                    <%--password--%>
                                    <div class="passwordUpdate">
                                        <h6>Password</h6>
                                        <asp:TextBox
                                            ID="password"
                                            runat="server"
                                            TextMode="Password"
                                            autocomplete="new-password"
                                            AutoCompleteType="Disabled" />
                                        <asp:RequiredFieldValidator
                                            ID="passcode_required"
                                            runat="server"
                                            CssClass="validation"
                                            ControlToValidate="password"
                                            ErrorMessage="Enter password"
                                            SetFocusOnError="True"
                                            ForeColor="Red"
                                            Display="Dynamic" />
                                        <asp:Label ID="currentPassword" runat="server"></asp:Label>
                                    </div>

                                    <%--last updated Date--%>
                                    <asp:Label ID="updatedDate" runat="server" CssClass="updateDate"></asp:Label>

                                    <%--update button--%>
                                    <asp:Button ID="update" CssClass="finalUpdateButton" OnClick="update_Click" runat="server" Text="Update" />
                                    <br />
                                    <asp:Label ID="messageUpdate" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="update" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:WizardStep>
            </WizardSteps>
        </asp:Wizard>

    </div>

</asp:Content>


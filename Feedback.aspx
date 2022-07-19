<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/Feedback.css" />
    <script src="https://kit.fontawesome.com/ffb41c23b7.js" crossorigin="anonymous"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>

            <div class="MainBoxFB">
                <h1 class="titleFB">Feedback</h1>
                <hr />

                Description :<br />
                <asp:TextBox
                    ID="feedbackText"
                    TextMode="MultiLine"
                    runat="server"
                    CssClass="feedbackText" />
                <br />
                <asp:RequiredFieldValidator
                    ID="validateFeedback"
                    runat="server"
                    Display="Dynamic"
                    ControlToValidate="feedbackText"
                    ErrorMessage="Please enter feedback"
                    ForeColor="Red"
                    SetFocusOnError="true" />

                <br />
                <asp:FileUpload
                    ID="fileUpload"
                    runat="server"
                    onchange="showpreview(this);"
                    CssClass="fileUploadFB" />
                <asp:Label
                    ID="requiredFile"
                    runat="server"
                    Visible="false"
                    ForeColor="Red" />

                <br />
                <asp:Button ID="submitFB" OnClick="submitFB_Click" runat="server" Text="Submit" CssClass="submitFB" />
                <br />
                <asp:Label ID="msgFB" runat="server" Visible="false" ForeColor="Red" />
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="submitFB" />
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>


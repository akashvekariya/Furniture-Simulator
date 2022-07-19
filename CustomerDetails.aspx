<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CustomerDetails.aspx.cs" Inherits="CustomerDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/CustomerDetails.css" />
    <script src="https://kit.fontawesome.com/ffb41c23b7.js" crossorigin="anonymous"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>

            <div class="MainPanelCD">
                <%-----------------------------------------title-------------------------------------------%>

                <h1 class="titleCD">Customer Details</h1>
                <hr />
                <div class="ContentPanelCD">

                    <div class="DatalistCD">
                        <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" OnItemDataBound="changeColor_order" OnItemCommand="orderComplete_Click" RepeatLayout="Flow" RepeatDirection="Vertical">
                            <ItemTemplate>
                                <div class="hoverCoverCD">
                                    <asp:Panel ID="colorStatus" runat="server" CssClass="dataBoxCoverCD">
                                        <div class="chairImageBoxCD">
                                            <div class="subChairImageBoxCD">
                                                <asp:Image ID="productImage" runat="server" CssClass="imageSize" ImageUrl='<%# Bind("product_filename", "~/simulation_database/{0}.png") %>' />
                                            </div>
                                        </div>
                                        <asp:LinkButton runat="server" ID="orderComplete" CssClass="addIcon" Text="Order Complete" CommandName="complete" CommandArgument='<%# Eval("purchase_id") %>' />
                                        <asp:LinkButton runat="server" ID="orderIncomplete" CssClass="revokeIcon" Text="Revoke Order" Visible="false" CommandName="revoke" CommandArgument='<%# Eval("purchase_id") %>' />
                                        <asp:HiddenField ID="orderStatus" runat="server" Value='<%# Eval("order_complete") %>' />

                                        <div class="detailBoxCD">
                                            <div class="inlineD-box">
                                                <span class="badge">Name:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_name" CssClass="badgeValue" Text='<%# Bind("customer_name") %>'></asp:Label>
                                                </span>
                                            </div>

                                            <span class="inlineD-box">
                                                <span class="badge">Email:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_email" CssClass="badgeValue" Text='<%# Bind("email") %>'></asp:Label>
                                                </span>
                                            </span>

                                            <span class="inlineD-box">
                                                <span class="badge">Phone:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_phone" CssClass="badgeValue" Text='<%# Bind("phone") %>'></asp:Label>
                                                </span>
                                            </span>

                                            <div class="address-box">
                                                <span class="badge">Address:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_address" CssClass="badgeValue" Text='<%# Bind("customer_address") %>'></asp:Label>
                                                </span>
                                            </div>

                                            <div class="address-box">
                                                <span class="badge">Amount:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_amount" CssClass="badgeValue" Text='<%# Bind("total_amount") %>'></asp:Label>
                                                </span>
                                            </div>

                                            <span class="inlineD-box">
                                                <span class="badge">Purchase date:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_purchase" CssClass="badgeValue" Text='<%# Bind("purchase_date") %>'></asp:Label>
                                                </span>
                                            </span>

                                            <span class="inlineD-box">
                                                <span class="badge">Shipping date:</span>
                                                <span>
                                                    <asp:Label runat="server" ID="customer_badge_shipping" CssClass="badgeValue" Text='<%# Bind("shipping_date") %>'></asp:Label>
                                                </span>
                                            </span>

                                            <div class="address-box">
                                                <span class="inlineD-box">
                                                    <span class="badge">Material:</span>
                                                    <span>
                                                        <asp:Label runat="server" ID="customer_badge_material" CssClass="badgeValue" Text='<%# Bind("material_name") %>'></asp:Label>
                                                        <span class="tinyImageCover">
                                                            <asp:Image ID="material_image" runat="server" onerror="this.style.display='none'" CssClass="tinyImage" ImageUrl='<%# Bind("material_filename", "~/materialColor_database/{0}.png") %>' />
                                                        </span>
                                                    </span>
                                                </span>

                                                <span class="inlineD-box">
                                                    <span class="badge">Color:</span>
                                                    <span>
                                                        <asp:Label runat="server" ID="customer_badge_color" CssClass="badgeValue" Text='<%# Bind("color_name") %>'></asp:Label>

                                                        <span class="tinyImageCover">
                                                            <asp:Image ID="color_image" onerror="this.style.display='none'" runat="server" CssClass="tinyImage" ImageUrl='<%# Bind("color_filename", "~/materialColor_database/{0}.png") %>' />
                                                        </span>
                                                    </span>
                                                </span>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <div class="extraSpace"></div>
                    </div>

                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="DataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

</asp:Content>


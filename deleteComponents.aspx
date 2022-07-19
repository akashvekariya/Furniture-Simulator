<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="deleteComponents.aspx.cs" Inherits="deleteComponents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="App_Themes/Default/stylesheets/deleteComponents.css" />
    <script src="https://kit.fontawesome.com/ffb41c23b7.js" crossorigin="anonymous"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <div class="mainPanelDel">
                <h1 class="mainTitle">Delete Components</h1>
                <hr />
                <div class="subPanel">

                    <%----------------------------------------------------data list----------------------------------------------------%>
                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Chair Back</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList1" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Chair Hand-rest</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList2" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Chair Seat</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList3" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Chair Leg</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList4" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>


                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Bed Back</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList5" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Bed Mattress</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList6" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Bed Leg</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList7" runat="server" OnItemCommand="deletePart" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("part_filename", "~/Parts_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("part_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>

                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Material</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList8" runat="server" OnItemCommand="deleteMaterial" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("material_filename", "~/materialColor_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("material_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>

                    <div class="deleteComponentDatalist">
                        <h2 class="subTitle">Color</h2>
                        <div class="datalistCover">
                            <asp:DataList ID="DataList9" runat="server" OnItemCommand="deleteColor" RepeatColumns="5" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <div class="itemBox">
                                        <asp:Image ID="image" runat="server" CssClass="deleteComponentImg" ImageUrl='<%# Bind("color_filename", "~/materialColor_database/{0}.png")%>' />
                                        <asp:Button ID="deleteComponent" runat="server" Text="Delete" CommandName="Click" CssClass="deleteComponentBtn" CommandArgument='<%# Eval("color_filename")%>' />
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                    <%----------------------------------------------end of data list----------------------------------------------------%>

                    <div class="useless"></div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-----------------------------------------------data sources-------------------------------------------------%>

    <asp:SqlDataSource ID="ChairBackSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="ChairHandrestSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="ChairSeatSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="ChairLegSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="BedBackSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="BedMattressSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="BedLegSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="materialSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <asp:SqlDataSource ID="colorSrc" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" />

    <%------------------------------------------end of Data sources---------------------------------------------%>
</asp:Content>


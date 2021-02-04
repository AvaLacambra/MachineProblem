<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewAnnouncements.aspx.cs" Inherits="Machine_Problem.master.WebForm11" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(function () {
            $(".announcementsView").DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top:30px; margin-bottom:70px;">
        <div class ="jumbotron">
            <div class="row justify-content-center">
                <h1>View Announcements</h1>
            </div>
            <hr />
            <div class="row justify-content-center">
                <asp:Button ID="btnAddAnnouncement" runat="server" Text="Add Announcement" class="btn btn-primary" OnClick="btnAddAnnouncement_Click"/>
            </div>
            <div class="container table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="announceID" DataSourceID="announcements" CssClass="announcementsView table table-hover" OnRowCommand="GridView1_OnRowCommand">
                    <Columns>
                        <asp:BoundField DataField="announceTitle" HeaderText="Title" SortExpression="announceTitle" />
                        <asp:BoundField DataField="announceText" HeaderText="Text" SortExpression="announceText" />
                        <asp:BoundField DataField="announceDatePosted" HeaderText="Date Posted" SortExpression="announceDatePosted" DataFormatString="{0:dd/MM/yyyy}" htmlencode="false"/>
                        <asp:TemplateField HeaderText = "Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CausesValidation="false" CommandName="EditAnnouncement"
                                    Text="Edit" CommandArgument='<%# Eval("announceID") %>' />
                                <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteAnnouncement"
                                    Text="Delete" CommandArgument='<%# Eval("announceID") %>' 
                                    onclientclick="return confirm('Are you sure you want to delete this announcement?');"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="announcements" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT [announceID], [announceTitle], [announceText], [announceDatePosted] FROM [Announcements]"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

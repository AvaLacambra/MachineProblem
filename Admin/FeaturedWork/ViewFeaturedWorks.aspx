<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewFeaturedWorks.aspx.cs" Inherits="Machine_Problem.master.WebForm14" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
    </style>

    <!-- Data Tables CSS -->
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" />

    <!-- jQuery Data Tables CDN -->
    <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js" type="text/javascript" charset="utf8"></script>

    <script type="text/javascript">
        $(function () {
            $(".featuredWorksView").DataTable();
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top:30px; margin-bottom:70px;">
        <div class ="jumbotron">
            <div class="text-center">
                <strong>
                <asp:Label ID="featuredWorksHeader" runat="server" Text="View Featured Works" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
                <asp:Button ID="btnAddFeaturedWork" runat="server" Text="Add Featured Work" class="btn btn-primary" OnClick="btnAddFeaturedWork_Click"/>
            </div>
            <div class="container table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="featuredWorks" CssClass="featuredWorksView table table-hover" OnRowCommand="GridView1_OnRowCommand">
                    <Columns>
                        <asp:BoundField DataField="featuredTitle" HeaderText="Title" SortExpression="featuredTitle" />
                        <asp:BoundField DataField="featuredDesc" HeaderText="Text" SortExpression="featuredDesc" />
                        <asp:BoundField DataField="featuredDatePosted" HeaderText="Date Posted" SortExpression="featuredDatePosted" DataFormatString="{0:dd/MM/yyyy}" htmlencode="false"/>
                        <asp:TemplateField HeaderText = "Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CausesValidation="false" CommandName="EditFeaturedWork"
                                    Text="Edit" CommandArgument='<%# Eval("featuredWorkID") %>' />
                                <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteFeaturedWork"
                                    Text="Delete" CommandArgument='<%# Eval("featuredWorkID") %>' 
                                    onclientclick="return confirm('Are you sure you want to delete this featured work?');"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="featuredWorks" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT [featuredWorkID], [featuredTitle], [featuredDesc], [featuredDatePosted] FROM [FeaturedWorks]"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

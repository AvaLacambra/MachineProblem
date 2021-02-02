<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewNewsEvents.aspx.cs" Inherits="Machine_Problem.master.WebForm18" %>
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
            $(".newsEventsView").DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top:30px; margin-bottom:70px;">
        <div class ="jumbotron">
            <div class="text-center">
                <strong>
                <asp:Label ID="lblHeader" runat="server" Text="View News and Events" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
                <asp:Button ID="btnAddNewsEvent" runat="server" Text="Add News and Event" class="btn btn-primary" OnClick="btnAddNewsEvent_Click" />
            </div>
            <div class="container table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="newsEventsID" DataSourceID="newsEvents" CssClass="newsEventsView table table-hover" OnRowCommand="GridView1_OnRowCommand">
                    <Columns>
                        <asp:BoundField DataField="newsEventsTitle" HeaderText="Title" SortExpression="newsEventsTitle" />
                        <asp:BoundField DataField="newsEventsDesc" HeaderText="Text" SortExpression="newsEventsDesc" />
                        <asp:BoundField DataField="newsEventsDatePosted" HeaderText="Date Posted" SortExpression="newsEventsDatePosted" DataFormatString="{0:dd/MM/yyyy}" htmlencode="false"/>
                        <asp:TemplateField HeaderText = "Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CausesValidation="false" CommandName="EditNewsEvent"
                                    Text="Edit" CommandArgument='<%# Eval("newsEventsID") %>' />
                                <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteNewsEvent"
                                    Text="Delete" CommandArgument='<%# Eval("newsEventsID") %>' 
                                    onclientclick="return confirm('Are you sure you want to delete this news or event?');"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="newsEvents" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT [newsEventsID], [newsEventsTitle], [newsEventsDesc], [newsEventsDatePosted] FROM [NewsEvents]"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

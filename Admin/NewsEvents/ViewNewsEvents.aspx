<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewNewsEvents.aspx.cs" Inherits="Machine_Problem.master.WebForm18" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(function () {
            $(".newsEventsView").DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top:30px; margin-bottom:70px;">
        <div class ="jumbotron">
            <div class="row justify-content-center">
                <h1>View News and Events</h1>
            </div>
            <hr />
            <div class="row justify-content-center">
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

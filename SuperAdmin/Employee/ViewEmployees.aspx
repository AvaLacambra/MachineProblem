<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewEmployees.aspx.cs" Inherits="Machine_Problem.master.WebForm5" %>
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
            $(".employees").DataTable();
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top:30px; margin-bottom:70px;">
        <div class ="jumbotron">
            <div class="text-center">
                <strong>
                <asp:Label ID="lblHeader" runat="server" Text="View Employees" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
                <asp:Button ID="btnAddNewEmployee" runat="server" Text="Add Employee" class="btn btn-primary" OnClick="btnAddNewEmployee_Click"/>
            </div>
            <div class="container-fluid">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="employees" CssClass="employees" OnRowCommand="GridView1_OnRowCommand">
                     <Columns>
                        <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                        <asp:BoundField DataField="lastname" HeaderText="Last Name" SortExpression="lastname" />
                        <asp:BoundField DataField="middleI" HeaderText="Middle Initial" SortExpression="middleI" />
                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                        <asp:BoundField DataField="dateEmployed" HeaderText="Date Employed" SortExpression="dateEmployed" DataFormatString="{0:dd/MM/yyyy}"/>
                        <asp:BoundField DataField="roleName" HeaderText="Role" SortExpression="roleName" />
                        <asp:TemplateField HeaderText = "Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CausesValidation="false" CommandName="EditEmployee"
                                    Text="Edit" CommandArgument='<%# Eval("employeeID") %>' />
                                <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteEmployee"
                                    Text="Delete" CommandArgument='<%# Eval("employeeID") %>' 
                                    onclientclick="return confirm('Are you sure you want to delete this employee account?');"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="employees" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT employeeID, firstName, lastname, middleI, email, dateEmployed, roleName 
                    FROM Employee INNER JOIN Roles ON Employee.roleID = Roles.roleID;"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

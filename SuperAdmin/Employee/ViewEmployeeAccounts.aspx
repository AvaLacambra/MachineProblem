<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewEmployeeAccounts.aspx.cs" Inherits="Machine_Problem.master.WebForm6" %>
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
            $(".employeeAccountsView").DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top:30px; margin-bottom:70px;">
        <div class ="jumbotron">
            <div class="text-center">
                <strong>
                <asp:Label ID="employeeAccountsView" runat="server" Text="View Employee Accounts" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
                <asp:Button ID="btnAddNewEmployeeAccount" runat="server" Text="Add Employee Account" OnClick="btnAddNewEmployeeAccount_Click" class="btn btn-primary"/>
            </div>
            <div class="container table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="employeeID" DataSourceID="employeeAccounts" CssClass="employeeAccountsView table table-hover" OnRowCommand="GridView1_OnRowCommand">
                    <Columns>
                        <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                        <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                        <asp:BoundField DataField="middleI" HeaderText="Middle Initial" SortExpression="middleI" />
                        <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
                        <asp:BoundField DataField="roleName" HeaderText="Role Name" SortExpression="roleName" />
                        <asp:BoundField DataField="dateCreated" HeaderText="Date Created" SortExpression="dateCreated" DataFormatString="{0:dd/MM/yyyy}" htmlencode="false"/>
                        <asp:TemplateField HeaderText = "Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CausesValidation="false" CommandName="ChangePassword"
                                    Text="Change Password" CommandArgument='<%# Eval("employeeID") %>' />
                                <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteEmployee"
                                    Text="Delete" CommandArgument='<%# Eval("employeeID") %>' 
                                    onclientclick="return confirm('Are you sure you want to delete this employee account?');"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="employeeAccounts" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT EmployeeAccounts.employeeID, lastName, firstName,middleI, username, roleName, dateCreated 
                    FROM ((EmployeeAccounts LEFT JOIN  Employee ON EmployeeAccounts.employeeID = Employee.employeeID) 
                    INNER JOIN Roles ON Employee.roleID = Roles.roleID); "></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Working Version.aspx.cs" Inherits="Machine_Problem.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- Data Tables CSS -->
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" />

        <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- jQuery Data Tables CDN -->
    <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js" type="text/javascript" charset="utf8"></script>

        <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
         <div class="container" style="margin-top:30px; margin-bottom:70px;">
            <div class="text-center">
                <strong>
                <asp:Label ID="lblHeader" runat="server" Text="View Employees" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
            </div>
            <div class="container-fluid">
                <asp:GridView ID="employeeView" runat="server" AutoGenerateColumns="False" DataSourceID="employees" CssClass="table">
                     <Columns>
                        <asp:BoundField DataField="employeeID" HeaderText="Employee ID" InsertVisible="False" ReadOnly="True" SortExpression="employeeID" />
                        <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                        <asp:BoundField DataField="lastname" HeaderText="Last Name" SortExpression="lastname" />
                        <asp:BoundField DataField="middleI" HeaderText="Middle Initial" SortExpression="middleI" />
                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                        <asp:BoundField DataField="dateEmployed" HeaderText="Date Employed" SortExpression="dateEmployed" />
                        <asp:BoundField DataField="roleName" HeaderText="Role" SortExpression="roleName" />
                        <asp:ButtonField ButtonType="Button" CommandName="Edit" HeaderText="Edit Record" ShowHeader="True" Text="Edit" />
                        <asp:ButtonField ButtonType="Button" CommandName="Delete" HeaderText="Delete Record" ShowHeader="True" Text="Delete" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="employees" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT employeeID, firstName, lastname, middleI, email, dateEmployed, roleName 
                    FROM Employee INNER JOIN Roles ON Employee.roleID = Roles.roleID;"></asp:SqlDataSource>

            </div>
        </div>
    </form>
</body>
</html>

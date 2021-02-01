<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="CreateEmployeeAccount.aspx.cs" Inherits="Machine_Problem.master.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-10 col-md-9 col-lg-7 col-xl-5" style="margin-top:30px; margin-bottom:70px;">
        <div class="jumbotron">
            <div class="row justify-content-center">
                <h1>Create Employee Account</h1>
            </div>
            <hr />
            <div class="form-group">
                <asp:DropDownList ID="drpEmployeeID" runat="server" DataSourceID="employeeDropdown" DataTextField="Column1" DataValueField="employeeID" class ="form-control"></asp:DropDownList>
                <asp:SqlDataSource ID="employeeDropdown" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connectionString %>" 
                    SelectCommand="SELECT 'Name : ' + lastName + ', '+ firstName + ' ' + middleI + ' | Role: ' + roleName, Employee.employeeID 
                    FROM ((Employee LEFT JOIN EmployeeAccounts ON Employee.employeeID = EmployeeAccounts.employeeID) 
                    INNER JOIN Roles ON Employee.roleID = Roles.roleID) WHERE username is NULL;" OnSelected="employeeDropdown_Selected"></asp:SqlDataSource>
            </div>
            <div class="form-group">
                <asp:Label ID="lblUsername" runat="server" Text="Enter Username : "></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" Text="Username must not be empty." 
                    ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Enter Password : "></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" class="form-control" MaxLength="50" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" Text="Password must not be empty." 
                    ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblRepeatPassword" runat="server" Text="Enter Password Again: "></asp:Label>
                <asp:TextBox ID="txtRepeatPassword" runat="server" class="form-control" MaxLength="50" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator ID="comparePassword" runat="server" Text="Both passwords must be the same." 
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtPassword" ControlToCompare="txtRepeatPassword"></asp:CompareValidator>
            </div>
            
            <div class="form-group text-center" style="padding-top:15px;">
                <asp:Button ID="btnCreateEmployeeAccount" runat="server" Text="Create Account" class="btn btn-primary" OnClick="btnCreateEmployeeAccount_Click"/>
            </div>
            <div class="form-group text-center" style="padding-top:15px;">
                <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" OnClick="btnBack_Click" CausesValidation="false"/>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="EditEmployee.aspx.cs" Inherits="Machine_Problem.master.WebForm8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="jumbotron">
            <div class="text-center">
                <strong>
                <asp:Label ID="lblHeader" runat="server" Text="Add Employee" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
            </div>
           <div class="container-fluid">
                <div class="form-group">
                    <asp:Label ID="Label1" runat="server" Text="First name : "></asp:Label>
                    <asp:TextBox ID="txtFirstName" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" Text="First name must not be empty." 
                        ControlToValidate="txtFirstName" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label2" runat="server" Text="Last name : "></asp:Label>
                    <asp:TextBox ID="txtLastName" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" Text="Last name must not be empty." 
                        ControlToValidate="txtLastName" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label6" runat="server" Text="M.I. :"></asp:Label>
                    <asp:TextBox ID="txtMiddleI" runat="server" class="form-control" MaxLength="1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMiddileI" runat="server" Text="M.I. must not be empty." 
                        ControlToValidate="txtMiddleI" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblEmail" runat="server" Text="Email : "></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" Text="Email must not be empty." 
                        ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexEmail" runat="server" Display="Dynamic" ControlToValidate="txtEmail"
                        ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ForeColor="Red" Text="Invalid email format.">
                    </asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblRole" runat="server" Text="Role : "></asp:Label>
                    <asp:DropDownList ID="drpRole" runat="server" DataSourceID="TKNOS" DataTextField="roleName" DataValueField="roleID" class="form-control"></asp:DropDownList>
                    <asp:SqlDataSource ID="TKNOS" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" SelectCommand="SELECT [roleName], [roleID] FROM [Roles]"></asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" Text="City must not be empty." 
                        ControlToValidate="drpRole" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnEditEmployee" runat="server" Text="Edit Employee" class="btn btn-primary" OnClick="btnEditEmployee_Click"/>
                </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" OnClick="btnBack_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

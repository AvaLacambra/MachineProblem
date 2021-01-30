<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ChangePassEmployeeAccount.aspx.cs" Inherits="Machine_Problem.master.WebForm7" %>
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
            <div class="text-center">
                <strong>
                <asp:Label ID="lblHeader" runat="server" Text="Change Employee Account Password" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
            </div>
            <div class="form-group">
                <asp:Label ID="lblOldPassword" runat="server" Text="Enter Old Password : "></asp:Label>
                <asp:TextBox ID="txtOldPassword" runat="server" class="form-control" MaxLength="50" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" Text="Old Password must not be empty." 
                    ControlToValidate="txtOldPassword" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblOldPasswordRepeat" runat="server" Text="Enter Old Password Again: "></asp:Label>
                <asp:TextBox ID="txtOldPasswordRepeat" runat="server" class="form-control" MaxLength="50" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator ID="comparePassword" runat="server" Text="Both passwords must be the same." 
                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtOldPassword" ControlToCompare="txtOldPasswordRepeat"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblNewPassword" runat="server" Text="Enter New Password : "></asp:Label>
                <asp:TextBox ID="txtNewPassword" runat="server" class="form-control" MaxLength="50" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" Text="New Password must not be empty." 
                    ControlToValidate="txtNewPassword" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group text-center" style="padding-top:15px;">
                <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" class="btn btn-primary" OnClick="btnChangePassword_Click"/>
            </div>
            <div class="form-group text-center" style="padding-top:15px;">
                <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" CausesValidation="false" OnClick="btnBack_Click"/>
            </div>
        </div>
    </div>
</asp:Content>
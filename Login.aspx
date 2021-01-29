<%@ Page Title="" Language="C#" MasterPageFile="~/master/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Machine_Problem.master.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-8 col-md-8 col-lg-5 col-xl-4" style="margin-top:30px; margin-bottom:70px;"">
        <div class="jumbotron">
            <div class="text-center">
                <strong>
                <asp:Label ID="lblLoginHeader" runat="server" Text="Login" CssClass="auto-style1"></asp:Label>
                </strong>
                <hr />
            </div>
            <div class="form-group text-center">
                <asp:TextBox ID="txtUsername" 
                    runat="server" 
                    class="form-control"
                    placeholder="Enter your username">
                </asp:TextBox>
                <asp:Label ID="lblUsername" 
                    runat="server" 
                    Text="Username" >
                </asp:Label>
            </div>
            <div class="form-group text-center">
                <asp:TextBox ID="txtPassword" 
                    runat="server" 
                    class="form-control" 
                    TextMode="Password" 
                    placeholder="Enter your password">
                </asp:TextBox>
                <asp:Label ID="lblPassword" 
                    runat="server" 
                    Text="Password">
                </asp:Label>
            </div>
            <div class="form-group text-center">
                <asp:Button ID="btnLogin" 
                    runat="server" 
                    Text="LOGIN" 
                    class="btn btn-secondary" OnClick="btnLogin_Click"/>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="AddNewsEvents.aspx.cs" Inherits="Machine_Problem.master.WebForm17" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../js/Posts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="jumbotron">
            <div class="row justify-content-center">
                <h1>Add News and Events</h1>
            </div>
            <hr />
           <div class="container-fluid">
                <div class="form-group">
                    <asp:Label ID="lblNewsEventsTitle" runat="server" Text="News or Event Title: "></asp:Label>
                    <asp:TextBox ID="txtNewsEventsTitle" runat="server" class="form-control" MaxLength="150"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" Text="News or Event Title must not be empty." 
                        ControlToValidate="txtNewsEventsTitle" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblNewsEventsDesc" runat="server" Text="Featured Work Description: "></asp:Label>
                    <asp:TextBox ID="txtNewsEventsDesc" runat="server" class="form-control" MaxLength="4000" TextMode="MultiLine" Rows="6"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvText" runat="server" Text="News or Event Description must not be empty." 
                        ControlToValidate="txtNewsEventsDesc" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
               <div class="form-group">
                    <asp:FileUpload ID="filePhoto" runat="server" AllowMultiple="true" accept="image/*"/>
               </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnAddNewsEvent" runat="server" Text="Add Featured Work" class="btn btn-primary" OnClick="btnAddNewsEvent_Click"/>
                </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" CausesValidation="false" OnClick="btnBack_Click"/>
                </div>
               <div class="container-fluid">
                    <div class="form-group">
                        <div id="frames" class="row justify-content-center">
                    </div>
               </div>
               </div>
            </div>
        </div>
    </div>
</asp:Content>

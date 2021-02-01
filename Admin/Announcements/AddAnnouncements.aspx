<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="AddAnnouncements.aspx.cs" Inherits="Machine_Problem.master.WebForm9" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="jumbotron">
            <div class="row justify-content-center">
                <h1>Announcements</h1>
            </div>
            <hr />
           <div class="container-fluid">
                <div class="form-group">
                    <asp:Label ID="lblAnnounceTitle" runat="server" Text="Announcement Title: "></asp:Label>
                    <asp:TextBox ID="txtAnnounceTitle" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" Text="Announcement Title must not be empty." 
                        ControlToValidate="txtAnnounceTitle" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblAnnounceText" runat="server" Text="Announcement Text: "></asp:Label>
                    <asp:TextBox ID="txtAnnounceText" runat="server" class="form-control" MaxLength="256" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvText" runat="server" Text="Announcement Text must not be empty." 
                        ControlToValidate="txtAnnounceText" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
               <div class="form-group">
                   <asp:FileUpload ID="filePhoto" runat="server" AllowMultiple="true"/>
               </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnAddEmployee" runat="server" Text="Add Announcement" class="btn btn-primary" OnClick="btnAddEmployee_Click"/>
                </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" CausesValidation="false" OnClick="btnBack_Click"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

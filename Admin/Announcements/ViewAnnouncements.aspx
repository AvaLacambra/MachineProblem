<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="ViewAnnouncements.aspx.cs" Inherits="Machine_Problem.master.WebForm10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <% for (int i=0; i < announcements.announceID.Count; i++) { %>
            <div class="jumbotron">
                <h3 style="text-align:center"><%= announcements.announceTitle[i] %></h3>
                <small><%= announcements.announceDatePosted[i] %></small>
                <hr />
                <% for (int j=0; j < announcementPhotos.photoID.Count; j++) { %>
                    <img src="<%= announcementPhotos.photoPath[j] %>" class="img-responsive">
                <% } %>
            </div>
        <% } %>
    </div>
</asp:Content>

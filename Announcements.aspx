<%@ Page Title="" Language="C#" MasterPageFile="master/User.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="Machine_Problem.master.WebForm10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="row justify-content-center">
            <h1>Announcements</h1>
        </div>
        <hr />
        <% for (int i=0; i < announcements.announceID.Count; i++) { %>
            <div class="jumbotron">
                <h3 style="text-align:center"><%= announcements.announceTitle[i] %></h3>
                <small>Date Posted : <%= String.Format("{0:dd/MM/yyyy}", announcements.announceDatePosted[i]) %></small>
                <hr />
                <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <% int photoCounter = 0; %>
                        <% for (int j=0; j < announcementPhotos.photoID.Count; j++) { %>
                            <% if (announcementPhotos.announceID[j] == announcements.announceID[i] && photoCounter==0) {%>
                                <div class="carousel-item active">
                                    <img class="d-block w-100" src="Admin/Announcements/<%= announcementPhotos.photoPath[j] %>" alt="<%= announcementPhotos.photoName[j] %>">
                                </div>
                                <% photoCounter+=1; %>
                            <% } %> 
                            <% else if (announcementPhotos.announceID[j] == announcements.announceID[i] && photoCounter > 0) {%>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src="Admin/Announcements/<%= announcementPhotos.photoPath[j] %>" alt="<%= announcementPhotos.photoName[j] %>">
                                </div>
                                <% photoCounter+=1; %>
                            <% } %> 
                        <% } %>
                    </div>
                    <% if (photoCounter > 1) {%> 
                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                    <% } %> 
                </div>
                <div class="=container col-11">
                    <p style="text-align:justify"><%= announcements.announceText[i] %></p>
                </div>
            </div>
        <% } %>
    </div>
</asp:Content>
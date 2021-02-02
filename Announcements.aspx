    <%@ Page Title="" Language="C#" MasterPageFile="master/User.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="Machine_Problem.master.WebForm10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
          <style>
            pre {
                white-space: pre-wrap;
            }
            .more {
                margin: 10px;
            }
            .morecontent span {
                display: none;
            }
          </style>
        <script>
            $(function() {
                var showChar = 750, showtxt = "more", hidetxt = "less";
                $('.more').each(function() {
                    var content = $(this).text();
                    if (content.length > showChar) {
                        var con = content.substr(0, showChar);
                        var hcon = content.substr(showChar, content.length - showChar);
                        var txt= con +  '<span class="dots">...</span><span class="morecontent"><span>' + hcon + '</span>&nbsp;&nbsp;<a href="" class="moretxt">' + showtxt + '</a></span>';
                        $(this).html(txt);
                    }
                });

                $(".moretxt").click(function() {
                    if ($(this).hasClass("sample")) {
                        $(this).removeClass("sample");
                        $(this).text(showtxt);
                    } else {
                        $(this).addClass("sample");
                        $(this).text(hidetxt);
                    }
                    $(this).parent().prev().toggle();
                    $(this).prev().toggle();

                    return false;
                    });
                });
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="row justify-content-center">
            <h1>Announcements</h1>
        </div>
        <hr />
        <% for (int i=0; i < announcements.announceID.Count; i++) { %>
            <div class="card">
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
                <hr />
                <div class="row justify-content-center">
                    <h2 class="card-title mt-2 ml-2"><%= announcements.announceTitle[i] %></h2>
                </div>
                <div class="row justify-content-center">
                    <small class=" mt-2 ml-2">Date Posted : <%= String.Format("{0:dd/MM/yyyy}", announcements.announceDatePosted[i]) %></small>
                </div>
                <hr />
                <div class="container">
                    <div class="col-10" style="float:none;margin:auto;">
                        <pre class="more" style="text-align:justify"><%= announcements.announceText[i] %></pre>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</asp:Content>
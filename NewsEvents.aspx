<%@ Page Title="" Language="C#" MasterPageFile="master/User.Master" AutoEventWireup="true" CodeBehind="NewsEvents.aspx.cs" Inherits="Machine_Problem.master.WebForm20" %>
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
                var showChar = 500, showtxt = "more", hidetxt = "less";
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
    <div class="container col-sm-10 col-md-10 col-lg-9 col-xl-7" style="margin-top:30px; margin-bottom:70px;">
        <div class="row justify-content-center">
            <h1>News and Events</h1>
        </div>
        <hr />
        <div class="card-deck">
        <% for (int i = 0; i < newsEvents.newsEventsID.Count; i++) { %>
            <div class="card mb-3" style="min-width: 18rem;">
                <div class="card-img-top">
                    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <% int photoCounter = 0; %>
                            <% for (int j=0; j < newsEventsPhotos.photoID.Count; j++) { %>
                                <% if (newsEventsPhotos.newsEventsID[j] == newsEvents.newsEventsID[i] && photoCounter==0) {%>
                                    <div class="carousel-item active">
                                        <img class="img-fluid" src="Admin/NewsEvents/<%= newsEventsPhotos.photoPath[j] %>" alt="<%= newsEventsPhotos.photoName[j] %>">
                                    </div>
                                    <% photoCounter+=1; %>
                                <% } %> 
                                <% else if (newsEventsPhotos.newsEventsID[j] == newsEvents.newsEventsID[i] && photoCounter > 0) {%>
                                    <div class="carousel-item">
                                        <img class="img-fluid" src="Admin/NewsEvents/<%= newsEventsPhotos.photoPath[j] %>" alt="<%= newsEventsPhotos.photoName[j] %>">
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
                </div>
                <div class="card-body">
                    <h2 class="card-title mt-2 ml-2"> <%= newsEvents.newsEventsTitle[i] %> </h2>
                    <small class="ml-2"> Date Posted : <%= String.Format("{0:dd/MM/yyyy}", newsEvents.newsEventsDatePosted[i]) %> </small>
                    <div class="mt-2 ml-2 more"><%= newsEvents.newsEventsDesc[i] %></div>
                </div>
            </div>
        <% } %>
        </div>
    </div>
</asp:Content>

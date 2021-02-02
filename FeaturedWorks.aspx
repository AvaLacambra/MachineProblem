<%@ Page Title="" Language="C#" MasterPageFile="master/User.Master" AutoEventWireup="true" CodeBehind="FeaturedWorks.aspx.cs" Inherits="Machine_Problem.master.WebForm16" %>
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
            <h1>Featured Student Works</h1>
        </div>
        <hr />
        <% for (int i = 0; i < featuredWorks.featuredWorkID.Count; i++) { %>
        <div class="card">
            <div class="row">
                <div class="col-md-4">
                    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <% int photoCounter = 0; %>
                            <% for (int j=0; j < featuredWorkPhotos.photoID.Count; j++) { %>
                                <% if (featuredWorkPhotos.featuredWorkID[j] == featuredWorks.featuredWorkID[i] && photoCounter==0) {%>
                                    <div class="carousel-item active">
                                        <img class="d-block w-100" src="Admin/FeaturedWork/<%= featuredWorkPhotos.photoPath[j] %>" alt="<%= featuredWorkPhotos.photoName[j] %>">
                                    </div>
                                    <% photoCounter+=1; %>
                                <% } %> 
                                <% else if (featuredWorkPhotos.featuredWorkID[j] == featuredWorks.featuredWorkID[i] && photoCounter > 0) {%>
                                    <div class="carousel-item">
                                        <img class="d-block w-100" src="Admin/FeaturedWork/<%= featuredWorkPhotos.photoPath[j] %>" alt="<%= featuredWorkPhotos.photoName[j] %>">
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
                <div class="col-md-8">
                    <h2 class="card-title mt-2 ml-2"> <%= featuredWorks.featuredTitle[i] %> </h2>
                    <small class="ml-2"> Date Posted : <%= featuredWorks.featuredDatePosted[i] %> </small>
                    <div class="mt-2 ml-2 more"><%= featuredWorks.featuredDesc[i] %></div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</asp:Content>

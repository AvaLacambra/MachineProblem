<%@ Page Title="" Language="C#" MasterPageFile="master/User.Master" AutoEventWireup="true" CodeBehind="FeaturedWorks.aspx.cs" Inherits="Machine_Problem.master.WebForm16" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/ViewPost.css" rel="stylesheet" />
    <script src="js/ViewPosts.js"></script>
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
                    <div id="carouselExampleControls<%= i%>" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <% int photoCounter = 0; %>
                            <% for (int j=0; j < featuredWorkPhotos.photoID.Count; j++) { %>
                                <% if (featuredWorkPhotos.featuredWorkID[j] == featuredWorks.featuredWorkID[i] && photoCounter==0) {%>
                                    <div class="carousel-item active">
                                        <img class="img-fluid" src="Admin/FeaturedWorks/<%= featuredWorkPhotos.photoPath[j] %>" alt="<%= featuredWorkPhotos.photoName[j] %>">
                                    </div>
                                    <% photoCounter+=1; %>
                                <% } %> 
                                <% else if (featuredWorkPhotos.featuredWorkID[j] == featuredWorks.featuredWorkID[i] && photoCounter > 0) {%>
                                    <div class="carousel-item">
                                        <img class="img-fluid" src="Admin/FeaturedWorks/<%= featuredWorkPhotos.photoPath[j] %>" alt="<%= featuredWorkPhotos.photoName[j] %>">
                                    </div>
                                    <% photoCounter+=1; %>
                                <% } %> 
                            <% } %>
                        </div>
                        <% if (photoCounter > 1) {%> 
                        <a class="carousel-control-prev" href="#carouselExampleControls<%= i%>" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleControls<%= i%>" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                        <% } %> 
                    </div>
                </div>
                <div class="col-md-8">
                    <h2 class="card-title mt-2 ml-2"> <%= featuredWorks.featuredTitle[i] %> </h2>
                    <small class="ml-2"> Date Posted : <%= String.Format("{0:dd/MM/yyyy}", featuredWorks.featuredDatePosted[i]) %> </small>
                    <div class="mt-2 ml-2 more"><%= featuredWorks.featuredDesc[i] %></div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="EditAnnouncement.aspx.cs" Inherits="Machine_Problem.master.WebForm12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../js/Posts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="jumbotron">
            <div class="row justify-content-center">
                <h1>Edit Announcement</h1>
            </div>
            <hr />
           <div class="container-fluid">
                <div class="form-group">
                    <asp:Label ID="lblAnnounceTitle" runat="server" Text="Announcement Title: "></asp:Label>
                    <asp:TextBox ID="txtAnnounceTitleEdit" runat="server" class="form-control" MaxLength="150"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" Text="Announcement Title must not be empty." 
                        ControlToValidate="txtAnnounceTitleEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblAnnounceText" runat="server" Text="Announcement Text: "></asp:Label>
                    <asp:TextBox ID="txtAnnounceTextEdit" runat="server" class="form-control" MaxLength="4000" TextMode="MultiLine" Rows="6"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvText" runat="server" Text="Announcement Text must not be empty." 
                        ControlToValidate="txtAnnounceTextEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
               <div class="form-group">
                    <asp:FileUpload ID="filePhoto" runat="server" AllowMultiple="true" accept="image/*"/>
               </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnEditAnnouncement" runat="server" Text="Edit Announcement" class="btn btn-primary" OnClick="btnEditAnnouncement_Click"/>
                </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" CausesValidation="false" OnClick="btnBack_Click"/>
                </div>
               <div class="container-fluid">
                    <div class="form-group">
                        <div id="frames" class="row justify-content-center"></div>
                    </div>
               </div>
               <div class="container-fluid">
                    <div class="form-row justify-content-center">
                    <asp:Repeater ID="photoRepeater" runat="server" DataSourceID="photoData" OnItemCommand="Repeater1_ItemCommand">
                        <ItemTemplate>
                            <div class="form-group">
                                <div class="container row">
                                    <asp:Image ID="photo" runat="server" width ="200px" Height="200px" ImageUrl='<%# Eval("photoPath") %>' BorderStyle="Solid" BorderColor="Transparent" BorderWidth="8px" />
                                </div>
                                <div class="container row justify-content-center">
                                    <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandName="deletePhoto"
                                        Text="Delete" CommandArgument='<%# Eval("photoID") %>' onclientclick="return confirm('Are you sure you want to delete this photo?');"/>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    </div>
                   <asp:SqlDataSource ID="photoData" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" SelectCommand="SELECT [photoID], [photoName], [photoPath] FROM [AnnouncementPhotos] WHERE ([announceID] = @announceID)">
                       <SelectParameters>
                           <asp:SessionParameter Name="announceID" SessionField="EditAnnounceID" Type="Int32" />
                       </SelectParameters>
                   </asp:SqlDataSource>
               </div>
            </div>
        </div>
    </div>
</asp:Content>

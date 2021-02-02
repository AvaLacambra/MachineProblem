<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="EditFeaturedWork.aspx.cs" Inherits="Machine_Problem.master.WebForm15" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $('#ContentPlaceHolder1_filePhoto').change(function () {
                $("#frames").html('');
                for (var i = 0; i < $(this)[0].files.length; i++) {
                    $("#frames").append('<img src="' + window.URL.createObjectURL(this.files[i]) + '"width="200px" height="200px" style="border:8px solid transparent" alt="Not an image, please change."/>');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-sm-9 col-md-9 col-lg-8 col-xl-6" style="margin-top:30px; margin-bottom:70px;">
        <div class="jumbotron">
            <div class="row justify-content-center">
                <h1>Edit Featured Work</h1>
            </div>
            <hr />
           <div class="container-fluid">
                <div class="form-group">
                    <asp:Label ID="lblFeaturedTitle" runat="server" Text="Featured Work Title: "></asp:Label>
                    <asp:TextBox ID="txtFeaturedTitle" runat="server" class="form-control" MaxLength="150"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" Text="Featured Work Title must not be empty." 
                        ControlToValidate="txtFeaturedTitle" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblFeaturedDesc" runat="server" Text="Featured Work Description: "></asp:Label>
                    <asp:TextBox ID="txtFeaturedDesc" runat="server" class="form-control" MaxLength="4000" TextMode="MultiLine" Rows="6"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvText" runat="server" Text="Featured Work Description must not be empty." 
                        ControlToValidate="txtFeaturedDesc" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
               <div class="form-group">
                    <asp:FileUpload ID="filePhoto" runat="server" AllowMultiple="true" accept="image/*"/>
               </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnEditFeaturedWork" runat="server" Text="Edit Featured Work" class="btn btn-primary" OnClick="btnEditFeaturedWork_Click"/>
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
                   <asp:SqlDataSource ID="photoData" runat="server" ConnectionString="<%$ ConnectionStrings:connectionString %>" SelectCommand="SELECT [photoID], [photoName], [photoPath] FROM [FeaturedWorkPhotos] WHERE ([featuredWorkID] = @featuredWorkID)">
                       <SelectParameters>
                           <asp:SessionParameter Name="featuredWorkID" SessionField="featuredWorkID" Type="Int32" />
                       </SelectParameters>
                   </asp:SqlDataSource>
               </div>
            </div>
        </div>
    </div>
</asp:Content>

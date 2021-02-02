﻿<%@ Page Title="" Language="C#" MasterPageFile="../../master/Admin.Master" AutoEventWireup="true" CodeBehind="AddFeaturedWork.aspx.cs" Inherits="Machine_Problem.master.WebForm13" %>
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
                <h1>Add Featured Work</h1>
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
                    <asp:Button ID="btnAddFeaturedWork" runat="server" Text="Add Featured Work" class="btn btn-primary" OnClick="btnAddFeaturedWork_Click"/>
                </div>
                <div class="form-group text-center" style="padding-top:15px;">
                    <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary" CausesValidation="false" OnClick="btnBack_Click" />
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
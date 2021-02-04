<%@ Page Title="" Language="C#" MasterPageFile="~/master/User.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Machine_Problem.master.WebForm10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .header-label{
            font-weight:bold;
            font-size:xx-large;
            text-align:center;
            padding-bottom:30px;
        }

        .required{
            color:red;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-11 col-sm-10 col-md-10 col-lg-9 col-xl-7" style="margin-top:30px; margin-bottom:70px;">
        <div class="header-label">
            Contact Us
        </div>
        
        <div class="jumbotron">
            <div class="container-fluid">
                <div class="form-row">
                    <div class="form-group col-md-6">   
                        First Name:<span class="required">*</span>
                        <asp:TextBox ID="txtFirstname" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" 
                            runat="server" Text="First name must not be empty." 
                            Display="Dynamic" 
                            ControlToValidate="txtFirstname" 
                            ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-md-6">
                        Last Name:<span class="required">*</span>
                        <asp:TextBox ID="txtLastname" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" 
                            runat="server" Text="Last name must not be empty." 
                            Display="Dynamic" 
                            ControlToValidate="txtLastname" 
                            ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        Company Affiliation:
                        <asp:TextBox ID="txtAffiliation" runat="server" class="form-control" MaxLength="50" />
                    </div>
                    <div class="form-group col-md-4">
                        Contact Number:<span class="required">*</span>
                        <asp:TextBox ID="txtContact" runat="server" class="form-control" MaxLength="11" />
                        <asp:RequiredFieldValidator ID="rfvContact" runat="server" Text="Contact number must not be empty." 
                            ControlToValidate="txtContact" Display="Dynamic" ForeColor="Red" />
                        <asp:RegularExpressionValidator 
                            ID="revContact" 
                            runat="server" 
                            Display="Dynamic" 
                            ControlToValidate="txtContact"
                            ForeColor="Red"
                            ValidationExpression="[0-9]{7,11}$"
                            Text="Invalid contact number.">
                        </asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        Email:<span class="required">*</span>
                        <asp:TextBox ID="txtEmail" runat="server" class="form-control" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" Text="Email must not be empty." 
                            ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" />
                        <asp:RegularExpressionValidator ID="regexEmail" runat="server" Display="Dynamic" ControlToValidate="txtEmail"
                            ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ForeColor="Red" Text="Invalid email format.">
                        </asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group col-md-4">
                        Inquiry Type:<span class="required">*</span>
                        <asp:DropDownList ID="ddlInquiryType" runat="server" class="form-control">
                            <asp:ListItem Text="Choose inquiry type" Value="0"/>
                            <asp:ListItem Text="Inquiry" Value="1"/>
                            <asp:ListItem Text="Suggestion" Value="2"/>
                            <asp:ListItem Text="Commendation" Value="3"/>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvInquiry" runat="server" Text="Please choose an inquiry type." 
                            ControlToValidate="ddlInquiryType" Display="Dynamic" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    Comments/Message:<span class="required">*</span>
                    <asp:TextBox ID="txtComments" runat="server" class="form-control" TextMode="MultiLine" MaxLength="256" />
                    <asp:RequiredFieldValidator ID="rfvComments" runat="server" Text="Comments must must not be empty." 
                        ControlToValidate="txtComments" Display="Dynamic" ForeColor="Red" />
                </div>
                
                <div class="form-group text-center" style="padding-top:20px;">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary" OnClick="btnSubmit_Click" CausesValidation="true" />
                </div>
               
            </div>
        </div>
    </div>
</asp:Content>

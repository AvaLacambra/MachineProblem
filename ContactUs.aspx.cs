using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace Machine_Problem.master
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sqlCommand = "INSERT INTO Inquiry VALUES (@firstName, @lastName, @affiliation, @contact, @email, @inquiryType, @comments);";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("firstName", txtFirstname.Text);
                command.Parameters.AddWithValue("lastName", txtLastname.Text);
                command.Parameters.AddWithValue("affiliation", txtAffiliation.Text);
                command.Parameters.AddWithValue("contact", txtContact.Text);
                command.Parameters.AddWithValue("email", txtEmail.Text);
                command.Parameters.AddWithValue("inquiryType", ddlInquiryType.SelectedValue);
                command.Parameters.AddWithValue("comments", txtComments.Text);
                command.ExecuteNonQuery();
            }

            Response.Write("<script>alert('Inquiry was submitted!')</script>");
        } 
    }
}
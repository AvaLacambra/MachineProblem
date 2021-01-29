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
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void btnAddEmployee_Click(object sender, EventArgs e)
        {
            string sqlCommand = "INSERT INTO Employee VALUES (@firstname, @lastname, @middleI, @email, GETDATE(), @roleID);";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();
                try {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("firstname", txtFirstName.Text);
                    command.Parameters.AddWithValue("lastname", txtLastName.Text);
                    command.Parameters.AddWithValue("middleI", txtMiddleI.Text);
                    command.Parameters.AddWithValue("email", txtEmail.Text);
                    command.Parameters.AddWithValue("roleID", drpRole.Text);
                    command.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "redirect", "alert('New Employee Added.'); window.location='" +
                        Request.ApplicationPath + "Admin/Employee/ViewEmployees.aspx';", true);
                }
                catch {
                    Response.Write("<script>alert('Email entered is currently in use.')</script>");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewEmployees.aspx");
        }

    }
}
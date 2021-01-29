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
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string sqlCommand = "SELECT roleID " +
                                "FROM Employee INNER JOIN EmployeeAccounts " +
                                "ON Employee.employeeID = EmployeeAccounts.employeeID " +
                                "WHERE username = @username AND password = @password;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString)) 
            {
                using (SqlCommand command = new SqlCommand(sqlCommand, connection))
                {
                    connection.Open();
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("username", txtUsername.Text);
                    command.Parameters.AddWithValue("password", txtPassword.Text);

                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        Response.Write("<script>alert('Login successful.')</script>");
                        Session["username"] = txtUsername;

                        //placeholder until we have seperate pages for each role
                        if (reader["roleID"].ToString() == "1") Response.Redirect("Admin/Dashboard.aspx");
                        else if (reader["roleID"].ToString() == "2") Response.Write("TEACHER");
                        else if (reader["roleID"].ToString() == "3") Response.Write("REGISTRAR");
                        else if (reader["roleID"].ToString() == "4") Response.Write("SUPERADMIN");
                    }
                    else Response.Write("<script>alert('Incorrect Username and Password.')</script>");
                }
            }
        }

    }
}
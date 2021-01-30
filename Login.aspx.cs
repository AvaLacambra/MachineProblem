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
            string sqlCommand = "SELECT Employee.employeeID, roleID " +
                                "FROM Employee INNER JOIN EmployeeAccounts " +
                                "ON Employee.employeeID = EmployeeAccounts.employeeID " +
                                "WHERE username = @username AND password = @password;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString)) 
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);

                connection.Open();
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("username", txtUsername.Text);
                command.Parameters.AddWithValue("password", txtPassword.Text);

                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    Response.Write("<script>alert('Login successful.')</script>");
                    Session["username"] = txtUsername;
                    Session["employeeID"] = reader["Employee.employeeID"].ToString();

                    //placeholder until we have seperate pages for each role
                    if (reader["roleID"].ToString() == "1") Response.Redirect("ADMIN");
                    else if (reader["roleID"].ToString() == "2") Response.Write("TEACHER");
                    else if (reader["roleID"].ToString() == "3") Response.Write("REGISTRAR");
                }
                else if (txtUsername.Text == WebConfigurationManager.AppSettings["SuperAdminUser"] && txtPassword.Text == WebConfigurationManager.AppSettings["SuperAdminPass"]) 
                {
                    Response.Redirect("SuperAdmin/Dashboard.aspx");
                }
                else Response.Write("<script>alert('Incorrect Username and Password.')</script>");
            }
        }
    }
}
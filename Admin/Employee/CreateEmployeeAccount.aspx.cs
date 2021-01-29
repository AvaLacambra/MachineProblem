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
    public partial class WebForm2 : System.Web.UI.Page
    {
        //check if there are no employees that have no account
        protected void employeeDropdown_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "redirect", "alert('No Employees found to create a new account.'); window.location='" +
                    Request.ApplicationPath + "Admin/Employee/ViewEmployeeAccounts.aspx';", true);
            }
        }

        protected void btnCreateEmployeeAccount_Click(object sender, EventArgs e)
        {
            string sqlCommand = "INSERT INTO EmployeeAccounts VALUES (@username, @password, GETDATE(), @employeeID);";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();
                try {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("username", txtUsername.Text);
                    command.Parameters.AddWithValue("password", txtPassword.Text);
                    command.Parameters.AddWithValue("employeeID", drpEmployeeID.SelectedValue);
                    command.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "redirect", "alert('New Employee Account Created.'); window.location='" +
                        Request.ApplicationPath + "Admin/Employee/ViewEmployeeAccounts.aspx';", true);
                }
                catch {
                Response.Write("<script>alert('Username entered is currently in use.')</script>");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewEmployeeAccounts.aspx");
        }

    }
}
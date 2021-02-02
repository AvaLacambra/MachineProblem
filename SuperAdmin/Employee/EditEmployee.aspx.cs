using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Machine_Problem.master
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                if (Session["editEmployeeID"] is null)Response.Redirect("ViewEmployees.aspx");
            
                string sqlretrieve = "SELECT firstName, lastName, middleI, email, Employee.roleID " +
                    "FROM Employee INNER JOIN Roles ON Employee.roleID = Roles.roleID " +
                    "WHERE employeeID = @employeeID;";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    SqlCommand retrieve = new SqlCommand(sqlretrieve, connection);

                    connection.Open();
                    try
                    {
                        retrieve.CommandType = CommandType.Text;
                        retrieve.Parameters.AddWithValue("employeeID", Session["editEmployeeID"].ToString());

                        SqlDataReader reader = retrieve.ExecuteReader();
                        if (reader.Read())
                        {
                            txtFirstName.Text = reader["firstName"].ToString();
                            txtLastName.Text = reader["lastName"].ToString();
                            txtMiddleI.Text = reader["middleI"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                            drpRole.SelectedValue = reader["roleID"].ToString();
                        }
                    }
                    catch
                    {
                        Session.Clear();
                        ScriptManager.RegisterStartupScript(this, this.GetType(),
                            "redirect", "alert('Employee Information cannot be retrived.'); window.location='" +
                            Request.ApplicationPath + "SuperAdmin/Employee/ViewEmployees.aspx';", true);
                    }
                }
            }
        }

        protected void btnEditEmployee_Click(object sender, EventArgs e)
        {
            string sqlCommand = "UPDATE Employee SET firstName = @firstName, lastName = @lastName, " +
                                "middleI = @middleI, email = @email, roleID = @roleID " +
                                "WHERE employeeID = @employeeID;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                try {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("firstName", txtFirstName.Text);
                    command.Parameters.AddWithValue("lastName", txtLastName.Text);
                    command.Parameters.AddWithValue("middleI", txtMiddleI.Text);
                    command.Parameters.AddWithValue("email", txtEmail.Text);
                    command.Parameters.AddWithValue("roleID", drpRole.SelectedValue);
                    command.Parameters.AddWithValue("employeeID", Session["editEmployeeID"].ToString());
                    command.ExecuteNonQuery();

                    Session["editEmployeeID"] = null;
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "redirect", "alert('Employee Information has been edited.'); window.location='" +
                        Request.ApplicationPath + "SuperAdmin/Employee/ViewEmployees.aspx';", true);
                }
                catch {
                    Response.Write("<script>alert('Employee Information cannot be retrived.')</script>");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session["editEmployeeID"] = null;
            Response.Redirect("ViewEmployees.aspx");
        }

    }
}
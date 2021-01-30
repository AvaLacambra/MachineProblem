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
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check if there is employeeID to be used
            if (Session["changePasswordEmployeeID"] is null) 
                Response.Redirect("ViewEmployeeAccounts.aspx");
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string sqlretrieve = "SELECT password FROM EmployeeAccounts WHERE employeeID = @employeeID";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand retrieve = new SqlCommand(sqlretrieve, connection);
                connection.Open();

                try {
                    retrieve.CommandType = CommandType.Text;
                    retrieve.Parameters.AddWithValue("employeeID", Session["changePasswordEmployeeID"].ToString());

                    if ((string)retrieve.ExecuteScalar() == txtOldPassword.Text) changePassword();
                    else Response.Write("<script>alert('Old password entered does not match current passsword.')</script>");
                }
                catch {
                    Response.Write("<script>alert('Error with retrieval of records.')</script>");
                }
            }
        }

        protected void changePassword()
        {
            string sqlCommand = "UPDATE EmployeeAccounts SET password = @password WHERE employeeID = @employeeID;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                try {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("employeeID", Session["changePasswordEmployeeID"].ToString());
                    command.Parameters.AddWithValue("password", txtNewPassword.Text);
                    command.ExecuteNonQuery();

                    Session["changePasswordEmployeeID"] = null;
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "redirect", "alert('Password Changed.'); window.location='" +
                        Request.ApplicationPath + "SuperAdmin/Employee/ViewEmployeeAccounts.aspx';", true);
                }
                catch {
                    Response.Write("<script>alert('Error in changing password.')</script>");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session["changePasswordEmployeeID"] = null;
            Response.Redirect("ViewEmployeeAccounts.aspx");
        }

    }
}
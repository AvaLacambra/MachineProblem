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
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count != 0)
            {
                GridView1.Enabled = true;
                GridView1.UseAccessibleHeader = true;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            else
            {
                GridView1.Enabled = false;
                Response.Write("<script>alert('No Employees Found.')</script>");
            }
        }

        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditEmployee")
            {
                Session["editEmployeeID"] = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("EditEmployee.aspx"); 
            }
            else if (e.CommandName == "DeleteEmployee")
            {
                string sqlCommand = "DELETE FROM Employee WHERE employeeID = @employeeID;";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    SqlCommand command = new SqlCommand(sqlCommand, connection);

                    connection.Open();
                    try {
                        int employeeID = Convert.ToInt32(e.CommandArgument);

                        command.CommandType = CommandType.Text;
                        command.Parameters.AddWithValue("employeeID", employeeID);
                        command.ExecuteNonQuery();

                        GridView1.DataBind();
                        GridView1.UseAccessibleHeader = true;
                        GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

                        Response.Write("<script>alert('Employee has been deleted.')</script>");
                    }
                    catch {
                        Response.Write("<script>alert('Employee does not exist.')</script>");
                    }
                }
            }
        }

        protected void btnAddNewEmployee_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEmployee.aspx");
        }

    }
}
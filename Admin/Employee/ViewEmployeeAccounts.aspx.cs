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
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(GridView1.Rows.Count != 0) {
                GridView1.Enabled = true;
                GridView1.UseAccessibleHeader = true;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            else {
                GridView1.Enabled = false;
                Response.Write("<script>alert('No Employee Accounts Found.')</script>");
            }
        }

        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ChangePassword") {
                Session["changePasswordEmployeeID"] = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("ChangePassEmployeeAccount.aspx");
            }

            else if (e.CommandName == "DeleteEmployee")
            {
                string sqlCommand = "DELETE FROM EmployeeAccounts WHERE employeeID = @employeeID;";

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

                        Response.Write("<script>alert('Employee account has been deleted.')</script>");
                    }
                    catch
                    {
                        Response.Write("<script>alert('Employee account does not exist.')</script>");
                    }
                }
            }
        }

        protected void btnAddNewEmployeeAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateEmployeeAccount.aspx");
        }

    }
}
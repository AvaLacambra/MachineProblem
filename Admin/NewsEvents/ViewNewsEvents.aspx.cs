using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Machine_Problem.master
{
    public partial class WebForm18 : System.Web.UI.Page
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
                Response.Write("<script>alert('No News or Events Found.')</script>");
            }
        }

        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditNewsEvent")
            {
                Session["newsEventsID"] = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("EditNewsEvents.aspx");
            }
            else if (e.CommandName == "DeleteNewsEvent")
            {
                string sqlRetrieve = "SELECT photoPath FROM NewsEventsPhotos WHERE newsEventsID = @newsEventsID";
                string sqlCommand = "DELETE FROM NewsEvents WHERE newsEventsID = @newsEventsID;";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    connection.Open();

                    SqlCommand retrieve = new SqlCommand(sqlRetrieve, connection);

                    retrieve.CommandType = CommandType.Text;
                    retrieve.Parameters.AddWithValue("newsEventsID", e.CommandArgument);

                    SqlDataReader reader = retrieve.ExecuteReader();

                    while (reader.Read())
                    {
                        string imageFilePath = Server.MapPath($@"{reader["photoPath"].ToString()}");

                        if (File.Exists(imageFilePath))
                        {
                            File.Delete(imageFilePath);
                        }
                    }
                    reader.Close();

                    SqlCommand command = new SqlCommand(sqlCommand, connection);

                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("newsEventsID", e.CommandArgument);
                    command.ExecuteNonQuery();

                    GridView1.DataBind();
                    GridView1.UseAccessibleHeader = true;
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

                    Response.Write("<script>alert('News or Event has been deleted.')</script>");
                }
            }
        }

        protected void btnAddNewsEvent_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddNewsEvents.aspx");
        }
    }
}
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
    public partial class WebForm14 : System.Web.UI.Page
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
                Response.Write("<script>alert('No Featured Works Found.')</script>");
            }
        }
        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditFeaturedWork")
            {
                Session["featuredWorkID"] = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("EditFeaturedWork.aspx");
            }
            else if (e.CommandName == "DeleteFeaturedWork")
            {
                string sqlRetrieve = "SELECT photoPath FROM FeaturedWorkPhotos WHERE featuredWorkID = @featuredWorkID";
                string sqlCommand = "DELETE FROM FeaturedWorks WHERE featuredWorkID = @featuredWorkID;";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    connection.Open();

                    SqlCommand retrieve = new SqlCommand(sqlRetrieve, connection);

                    retrieve.CommandType = CommandType.Text;
                    retrieve.Parameters.AddWithValue("featuredWorkID", e.CommandArgument);

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
                    command.Parameters.AddWithValue("featuredWorkID", e.CommandArgument);
                    command.ExecuteNonQuery();

                    GridView1.DataBind();
                    GridView1.UseAccessibleHeader = true;
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

                    Response.Write("<script>alert('Featured Work has been deleted.')</script>");
                }
            }
        }

        protected void btnAddFeaturedWork_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddFeaturedWork.aspx");
        }
    }
}
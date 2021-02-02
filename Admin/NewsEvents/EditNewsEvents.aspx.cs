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
    public partial class WebForm19 : System.Web.UI.Page
    {
        public class Photos
        {
            public List<string> paths { get; set; }
            public List<string> fileNames { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["newsEventsID"] is null) Response.Redirect("ViewFeaturedWorks.aspx");

                string sqlretrieve = "SELECT newsEventsTitle,newsEventsDesc FROM NewsEvents WHERE newsEventsID = @newsEventsID;";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    SqlCommand retrieve = new SqlCommand(sqlretrieve, connection);

                    connection.Open();
                    try
                    {
                        retrieve.CommandType = CommandType.Text;
                        retrieve.Parameters.AddWithValue("newsEventsID", Session["newsEventsID"].ToString());

                        SqlDataReader reader = retrieve.ExecuteReader();
                        if (reader.Read())
                        {
                            txtNewsEventsTitle.Text = reader["newsEventsTitle"].ToString();
                            txtNewsEventsDesc.Text = reader["newsEventsDesc"].ToString();
                        }
                    }
                    catch
                    {
                        Session.Clear();
                        ScriptManager.RegisterStartupScript(this, this.GetType(),
                            "redirect", "alert('News or Event Information cannot be retrived.'); window.location='" +
                            Request.ApplicationPath + "Admin/NewsEvents/ViewNewsEvents.aspx';", true);
                    }
                }
            }
        }

        protected void btnEditnewsEvent_Click(object sender, EventArgs e)
        {
            try
            {
                insertPhotos(updateNewsEvents());
                Session["newsEventsID"] = null;
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "redirect", "alert('Updated News or Event.'); window.location='" +
                    Request.ApplicationPath + "Admin/NewsEvents/ViewNewsEvents.aspx';", true);
            }
            catch
            {

            }
        }

        protected string updateNewsEvents()
        {
            string sqlCommand = "UPDATE NewsEvents SET newsEventsTitle = @newsEventsTitle, newsEventsDesc = @newsEventsDesc WHERE newsEventsID = @newsEventsID;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("newsEventsTitle", txtNewsEventsTitle.Text);
                command.Parameters.AddWithValue("newsEventsDesc", txtNewsEventsDesc.Text);
                command.Parameters.AddWithValue("newsEventsID", Session["newsEventsID"].ToString());
                command.ExecuteNonQuery();

                return Session["newsEventsID"].ToString();
            }
        }

        protected void insertPhotos(string newsEventsID)
        {
            Photos photos = getPhotos();

            if (photos.paths.Count > 0)
            {
                string sqlCommand = "INSERT INTO NewsEventsPhotos VALUES (@newsEventsID, @photoName, @photoPath);";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    connection.Open();

                    for (int i = 0; i < photos.paths.Count(); i++)
                    {
                        SqlCommand command = new SqlCommand(sqlCommand, connection);

                        command.CommandType = CommandType.Text;
                        command.Parameters.AddWithValue("newsEventsID", newsEventsID);
                        command.Parameters.AddWithValue("photoName", photos.fileNames[i]);
                        command.Parameters.AddWithValue("photoPath", photos.paths[i]);
                        command.ExecuteNonQuery();
                    }
                }
            }
        }

        protected Photos getPhotos()
        {
            List<string> paths = new List<string>();
            List<string> fileNames = new List<string>();

            if (filePhoto.HasFile)
            {
                foreach (HttpPostedFile postedFile in filePhoto.PostedFiles)
                {
                    if (postedFile.ContentType.Contains("image"))
                    {
                        string fileName = Path.GetFileName(postedFile.FileName);
                        Guid g = Guid.NewGuid();
                        postedFile.SaveAs(Server.MapPath("Photos/") + g + fileName);
                        paths.Add("Photos/" + g + fileName);
                        fileNames.Add(fileName);
                    }
                }
            }
            return new Photos { paths = paths, fileNames = fileNames };
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "deletePhoto")
            {
                string sqlRetrieve = "SELECT photoPath FROM NewsEventsPhotos WHERE photoID = @photoID;";
                string sqlCommand = "DELETE FROM NewsEventsPhotos WHERE photoID = @photoID;";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    connection.Open();

                    SqlCommand retrieve = new SqlCommand(sqlRetrieve, connection);

                    retrieve.CommandType = CommandType.Text;
                    retrieve.Parameters.AddWithValue("photoID", e.CommandArgument);

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
                    command.Parameters.AddWithValue("photoID", e.CommandArgument);
                    command.ExecuteNonQuery();

                    photoRepeater.DataBind();

                    Response.Write("<script>alert('Photo has been deleted.')</script>");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewNewsEvents.aspx");
        }

    }
}
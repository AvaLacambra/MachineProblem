using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Machine_Problem.master
{
    public partial class WebForm17 : System.Web.UI.Page
    {
        public class Photos
        {
            public List<string> paths { get; set; }
            public List<string> fileNames { get; set; }
        }

        protected void btnAddNewsEvent_Click(object sender, EventArgs e)
        {
            insertPhotos(insertFeaturedWork());
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "redirect", "alert('New News or Event Posted.'); window.location='" +
                Request.ApplicationPath + "Admin/NewsEvents/ViewNewsEvents.aspx';", true);
        }

        protected int insertFeaturedWork()
        {
            string sqlCommand = "INSERT INTO NewsEvents VALUES (@newsEventsTitle , @newsEventsDesc , GETDATE());";

            using (SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("newsEventsTitle", txtNewsEventsTitle.Text);
                command.Parameters.AddWithValue("newsEventsDesc", txtNewsEventsDesc.Text);
                command.ExecuteNonQuery();

                command.Parameters.Clear();
                command.CommandText = "SELECT @@IDENTITY";
                int newsEventsID = Convert.ToInt32(command.ExecuteScalar());

                return newsEventsID;
            }
        }

        protected void insertPhotos(int newsEventsID)
        {
            Photos photos = getPhotos();

            if (photos.paths.Count > 0)
            {
                string sqlCommand = "INSERT INTO NewsEventsPhotos VALUES (@newsEventsID, @photoName, @photoPath);";

                using (SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewNewsEvents.aspx");
        }

    }
}
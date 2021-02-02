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
    public partial class WebForm20 : System.Web.UI.Page
    {
        public NewsEvents newsEvents;
        public NewsEventsPhotos newsEventsPhotos;

        public class NewsEvents
        {
            public List<string> newsEventsID { get; set; }
            public List<string> newsEventsTitle { get; set; }
            public List<string> newsEventsDesc { get; set; }
            public List<string> newsEventsDatePosted { get; set; }
        }

        public class NewsEventsPhotos
        {
            public List<string> photoID { get; set; }
            public List<string> newsEventsID { get; set; }
            public List<string> photoName { get; set; }
            public List<string> photoPath { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            loadText();
            loadPictures();
        }

        public void loadText()
        {
            newsEvents = new NewsEvents();

            List<string> newsEventsID = new List<string>();
            List<string> newsEventsTitle = new List<string>();
            List<string> newsEventsDesc = new List<string>();
            List<string> newsEventsDatePosted = new List<string>();

            string sqlCommand = "SELECT newsEventsID, newsEventsTitle, newsEventsDesc, newsEventsDatePosted FROM NewsEvents;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    newsEventsID.Add(reader["newsEventsID"].ToString());
                    newsEventsTitle.Add(reader["newsEventsTitle"].ToString());
                    newsEventsDesc.Add(reader["newsEventsDesc"].ToString());
                    newsEventsDatePosted.Add(reader["newsEventsDatePosted"].ToString());
                }
                newsEvents.newsEventsID = newsEventsID;
                newsEvents.newsEventsTitle = newsEventsTitle;
                newsEvents.newsEventsDesc = newsEventsDesc;
                newsEvents.newsEventsDatePosted = newsEventsDatePosted;
            }
        }

        public void loadPictures()
        {
            newsEventsPhotos = new NewsEventsPhotos();

            List<string> photoID = new List<string>();
            List<string> newsEventsID = new List<string>();
            List<string> photoName = new List<string>();
            List<string> photoPath = new List<string>();

            string sqlCommand2 = "SELECT photoID, newsEventsID, photoName, photoPath FROM NewsEventsPhotos WHERE newsEventsID = @newsEventsID;";

            using (SqlConnection connection2 = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                connection2.Open();

                foreach (string newsEvents in newsEvents.newsEventsID)
                {
                    SqlCommand command2 = new SqlCommand(sqlCommand2, connection2);

                    command2.CommandType = CommandType.Text;
                    command2.Parameters.AddWithValue("newsEventsID", newsEvents);

                    SqlDataReader reader = command2.ExecuteReader();

                    while (reader.Read())
                    {
                        photoID.Add(reader["photoID"].ToString());
                        newsEventsID.Add(reader["newsEventsID"].ToString());
                        photoName.Add(reader["photoName"].ToString());
                        photoPath.Add(reader["photoPath"].ToString());
                    }
                    reader.Close();
                }

                newsEventsPhotos.photoID = photoID;
                newsEventsPhotos.newsEventsID = newsEventsID;
                newsEventsPhotos.photoName = photoName;
                newsEventsPhotos.photoPath = photoPath;
            }
        }
    }
}
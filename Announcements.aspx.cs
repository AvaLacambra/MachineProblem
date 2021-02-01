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
    public partial class WebForm10 : System.Web.UI.Page
    {
        public Announcements announcements;
        public AnnouncementPhotos announcementPhotos;

        public class Announcements
        {
            public List<string> announceID { get; set; }
            public List<string> announceTitle { get; set; }
            public List<string> announceText { get; set; }
            public List<string> announceDatePosted { get; set; }
        }

        public class AnnouncementPhotos
        {
            public List<string> photoID { get; set; }
            public List<string> announceID { get; set; }
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
            announcements = new Announcements();

            List<string> announceID = new List<string>();
            List<string> announceTitle = new List<string>();
            List<string> announceText = new List<string>();
            List<string> announceDatePosted = new List<string>();

            string sqlCommand = "SELECT announceID, announceTitle, announceText, announceDatePosted FROM Announcements;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    announceID.Add(reader["announceID"].ToString());
                    announceTitle.Add(reader["announceTitle"].ToString());
                    announceText.Add(reader["announceText"].ToString());
                    announceDatePosted.Add(reader["announceDatePosted"].ToString());
                }
                announcements.announceID = announceID;
                announcements.announceTitle = announceTitle;
                announcements.announceText = announceText;
                announcements.announceDatePosted = announceDatePosted;
            }
        }

        public void loadPictures()
        {
            announcementPhotos = new AnnouncementPhotos();

            List<string> photoID = new List<string>();
            List<string> announceID = new List<string>();
            List<string> photoName = new List<string>();
            List<string> photoPath = new List<string>();
            
            string sqlCommand2 = "SELECT photoID, announceID, photoName, photoPath FROM AnnouncementPhotos WHERE announceID = @announcementID;";

            using (SqlConnection connection2 = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                connection2.Open();

                foreach (string announce in announcements.announceID)
                {
                    SqlCommand command2 = new SqlCommand(sqlCommand2, connection2);
                    
                    command2.CommandType = CommandType.Text;
                    command2.Parameters.AddWithValue("announcementID", announce);

                    SqlDataReader reader = command2.ExecuteReader();

                    while (reader.Read())
                    {
                        photoID.Add(reader["photoID"].ToString());
                        announceID.Add(reader["announceID"].ToString());
                        photoName.Add(reader["photoName"].ToString());
                        photoPath.Add(reader["photoPath"].ToString());
                    }
                    reader.Close();
                }

                announcementPhotos.photoID = photoID;
                announcementPhotos.announceID = announceID;
                announcementPhotos.photoName = photoName;
                announcementPhotos.photoPath = photoPath;
            }
        }
    }
}
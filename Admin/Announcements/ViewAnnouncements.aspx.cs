using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
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

            using (SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string announceIDString = reader["announceID"].ToString();
                    string announceTitleString = reader["announceTitle"].ToString();
                    string announceTextString = reader["announceText"].ToString();
                    string announceDatePostedString = reader["announceDatePosted"].ToString();

                    announceID.Add(announceIDString);
                    announceTitle.Add(announceTitleString);
                    announceText.Add(announceTextString);
                    announceDatePosted.Add(announceDatePostedString);
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
            List<string> photoName = new List<string>();
            List<string> photoPath = new List<string>();

            string sqlCommand2 = "SELECT photoID, photoName, photoPath FROM AnnouncementPhotos WHERE announceID = @announceID;";

            using (SqlConnection connection2 = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                foreach (string announce in announcements.announceID)
                {
                    SqlCommand command2 = new SqlCommand(sqlCommand2, connection2);
                    connection2.Open();

                    command2.CommandType = CommandType.Text;
                    command2.Parameters.AddWithValue("announceID", announce);

                    SqlDataReader reader = command2.ExecuteReader();

                    while (reader.Read())
                    {
                        string photoIDString = reader["photoID"].ToString();
                        string photoNameString = reader["photoName"].ToString();
                        string photoPathString = reader["photoPath"].ToString();

                        photoID.Add(photoIDString);
                        photoName.Add(photoNameString);
                        photoPath.Add(photoPathString);
                    }
                }

                announcementPhotos.photoID = photoID;
                announcementPhotos.photoName = photoName;
                announcementPhotos.photoPath = photoPath;
            }
        }
    }
}
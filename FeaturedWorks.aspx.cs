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
    public partial class WebForm16 : System.Web.UI.Page
    {
        public FeaturedWorks featuredWorks;
        public FeaturedWorkPhotos featuredWorkPhotos;

        public class FeaturedWorks
        {
            public List<string> featuredWorkID { get; set; }
            public List<string> featuredTitle { get; set; }
            public List<string> featuredDesc { get; set; }
            public List<string> featuredDatePosted { get; set; }
        }

        public class FeaturedWorkPhotos
        {
            public List<string> photoID { get; set; }
            public List<string> featuredWorkID { get; set; }
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
            featuredWorks = new FeaturedWorks();

            List<string> featuredWorkID = new List<string>();
            List<string> featuredTitle = new List<string>();
            List<string> featuredDesc = new List<string>();
            List<string> featuredDatePosted = new List<string>();

            string sqlCommand = "SELECT featuredWorkID, featuredTitle, featuredDesc, featuredDatePosted FROM FeaturedWorks;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    featuredWorkID.Add(reader["featuredWorkID"].ToString());
                    featuredTitle.Add(reader["featuredTitle"].ToString());
                    featuredDesc.Add(reader["featuredDesc"].ToString());
                    featuredDatePosted.Add(reader["featuredDatePosted"].ToString());
                }
                featuredWorks.featuredWorkID = featuredWorkID;
                featuredWorks.featuredTitle = featuredTitle;
                featuredWorks.featuredDesc = featuredDesc;
                featuredWorks.featuredDatePosted = featuredDatePosted;
            }
        }

        public void loadPictures()
        {
            featuredWorkPhotos = new FeaturedWorkPhotos();

            List<string> photoID = new List<string>();
            List<string> featuredWorkID = new List<string>();
            List<string> photoName = new List<string>();
            List<string> photoPath = new List<string>();

            string sqlCommand2 = "SELECT photoID, featuredWorkID, photoName, photoPath FROM FeaturedWorkPhotos WHERE featuredWorkID = @featuredWorkID;";

            using (SqlConnection connection2 = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                connection2.Open();

                foreach (string featuredWork in featuredWorks.featuredWorkID)
                {
                    SqlCommand command2 = new SqlCommand(sqlCommand2, connection2);

                    command2.CommandType = CommandType.Text;
                    command2.Parameters.AddWithValue("featuredWorkID", featuredWork);

                    SqlDataReader reader = command2.ExecuteReader();

                    while (reader.Read())
                    {
                        photoID.Add(reader["photoID"].ToString());
                        featuredWorkID.Add(reader["featuredWorkID"].ToString());
                        photoName.Add(reader["photoName"].ToString());
                        photoPath.Add(reader["photoPath"].ToString());
                    }
                    reader.Close();
                }

                featuredWorkPhotos.photoID = photoID;
                featuredWorkPhotos.featuredWorkID = featuredWorkID;
                featuredWorkPhotos.photoName = photoName;
                featuredWorkPhotos.photoPath = photoPath;
            }
        }
    }
}
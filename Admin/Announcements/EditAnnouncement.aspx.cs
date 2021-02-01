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
    public partial class WebForm12 : System.Web.UI.Page
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
                if (Session["EditAnnounceID"] is null) Response.Redirect("ViewEmployees.aspx");
            }

            string sqlretrieve = "SELECT announceTitle,announceText FROM Announcements WHERE announceID = @announceID;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand retrieve = new SqlCommand(sqlretrieve, connection);

                connection.Open();
                try
                {
                    retrieve.CommandType = CommandType.Text;
                    retrieve.Parameters.AddWithValue("announceID", Session["EditAnnounceID"].ToString());

                    SqlDataReader reader = retrieve.ExecuteReader();
                    if (reader.Read())
                    {
                        txtAnnounceTitle.Text = reader["announceTitle"].ToString();
                        txtAnnounceText.Text = reader["announceText"].ToString();
                    }
                }
                catch
                {
                    Session.Clear();
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "redirect", "alert('Announcement Information cannot be retrived.'); window.location='" +
                        Request.ApplicationPath + "Admin/Announcements/ViewAnnouncements.aspx';", true);
                }
            }
        }

        protected void btnEditAnnouncement_Click(object sender, EventArgs e)
        {
            try {
                insertPhotos(updateAnnouncement());
                Session["EditAnnounceID"] = null;
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "redirect", "alert('Updated Announcement'); window.location='" +
                    Request.ApplicationPath + "Admin/Announcements/ViewAnnouncements.aspx';", true);
            }
            catch {

            }
        }

        protected string updateAnnouncement()
        {
            string sqlCommand = "UPDATE Announcements SET announceTitle = @announceTitle, announceText = @announceText WHERE announceID = @announceID;";

            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(sqlCommand, connection);
                connection.Open();

                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("announceTitle", txtAnnounceTitle.Text);
                command.Parameters.AddWithValue("announceText", txtAnnounceText.Text);
                command.Parameters.AddWithValue("announceID", Session["EditAnnounceID"].ToString());
                command.ExecuteNonQuery();

                return Session["EditAnnounceID"].ToString();
            }
        }

        protected void insertPhotos(string announceID)
        {
            Photos photos = getPhotos();

            if (photos.paths.Count > 0)
            {
                string sqlCommand = "INSERT INTO AnnouncementPhotos VALUES (@announceID, @photoName, @photoPath);";

                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    connection.Open();

                    for (int i = 0; i < photos.paths.Count(); i++)
                    {
                        SqlCommand command = new SqlCommand(sqlCommand, connection);

                        command.CommandType = CommandType.Text;
                        command.Parameters.AddWithValue("announceID", announceID);
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
                        postedFile.SaveAs(Server.MapPath("Photos/") + fileName);
                        paths.Add("Photos/" + fileName);
                        fileNames.Add(fileName);
                    }
                }
            }
            return new Photos { paths = paths, fileNames = fileNames };
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session["EditAnnounceID"] = null;
            Response.Redirect("ViewAnnouncements.aspx");
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "deletePhoto")
            {
                string sqlRetrieve = "SELECT photoPath FROM AnnouncementPhotos WHERE photoID = @photoID;";
                string sqlCommand = "DELETE FROM AnnouncementPhotos WHERE photoID = @photoID;";

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

                    //refresh repeater
                    photoRepeater.DataBind();

                    Response.Write("<script>alert('Photo has been deleted.')</script>");
                }
            }
        }

    }
}
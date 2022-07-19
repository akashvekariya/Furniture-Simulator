using System;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Configuration;

public partial class Feedback : System.Web.UI.Page
{
    static string email;
    static string name;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string getDetail = "SELECT first_name, last_name, email FROM user_master WHERE user_id = '" + Session["AcquireSession"].ToString() + "'";
        SqlCommand getDetailCmd = new SqlCommand(getDetail, connection);

        try
        {
            connection.Open();

            SqlDataReader rdr = getDetailCmd.ExecuteReader();

            rdr.Read();
            email = rdr[2].ToString();
            name = rdr[0].ToString() + " " + rdr[1].ToString();
            rdr.Close();
        }
        catch (Exception ex)
        {
            msgFB.Text = "Something went wrong! Try again later." + ex;
        }
        finally
        {
            connection.Close();
        }
    }

    protected void submitFB_Click(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage("john@gmail.com", "john@gmail.com");
        mail.Subject = "Feedback from Furniture Simulator";
        mail.Body = "<h3 style=\"font-family: 'SF Pro Text';\">From : " + email + "<hr />" + "Name : " + name + "<hr />" + "Feedback : " + feedbackText.Text.ToString() + "</h3>";
        mail.IsBodyHtml = true;

        if (fileUpload.HasFile)
        {
            decimal size = Math.Round(((decimal)fileUpload.PostedFile.ContentLength / (decimal)1024), 2);
            if (size < 5000)
            {
                string extension = System.IO.Path.GetExtension(fileUpload.FileName);
                if (extension == ".jpg" || extension == ".png" || extension == ".JPG" || extension == ".PNG" || extension == ".jpeg" || extension == ".JPEG")
                {
                    string FileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                    mail.Attachments.Add(new Attachment(fileUpload.PostedFile.InputStream, FileName));
                }
                else
                {
                    requiredFile.Text = "Only JPG/JPEG/PNG images are allowed";
                    requiredFile.Visible = true;
                }
            }
            else
            {
                requiredFile.Text = "file size must not exceed 5Mb";
                requiredFile.Visible = true;
            }
        }
        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.EnableSsl = true;
        smtp.Credentials = new NetworkCredential("john@gmail.com", "Hello@world");
        smtp.Send(mail);

        msgFB.Text = "Feedback sent";
        msgFB.Visible = true;
        msgFB.ForeColor = System.Drawing.Color.Green;
        feedbackText.Text = string.Empty;
        fileUpload.Dispose();
    }
}
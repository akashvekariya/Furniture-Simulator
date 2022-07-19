using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

public partial class Signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Random r = new Random();
            backgroundImg.Attributes.Add("style", "background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(App_Themes/Default/images/SignUpRandomImage/" + r.Next(1, 44) + ".jpg); background-size: cover;");
        }
    }
    static string encryption(string input)
    { // Create a new instance of the MD5CryptoServiceProvider object.
        MD5 md5Hasher = MD5.Create(); // Convert the input string to a byte array and compute the hash.
        byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));
        // Create a new Stringbuilder to collect the bytes // and create a string.
        StringBuilder sBuilder = new StringBuilder(); // Loop through each byte of the hashed data // and format each one as a hexadecimal string.
        for (int i = 0; i < data.Length; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }
        // Return the hexadecimal string.
        return sBuilder.ToString();
    }
    protected void submit_btn_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        int acc_status = 1;
        int maxuid;
        Boolean emailExist = false;
        email.Text = email.Text.ToLower();
        try
        {
            connection.Open();
            string getEmail = "SELECT email from user_master";
            SqlCommand cmdToGetEmail = new SqlCommand(getEmail, connection);
            try
            {
                SqlDataReader rdr = cmdToGetEmail.ExecuteReader();
                if (rdr.HasRows)
                {
                    while(rdr.Read())
                    {
                        if (rdr[0].ToString() == email.Text.ToString())
                        {
                            emailExist = true;
                        }
                    }
                }
                rdr.Close();
                if(emailExist==true)
                    throw new Exception();
            }
            catch (Exception ex)
            {
                warning.Text = "account already exist";
            }

            // retive userid from database
            if (emailExist == false)
            {
                string getuserid = "SELECT MAX (user_id) FROM user_master";
                SqlCommand userIdCmd = new SqlCommand(getuserid, connection);
                maxuid = Convert.ToInt32(userIdCmd.ExecuteScalar().ToString()) + 1;

                // add data to database
                string addDataQuery = "INSERT INTO user_master " +
                                      "VALUES (@uid, @FirstName, @LastName, @Email, @Phone, @Passcode, @account_status, @creation_date, @updation_date)";
                SqlCommand cmdToEnterData = new SqlCommand(addDataQuery, connection);
                cmdToEnterData.Parameters.AddWithValue("uid", maxuid);
                cmdToEnterData.Parameters.AddWithValue("FirstName", firstname.Text.Trim());
                cmdToEnterData.Parameters.AddWithValue("LastName", lastname.Text.Trim());
                cmdToEnterData.Parameters.AddWithValue("Email", email.Text.Trim());
                cmdToEnterData.Parameters.AddWithValue("Phone", phone_no.Text.Trim());
                cmdToEnterData.Parameters.AddWithValue("Passcode", encryption(passcode.Text));
                cmdToEnterData.Parameters.AddWithValue("account_status", acc_status);
                cmdToEnterData.Parameters.AddWithValue("creation_date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmdToEnterData.Parameters.AddWithValue("updation_date", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                cmdToEnterData.ExecuteNonQuery();
                Session["AcquireSession"] = maxuid;
                connection.Close();
                Response.Redirect("publishParts.aspx");
            }
        }
        catch (Exception ex)
        {
            warning.Text = ex + "error occured";
            firstname.Text = string.Empty;
            lastname.Text = string.Empty;
            email.Text = string.Empty;
            phone_no.Text = string.Empty;
            passcode.Text = string.Empty;
            c_passcode.Text = string.Empty;
        }
        

    }
}
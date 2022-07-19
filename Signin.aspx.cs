using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.Net;
using System.Net.Mail;

public partial class Signin : System.Web.UI.Page
{
    static string emailString;
    static int otp;

    protected void Page_Load(object sender, EventArgs e)
    {
        msgFindEmail.Visible = false;

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

    protected void login_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string checkemail = "SELECT email FROM user_master";
        Boolean passCorrect = false;
        Boolean emailFound = false;
        connection.Open();
        string getAccStatus = "SELECT account_status FROM user_master";
        SqlCommand accStatusCmd = new SqlCommand(getAccStatus, connection);
        int statusCode = Convert.ToInt32(accStatusCmd.ExecuteScalar());
        if (statusCode == 1)
        {
            try
            {
                SqlCommand cmdToGetEmail = new SqlCommand(checkemail, connection);
                SqlDataReader rdr = cmdToGetEmail.ExecuteReader();
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        if (rdr[0].ToString() == email.Text.Trim())
                        {
                            emailFound = true;
                            break;
                        }
                    }
                }
                rdr.Close();
                if (emailFound == true)
                {
                    string checkpassword = "SELECT user_id, password FROM user_master WHERE email = \'" + email.Text.Trim() + "\'";
                    SqlCommand cmdForPass = new SqlCommand(checkpassword, connection);
                    SqlDataReader rdr_pass = cmdForPass.ExecuteReader();
                    if (rdr_pass.HasRows)
                    {
                        while (rdr_pass.Read())
                        {
                            if ((string)rdr_pass[1] == encryption(passcode.Text))
                            {
                                int sessionVariable = Convert.ToInt32(rdr_pass[0]);
                                rdr_pass.Close();
                                Session["AcquireSession"] = sessionVariable;
                                Response.Redirect("publishParts.aspx");
                                connection.Close();
                            }
                        }
                    }
                    rdr.Close();
                }
                if (passCorrect == false || emailFound == false)
                {
                    warning.Text = "Wrong email or password! Try again";
                }
            }
            catch (Exception ex)
            {
                warning.Text = "Sorry! Some error occured please try again later";
            }
        }
        else
            warning.Text = "Wrong email or password! Try again";
        connection.Close();
    }

    protected void forgetPassword_Click(object sender, EventArgs e)
    {
        wizard.ActiveStepIndex = 1;
    }

    protected void cancelFindEmail_Click(object sender, EventArgs e)
    {
        wizard.ActiveStepIndex = 0;
    }

    protected void continueWiz2FindEmail_Click(object sender, EventArgs e)
    {
        bool emailExist = false;
        int otpid;

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

        string findEmailStr = "SELECT email FROM user_master";
        SqlCommand findEmailCmd = new SqlCommand(findEmailStr, connection);

        string getOtpid = "SELECT MAX (otp_id) FROM otp_master";
        SqlCommand getOtpidCmd = new SqlCommand(getOtpid, connection);

        string otpString = "INSERT INTO otp_master (otp_id, email, otp, requested_time, expire_time) VALUES (@id, @email, @otp, @time_1, @time_2)";
        SqlCommand otpStringCmd = new SqlCommand(otpString, connection);

        try
        {
            connection.Open();
            SqlDataReader rdr = findEmailCmd.ExecuteReader();

            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    if ((string)rdr[0] == findEmail.Text.ToLower().ToString())
                    {
                        emailExist = true;

                        msgFindEmail.Text = "Processing. . .";
                        msgFindEmail.Visible = true;
                        msgFindEmail.ForeColor = System.Drawing.Color.FromArgb(0, 20, 115, 230);

                        rdr.Close();
                        try
                        {
                            //----------------------------------getting mac otp id-----------------------------

                            try
                            {
                                if (getOtpidCmd.ExecuteScalar() == System.DBNull.Value)
                                {
                                    otpid = 1;
                                }
                                else
                                {
                                    otpid = Convert.ToInt32(getOtpidCmd.ExecuteScalar()) + 1;
                                }
                            }
                            catch (NullReferenceException ex)
                            {
                                otpid = 1;
                            }

                            //---------------------------generating OTP--------------------------------------

                            Random rand = new Random();
                            otp = rand.Next(100001, 999999);

                            //---------------------------time limit of OTP-----------------------------------

                            DateTime currentTime = DateTime.Now;
                            DateTime after5Min = currentTime.AddMinutes(5);

                            //----------------------------updating database---------------------------------

                            try
                            {
                                otpStringCmd.Parameters.AddWithValue("id", Convert.ToInt32(otpid));
                                otpStringCmd.Parameters.AddWithValue("email", findEmail.Text.ToString());
                                otpStringCmd.Parameters.AddWithValue("otp", Convert.ToInt32(otp));
                                otpStringCmd.Parameters.AddWithValue("time_1", currentTime.ToString("yyyy-MM-dd HH:mm:ss"));
                                otpStringCmd.Parameters.AddWithValue("time_2", after5Min.ToString("yyyy-MM-dd HH:mm:ss"));

                                otpStringCmd.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                msgFindEmail.Text = "Something went wrong in OTP! Try again later";
                                msgFindEmail.Visible = true;
                                msgFindEmail.ForeColor = System.Drawing.Color.Red;
                            }

                            try
                            {
                                MailMessage mail = new MailMessage("john@gmail.com", findEmail.Text.ToString());
                                mail.Subject = "Reset your password";
                                mail.Body = "<h3 style=\"font-family: 'SF Pro Text';\"> <h1 style=\"font-family: 'SF Pro Text'; color: #1473e6;\">Furniture Simulator</h1><hr>Your OTP from Furniture simulator for Password recovery is <b>" + otp.ToString() + "</b> <br> Please ensure that your OTP is confidential <br> Do not share it with anyone.</h3>";
                                mail.IsBodyHtml = true;
                                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                                smtp.EnableSsl = true;
                                smtp.Credentials = new NetworkCredential("john@gmail.com", "Hello@world");
                                smtp.Send(mail);

                                msgFindEmail.Text = "Done sending otp";
                                msgFindEmail.Visible = true;
                                msgFindEmail.ForeColor = System.Drawing.Color.Green;

                                wizard.ActiveStepIndex = 2;
                            }
                            catch (Exception ex)
                            {
                                msgFindEmail.Text = "Problem sending Email! Try again later";
                                msgFindEmail.Visible = true;
                                msgFindEmail.ForeColor = System.Drawing.Color.Red;
                            }

                        }
                        catch (Exception ex)
                        {
                            msgFindEmail.Text = "Something went wrong in OTP! Try again later.";
                            msgFindEmail.Visible = true;
                            msgFindEmail.ForeColor = System.Drawing.Color.Red;
                        }
                        break;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            msgFindEmail.Text = "Something went wrong! Try again later.";
            msgFindEmail.Visible = true;
            msgFindEmail.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            connection.Close();
        }

        if (emailExist == false)
        {
            msgFindEmail.Text = "Account on this email does not exist!";
            msgFindEmail.Visible = true;
            msgFindEmail.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void backOTP_Click(object sender, EventArgs e)
    {
        wizard.ActiveStepIndex = 1;
    }

    protected void continueWiz3FOTP_Click(object sender, EventArgs e)
    {
        string email;
        int otpLocal;
        DateTime requested_time;
        DateTime expire_time;

        int result1;
        int result2;

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

        string getOTPdata = "SELECT * from otp_master where otp_id=(select MAX(otp_id) from otp_master where email='" + findEmail.Text.Trim().ToLower().ToString() + "')";
        SqlCommand getOTPdataCmd = new SqlCommand(getOTPdata, connection);

        try
        {
            connection.Open();
            SqlDataReader rdr = getOTPdataCmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    email = rdr["email"].ToString();
                    otpLocal = Convert.ToInt32(rdr["otp"]);
                    requested_time = Convert.ToDateTime(rdr["requested_time"].ToString());
                    expire_time = Convert.ToDateTime(rdr["expire_time"].ToString());

                    rdr.Close();
                    result1 = DateTime.Compare(DateTime.Now, requested_time);
                    result2 = DateTime.Compare(DateTime.Now, expire_time);

                    if (Convert.ToInt32(otpTextBox.Text) == otpLocal)
                    {
                        if (result1 > 0)
                        {
                            if (result2 < 0)
                            {
                                wizard.ActiveStepIndex = 3;

                            }
                            else
                            {
                                msgOTPbox.Text = "Session expired! Try again";
                                msgOTPbox.Visible = true;
                                msgOTPbox.ForeColor = System.Drawing.Color.Red;

                                continueOTP.Visible = false;
                                break;
                            }
                        }
                        else
                        {
                            msgOTPbox.Text = "Session expired! Try again";
                            msgOTPbox.Visible = true;
                            msgOTPbox.ForeColor = System.Drawing.Color.Red;

                            continueOTP.Visible = false;
                            break;
                        }
                    }
                    else
                    {
                        msgOTPbox.Text = "Invalid OTP";
                        msgOTPbox.Visible = true;
                        msgOTPbox.ForeColor = System.Drawing.Color.Red;
                    }
                    break;
                }
            }

        }
        catch (Exception ex)
        {
            msgOTPbox.Text = "Something went wrong! Try again later.";
            msgOTPbox.Visible = true;
            msgOTPbox.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            connection.Close();
        }
    }

    protected void cancelResetPass_Click(object sender, EventArgs e)
    {
        Response.Redirect("Signin.aspx");
    }

    protected void continueResetPass_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

        string updatePass = "UPDATE user_master SET password='" + encryption(pass1resetPass.Text.ToString()) + "' WHERE email='" + findEmail.Text.Trim().ToLower().ToString() + "'";
        SqlCommand updatePassCmd = new SqlCommand(updatePass, connection);

        try
        {
            connection.Open();
            updatePassCmd.ExecuteNonQuery();

            msgResetPass.Text = "Updated successfully";
            msgResetPass.Visible = true;
            msgResetPass.ForeColor = System.Drawing.Color.Green;

            continueResetPass.Visible = false;

        }
        catch (Exception ex)
        {
            msgResetPass.Text = "Cannot update password! Try again";
            msgResetPass.Visible = true;
            msgResetPass.ForeColor = System.Drawing.Color.Red;
        }
    }
}
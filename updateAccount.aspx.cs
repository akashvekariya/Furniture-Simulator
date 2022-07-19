using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

public partial class updateAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string getDate = "SELECT updated_date FROM user_master WHERE user_id=" + Session["AcquireSession"] + "";
        SqlCommand getDateCmd = new SqlCommand(getDate, connection);

        try
        {
            connection.Open();
            updatedDate.Text = "Last updated date: " + getDateCmd.ExecuteScalar().ToString();
            connection.Close();
        }
        catch(Exception ex)
        {
            messageUpdate.Text = "date error";
            messageUpdate.Visible = true;
        }
        finally
        {
            connection.Close();
        }

    }

    static string encryption(string input)
    { 
        MD5 md5Hasher = MD5.Create(); 
        byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));
        StringBuilder sBuilder = new StringBuilder();
        for (int i = 0; i < data.Length; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }
        return sBuilder.ToString();
    }

    protected void continue_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string getPass = "SELECT password FROM user_master WHERE user_id=" + Session["AcquireSession"] + "";
        SqlCommand getPassCmd = new SqlCommand(getPass, connection);
        try
        {
            connection.Open();
            string enteredPass = getPassCmd.ExecuteScalar().ToString();

            if (encryption(currentPassText.Text) == enteredPass)
            {
                wizard.ActiveStepIndex = 1;
                updateControlsPane.Attributes.Add("style", "visibility: visible");
            }
            else
            {
                wiz1Warning.Text = "Wrong Password!";
                wiz1Warning.Visible = true;
            }
        } catch (Exception ex)
        {
            wiz1Warning.Text = ex + "error";
        } finally
        {
            connection.Close();
        }   
    }

    protected void update_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string updateTable = "UPDATE user_master SET first_name=ISNULL('" + firstName.Text + "',first_name), last_name=ISNULL('" + lastName.Text + "',last_name), email=ISNULL('" + email.Text + "',email), phone_no=ISNULL('" + Phone.Text + "',phone_no), password=ISNULL('" + encryption(password.Text) + "',password), updated_date=ISNULL('" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',updated_date) WHERE user_id='" + Session["AcquireSession"] + "'";
        SqlCommand updateTableCmd = new SqlCommand(updateTable, connection);

        try
        {
            connection.Open();
            updateTableCmd.ExecuteNonQuery();
            messageUpdate.Text = "Updated Successfully :)";
            messageUpdate.ForeColor = System.Drawing.Color.Green;
            messageUpdate.Visible = true;
            update.Visible = false;
        }
        catch(Exception ex)
        {
            messageUpdate.Text = "Some Error occured!";
            messageUpdate.Visible = true;
        }
        finally
        {
            connection.Close();
        }
    }

}
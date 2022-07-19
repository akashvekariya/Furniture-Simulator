using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class publishParts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Category.SelectedValue == "Bed")
        {
            partPosition.Visible = false;
            partPosition2.Visible = true;
        }
        else
        {
            partPosition.Visible = true;
            partPosition2.Visible = false;
        }
    }

    protected void submitAll_Click(object sender, EventArgs e)
    {
        if (Category.SelectedValue == "Chair" || Category.SelectedValue == "Bed")
        {
            string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + Guid.NewGuid().ToString();
            string finalFileName;
            string category;
            string position;
            if (partPosition2.Visible == true && partPosition2.SelectedValue != "-- Select --")
            {
                position = partPosition2.SelectedValue.ToString();
                category = Category.SelectedValue.ToString();
                if (uploadImageBox.HasFile)
                {
                    decimal size = Math.Round(((decimal)uploadImageBox.PostedFile.ContentLength / (decimal)1024), 2);
                    if (size < 10000)
                    {
                        string extension = System.IO.Path.GetExtension(uploadImageBox.FileName);
                        if (extension == ".jpg" || extension == ".png" || extension == ".JPG" || extension == ".PNG" || extension == ".jpeg" || extension == ".JPEG")
                        {
                            finalFileName = fileName;

                            int partid;

                            //update in database parts_master
                            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
                            string getPartID = "SELECT MAX(part_id) FROM parts_master";
                            string update_part = "INSERT INTO parts_master(part_id, user_id, amount, part_name, part_filename, category_name) VALUES (@partid, @userid, @amount, @partname, @partfilename, @categoryname)";
                            try
                            {
                                connection.Open();
                                SqlCommand getPartIDCmd = new SqlCommand(getPartID, connection);
                                try
                                {
                                    if (getPartIDCmd.ExecuteScalar() == System.DBNull.Value)
                                    {
                                        partid = 1;
                                    }
                                    else
                                    {
                                        partid = Convert.ToInt32(getPartIDCmd.ExecuteScalar()) + 1;
                                    }
                                }
                                catch (NullReferenceException ex)
                                {
                                    partid = 1;
                                }
                                SqlCommand updatePartCmd = new SqlCommand(update_part, connection);
                                updatePartCmd.Parameters.AddWithValue("@partid", Convert.ToInt32(partid));
                                updatePartCmd.Parameters.AddWithValue("@userid", Convert.ToInt32(Session["AcquireSession"]));
                                updatePartCmd.Parameters.AddWithValue("@amount", Convert.ToInt32(partPrice.Text));
                                updatePartCmd.Parameters.AddWithValue("@partname", position);
                                updatePartCmd.Parameters.AddWithValue("@partfilename", Convert.ToString(finalFileName));
                                updatePartCmd.Parameters.AddWithValue("@categoryname", Convert.ToString(Category.SelectedValue));
                                try
                                {
                                    updatePartCmd.ExecuteNonQuery();
                                    uploadImageBox.PostedFile.SaveAs(Server.MapPath("Parts_database/" + finalFileName + ".png"));
                                    Response.Redirect("publishParts.aspx");
                                }
                                catch (Exception ex)
                                {
                                    finalMessage.Visible = true;
                                    finalMessage.Text = "Updation error" + ex;
                                }

                            }
                            catch (Exception ex)
                            {
                                finalMessage.Text = "Some error occured";
                                finalMessage.Visible = true;
                            }
                            finally
                            {
                                connection.Close();
                            }
                        }
                        else
                        {
                            requiredFIle.Text = "only JPEG/JPG/PNG files are allowed";
                        }
                    }
                    else
                    {
                        requiredFIle.Text = "File size must not exceed 10 MB";
                    }
                }
                else
                {
                    requiredFIle.Text = "Please select a image";
                }
            }
            else if (partPosition.SelectedValue != "-- Select --" && partPosition2.Visible != true)
            {
                position = partPosition.SelectedValue.ToString();
                category = Category.SelectedValue.ToString();
                if (uploadImageBox.HasFile)
                {
                    decimal size = Math.Round(((decimal)uploadImageBox.PostedFile.ContentLength / (decimal)1024), 2);
                    if (size < 10000)
                    {
                        string extension = System.IO.Path.GetExtension(uploadImageBox.FileName);
                        if (extension == ".jpg" || extension == ".png" || extension == ".JPG" || extension == ".PNG" || extension == ".jpeg" || extension == ".JPEG")
                        {
                            finalFileName = fileName;
                            int partid;

                            //update in database parts_master
                            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
                            string getPartID = "SELECT MAX(part_id) FROM parts_master";
                            string update_part = "INSERT INTO parts_master(part_id, user_id, amount, part_name, part_filename, category_name) VALUES (@partid, @userid, @amount, @partname, @partfilename, @categoryname)";
                            try
                            {
                                connection.Open();
                                SqlCommand getPartIDCmd = new SqlCommand(getPartID, connection);
                                try
                                {
                                    if (getPartIDCmd.ExecuteScalar() == System.DBNull.Value)
                                    {
                                        partid = 1;
                                    }
                                    else
                                    {
                                        partid = Convert.ToInt32(getPartIDCmd.ExecuteScalar()) + 1;
                                    }
                                }
                                catch (NullReferenceException ex)
                                {
                                    partid = 1;
                                }
                                SqlCommand updatePartCmd = new SqlCommand(update_part, connection);
                                updatePartCmd.Parameters.AddWithValue("@partid", Convert.ToInt32(partid));
                                updatePartCmd.Parameters.AddWithValue("@userid", Convert.ToInt32(Session["AcquireSession"]));
                                updatePartCmd.Parameters.AddWithValue("@amount", Convert.ToInt32(partPrice.Text));
                                updatePartCmd.Parameters.AddWithValue("@partname", position);
                                updatePartCmd.Parameters.AddWithValue("@partfilename", Convert.ToString(finalFileName));
                                updatePartCmd.Parameters.AddWithValue("@categoryname", Convert.ToString(Category.SelectedValue));
                                try
                                {
                                    updatePartCmd.ExecuteNonQuery();
                                    uploadImageBox.PostedFile.SaveAs(Server.MapPath("Parts_database/" + finalFileName + ".png"));
                                    Response.Redirect("publishParts.aspx");
                                }
                                catch (Exception ex)
                                {
                                    finalMessage.Text = "Updation error" + ex;
                                    finalMessage.Visible = true;
                                }

                            }
                            catch (Exception ex)
                            {
                                finalMessage.Text = "Some error occured";
                                finalMessage.Visible = true;
                            }
                            finally
                            {
                                connection.Close();
                            }
                        }
                        else
                        {
                            requiredFIle.Text = "only JPEG/JPG/PNG files are allowed";
                        }
                    }
                    else
                    {
                        requiredFIle.Text = "File size must not exceed 10 MB";
                    }
                }
                else
                {
                    requiredFIle.Text = "Please select a image";
                }
            }
            else
            {
                requiredFIle.Text = "Please select position";
            }

        }
        else
        {
            requiredFIle.Text = "Please select category";
        }
    }
}
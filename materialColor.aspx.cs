using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class materialColor : System.Web.UI.Page
{
    string filename = DateTime.Now.ToString("yyyyMMddHHmmssfff") + Guid.NewGuid().ToString();
    static string finalFilename;  

    protected void Page_Load(object sender, EventArgs e)
    { 

    }

    protected void uploadMatCol_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

        int materialId;
        int colorId;

        string getMaterialID = "SELECT MAX(material_id) FROM material_master";
        string updateMaterial = "INSERT INTO material_master(material_id, user_id, material_name, material_filename, amount) VALUES (@materialID, @userID, @materialName, @materialFilename, @amount)";

        string getColorID = "SELECT MAX(color_id) FROM color_master";
        string updateColor = "INSERT INTO color_master(color_id, user_id, color_name, color_filename, amount) VALUES (@colorID, @userID, @colorName, @colorFilename, @amount)";

        SqlCommand getMaterialIDCmd = new SqlCommand(getMaterialID, connection);
        SqlCommand updateMaterialCmd = new SqlCommand(updateMaterial, connection);

        SqlCommand getColorIDCmd = new SqlCommand(getColorID, connection);
        SqlCommand updateColorCmd = new SqlCommand(updateColor, connection);
        if (uploadImageBox.HasFile)
        {
            decimal size = Math.Round(((decimal)uploadImageBox.PostedFile.ContentLength / (decimal)1024), 2);
            if (size < 10000)
            {
                string extension = System.IO.Path.GetExtension(uploadImageBox.FileName);
                if (extension == ".jpg" || extension == ".png" || extension == ".JPG" || extension == ".PNG" || extension == ".jpeg" || extension == ".JPEG")
                {
                    finalFilename = filename;
                    uploadImageBox.PostedFile.SaveAs(Server.MapPath("materialColor_database/" + finalFilename + ".png"));
                    try
                    {
                        connection.Open();

                        //-----------------------------for material--------------------------------
                        if (matColDropdown.SelectedValue == "Material")
                        {
                            try
                            {
                                if (getMaterialIDCmd.ExecuteScalar() == System.DBNull.Value)
                                {
                                    materialId = 1;
                                }
                                else
                                {
                                    materialId = Convert.ToInt32(getMaterialIDCmd.ExecuteScalar()) + 1;
                                }
                            }
                            catch (NullReferenceException ex)
                            {
                                materialId = 1;
                            }

                            updateMaterialCmd.Parameters.AddWithValue("@materialID", Convert.ToInt32(materialId));
                            updateMaterialCmd.Parameters.AddWithValue("@userID", Convert.ToInt32(Session["AcquireSession"]));
                            updateMaterialCmd.Parameters.AddWithValue("@materialName", Convert.ToString(matColName.Text));
                            updateMaterialCmd.Parameters.AddWithValue("@materialFilename", Convert.ToString(finalFilename));
                            updateMaterialCmd.Parameters.AddWithValue("@amount", Convert.ToInt32(matColAmount.Text));

                            updateMaterialCmd.ExecuteNonQuery();
                            Response.Redirect("materialColor.aspx");
                        }

                        //-----------------------------for color--------------------------------
                        else if (matColDropdown.SelectedValue == "Color")
                        {
                            try
                            {
                                if (getColorIDCmd.ExecuteScalar() == System.DBNull.Value)
                                {
                                    colorId = 1;
                                }
                                else
                                {
                                    colorId = Convert.ToInt32(getColorIDCmd.ExecuteScalar()) + 1;
                                }
                            }
                            catch (NullReferenceException ex)
                            {
                                colorId = 1;
                            }

                            updateColorCmd.Parameters.AddWithValue("@colorID", Convert.ToInt32(colorId));
                            updateColorCmd.Parameters.AddWithValue("@userID", Convert.ToInt32(Session["AcquireSession"]));
                            updateColorCmd.Parameters.AddWithValue("@colorName", Convert.ToString(matColName.Text));
                            updateColorCmd.Parameters.AddWithValue("@colorFilename", Convert.ToString(finalFilename));
                            updateColorCmd.Parameters.AddWithValue("@amount", Convert.ToInt32(matColAmount.Text));

                            updateColorCmd.ExecuteNonQuery();
                            Response.Redirect("materialColor.aspx");
                        }
                    }
                    catch (Exception ex)
                    {
                        msgLabel.Text = "Unknown error occured!";
                        msgLabel.Visible = true;
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
                else
                {
                    requiredFile.Text = "only JPEG/JPG/PNG files are allowed";
                    requiredFile.Visible = true;
                }
            }
            else
            {
                requiredFile.Text = "File size must not exceed 10 MB";
                requiredFile.Visible = true;
            }
        }
        else
        {
            requiredFile.Text = "Please select a image";
            requiredFile.Visible = true;
        }
    }

}
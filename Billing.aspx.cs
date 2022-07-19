using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Billing : System.Web.UI.Page
{
    static int Materialid = 0;
    static int Colorid = 0;
    static int ChairAmount = 0;
    static int BedAmount = 0;
    static int productId = 0;
    string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + Guid.NewGuid().ToString();
    static string hiddenValue;
    static string finalImageName;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HttpContext CurrentContext = HttpContext.Current;
            try
            {
                Materialid = Convert.ToInt32(CurrentContext.Items["Materialid"].ToString());
            } catch (Exception ex)
            {
                Materialid = 0;
            }

            try
            {
                Colorid = Convert.ToInt32(CurrentContext.Items["Colorid"].ToString());
            } catch (Exception ex)
            {
                Colorid = 0;
            }

            try
            {
                ChairAmount = Convert.ToInt32(CurrentContext.Items["ChairAmount"].ToString());
            } catch (Exception ex)
            {
                ChairAmount = 0;
            }

            try
            {
                BedAmount = Convert.ToInt32(CurrentContext.Items["BedAmount"].ToString());
            }
            catch (Exception ex)
            {
                BedAmount = 0;
            }

            try
            {
                hiddenValue = CurrentContext.Items["imageData"].ToString();
            }
            catch (Exception ex)
            {
                hiddenValue = null;
            }
            amountText.Text = (ChairAmount == 0 ? BedAmount : ChairAmount).ToString();
            if(BedAmount != 0)
            {
                amountText.Text = BedAmount.ToString();
            } else
            {
                amountText.Text = ChairAmount.ToString();
            }
        }
    }

    protected int updateProduct_master()
    {
        int product = 0;

        finalImageName = fileName;

        byte[] finalImage;

        FileStream fs = new FileStream(Server.MapPath("simulation_database/" + finalImageName + ".png"), FileMode.Create);
        BinaryWriter bw = new BinaryWriter(fs);

        finalImage = Convert.FromBase64String(hiddenValue);
        bw.Write(finalImage);
        bw.Close();

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string saveChairSim = "INSERT INTO product_master (product_id, user_id, total_amount, category_name, product_filename, material_id, color_id) VALUES (@id, @userid, @amount, @category, @filename, @material, @color)";
        string productId = "SELECT MAX (product_id) FROM product_master";
        connection.Open();
        try
        {
            try
            {
                SqlCommand productIdCmd = new SqlCommand(productId, connection);
                if (productIdCmd.ExecuteScalar() == System.DBNull.Value)
                {
                    product = 1;
                }
                else
                {
                    product = Convert.ToInt32(productIdCmd.ExecuteScalar()) + 1;
                }
            }
            catch (NullReferenceException ex)
            {
                product = 1;
            }
            SqlCommand saveChairSimCmd = new SqlCommand(saveChairSim, connection);
            saveChairSimCmd.Parameters.AddWithValue("id", Convert.ToInt32(product));
            saveChairSimCmd.Parameters.AddWithValue("userid", Convert.ToInt32(Session["AcquireSession"]));
            saveChairSimCmd.Parameters.AddWithValue("amount", Convert.ToInt32(amountText.Text));

            saveChairSimCmd.Parameters.AddWithValue("category", Session["SimulationCategory"].ToString());
            saveChairSimCmd.Parameters.AddWithValue("filename", finalImageName.ToString());
            saveChairSimCmd.Parameters.AddWithValue("material", Materialid);
            saveChairSimCmd.Parameters.AddWithValue("Color", Colorid);

            saveChairSimCmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            Response.Write("Some error occured");
        }
        finally
        {
            connection.Close();
        }
        return product;
    }

    protected void purchase_Click(object sender, EventArgs e)
    {
        int purchaseid = 0;
        
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
        string getPurchaseid = "SELECT MAX (purchase_id) FROM purchase_master";
        string updatePurchase = "INSERT INTO purchase_master(purchase_id, product_id, user_id, customer_name, email, phone, customer_address, purchase_date, shipping_date, order_complete) VALUES (@id, @productid, @userid, @name, @email, @phone, @customer_address, @purchaseDate, @shippingDate, @order)";
        connection.Open();
        try
        {
            productId = updateProduct_master();
            try
            {
                SqlCommand getPurchaseidCmd = new SqlCommand(getPurchaseid, connection);
                if (getPurchaseidCmd.ExecuteScalar() == System.DBNull.Value)
                {
                    purchaseid = 1;
                }
                else
                {
                    purchaseid = Convert.ToInt32(getPurchaseidCmd.ExecuteScalar()) + 1;
                }
            }
            catch (NullReferenceException ex)
            {
                purchaseid = 1;
            }
            SqlCommand updatePurchaseCmd = new SqlCommand(updatePurchase, connection);
            updatePurchaseCmd.Parameters.AddWithValue("id", purchaseid);
            updatePurchaseCmd.Parameters.AddWithValue("productid", productId);
            updatePurchaseCmd.Parameters.AddWithValue("userid", Convert.ToInt32(Session["AcquireSession"]));
            updatePurchaseCmd.Parameters.AddWithValue("name", Convert.ToString(customerNameText.Text.ToString()));
            if (string.IsNullOrEmpty(emailText.Text.ToString()))
            {
                updatePurchaseCmd.Parameters.AddWithValue("email", DBNull.Value);
            } else
            {
                updatePurchaseCmd.Parameters.AddWithValue("email", emailText.Text.ToString());
            }

            if (string.IsNullOrEmpty(phoneText.Text.ToString()))
            {
                updatePurchaseCmd.Parameters.AddWithValue("phone", DBNull.Value);
            } else
            {
                updatePurchaseCmd.Parameters.AddWithValue("phone", phoneText.Text.ToString());
            }

            if (string.IsNullOrEmpty(customerAddressText.Text.ToString()))
            {
                updatePurchaseCmd.Parameters.AddWithValue("customer_address", DBNull.Value);
            }
            else
            {
                updatePurchaseCmd.Parameters.AddWithValue("customer_address", customerAddressText.Text.ToString());
            }

            if (string.IsNullOrEmpty(purchaseDateText.Text.ToString()))
            {
                updatePurchaseCmd.Parameters.AddWithValue("purchaseDate", DateTime.Now.ToString("yyyy-MM-dd"));
            } else
            {
                updatePurchaseCmd.Parameters.AddWithValue("purchaseDate", purchaseDateText.Text.ToString());
            }

            if (string.IsNullOrEmpty(ShippingDateText.Text.ToString()))
            {
                updatePurchaseCmd.Parameters.AddWithValue("shippingDate", DBNull.Value);
            } else
            {
                updatePurchaseCmd.Parameters.AddWithValue("shippingDate", ShippingDateText.Text.ToString());
            }
            updatePurchaseCmd.Parameters.AddWithValue("order", "0");

            updatePurchaseCmd.ExecuteNonQuery();
            message.Text = "Updated Successfully!";
            message.ForeColor = System.Drawing.Color.Green;
            purchase.Visible = false;

        } catch (Exception ex)
        {
            message.Text = ex + "Some Error occured!";
        }
        finally
        {
            connection.Close();
        }
    }

    protected void back_Click (object sender, EventArgs e)
    {
        Response.Redirect("Simulation.aspx");
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ProCsharp.Chapters
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                PopulateGridView();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            UpdateDB();
        }

        static SqlConnection OpenSqlConnection()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["FacilityConnection"].ConnectionString;
            con.Open();
            return con;
        }

        private void UpdateDB()
        {
            try
            {
                SqlCommand cmd = new SqlCommand();
                using (cmd.Connection = OpenSqlConnection())
                {
                    cmd.CommandText = "INSERT INTO Facility "
                                    + "([username], [requestType], [requestDescription]) "
                                    + "VALUES "
                                    + "('user1'" + ", '"
                                    + DropDownList1.SelectedValue.ToString() + "', '"
                                    + TextBox1.Text + "')";
                    cmd.ExecuteNonQuery();
                    Alert.Show("Submitted successfully");
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        private void PopulateGridView()
        {
            string query = "SELECT * FROM Facility WHERE "
                + "userName='user1';";
            using (SqlDataAdapter da = new SqlDataAdapter(query, OpenSqlConnection()))
            {
                DataSet ds = new DataSet();
                da.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
        }

        
    }
}
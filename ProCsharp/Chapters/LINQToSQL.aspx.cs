using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ProCsharp.Chapters
{
    public partial class LINQToSQL : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBox1.Enabled = false;
            TextBox2.Enabled = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            bool selectAll = false;
            QueryDB queryDb;
            if (RadioButtonList1.SelectedValue == "SelectAll")
            {
                selectAll = true;
                queryDb = new QueryDB(selectAll, TextBox3.Text);
            }
            else
            {
                queryDb = new QueryDB(TextBox1.Text, TextBox2.Text, TextBox3.Text);
            }

            DataSet ds = queryDb.FireADOQuery();
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void OnRadioChanged(object sender, EventArgs e)
        {
            if (RadioButtonList1.SelectedValue == "SelectSpecific")
            {

                TextBox1.Enabled = true;
                TextBox2.Enabled = true;
            }
            else
            {
                TextBox1.Enabled = false;
                TextBox2.Enabled = false;
            }
        }
    }

    // To start with, add a LINQ to SQL class, NothWind.dbml to the solution: DONE
    // Using the NorthWind DB, create a 'Product' object from the Product Table using 
    // the O/R designer now created by the LINQ to SQL class (.dbml).
    public class QueryDB
    {
        private string column1, column2, condition;
        private bool selectAll;

        // Overload constructor for SELECT *, columns and no condition
        public QueryDB(bool selectAll)
            : this(selectAll, null)
        { }
        public QueryDB(bool selectAll, string condition)
        {
            this.selectAll = selectAll;
            this.condition = condition;
        }
        public QueryDB(string col1, string col2, string condition)
        {
            this.column1 = col1;
            this.column2 = col2;
            this.condition = condition;
        }

        // Using ADO.net
        public DataSet FireADOQuery()
        {
            // First, the connection details
            //string source = "server=(local);" + "integrated security=SSPI;" +
            //                "database=northwind";

            NorthWindDataContext dc = new NorthWindDataContext();   // Used the dbml way (Linq to SQL class)
            string connectionString = dc.Connection.ConnectionString;
            string query;

            if (selectAll)
            {
                if (condition != "")
                {
                    query = "SELECT * FROM Products WHERE " + condition;
                }
                else
                {
                    query = "SELECT * FROM Products";
                }
            }
            else
            {
                query = "SELECT " + column1 + ", " + column2 +
                        " FROM Products" +
                        " WHERE " + condition;
            }

            SqlConnection con = new SqlConnection(connectionString);

            // Using SQLDataAdapter to fill the DataSet
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        //NorthWindDataContext dc = new NorthWindDataContext();

        //// frame the query
        //if (selectAll && (condition != null))
        //{
        //    var col = dc.Products + condition;
        //var query = from p in dc.Products
        //            where p.cond
        //            select p


    }

}
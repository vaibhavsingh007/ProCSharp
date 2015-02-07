using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ServiceModel;
using System.Windows.Forms;
using System.Threading;

namespace ProCsharp.Chapters
{
    public partial class WCF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // In order to test the WCF Host and Service, create an instance of the proxy and use
            // GetData of the WCF Service. The current security context will be passed to the WCF
            // service
            WCFExampleServiceReference.MathOperationsServiceClient wcfService =
                new WCFExampleServiceReference.MathOperationsServiceClient();

            // Invoke the method Add and Sub
            int addResult = wcfService.AddNumbers(3, 5);
            int subResult = wcfService.SubNumbers(5, 3);

            MessageBox.Show("Result from the methods of the WCF Service. Operations on 5 and 3 for Add: " + addResult + " and Subtract: " + subResult);
        }
    }
}

    
    // Let us first create the class that reads and writes to the Product table
    //public class ProductsData
    //{
    //    // Method for adding a product
    //    public void AddProduct(Product products)
    //    {
    //        using (NorthWindDataContext data = new NorthWindDataContext())
    //        {
    //            data.Products.InsertOnSubmit(products);
    //            data.SubmitChanges();
    //        }
    //    }

    //    // Get the products based on the supplier ID
    //    public Product[] GetProducts(int supplierID)
    //    {
    //        using (NorthWindDataContext data = new NorthWindDataContext())
    //        {
    //            return (from p in data.Products
    //                    where p.SupplierID == supplierID
    //                    select p).ToArray();
    //        }
    //    }
    //}

    // Now the service can be created. Refer to the included WCF project in this solution

    //// Creating a custom service host for the WCF service
    //public class WCFHost
    //{
    //    internal static ServiceHost wcfHost = null;

    //    internal static void StartService()
    //    {
    //        wcfHost = new ServiceHost(typeof(ProductUpdateService1));
    //        wcfHost.Open();
    //    }

    //    internal static void StopService()
    //    {
    //        if (wcfHost.State != CommunicationState.Closed)
    //            wcfHost.Close();
    //    }

    //    public static void Fire()
    //    {
    //        StartService();
    //        MessageBox.Show("Server is running");
    //        Thread.Sleep(3000);
    //        StopService();
    //        MessageBox.Show("Server Stopped..");
    //    }
    //}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Interop.COMServer;
using System.Windows.Forms;

namespace ProCsharp.Chapters
{
    public partial class Interoperability : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            UseCOMServer.InvokeIWelcome();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            UseCOMServer.InvokeIMath();
        }
    }

    // A reference to the COM component COMServer.dll has been added in order to use its methods
    public static class UseCOMServer
    {
        internal static COMDemo comObj = new COMDemo();
        public static void InvokeIWelcome()
        {


            // If the object — as in this case — offers multiple interfaces, a variable of the other interface can be
            // declared, and by using a simple assignment with the cast operator, the wrapper class does a
            // QueryInterface() with the COM object to return the second interface pointer.

            IWelcome welcome = comObj;
            Alert.Show(welcome.Greeting("Heya! I'm Greeting() invoked from the COM!!"));
        }

        public static void InvokeIMath()
        {
            IMath math = comObj as IMath;
            int x = math.Add(4, 5);
            int y = math.Sub(5, 4);

            Alert.Show("Methods from IMath in the COM invoked for Add(4,5): " + x + " Sub(5,4): " + y);
        }
    }
}



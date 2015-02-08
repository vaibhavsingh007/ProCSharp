using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Diagnostics;
using System.Windows.Forms;

namespace ProCsharp.Chapters
{
    public partial class ThreadingAndSynchronization : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Button1_Click(object sender, EventArgs e)
        {
            TextBox1.Text = null;
            WaitAWhileTest.PollWaitAWhile();
            TextBox1.Text = WaitAWhileTest.ReturnString;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            WaitAWhileTest.AsyncCallWaitAWhile();
            TextBox1.Text = null;
            TextBox1.Text = WaitAWhileTest.ReturnString;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Process.Start("C:\\users\\Vaibhav\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\" +
            "ProCsharp\\ProCsharp\\RaceCondition\\RaceCondition\\bin\\Debug\\RaceCondition.exe");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Process.Start("C:\\users\\Vaibhav\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\" +
            "ProCsharp\\ProCsharp\\Synchronization_Lock\\Synchronization_Lock\\bin\\Debug\\Synchronization_Lock.exe");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Process.Start("C:\\users\\Vaibhav\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\" +
            "ProCsharp\\ProCsharp\\BackgroundWorkerSample\\BackgroundWorkerSample\\bin\\Debug\\BackgroundWorkerSample.exe");
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Process.Start("C:\\users\\Vaibhav\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\ProCsharp\\ProCsharp\\Synchronization_Lock\\TestingMutex\\ConsoleApplication1\\bin\\Debug\\ConsoleApplication1.exe");
        }

    }

    // Delegate for the WaitAWhile method used below
    public delegate int WaitAWhileDelegate(int data, int waitMS);

    public class WaitAWhileTest
    {
        static string returnString;
        public static string ReturnString
        {
            get { return returnString; }
        }

        public static int WaitAWhile(int data, int waitMS)
        {
            returnString += "\nWaitAWhile Started!\n";
            Thread.Sleep(waitMS);
            returnString += "\nWaitAWhile Completed!\n";
            return ++data;
        }

        // Now, using Polling
        public static void PollWaitAWhile()
        {
            // A general synchronous method call will be like this:
            // WaitAWhile(1, 2000);
            // And an asynchronous call is by using the delegate like this:

            //WaitAWhileDelegate d1 = WaitAWhile;   A Func<> delegate can also be used instead.
            Func<int, int, int> d1 = WaitAWhile;

            // Now use BeginInvoke which returns IAsyncResult for its 'IsCompleted' property
            // to be checked to see if the delegate has finished its work

            // The first two params are the params to the d1 delegate and the two 'null' params 
            // are ASyncCallback and object types (will be used in Asynchronous Callback method)
            IAsyncResult d1Result = d1.BeginInvoke(1, 3000, null, null);

            returnString += "\nThe dots are printed from PollWaitAWhile()\nNumber passed = 1 and wait 3000ms\n";
            while (!d1Result.IsCompleted)
            {
                Thread.Sleep(50);
                returnString += ".";
            }

            // EndInvoke() can be used to wait for the delegate too. Its job is also to simply 
            // wait for the delegate
            int result = d1.EndInvoke(d1Result);
            returnString += "\nResult: " + result.ToString();
        }

        // Now, using the Asynchronous Callback
        public static void AsyncCallWaitAWhile()
        {
            returnString = String.Empty;
            WaitAWhileDelegate d2 = WaitAWhile;

            //The AsyncCallback delegate (third parameter of BeginInvoke()) defines a parameter of IAsnycResult 
            //and a void return type. Here, the address of the method WaitAWhileCompleted is assigned to the third
            //parameter that fulfills the requirements of the AsyncCallback delegate. With the last parameter, you
            //can pass any object for accessing it from the callback method. It is useful to pass the delegate instance
            //itself, so the callback method can use it to get the result of the asynchronous method.
            d2.BeginInvoke(1, 3000, WaitAWhileCompleted, d2);

            returnString += "\nNow using the Asynchronous Callback:";
            returnString += "\nWaiting for AsyncCallWaitAWhile()\nNumber passed = 1 and wait 3000ms\n";
            int count = 0;
            for (int i = 0; i < 4; i++)
            {
                Thread.Sleep(1000);
                count++;
            }
            //count = count * 50;     //Converting the count to represent the total ms passed.
            returnString += "\nSeconds Waited: " + count.ToString();
        }

        // The following method can also be simply put as the 3rd param to the BeginInvoke() using Lambda expr.
        static void WaitAWhileCompleted(IAsyncResult ar)
        {
            //The last parameter passed with the BeginInvoke() method can be read
            //here using ar.AsyncState. With the WaitAWhileDelegate you can invoke the EndInvoke method to
            //get the result.
            WaitAWhileDelegate d2 = ar.AsyncState as WaitAWhileDelegate;
            int result = d2.EndInvoke(ar);
            returnString += "\nResult: " + result.ToString();

            //With a callback method, you need to pay attention to the fact that this method is
            //invoked from the thread of the delegate and not from the main thread.
        }
    }

}



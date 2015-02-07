using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WCFExample;
using System.ServiceModel;

namespace WCFCustomHost
{
    class Program
    {
        // Declare a ServiceHost type variable which will then be used to start and
        // stop the service
        internal static ServiceHost wcfHost = null;

        internal static void StartService()
        {
            wcfHost = new ServiceHost(typeof(MathOperationsService));
            wcfHost.Open();
        }

        internal static void StopService()
        {
            if (wcfHost.State != CommunicationState.Closed)
                wcfHost.Close();
        }

        // The above methods will now be used in main to test start and stop the service
        static void Main(string[] args)
        {
            StartService();
            Console.WriteLine("The server is now running. Press a key to exit..");
            Console.ReadLine();
            StopService();
        }
    }
}

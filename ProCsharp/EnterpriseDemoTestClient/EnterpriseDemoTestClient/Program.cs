using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SimpleServer;     // Added reference to the EnterpriseDemo COM+ library
using System.EnterpriseServices;    // For using the COM+ library, this is required

namespace EnterpriseDemoTestClient
{
    class Program
    {
        static void Main(string[] args)
        {
            // using is used to release the object before GC performs the cleanup
            using (SimpleComponent obj = new SimpleComponent())
            {
                Console.WriteLine(obj.GetType().ToString());
                for (int i = 0; i < 10; i++)
                {
                    Console.WriteLine(obj.Welcome("Vaibhav"));
                }
            }
        }
    }
}

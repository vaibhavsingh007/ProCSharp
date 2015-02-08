using System;
using System.Text;
using System.Threading;

namespace TestingMutex
{
    class OneAtATimePlease
    {
        static void Main(string[] args)
        {
            using (var mutex = new Mutex(false, "TestMutex"))
            {
                if (!mutex.WaitOne(TimeSpan.FromSeconds(3), false))
                {
                    Console.WriteLine("The application is already running. Bye!\nHit Enter..");
                    Console.ReadLine();
                    return;
                }
                RunProgram();
            }
        }
        static void RunProgram()
        {
            Console.WriteLine("Running! Hit Enter to exit!");
            Console.ReadLine();
        }
    }
}

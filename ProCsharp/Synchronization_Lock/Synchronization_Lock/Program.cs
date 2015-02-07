using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace Synchronization_Lock
{
    class Program // Mutex and Semaphore are also tested here. See the comments
    {
        // Here, 20 threads are started with the SharedState object and are then joined to 
        // wait untill all the threads have finished completing the task when the final output
        // is written.
        static void Main(string[] args)
        {
            int numThreads = 20;
            SharedState state = new SharedState();
            Thread[] threads = new Thread[numThreads];

            for (int i = 0; i < numThreads; i++)
            {
                threads[i] = new Thread(new Task(state).DoTheTask);
                threads[i].Start();
            }

            for (int i = 0; i < numThreads; i++)
            {
                threads[i].Join();
            }
            Console.WriteLine("Summarized value: {0}", state.State);
            Console.ReadKey();
        }
    }

    // Class that just contains the property that will be incremented several times
    public class SharedState
    {
        public int State { get; set; }
    }

    // This class will increment the State 50000 times
    public class Task
    {
        // For testing Mutex, uncomment the mutex related code
        //static bool newMutexCreated;
        //Mutex mutex = new Mutex(false, "TestMutex", out newMutexCreated);

        SharedState state;
        public Task(SharedState sharedState)
        {
            this.state = sharedState;
        }
        public void DoTheTask()
        {
            //if (mutex.WaitOne())
            //{
            //    Console.WriteLine("Mutex acquired by thread ID: " + Thread.CurrentThread.ManagedThreadId);
            //    try
            //    {
                    //lock (state)  // Uncomment to enable lock and synchronize this the shared object
                    {
                        for (int i = 0; i < 50000; i++)
                        {
                            state.State += 1;
                        }
                    }
            //    }
            //    finally
            //    {
            //        mutex.ReleaseMutex();
            //    }
            //}
            //else
            //{
            //    Console.WriteLine("\nSome issue while waiting. Mutex exists [TestMutex]...");
            //}
        }
    }
}

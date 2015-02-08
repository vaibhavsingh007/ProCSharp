using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Diagnostics;

namespace RaceCondition
{
    // Threading and Synchronization: Race Condition
    class Program
    {
        //A new StateObject is created that is shared between all the
        //threads. Thread objects are created by passing the address of RaceCondition with an object of type
        //SampleThread in the constructor of the Thread class. The thread is then started with the Start()
        //method, passing the state object.
        static void Main(string[] args)
        {
            StateObject state = new StateObject();
            // Initialize 20 threads accessing the same shared object
            for (int i = 0; i < 20; i++)
            {
                new Thread(new SampleThread().RaceCondition).Start(state);
            }
        }
    }

    // A class that increments a value by 1 and then checks if it is incremented or not to identify a Race Condition
    public class StateObject
    {
        private int state = 5;

        public void ChangeState(int loopNumber)
        {
            if (state == 5)
            {
                state++;
                Console.WriteLine("Waiting for Race condition at loop #: " + loopNumber
                    + " Inside thread : " + Thread.CurrentThread.ManagedThreadId + " State = " + state);
                Trace.Assert(state == 6, "Race condition occured after " + loopNumber + " loops");
            }
            state = 5;
        }
    }

    // A class that calls the ChangeState function from the above class inside an infinite loop
    public class SampleThread
    {
        public void RaceCondition(object o)
        {
            // The object o will be instantiated in the main class
            StateObject state = o as StateObject;

            int i = 0;
            while (true)
            {
                lock (state) // uncomment to enable lock and avoid Race Condition
                {
                    state.ChangeState(i++);
                }
            }
        }
    }
    //Instead of doing the lock when using the shared object, you can make the shared object thread - safe.
    //Here, the ChangeState() method contains a lock statement. Because you cannot lock the state
    //variable itself (only reference types can be used for a lock), the variable sync of type object is defined
    //and used with the lock statement. If a lock is done using the same synchronization object every time the
    //value state is changed, race conditions no longer happen.

    //public class StateObject
    //{
    //    private int state = 5;
    //    private object sync = new object();
    //    public void ChangeState(int loop)
    //    {
    //        lock (sync)   <-- No Race condition anymore
    //        {
    //            if (state == 5)
    //        {
    //            state++;
    //            Trace.Assert(state == 6, “Race condition occurred after “ +
    //            loop + “ loops”);
    //        }
    //        state = 5;
    //        }
    //    }
    //}
}


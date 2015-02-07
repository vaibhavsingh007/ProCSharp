using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;

namespace ProCsharp
{
    public class InterlockedTest
    {
        protected virtual void TestMethod()
        {
            string x = null;
            string newx = "testVal";
            //lock (this)       // Instead of this, use Interlocked
            //{
            //    if (x == null)
            //    {
            //        x = newx;
            //    }
            //}
            Interlocked.CompareExchange<string>(ref x, newx, null);
            int y = 2;
            Interlocked.Increment(ref y);
        }
    }
}
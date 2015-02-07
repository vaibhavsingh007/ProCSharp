using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace WCFExample
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    public class MathOperationsService : IMathOperationsService
    {
        public int AddNumbers(int first, int second)
        {
            return first + second;
        }

        public int SubNumbers(int first, int second)
        {
            return first - second;
        }
    }

    // We will now be hosting this WCF library in a Windows Service
}

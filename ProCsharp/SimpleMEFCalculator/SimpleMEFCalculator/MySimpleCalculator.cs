using System;
using System.ComponentModel.Composition;
using System.Collections.Generic;

namespace SimpleMEFCalculator
{
    //Now that we have defined ICalculator, we need a class that implements it.
    //This Export must match the Import contract in the 'Program'.
    [Export(typeof(ICalculator))]
    class MySimpleCalculator : ICalculator
    {
        /* In order for SimpleCalculator to be extensible, it needs to import a list of operations. An ordinary 
         * ImportAttribute attribute is filled by one and only one ExportAttribute. If more than one is available, 
         * the composition engine produces an error. To create an import that can be filled by any number of exports, 
         * we can use the ImportManyAttribute attribute.
         */
        [ImportMany]    // This is what will provide the real extensibility to the application.
        IEnumerable<Lazy<IOperation, IOperationData>> operations;

        //Since the composition container will be populated with all the parts available in this assembly, 
        //the MySimpleCalculator part will be available.
        public string Calculate(string input)
        {
            int left, right;
            Char operation;
            int fn = FindOperator(input);
            if (fn < 0) return "Could not parse command!";

            try
            {
                //Seperate the operands
                left = int.Parse(input.Substring(0, fn));
                right = int.Parse(input.Substring(fn + 1));
            }
            catch
            {
                return "Could not parse command!";
            }

            operation = input[fn];

            //Now check against the operations available in the composition.
            foreach (Lazy<IOperation, IOperationData> i in operations)
            {
                if (i.Metadata.Symbol.Equals(operation)) return i.Value.Operate(left, right).ToString();
            }
            return "Operation Not Found!";
        }

        private int FindOperator(string s)
        {
            for (int i = 0; i < s.Length; i++)
            {
                if (!(Char.IsDigit(s[i]))) return i;
            }
            return -1;
        }
    }
}

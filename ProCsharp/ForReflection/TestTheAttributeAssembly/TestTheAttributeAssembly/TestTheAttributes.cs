using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using LastModifiedAttribute;

//Specifying the assembly level attribute for
//the fact that this assembly supports the LastModifiedAttrib
//as defined in the LastModifiedAttributes assembly.
[assembly: SupportsLastModifiedAttrib]

namespace TestTheAttributeAssembly
{
    [LastModifiedAttrib("14 July 2012", "Vaibhav Singh",
        "Constructing the assembly for the first time")]
    public class TestTheAttributes
    {
        private int first, second;

        public TestTheAttributes(int first, int second)
        {
            this.first = first;
            this.second = second;
        }

        // Here is the method level attribute as allowed in
        // the LastModifiedAttrib assembly
        [LastModifiedAttrib("14 July 2012", "Vaibhav Singh",
            "Adding the first method to perform simple addition")]
        public int Add()
        {
            return (first + second);
        }
    }
}

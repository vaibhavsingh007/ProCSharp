using System;
using System.ComponentModel.Composition;

namespace SimpleMEFCalculator
{
    [Export(typeof(IOperation))]
    [ExportMetadata("Symbol", '+')]
    class Add : IOperation
    {
        public int Operate(int left, int right)
        {
            return left + right;
        }
    }
}

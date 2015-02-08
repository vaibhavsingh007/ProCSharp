using System;
using System.ComponentModel.Composition;

namespace SimpleMEFCalculator
{
    public interface IOperation
    {
        int Operate(int left, int right);
    }

    public interface IOperationData
    {
        Char Symbol { get; }
    }

    //Now add another class 'Add' implementing these, depicting extensibility..
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProCsharp.Chapters._1_ObjectsAndTypes
{
    public partial class ClassesAndStructs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DisplayInputData classObj = new DisplayInputData(TextBox1.Text.ToString());
            Label2.Text = classObj.InputString;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            DisplayInputDataStruct structObj = new DisplayInputDataStruct(TextBox1.Text.ToString());
            Label2.Text = structObj.InputString;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            RefOutExample refOutObj = new RefOutExample();
            TextBox2.Text = "Variables: refParam = " + refOutObj.refParam
            + "\nrefArray[0] = " + refOutObj.refArray[0]
            + "\nwithoutRefParam = " + refOutObj.withoutRefParam
            + "\noutParam = " + refOutObj.outParam
            + "\n\nCalling the method by ref..";

            refOutObj.RefMethod(refOutObj.refArray, ref refOutObj.refParam, refOutObj.withoutRefParam);
            TextBox2.Text += "\nNew values of the original variables after calling RefMethod are,"
            + "\nrefParam = " + refOutObj.refParam
            + "\nrefArray[0] = " + refOutObj.refArray[0]
            + "\nand withoutRefParam = " + refOutObj.withoutRefParam
            + "\n\nNow calling the OutMethod..";

            refOutObj.OutMethod(out refOutObj.outParam);
            TextBox2.Text += "\nThe outParam variable was declared but not initialized"
                + " \nhowever, after calling the OutMethod, "
                + "\noutParam = " + refOutObj.outParam;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            RefOutExample refOutObj = new RefOutExample();
            refOutObj.RefOutExtensionMethod(5);
            TextBox3.Text = "After calling the RefOutExtension Method with the value 5,"
                + "the new value of outParam variable is :" + refOutObj.outParam;
        }
    }


    public class DisplayInputData
    {
        private string inputString;
        const string concatString = "Using Class: Your name is ";
        public DisplayInputData(string inputValue)
        {
            this.inputString = concatString + inputValue;
        }

        public string InputString
        {
            get
            {
                return inputString;
            }
        }
    }

    public struct DisplayInputDataStruct
    {
        private string inputString;
        const string concatString = "Using Struct: Your name is ";
        public DisplayInputDataStruct(string inputValue)
        {
            this.inputString = concatString + inputValue;
        }

        public string InputString
        {
            get
            {
                return inputString;
            }
        }
    }

    public class RefOutExample
    {
        public int refParam = 0;    //A ref param is always needed to be initialized before it can be referenced.
        public int outParam;        //The out param is just declared, not initialized.
        public int withoutRefParam = 0;
        public int[] refArray = { 0, 1, 2, 3, 4 };

        public void RefMethod(int[] a, ref int refparam, int woRefParam)
        {
            a[0] = 1;
            refparam = 1;
            woRefParam = 1;
        }

        public void OutMethod(out int i)
        {
            i = 1;
        }
    }

    public static class RefOutExampleExtension
    {
        public static void RefOutExtensionMethod(this RefOutExample a, int value)
        {
            a.outParam += value;
        }
    }
}
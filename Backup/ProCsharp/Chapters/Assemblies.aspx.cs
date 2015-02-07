using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.CodeDom.Compiler;
using Microsoft.CSharp;
using System.Reflection;
using System.Text;
using System.IO;

namespace ProCsharp.Chapters
{
    public partial class Assemblies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            CodeDomExample codeDom = new CodeDomExample();
            TextBox2.Text = codeDom.CompileAndRun(TextBox1.Text.ToString(), false);
        }
    }

    public class CodeDomExample
    {
        private string prefix =
            "using System;" +
            "public static class CodeDriver" +
            "{" +
            "   public static void Run()" +
            "   {";

        private string postfix =
            "   }" +
            "}";

        public string CompileAndRun(string input, bool hasError)
        {
            hasError = false;
            string returnData = null;

            CompilerResults results = null;
            using (CSharpCodeProvider provider = new CSharpCodeProvider())
            {
                CompilerParameters options = new CompilerParameters();
                options.GenerateInMemory = true;

                StringBuilder sb = new StringBuilder();

                sb.Append(prefix);
                sb.Append(input);
                sb.Append(postfix);

                results = provider.CompileAssemblyFromSource(options, sb.ToString());
            }

            if (results.Errors.HasErrors)
            {
                hasError = true;
                StringBuilder errorMessage = new StringBuilder();

                foreach (CompilerError error in results.Errors)
                {
                    errorMessage.AppendFormat("{0} {1}", error.Line, error.ErrorText);
                }
                returnData = errorMessage.ToString();
            }
            else
            {
                TextWriter temp = Console.Out;
                StringWriter writer = new StringWriter();
                Console.SetOut(writer);

                Type driverType = results.CompiledAssembly.GetType("CodeDriver");
                driverType.InvokeMember("Run", BindingFlags.InvokeMethod | BindingFlags.Static |
                                            BindingFlags.Public, null, null, null);
                Console.SetOut(temp);
                returnData = writer.ToString();
            }
            return returnData;
        }
    }
}
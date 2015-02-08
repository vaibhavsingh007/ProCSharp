using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection; // Used for using the 'Assembly' type
using LastModifiedAttribute;    // Referencing the two custom built assemblies
using TestTheAttributeAssembly;
using System.Text; // For using StringBuilder

namespace ProCsharp.Chapters
{
    public partial class Reflection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            CheckAssembly.TestAssembly();
            TextBox1.Text = CheckAssembly.outputText.ToString();
        }
    }

    // This module uses two assemblies already built and referenced here: LastModifiedAttribute
    // and TestTheAttributeAssembly
    public class CheckAssembly
    {
        public static StringBuilder outputText = new StringBuilder(1000);
        public static void TestAssembly()
        {
            // The Assembly.Load method searches the local dir. and the GAC
            Assembly theAssembly = Assembly.Load("TestTheAttributeAssembly");

            // Getting the custom attributes defined in the loaded assembly
            Attribute supportsAttrib = Attribute.GetCustomAttribute(theAssembly, typeof(SupportsLastModifiedAttrib));
            string assemblyName = theAssembly.FullName;
            outputText.Append("\nAssembly Name: " + assemblyName);

            if (supportsAttrib == null)
            {
                outputText.Append("\nThis assembly does not support the LastModified attributes.");
                return;
            }
            else
            {
                outputText.Append("\nDefined types found: ");
                Type[] types = theAssembly.GetTypes();

                foreach (Type definedType in types)
                {
                    // Picking out only classes
                    if (definedType.IsClass)
                    {
                        outputText.Append("\nClass: " + definedType.Name);
                        Attribute[] attribs = Attribute.GetCustomAttributes(definedType);

                        // If the class stated no LastModifiedAttribute attribute then there were no changes
                        if (attribs.Length == 0)
                        {
                            outputText.Append("\nNo changes to this class");
                        }
                        else
                        {
                            foreach (Attribute attrib in attribs)
                            {
                                WriteAttributeInfo(attrib);
                            }
                        }
                    }
                    //else
                    //{
                        MethodInfo[] methods = definedType.GetMethods();
                        outputText.Append("\nChanges to the methods: ");

                        foreach (MethodInfo method in methods)
                        {
                            object[] attribs2 = method.GetCustomAttributes(typeof(LastModifiedAttrib), false);

                            if (attribs2 == null)
                            {
                                outputText.Append("\n" + method.ReturnType + " " + method.Name + "()");
                            }
                            foreach (Attribute nextAttrib in attribs2)
                            {
                                WriteAttributeInfo(nextAttrib);
                            }
                        }
                    //}
                }
            }
        }

        static void WriteAttributeInfo(Attribute attrib)
        {
            LastModifiedAttrib lastModifiedAttrib = attrib as LastModifiedAttrib;
            DateTime modifiedDate = lastModifiedAttrib.DateModified;

            if (lastModifiedAttrib == null)
            {
                return;
            }

            outputText.Append("\nModified: " + modifiedDate.ToLongDateString() + ":     "
                + lastModifiedAttrib.ChangesMade);
            outputText.Append("\nName and Comments from Dev: " + lastModifiedAttrib.NameOfDev
                + lastModifiedAttrib.Comments);
        }

    }
}
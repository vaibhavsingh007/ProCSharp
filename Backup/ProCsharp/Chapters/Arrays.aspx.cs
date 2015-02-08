using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

namespace ProCsharp.Chapters
{
    public partial class Arrays : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            MathOperations addOp = new MathOperations();
            int first = int.Parse(TextBox1.Text);
            int second = int.Parse(TextBox2.Text);
            Label2.Text = "The sum is: " + addOp.AddNumbers(first, second).ToString();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            MathOperations subOp = new MathOperations();
            int first = int.Parse(TextBox1.Text);
            int second = int.Parse(TextBox2.Text);
            Label2.Text = "The difference is: " + subOp.SubtractNumbers(first, second).ToString();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            TextBox4.Text = ReturnPeople.IteratePeople();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            TextBox5.Text = StringRW.RunStringRW();
        }
    }

    /*Lets say that a class implementing a Basic Operations interface has
    to perform atleast addition and subtraction. Hence, here, the class
    MathOperations will implement IBasicOperations interface to assure
    that the addition and subtraction operations are definitely available
    with it like a Contract*/

    public interface IBasicOperations
    {
        int AddNumbers(int x, int y);
        int SubtractNumbers(int x, int y);
    }

    public class MathOperations : IBasicOperations
    {
        public int AddNumbers(int first, int second)
        {
            return (first + second);
        }

        public int SubtractNumbers(int first, int second)
        {
            return (first - second);
        }
    } // End of Interface example.


    /* Example: Foreach and yield return. Will get a collection of string from the user 
     * and then iterate and return sorted.
     * This class should implement the GetEnumerator() method from IEnumerable that will be used later by 
     * foreach to iterate through the collection in this class (this type).
     */

    public class Person
    {
        public Person(string fname, string lname)
        {
            this.FirstName = fname;
            this.LastName = lname;
        }

        public readonly string FirstName;
        public readonly string LastName;
    }

    public class People : IEnumerable<Person>
    {
        private Person[] _people;

        public People(Person[] people)
        {
            _people = new Person[people.Length];

            for (int i = 0; i < people.Length; i++)
            {
                this._people[i] = people[i];
            }
        }

        public IEnumerator GetEnumerator()
        {
            for (int i = 0; i < _people.Count(); i++)
            {
                yield return _people[i];
            }
        }

        IEnumerator<Person> IEnumerable<Person>.GetEnumerator()
        {
            // This is a doubt though the source is 
            // http://msdn.microsoft.com/en-us/library/system.collections.ienumerable.aspx
            return GetEnumerator() as IEnumerator<Person>;
        }
    }

    public class ReturnPeople
    {
        public static string IteratePeople()
        {
            string returnString = null;
            int count = 0;
            Person[] personArray = new Person[3]
                                {
                                    new Person("James", "White"),
                                    new Person("Mark", "Buchanan"),
                                    new Person("Joseph", "Ulrich")
                                };
            People people = new People(personArray);
            foreach (Person person in people)
            {
                count++;
                returnString += String.Format("Iteration {2}..\nFirst Name: {0}\nLast Name: {1}\n\n", person.FirstName, person.LastName, count);
            }
            return returnString;
        }

    } // End of the foreach, yield return example.

    // Example for StringReader and StringWriter
    public class StringRW
    {
        public static string RunStringRW()
        {
            //StringBuilder sb = new StringBuilder();
            string returnString = null;
            string textReaderText = "TextReader is the abstract base " +
                "class of StreamReader and StringReader, which read " +
                "characters from streams and strings, respectively.\n\n" +

                "Create an instance of TextReader to open a text file " +
                "for reading a specified range of characters, or to " +
                "create a reader based on an existing stream.\n\n" +

                "You can also use an instance of TextReader to read " +
                "text from a custom backing store using the same " +
                "APIs you would use for a string or a stream.\n\n";

            returnString += string.Format("Original text:\n\n{0}", textReaderText);

            // From textReaderText, create a continuous paragraph  
            // with two spaces between each sentence. 
            string aLine, aParagraph = null;
            StringReader strReader = new StringReader(textReaderText);
            while (true)
            {
                aLine = strReader.ReadLine();
                if (aLine != null)
                {
                    aParagraph = aParagraph + aLine + " ";
                }
                else
                {
                    aParagraph = aParagraph + "\n";
                    break;
                }
            }
            returnString += string.Format("Modified text:\n\n{0}", aParagraph);

            // Re-create textReaderText from aParagraph. 
            int intCharacter;
            char convertedCharacter;
            StringWriter strWriter = new StringWriter();
            strReader = new StringReader(aParagraph);
            while (true)
            {
                intCharacter = strReader.Read();

                // Check for the end of the string  
                // before converting to a character. 
                if (intCharacter == -1) break;

                convertedCharacter = Convert.ToChar(intCharacter);
                if (convertedCharacter == '.')
                {
                    strWriter.Write(".\n\n");

                    // Bypass the spaces between sentences.
                    strReader.Read();
                    strReader.Read();
                }
                else
                {
                    strWriter.Write(convertedCharacter);
                }
            }
            returnString += string.Format("\nOriginal text:\n\n{0}", strWriter.ToString());
            return returnString;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.SqlServer;
using System.IO;
using System.Threading;

namespace ProCsharp.Chapters
{
    public partial class Parallelization : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            TextBox1.Text = ParallelizationStudy.ParallelSpellCheck();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TextBox1.Text = ParallelizationStudy.ParallelSpellCheck(true);
        }
    }

    public class ParallelizationStudy
    {
        public static string ParallelSpellCheck(bool cancellation = false)
        {
            string wordLookupPath = "C:\\users\\Vaibhav\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\ProCsharp\\ProCsharp\\App_Data\\WordLookup.txt";
            var wordLookup = new HashSet<string>(File.ReadAllLines(wordLookupPath), StringComparer.InvariantCultureIgnoreCase);
            string text = null;
            /* We’ll now use our word lookup to create a test “document” comprising an array 
             * of a million random words. After building the array, we’ll introduce a couple of spelling mistakes
             */

            var random = new Random();
            string[] wordList = wordLookup.ToArray();

            string[] wordsToTest = Enumerable.Range(0, 100000)
                                        .Select(i => wordList[random.Next(0, wordList.Length)])
                                        .ToArray();

            // Introduce a couple of spelling mistakes
            wordsToTest[12345] = "woozshk";
            wordsToTest[23422] = "apwfjae";

            // Now we can perform our parallel spellcheck by testing wordsToTest against wordLookup
            if (cancellation)   // Demonstrate with cancellation else without it
            {
                var cancelSource = new CancellationTokenSource();

                var query = wordsToTest
                            .AsParallel().WithCancellation(cancelSource.Token)
                            .Select((word, index) => new IndexedWord { Word = word, Index = index })
                            .Where(iword => !wordLookup.Contains(iword.Word))
                            .OrderBy(iword => iword.Index);
                
                // Another thread supplies the cancellation token to the query
                new Thread(() =>
                {
                    Thread.Sleep(100);
                    cancelSource.Cancel();
                }).Start();

                try
                {
                    foreach (var mistake in query)
                    {
                        text += ("\n " + mistake.Word + " at index: " + mistake.Index);
                    }
                }
                catch (OperationCanceledException oce)
                {
                    text = oce.Message.ToString();
                }
            }
            else
            {
                var query = wordsToTest
                            .AsParallel()
                            .Select((word, index) => new IndexedWord { Word = word, Index = index })
                            .Where(iword => !wordLookup.Contains(iword.Word))
                            .OrderBy(iword => iword.Index);

                foreach (var mistake in query)
                {
                    text += ("\n " + mistake.Word + " at index: " + mistake.Index);
                }
            }
            return text;
        }

        /* We could simplify the query slightly by using an anonymous type instead of the IndexedWord struct.
            However, this would degrade performance because anonymous types (being classes and therefore reference
            types) incur the cost of heap-based allocation and subsequent garbage collection.
         */
        public struct IndexedWord { public string Word; public int Index; }




    }
}

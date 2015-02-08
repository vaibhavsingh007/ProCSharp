using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace ProCsharp.Chapters
{
    public partial class LINQ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TextBox1.Text += "Student Name\t[ Class,  Total Mark, Class Teacher ]\n";
                TextBox1.Text += "============\n";
                foreach (var stu in Students.GetStudents())
                {
                    TextBox1.Text += stu.StuName + "\t[ ";
                    //TextBox1.Text += String.Format("{0:-10}", stu.StuClass);
                    TextBox1.Text += stu.StuClass + ", " + stu.TotalMarks + ", " + stu.StuTeacher + " ]";
                    TextBox1.Text += "\n";
                }

                TextBox1.Text += "\n\nSubject\t[ Teacher ]\n";
                TextBox1.Text += "=======\n";
                foreach (var sub in Subjects.GetSubjects())
                {
                    TextBox1.Text += sub.SubjectName;
                    //TextBox1.Text += String.Format("{0:-10}", stu.StuClass);
                    TextBox1.Text += "\t" + sub.SubjectTeacher;
                    TextBox1.Text += "\n";
                }
            }
        }


        public delegate IList<Student> LinqMethods();
        protected void Button1_Click(object sender, EventArgs e)
        {
            TextBox2.Text = "Calling respective LINQ methods in the class LinqExamples..\n";

            // Using multicast Delegate in order to call all the methods
            LinqMethods linqMethods = LinqExamples.SimpleLinqQuery;
            linqMethods += LinqExamples.FilteringWithIndex;
            linqMethods += LinqExamples.SetOperations;
            // Will take up the Join() method seperately as it returns an 'object' type.

            Delegate[] delMethods = linqMethods.GetInvocationList();
            foreach (LinqMethods d in delMethods)
            {
                TextBox2.Text += "\n\nCalling method : " + d.Method.Name;
                foreach (var stu in d())
                {
                    TextBox2.Text += "\n" + stu.StuName + ", " + stu.StuClass + ", "
                        + stu.StuTeacher + ", " + stu.TotalMarks;
                }
            }

            TextBox2.Text += "\n\nCalling method : Join\n";
            TextBox2.Text += "\n[Student]\t[Teacher]\t[Subject]\n";
            foreach (string s in LinqExamples.Join())
            {
                TextBox2.Text += s;
            }
                
        }
    }

    public class Student        // Define the student fields that will be stored as a collection.
    {
        public string StuName { get; set; }
        public string StuClass { get; set; }
        public string StuTeacher { get; set; }
        public int TotalMarks { get; set; }
    }

    public class Subject        // Define the subject fields.
    {
        public string SubjectName { get; set; }
        public string SubjectTeacher { get; set; }
    }


    public static class Students    // Create a list of students.
    {
        /* Returning IList is an OOP pattern which seperates the interface implementation from the class.
         * It provides the flexibility to now use the returned item(s) with any class that implements IList<>.
         * To make it more concrete (but not loosely coupled) List<> type objects could also have been returned.
         */
        public static List<Student> GetStudents()
        {
            List<Student> students = new List<Student>(5);
            students.Add(new Student()
            {
                StuName = "James Paul",
                StuClass = "11A",
                StuTeacher = "Mike Jose",
                TotalMarks = 300
            });
            students.Add(new Student()
            {
                StuName = "Jimmy Hendrikson",
                StuClass = "7A",
                StuTeacher = "Ronald McKinley",
                TotalMarks = 500
            });
            students.Add(new Student()
            {
                StuName = "Lene Drewes",
                StuClass = "10C",
                StuTeacher = "Ronnie Colt",
                TotalMarks = 700
            });
            students.Add(new Student()
            {
                StuName = "Dirk F Lassen",
                StuClass = "10C",
                StuTeacher = "Kim Horn",
                TotalMarks = 300
            });
            students.Add(new Student()
            {
                StuName = "Rita Smith",
                StuClass = "11A",
                StuTeacher = "Kim Horn",
                TotalMarks = 400
            });
            return students;
        }
    }
    
    public static class Subjects
    { 
        public static List<Subject> GetSubjects()
        {
            List<Subject> sub = new List<Subject>(3);
            sub.Add(new Subject() { SubjectName = "Physics", SubjectTeacher = "Ronnie Colt" });
            sub.Add(new Subject() { SubjectName = "Maths", SubjectTeacher = "Kim Horn" });
            sub.Add(new Subject() { SubjectName = "Chemistry", SubjectTeacher = "Mike Jose" });
            return sub;
        }
    }

    public static class LinqExamples
    {
        // Implementing the Where() extension method of the IEnumerable<T> interface to be 
        // used with the Students class. This will be used when filtering with index.
        //public static IEnumerable<T> Where<T>(this List<T> source, Func<T, bool> predicate)
        //{
        //    foreach (T item in source)
        //        if (predicate(item))
        //            yield return item;
        //}

        // A simple LINQ query returning the students with teacher 'Kim Horn' from the list
        // sorted in descending order of the total marks.
        private static List<Student> results = new List<Student>();
        public static IList<Student> SimpleLinqQuery()
        {
            results.Clear();
            var query = from r in Students.GetStudents()
                        where r.StuTeacher == "Kim Horn"
                        orderby r.TotalMarks descending
                        select r;
            foreach (Student r in query)
            {
                results.Add(r);
            }
            return results;
        }

        // Filtering with index. Here LINQ cannot be used with the overload of the where() method.
        public static List<Student> FilteringWithIndex()       // DOUBT
        {
            results.Clear();
            
            var students = Students.GetStudents().Where((r, index) => r.StuName.StartsWith("J") && index % 2 != 0)
                .Select(i => i);
            foreach (Student r in students)
            {
                results.Add(r);
            }
            return results;
        }

        // Join -> For doing this, first two queries on the Student and Subject should be defined.
        // The join will be performed on the teacher name to get the subjects taught by each class teacher.
        public static List<string> Join()
        {
            List<string> result = new List<string>();
            var students = from stu in Students.GetStudents()
                           select new
                           {
                               StudentName = stu.StuName,
                               Teacher = stu.StuTeacher
                           };
            var subjects = from sub in Subjects.GetSubjects()
                           select new
                           {
                               Teacher = sub.SubjectTeacher,
                               SubjectName = sub.SubjectName
                           };

            // Join will now be done based on the teacher name.

            var stuTeacherSub = from stu in students
                                join sub in subjects on stu.Teacher equals sub.Teacher
                                select new
                                {
                                    StudentName = stu.StudentName,
                                    ClassTeacher = stu.Teacher,
                                    ClassTeacherSub = sub.SubjectName
                                };
            foreach (var item in stuTeacherSub)
            {
                result.Add("\n" + item.StudentName.ToString());
                result.Add("\t" + item.ClassTeacher.ToString());
                result.Add("\t" + item.ClassTeacherSub.ToString());
            }

            return result;
        }

        public static List<Student> SetOperations()
        {
            results.Clear();
            // Set Operations -> Extension methods: Distinct(), Union(), Intersect(), Except().
            // Using this, let us find a Teacher teaching both the 10C and 11A
            // It is clear that Intersect() will run the query against the common elements of two sets.
            // Hence, to avoid writing the same query twice, a delegate type method is used as below:

            Func<string, IEnumerable<Student>> TeachersByClass = stu_Class =>
                                                                    Students.GetStudents()
                                                                    .Where(c => c.StuClass == stu_Class)
                                                                    .OrderBy(i => i.StuTeacher)
                                                                    .Select(i => i);

            foreach (var stu in TeachersByClass("11A").Union(TeachersByClass("10C")))
            {
                results.Add(stu);
            }
            return results;
        }
    }
}

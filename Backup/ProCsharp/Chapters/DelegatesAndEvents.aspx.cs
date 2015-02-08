using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProCsharp.Chapters
{
    public partial class DelegatesAndEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int first = int.Parse(TextBox1.Text);
            int second = int.Parse(TextBox2.Text);
            UseDelegate useDelegate = new UseDelegate(first, second);
            Label1.Text = "The result of Add and Sub operations: " + useDelegate.PerformOp();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            AnonymousAndLamba anonObj = new AnonymousAndLamba(int.Parse(TextBox1.Text), int.Parse(TextBox2.Text));
            Label2.Text = anonObj.Add().ToString();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            AnonymousAndLamba lambdaObj = new AnonymousAndLamba(int.Parse(TextBox1.Text), int.Parse(TextBox2.Text));
            Label3.Text = lambdaObj.Subtract().ToString();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            TestEvent testEvent = new TestEvent(int.Parse(TextBox3.Text));
            
            if (Button4.Text == "Clear")
            {
                Label4.Text = testEvent.TestListEvent(true).ToString();
            }
            else
            {
                Label4.Text = testEvent.TestListEvent().ToString();
            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            
            //Alert.Show("Not implemented");
        }
    }

    // Delegate Example.

    public delegate int MathOpsDelegate(int first, int second);

    class UseDelegate
    {
        private int firstNumber, secondNumber;
        public UseDelegate(int first, int second)
        {
            this.firstNumber = first;
            this.secondNumber = second;
        }

        public string PerformOp()
        {
            string results = null;
            MathOperations MathOp = new MathOperations();
            MathOpsDelegate del = MathOp.AddNumbers;
            del += MathOp.SubtractNumbers;

            Delegate[] delMethods = del.GetInvocationList();
            foreach (MathOpsDelegate d in delMethods)
            {
                try
                {
                    results += d(firstNumber, secondNumber).ToString() + " ";
                }
                catch (Exception)
                { }
            }
            return results;
        }
    } // Delegate example ends.

    // Anonymous methods and Lambda expressions.

    public class AnonymousAndLamba
    {
        private int first, second;
        public AnonymousAndLamba(int first, int second)
        {
            this.first = first;
            this.second = second;
        }

        delegate int TestDelegate(int param1, int param2);

        public int Add()
        {
            TestDelegate anonDel = delegate(int param1, int param2)     // Using anonymous method
                {
                    return (param1 + param2);
                };
            return anonDel(first, second);
        }

        public int Subtract()
        {
            TestDelegate lambdaDel = (param1, param2) => param1 - param2;   // Using a lambda expr
            return lambdaDel(first, second);
        }
    } // End of Anonymous methods and Lambda expressions example.

    
    // Events (with Generics). Will create a list generating events when it is changed.

    // A delegate type for hooking up change notifications.
    public delegate void ChangedEventHandler(Object sender, EventArgs e);

    // A collection class implementing List<T> that sends event notifications
    // whenever the list is changed.
    public class ListWithChangedEvents<T> : List<T>
    {
        // An event that clients can use to get notified.
        public event ChangedEventHandler Changed;   // So an event is always defined as a delegate type

        // Invoking the 'Changed' event after performing a null check. Hence,
        // wrapping inside the 'OnChanged' method. This method will be called 
        // whenever an event has to be generated.
        protected virtual void OnChanged(EventArgs e)       // This has to be overriden in the implementing class
        {
            if (Changed != null)
            {
                Changed(this, e);
            }
        }

        // Implement methods from List<T> and invoke event after each.
        public new void Add(T item)
        {
            base.Add(item);
            OnChanged(EventArgs.Empty);
        }

        public new void Clear()
        {
            base.Clear();
            OnChanged(EventArgs.Empty);
        }

        public new T this[int index]
        {
            set
            {
                base[index] = value;
                OnChanged(EventArgs.Empty);
            }
        }
    }

    // Now, the ListWithChangedEvents type list can deliver events as defined above.
    // Let us use it. The funda used below to assign an event handler to the event can also be implemented 
    // in the main class generating the event above (unless its generic). This is done simply to assign 
    // the event handler independently.
    class EventListener
    {
        private ListWithChangedEvents<int> List;

        public EventListener(ListWithChangedEvents<int> list)
        {
            this.List = list;
            // Add the method to be called at the changed event of the list.
            List.Changed += new ChangedEventHandler(ListChanged);
        }

        private void ListChanged(object sender, EventArgs e)
        {
            Alert.Show("List Changed Event Triggered!");
        }

        public void Detach()
        {
            // Detach the event and delete the list.
            List.Changed -= new ChangedEventHandler(ListChanged);
            List = null;
        }
    }

    public class TestEvent
    {
        private int numberToAdd;

        public TestEvent(int num)
        {
            this.numberToAdd = num;
        }

        public string TestListEvent(bool clear = false)
        {
            string listItems = null;
            // Create the list
            ListWithChangedEvents<int> list = new ListWithChangedEvents<int>();

            // Create the listener (instance)
            EventListener listener = new EventListener(list);

            // Now try to modify the list
            list.Add(numberToAdd);

            if (clear)
            {
                list.Clear();
            }

            foreach (int item in list)
            {
                listItems += string.Format("Item: {0}\n", item.ToString());
            }
            listener.Detach();
            return listItems;
        }
    }
}
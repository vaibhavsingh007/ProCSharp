using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Windows.Forms;
using System.IO;

namespace ProCsharp.Chapters
{
    public partial class TracingAndEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DemonstrateTracing.RunDemonstrateTracing();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            DemonstrateEventLogging.RunDemonstrateEventLogging();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            DemonstrateEventLogging.RunUsingResourceFile();
        }
    }

    public class DemonstrateTracing
    {
        public static void RunDemonstrateTracing()
        {
            // Create a new trace source
            TraceSource source1 = new TraceSource("TracingAndEvents");

            // Define the trace switch with the trace level
            //source1.Switch = new SourceSwitch("MySwitch", "Verbose");   // Also added to the web.config under configuration

            source1.TraceInformation("Info message"); // Instead of writing this explicit info, use TraceEvent() and
            // supply the eventlevel enumerator. Simple!
            source1.TraceEvent(TraceEventType.Error, 3, "Error message");

            /*With the TraceData() method, you can pass any object, for example an exception
            instance, instead of a message. To make sure that data is written by the listeners and does not stay in
            memory, you need to do a Flush() . If the source is no longer needed, you can invoke the Close()
            method that closes all listeners associated with the trace source. Close() does a Flush() as well.
             */
            source1.TraceData(TraceEventType.Information, 2, new int[] { 1, 2, 3 });
            source1.Flush();
            source1.Close();
            Alert.Show("Tracing completed!");
        }
    }

    public class DemonstrateEventLogging
    {
        public static void RunDemonstrateEventLogging()
        {
            // Create an event source
            // Error encountered on first run: The application attempted to perform an operation not allowed by 
            // the security policy. Running Visual Studio as administrator resolved the issue.
            if (!EventLog.SourceExists("TracingAndEvents"))
            {
                EventSourceCreationData eventSourceData = new EventSourceCreationData("TracingAndEvents", "CsharpExemplificationLog");
                EventLog.CreateEventSource(eventSourceData);
            }

            // For writing event log entries, you can use the WriteEntry() or WriteEvent() methods of the
            //EventLog class.
            using (EventLog log = new EventLog("CsharpExemplificationLog", ".", "TracingAndEvents"))
            {
                log.WriteEntry("Message 1");
                log.WriteEntry("Message 2", EventLogEntryType.Warning);
                log.WriteEntry("Message 3", EventLogEntryType.Information, 33);
            }
            Alert.Show("Logging completed!");
        }

        public static string ReturnString { get; set; }

        public static void RunUsingResourceFile()
        {
            // If you want to delete a previously created event source, you can do so with 
            // EventLog.DeleteEventSource(sourceName); . To delete a log, you can invoke EventLog.Delete(logName); .
            string logName = "CsharpExemplificationLog";
            string sourceName = "TracingAndEvents";
            string resourceFile = @"C:\Users\test\Documents\Visual Studio 2010\Projects\ASPdotnet\ProCsharp\ProCsharp\App_Data\EventLogDemoMessages.dll";

            if (!EventLog.SourceExists(sourceName))
            {
                if (!File.Exists(resourceFile))
                {
                    ReturnString = "Message resource file does not exist!";
                    return;
                }

                EventSourceCreationData eventSource = new EventSourceCreationData(sourceName, logName);

                eventSource.CategoryResourceFile = resourceFile;
                eventSource.CategoryCount = 4;
                eventSource.MessageResourceFile = resourceFile;
                eventSource.ParameterResourceFile = resourceFile;

                EventLog.CreateEventSource(eventSource);
            }
            else
            {
                logName = EventLog.LogNameFromSourceName(sourceName, ".");
            }

            EventLog evlog = new EventLog(logName, ".", sourceName);

            // Finally, the method RegisterDisplayName() from the EventLog class specifies the name of the log as it is
            // displayed in the Event Viewer. The ID 5001 is taken from the message file.
            evlog.RegisterDisplayName(resourceFile, 5001);

            // Now, you can use the WriteEvent() method instead of WriteEntry() to write the event log entry.
            //WriteEvent() requires an object of type EventInstance as parameter. With the EventInstance , you
            //can assign the message ID, the category, and the severity of type EventLogEntryType . In addition to the
            //EventInstance parameter, WriteEvent() accepts parameters for messages that have parameters and
            //binary data as byte array.
            EventLog log = new EventLog(logName, ".", sourceName);
            EventInstance info1 = new EventInstance(1000, 4, EventLogEntryType.Information);
            log.WriteEvent(info1);
            EventInstance info2 = new EventInstance(1001, 4, EventLogEntryType.Error);
            log.WriteEvent(info2, "avalon");
            EventInstance info3 = new EventInstance(1002, 3, EventLogEntryType.Error);
            byte[] addionalInfo = { 1, 2, 3 };
            log.WriteEvent(info3, addionalInfo);
            log.Dispose();

            Alert.Show("Logging from resource file completed!");

        }
    }
}
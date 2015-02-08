using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;

namespace BackgroundWorkerSample
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void buttonCalculate_Click(object sender, EventArgs e)
        {
            buttonCalculate.Enabled = false;
            textBoxResult.Text = string.Empty;
            buttonCancel.Enabled = true;
            progressBar.Value = 0;
            progressBar.ForeColor = Color.Green;

            // The BackgroundWorker will do the task using a thread from a thread pool in
            // the background and we will use its methods to control/track the progress.

            // To start the BackgroundWorker, invoke RunWorkerAsync()
            backgroundWorker.RunWorkerAsync(new CalcInput(int.Parse(textBox.Text), int.Parse(textBoxY.Text)));

        }

        // Event handler for the DoWork event from the BackgroundWorker
        private void OnDoWork(object sender, DoWorkEventArgs e)
        {
            // The arguments are recieved using the 'Argument' property of the event
            CalcInput input = (CalcInput)e.Argument;

            // Implementing cancellation (refer to the OnCancel event)
            for (int i = 0; i < 10; i++)
            {
                Thread.Sleep(500); // to take some time
                backgroundWorker.ReportProgress(i * 10);
                if (backgroundWorker.CancellationPending)
                {
                    e.Cancel = true;
                    return;
                }
            }
            e.Result = input.x + input.y;
            // After OnDoWork is completed, the background worker fires the RunWorkerCompleted event
        }

        private void OnProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            this.progressBar.Value = e.ProgressPercentage;
        }

        private void OnWorkCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            // The result from DoWork is accessed using the Result property of the event
            // This will directly be written to the TextBoxResult
            if (e.Cancelled)
            {
                textBoxResult.Text = "Cancelled!";
                progressBar.ForeColor = Color.Red;  //Comment 'EnableVisualStyles' line in Program()
                                                    //for this to work.
                progressBar.Style = ProgressBarStyle.Continuous;
            }
            else
                textBoxResult.Text = e.Result.ToString(); // [Cancellation not handled. Refer to theory for implementation]

            buttonCalculate.Enabled = true;
            buttonCancel.Enabled = false;
            progressBar.Value = 100;

            // When firing the event, the BackgroundWorker control changes control to the creator
            // thread, so there is no need to use the Invoke methods of the Windows Forms controls, 
            // and you can invoke properties and methods of Windows Forms controls directly.
        }

        private void OnCancel(object sender, EventArgs e)
        {
            // To enable the cancel functionality to stop the thread's progress while it is running, 
            // the BackgroundWorker property WorkerSupportsCancellation is set to True.
            backgroundWorker.CancelAsync();
            // Now use the CancellationPending property in the DoWork for this to actually work.
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        } 
    }

    // Creating the struct to store values from the text boxes
    public struct CalcInput
    {
        public int x, y;
        public CalcInput(int x, int y)
        {
            this.x = x;
            this.y = y;
        }
    }

}

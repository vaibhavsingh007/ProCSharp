using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using GreetingServer;

namespace GreetingService
{
    public partial class GreetingService : ServiceBase
    {
        public GreetingService()
        {
            InitializeComponent();
        }

        private TestServer testServer;

        protected override void OnStart(string[] args)
        {
            testServer = new TestServer();
            testServer.Start();
        }

        protected override void OnStop()
        {
            testServer.Stop();
        }
    }
}

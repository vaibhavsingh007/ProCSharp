using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using WCFExample;

namespace WCFWindowsService
{
    public partial class Service1 : ServiceBase
    {
        public Service1()
        {
            InitializeComponent();
        }

        internal static ServiceHost wcfHost = null;

        internal static void StartService()
        {
            wcfHost = new ServiceHost(typeof(MathOperationsService));
            wcfHost.Open();
        }

        internal static void StopService()
        {
            if (wcfHost.State != CommunicationState.Closed)
                wcfHost.Close();
        }

        protected override void OnStart(string[] args)
        {
            if (wcfHost != null)
            {
                wcfHost.Close();
            }
            StartService();
        }

        protected override void OnStop()
        {
            StopService();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.EnterpriseServices; // Needed for inheriting from ServicedComponent
using System.Runtime.InteropServices; // For using the [ComVisible] attribute

[assembly: ApplicationName("EnterpriseDemo")]
[assembly: Description("Example to demonstrate the Enterprise Services")]
[assembly: ApplicationActivation(ActivationOption.Server)] // Whether to run as a server or library(within a client)
[assembly: ApplicationAccessControl(false)] // For specifying security(off in this case - all can access)
namespace SimpleServer
{
    // Create an interface to set a contract between the client and the component
    [ComVisible(true)]  // Makes the interface accessible from Enterprise Services features
    public interface IGreeting
    {
        string Welcome(string name);
    }

    [EventTrackingEnabled(true)]    // To monitor objects using the Components Services Explorer(reduces performance)
    [ComVisible(true)]
    [Description("Simple Serviced Component Sample")]
    public class SimpleComponent : ServicedComponent, IGreeting
    {
        public string Welcome(string name)
        {
            // Simulate some processing time
            System.Threading.Thread.Sleep(2000);
            return "Hello " + name;
        }
    }
    //Other than applying some attributes and deriving the class from ServicedComponent , there ’ s nothing
    //special to do with classes that should use Enterprises Services features. All that is left to do is build and
    //deploy a client application. Read more about Automatic and Manual deployments- Pg: 1534

    // Signed the assembly using sn -k SimpleServerKey.snk and registered using regsvcs SimpleServer.dll
    // Installed in GAC using gacutil -i SimpleServer.dll
    // Created an installer using the Component Service Explorer
}

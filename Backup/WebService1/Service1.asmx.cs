using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace WebService1
{
    /// <summary>
    /// Summary description for Service1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Service1 : System.Web.Services.WebService
    {
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        // Adding a custom web method that returns an array of clientData structures.
        [WebMethod(CacheDuration = 30,  // Cache the response from the web service for 30 seconds.
            Description = "Returns an array of clients")]     
        public ClientData[] GetClientData(int number)
        {
            ClientData[] clients = null;

            if (number > 0 && number <= 10)
            {
                clients = new ClientData[number];
                for (int i = 0; i < number; i++)
                {
                    clients[i].Name = "Client" + i.ToString();
                    clients[i].Id = i;
                }
            }
            return clients;
            }
    }

    public struct ClientData
    {
        public string Name;
        public int Id;
    }
}
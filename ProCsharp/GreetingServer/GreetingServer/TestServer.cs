using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace GreetingServer
{
    public class TestServer
    {
        private TcpListener listener;
        private string greeting;
        private Thread listenerThread;
        private int port;

        // Overloading the cunstructor 

        public TestServer()
            : this("Default Message From Server: \nHey! How are you client? Heard you on 7890!")
        { }

        public TestServer(string greeting)
            : this(greeting, 7890)
        { }

        public TestServer(string greeting, int port)
        {
            this.greeting = greeting;
            this.port = port;
        }

        // Creating the Start method to handle a start of the server
        public void Start()
        {
            listenerThread = new Thread(Listener);
            listenerThread.IsBackground = true;
            listenerThread.Name = "Listener";
            listenerThread.Start();
        }

        // Now creating the Listener method that will be fired by the thread
        public void Listener()
        {
            try
            {
                IPAddress ip = IPAddress.Parse("127.0.0.1");
                listener = new TcpListener(ip, port);
                listener.Start();

                while (true)    // For the AcceptSocket to wait for the client to connect
                {
                    Socket clientSocket = listener.AcceptSocket();

                    string message = greeting;

                    // Prepare to send the message in unicode as follows:
                    UnicodeEncoding encoder = new UnicodeEncoding();
                    byte[] buffer = encoder.GetBytes(message);

                    clientSocket.Send(buffer, buffer.Length, 0);
                    clientSocket.Close();
                }
            }
            catch (SocketException ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        // Write the other control methods like,
        public void Stop()
        {
            listener.Stop();
        }
        public void Suspend()
        {
            listener.Stop();
        }
        public void Resume()
        {
            Start();
        }
    }
}

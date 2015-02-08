using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Sockets;
using System.Text;
using System.Windows.Forms;

namespace ProCsharp.Chapters
{
    public partial class WindowsServices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string serverName = Properties.Settings.Default.ServerName;
            int portNumber = Properties.Settings.Default.PortNumber;

            // Create a client to connect to the server and then recieve the message
            // in a stream as:
            TcpClient client = new TcpClient();
            NetworkStream stream = null;

            try
            {
                client.Connect(serverName, portNumber);

                // This is the way to read from the server stream
                stream = client.GetStream();
                byte[] sendBuffer = Encoding.UTF8.GetBytes("Hi! This is client 1");
                stream.Write(sendBuffer, 0, sendBuffer.Length);

                byte[] recieveBuffer = new byte[1024];
                int recieved = stream.Read(recieveBuffer, 0, 1024);
                TextBox1.Text = Encoding.UTF8.GetString(recieveBuffer).Trim('\0');
            }
            catch (SocketException ex)
            {
                Alert.Show(ex.Message);
            }
            finally
            {
                if (stream != null)
                {
                    stream.Close();
                }

                if (client.Connected)
                {
                    client.Close();
                }
            }
        }
    }
}
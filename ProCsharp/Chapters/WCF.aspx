<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WCF.aspx.cs"
    Inherits="ProCsharp.Chapters.WCF" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1"><strong style="font-style: italic">WINDOWS COMMUNICATION FOUNDATION</strong></span><br />
        <br />
        WCF combines the functionality from ASP.NET Web services, .NET Remoting, Message
        Queuing, and Enterprise Services.<br />
        The final goal is to send and receive messages from a client to a service either
        across processes or different systems, across a local network, or the Internet.
        This should be done if required in a platform-independent way and as fast as possible.
        <strong>On a distant view, the service offers an endpoint that is described by a contract,
        binding, and an address (ABC)</strong>. The contract defines the operations offered by the service,
        binding gives information about the protocol and encoding, and the address is the
        location of the service. The client needs a compatible endpoint to access the service.<br />
        <br />
        The schematic of the components that participate in a WCF communication is as follows:<br />
        <br />
        ===============================================<br />
        Client Code-----Proxy----------<strong>CHANNEL</strong>-----------Dispatcher-----Service<br />
        ===============================================<br />
        <br />
        <strong>Core Services used for platform independent communication:</strong><br />
        <br />
        <strong>SOAP</strong><br />
        Was the abbreviation for Simple Object Access Protocol however, now it uses XML
        for sending and recieving messages.&nbsp; A SOAP message consists of an envelope
        that contains a header and a body (these are simply XML tags).<br />
        <br />
        <strong>WSDL</strong><br />
        Web Service Description Language simply defines the message and operations of a
        service. It also defines the metadata of the service that can be used to create
        a proxy for the client application.<br />
        It contains:<br />
        1. Types of messages.<br />
        2. Messages that are sent to and from the service.<br />
        3. Port Types<br />
        4. Binding<br />
        5. Service info that maps ports to the endpoints.<br />
        <br />
        With WCF, WSDL info is offered via the MEX (Metadata Exchange) endpoints.<br />
        <br />
        <strong>JSON</strong><br />
        Java Script Object Notation is used to access the service using JavaScript and is
        best for js clients like AJAX clients.<br />
        <br />
        Press the button below to fire the WCF host<br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Fire WCF Host" />
        <br />
        <br />
        <br />
        In the example used in this part, I have used a simple WCF library to provide a
        ServiceContract of two methods to Add and Sub two numbers.<br />
        This is then hosted in a Windows Service which will later be consumed by the client
        designed below:<br />
        <br />
        ( Notes: Let me also list down the steps to the complete process followed as this
        might help later!<br />
        <br />
        1. Created a WCF Service using WCF Service Library project.<br />
        2. Configured the WCF Endpoints to use TCP and Set the Base Address.<br />
        3. Created a Windows Service.<br />
        4. Added service installers to the windows service.<br />
        5. Modified the windows service to host the WCF service.<br />
        6. Installed the Windows Service.<br />
        7. Created the following Test Client Application.<br />
        8. Added the WCF service reference for the URI net.tcp:<br />
        localhost:8523/Service1<br />
        9. Test the service.<br />
        <br />
        Reference:<br />
        <a href="http://msdn.microsoft.com/en-us/library/ff649818.aspx">http://msdn.microsoft.com/en-us/library/ff649818.aspx</a><br />
        <br />
        <br />
        <br />
        <strong>Contracts</strong><br />
        <br />
        There are three type of contracts:-<br />
        - Service Contracts:&nbsp;&nbsp;&nbsp; As used in the above example, these 
        define the operations provided by the service that are independent of the 
        implementation.<br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        The interface is marked with the [ServiceContract] attribute and the methods 
        with [OperationContract] attribute.<br />
        - Data Contracts:&nbsp;&nbsp;&nbsp; These define the data types mapped to XML 
        schemas where unlike the .NET serialization (public and private both 
        serialized), only<br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        the public members are serialized. It is applied to the fields with the 
        [DataMember] attribute as below:<br />
        [DataContract(Namespace="<a
            href="http:<br />www.thinktecture.com/SampleServices/2008">http:<br />
            www.thinktecture.com/SampleServices/2008</a>"]
        <br />
        public class RoomReservation
        <br />
        {
        <br />
        &nbsp;&nbsp;&nbsp; [DataMember] public string Room { get; set; }
        <br />
        &nbsp;&nbsp;&nbsp; [DataMember] public DateTime StartDate { get; set; }<br />
        }<br />
        <br />
        -Message Contract:&nbsp;&nbsp;&nbsp; This can define what goes into the SOAP 
        header and/or body as follows:<br />
        <br />
        [MessageContract]
        <br />
        public class ProcessPersonRequestMessage
        <br />
        { 
        <br />
        [MessageHeader]&nbsp;&nbsp;&nbsp;&nbsp; &lt;-- Defines the data that goes 
        into the SOAP header.<br />
        public int employeeId;
        <br />
        [MessageBodyMember(Position=0)]&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;-- Defines what goes into the SOAP body with the position/order.<br />
        public Person person;
        <br />
        } 
        <br />
        <br />
        The class ProcessPersonRequestMessage is used with 
        the service contract that is defined with the 
        <br />
        <br />
        interface IProcessPerson : 
        <br />
        [ServiceContract]
        <br />
        public interface IProcessPerson
        <br />
        {
        <br />
        [OperationContract] 
        <br />
        public PersonResponseMessage ProcessPerson(
        <br />
        ProcessPersonRequestMessage 
        message);
        <br />
        }<br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style1 {
            text-decoration: underline;
        }
    </style>
</asp:Content>

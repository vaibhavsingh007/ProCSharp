<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FactoryAndDI.aspx.cs" Inherits="ProCsharp.Chapters.FactoryAndDI" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>


    <span class="style1"><strong>FACTORY PATTERN AND DEPENDENCY INJECTION</strong></span><br />
    <br />
    A Factory pattern example typically includes three items / steps:<br />
    1. <em><strong>An interface</strong></em><br />
    <br />
    <span id="ctl00_MTContentSelector1_mainContentContainer_ctl04" 
        xmlns:msxsl="urn:schemas-microsoft-com:xslt">public interface 
    IDomainObjectInterface<br />
    {<br />
&nbsp;&nbsp;&nbsp; string Name{ get; }<br />
    }</span><br />
    <br />
    2. <strong><em>Implementation Classes</em></strong><br />
    <br />
    <span>
    <span id="ctl00_MTContentSelector1_mainContentContainer_ctl24_ctl00_ctl00" 
        xmlns:msxsl="urn:schemas-microsoft-com:xslt">public class 
    ImplementationClass1 : IDomainObjectInterface {<br />
&nbsp;&nbsp;&nbsp; public ImplementationClass1(){}<br />
&nbsp;&nbsp;&nbsp; public string Name<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get { return &quot;Implementation Class 1&quot;; }&nbsp;
    <br />
&nbsp;&nbsp;&nbsp; }<br />
    }<br />
    <br />
    public class ImplementationClass2 : IDomainObjectInterface {<br />
&nbsp;&nbsp;&nbsp; public ImplementationClass2(){}<br />
&nbsp;&nbsp;&nbsp; public string Name<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get { return &quot;Implementation Class 2&quot;; }<br />
&nbsp;&nbsp;&nbsp; }<br />
    }</span></span><br />
    <br />
    3. <strong><em>A condition based Factory to deliver the required object(s)</em></strong><br />
    <br />
    <span>
    <span id="ctl00_MTContentSelector1_mainContentContainer_ctl25_ctl00_ctl00" 
        xmlns:msxsl="urn:schemas-microsoft-com:xslt">public enum 
    ImplementationClassType<br />
    {<br />
&nbsp;&nbsp;&nbsp; ImplementationClass1, ImplementationClass2<br />
    }<br />
    <br />
    public class ImplementationClassFactory<br />
    {<br />
&nbsp;&nbsp;&nbsp; public static IDomainObjectInterface GetImplementationClass(
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ImplementationClassType 
    implementationClassType )<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch ( implementationClassType )<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 
    ImplementationClassType.ImplementationClass1:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    return new ImplementationClass1();<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 
    ImplementationClassType.ImplementationClass2:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    return new ImplementationClass2();<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    throw new ArgumentException(&quot;Class &quot; +
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    implementationClassType + &quot; not supported.&quot; );<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br />
&nbsp;&nbsp;&nbsp; }<br />
    }</span></span><br />
    <br />
    4. <strong><em>Client</em></strong><br />
    <br />
    <span>
    <span id="ctl00_MTContentSelector1_mainContentContainer_ctl26_ctl00_ctl00" 
        xmlns:msxsl="urn:schemas-microsoft-com:xslt">using System;<br />
    using SpringDIExample;<br />
    <br />
    class ConsoleRunner<br />
    {<br />
&nbsp;&nbsp;&nbsp; static void Main()<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDomainObjectInterface 
    domainObjectInterface =
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    ImplementationClassFactory.GetImplementationClass(<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    ImplementationClassType.ImplementationClass1);<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Console.WriteLine(&quot;My name is &quot; + 
    domainObjectInterface.Name);<br />
&nbsp;&nbsp;&nbsp; }<br />
    }</span></span><br />
    <br />
    <br />
    <strong>Drawbacks of the Factory method.</strong><br />
    <br />
    Now, there are several drawbacks to this factory method. The first is that the 
    number of implementation classes is hardwired into the factory method. 
    Therefore, even though there is an interface for the implementation objects, 
    it&#39;s impossible for the factory method to return an implementation class that it 
    does not know about. This limits extensibility, especially in the case of a 
    public API and application frameworks, where the ability to dynamically 
    introduce new implementation classes is not only desired, but often expected to 
    achieve a certain degree of flexibility.
    <br />
    <br />
    Secondly, even if the ability to dynamically introduce new implementations 
    existed, the client application would still need to know which class to ask for. 
    This eliminates some of the flexibility that the factory class was supposed to 
    provide.<br />
    <br />
    <br />
    <span class="style1"><strong>Dependecy Injection</strong></span><br />
    <br />
    DI implements the concept of containers to provide more flexibility in chosing 
    and adding the objects delivered by the factory.<br />
    This is typically done by inserting a declarative config.xml between the client 
    and the factory implementation as follows:<br />
    <br />
    For this example I&#39;m using the Spring.NET DI container, which requires a bit of 
    initial setup. First, you must create an instance of the factory, using a 
    config.xml file as the source of your object definitions. Next, replace a call 
    to the custom factory class with a call to the Spring.NET factory class.
    <br />
    Notice that since the generic factory doesn&#39;t know anything about third-party 
    interfaces, everything coming back from the factory is downcast to object. So 
    you must upcast the object instances returned by the factory to the interface 
    that you expect.
    <br />
    Finally, the last line of the ConsoleRunner class remains unaffected, even 
    though you have changed the source of the object and how it&#39;s instantiated.<br />
    <br />
    Note: Refer to the following site for the example on using a lightweight DI 
    container for extensibility based on Spring.net framework:<br />
    <br />
    <a href="http://msdn.microsoft.com/en-us/magazine/cc163739.aspx#S2">
    http://msdn.microsoft.com/en-us/magazine/cc163739.aspx#S2</a><br />
    <br />
    <br />
    <br />
    <br />


</div>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
        .style1
        {
            text-decoration: underline;
        }
    </style>
</asp:Content>


<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebServices.aspx.cs"
    Inherits="ProCsharp.Chapters.WebServices" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1"><strong>WEB SERVICES</strong></span><br />
        <br />
        References to the theory behind Web Services:<br />
        <br />
        <a href="http://www.codeproject.com/Articles/4379/Introduction-to-NET-Web-Services">
            http://www.codeproject.com/Articles/4379/Introduction-to-NET-Web-Services</a><br />
        <a href="http://www.codeproject.com/Articles/863/Your-first-C-Web-Service">http://www.codeproject.com/Articles/863/Your-first-C-Web-Service</a><br />
        <a href="http://www.w3schools.com/webservices/default.asp">http://www.w3schools.com/webservices/default.asp</a><br />
        <br />
        The following project, WebService1 is included in the same solution:<br />
        <%--<asp:Button ID="Button1" runat="server" Text="Invoke WebService1"  ="../WebService1/Service1.asmx" />--%>
        <br />
        <a href="http://localhost:59466/Service1.asmx">WebService1</a> &lt;-- Click to launch
        the webservice!<br />
        <br />
        <strong>Deploying the webservice</strong><br />
        <br />
        Now that we have a WebService it would be kind of nice to allow others to use it
        (call me crazy, but...). Publishing your WebService on your server requires that
        your solution be deployed correctly. On the Build menu of Visual Studio is a &quot;Deploy&quot;
        option that, when first selected, starts a Wizard that allows you to add a Deployment
        project to your solution. This creates an installation package that you can run
        on your server which will create the necessary directories, set the correct parameters
        and copy over the necessary files.<br />
        <br />
        This doesn&#39;t really give you an idea of what, exactly, is happening, so we&#39;ll
        deploy our MyService manually.<br />
        <br />
        Deploying the application is done using the steps in Getting the demo application
        to run. We need to create a directory for our service (or use an existing directory)
        for our .asmx file, and we need to have the service&#39;s assembly in the application&#39;s
        bin/ directory. Either place the .asmx file in a subdirectory on your website and
        place the assembly in the /bin folder in your website&#39;s root, or place the /bin
        in the subdirectory containing the .asmx file and mark that directory as an application.<br />
        <br />
        If you choose to create a separate directory and mark it as an application then
        Within this directory you need to add the following files and directories:<br />
        <br />
        <em>MyService.asmx</em> This file acts as the URL for your service
        <br />
        <em>MyService.disco</em> The discovery document for your service
        <br />
        <em>web.config</em> Configuration file for your service that overrides default web
        settings (optional).
        <br />
        <em>/bin</em> This directory holds the assembly for your service
        <br />
        <em>/bin/MyService.dll</em> The actual service asembly.
        <br />
        <br />
        ____________________________________________________________<br />
        <br />
        <br />
    </div>
</asp:Content>

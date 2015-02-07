<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WindowsServices.aspx.cs" Inherits="ProCsharp.Chapters.WindowsServices" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>


    <span class="style1"><strong>Windows Services</strong></span><br />
    <br />
    Three programs are needed to operate a windows service:<br />
    <br />
    1. A service program<br />
    2. A service control program<br />
    3. A service configuration program<br />
    <br />
    A service program comprises of:<br />
    - A main function<br />
    - A service-main function<br />
    - A handler<br />
    <br />
    A service control program:<br />
    SCM (Service Control Manager) is a part of the OS that controls the service by 
    sending Start, Stop, etc.<br />
    <br />
    Service Configuration Program:<br />
    Because services must be configured in the registry, you can ’ t use Xcopy 
    installation with services. The registry contains the startup type of the 
    service which can be set to automatic, manual, or disabled. You also need to 
    configure the user of the service program and dependencies of the service — for 
    example, the services that must be started before this one can start. All of 
    these configurations are made within a service configuration program. The 
    installation program can use the service configuration program to configure the 
    service, but this program can also be used at a later time to change service 
    configuration parameters.<br />
    <br />
    <br />
    Click the button below to start the server and deliver a greeting.<br />
    Refer to the code for details:<br />
    <br />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Test the server" />
    <br />
        <asp:TextBox ID="TextBox1" runat="server" Height="63px" Width="253px"></asp:TextBox>
    <br />
    <br />
    <br />
        The class diagram of the Service Installer:<br />
        <br />
        <img alt="" class="style2" src="file:///C:/Users/test/Desktop/Untitled.png" /><br />
        <br />
        <br />
        After adding the installer classes to the project, you can use the 
        installutil.exe utility to install and uninstall the service. This utility can 
        be used to install any assembly that has an Installer class. The installutil.exe 
        utility calls the method Install() of the class that derives from the Installer 
        class for installation, and Uninstall() for the uninstallation .
        <br />
        The command - line inputs for the installation and uninstallation of our service 
        are:
        <br />
        installutil quoteservice.exe<br />
&nbsp;installutil /u quoteservice.exe<br />
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
        .style2
        {
            width: 367px;
            height: 327px;
        }
    </style>
</asp:Content>


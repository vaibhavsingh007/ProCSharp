<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TracingAndEvents.aspx.cs" Inherits="ProCsharp.Chapters.TracingAndEvents" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>







    <br />
    <span class="style1"><strong>TRACING AND EVENTS</strong></span><br />
    <br />
    <img alt="" src="../Content/TracingClasses.png" />
    <br />
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong><span class="style1">Major 
    classes for tracing and how they are connected</span><br class="style1" />
    </strong>
    <br />
    _________________________________<br />
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Run Tracing" 
            onclick="Button1_Click" />
&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button2" runat="server" Text="Write EventLog" 
            onclick="Button2_Click" />
&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button3" runat="server" 
        Text="Write EventLog using Resource file" onclick="Button3_Click" />
    <br />
    <br />
        <strong>Compiling and using the message resource file (with mc.exe):</strong><br />
        <br />
        Use the Messages Compiler, mc.exe , to create a binary message file. mc – s 
        EventLogDemoMessages 
        <br />
        .mc compiles the source file containing the messages to a messages file with the 
        .bin extension and the
        <br />
        file Messages.rc , which contains a reference to the binary message file:
        <br />
        mc -s EventLogDemoMessages.mc
        <br />
        Next, you must use the Resource Compiler, rc.exe . rc EventLogDemoMessages.rc 
        creates the
        <br />
        resource file EventLogDemoMessages.RES :
        <br />
        rc EventLogDemoMessages.rc
        <br />
        With the linker, you can bind the binary message file EventLogDemoMessages.RES 
        to a native DLL:
        <br />
        link /DLL /SUBSYSTEM:WINDOWS /NOENTRY /MACHINE:x86 EventLogDemoMessages.RES<br />
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
<asp:Content ID="Content1" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
        .style1
        {
            text-decoration: underline;
        }
    </style>
</asp:Content>


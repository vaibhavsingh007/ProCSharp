<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MEF.aspx.cs" Inherits="ProCsharp.Chapters.MEF" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>


    <span class="style1"><strong>MEF</strong></span><br />
    <br />
    <span class="style1">Managed Extensibility Framework</span> is the successor to 
    the MAF (Managed Add-in Framework) used in earlier .net versions.<br />
    <br />
    Instead of the explicit registration (or loading/unloading assemblies) of 
    available components, MEF provides a way to discover them implicitly, via 
    <span class="parameter">composition</span>. A MEF component, called a
    <span class="parameter">part</span>, declaratively specifies both its 
    dependencies (known as <span class="parameter">imports</span>) and what 
    capabilities (known as <span class="parameter">exports</span>) it makes 
    available. When a part is created, the MEF composition engine satisfies its 
    imports with what is available from other parts.<br />
    <br />
    MEF is an integral part of the .NET Framework 4, and is available wherever the 
    .NET Framework is used. You can use MEF in your client applications, whether 
    they use Windows Forms, WPF, or any other technology, or in server applications 
    that use ASP.NET.
    <br />
    <br />
    The simplest way to see what MEF can do is to build a simple MEF application. In 
    this example, we build a very simple calculator named SimpleCalculator. The goal 
    of SimpleCalculator is to create a console application that accepts basic 
    arithmetic commands, in the form &quot;5+3&quot; or &quot;6-2&quot;, and returns the correct 
    answers. Using MEF, we will be able to add new operators without changing the 
    application code.<br />
    <br />
    Source: <a href="http://msdn.microsoft.com/en-us/library/dd460648.aspx#Y2582">
    http://msdn.microsoft.com/en-us/library/dd460648.aspx#Y2582</a><br />
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Start MySimpleCalculator" />
    <br />
    <br />
    <strong>The subtraction operation is added to the application using MEF. Please 
    refer to the code behind for details!</strong><br />
    <br />
    <em>Conclusion</em>:<br />
    ------------<br />
    <br />
    Parts, catalogs, and the composition container Parts and the composition 
    container are the basic building blocks of a MEF application. A part is any 
    object that imports or exports a value, up to and including itself. A catalog 
    provides a collection of parts from a particular source. The composition 
    container uses the parts provided by a catalog to perform composition, the 
    binding of imports to exports.
    <br />
    <br />
    Imports and exports Imports and exports are the way by which components 
    communicate. With an import, the component specifies a need for a particular 
    value or object, and with an export it specifies the availability of a value. 
    Each import is matched with a list of exports by way of its contract.
    <br />
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
.parameter{font-style:italic;}.parameter{font-family:Verdana,Arial,Helvetica,sans-serif;font-size:100%;font-style:italic;margin:0;}</style>
</asp:Content>


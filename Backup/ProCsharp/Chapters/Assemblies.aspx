<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Assemblies.aspx.cs" Inherits="ProCsharp.Chapters.Assemblies" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>

    <span class="style1"><strong>ASSEMBLIES</strong></span><br />
    <br />
    <br />
    <span class="style2"><strong>Structure of a typical assembly spread across three 
    components.</strong></span><br />
    <br />
    <img alt="" src="../Content/Assemblies.PNG" 
        style="width: 396px; height: 324px" />
    
    <br />
    <br />
    <strong>Manifests:</strong><br />
    <br />
    It is a part of the metadata that describes the assembly. All the info needed to 
    reference the assembly and its dependencies are listed. Manifests include:<br />
    + Identity - Name, version, culture, public key.<br />
    + List of files belonging to the assembly.<br />
    + List of referenced assemblies.<br />
    + Set of permission requests.
    <br />
    + Exported types.<br />
    <br />
    <strong>
    <br />
    Namespaces, Assemblies, and Components:</strong><br />
    <br />
    You might be a little confused by the meanings of namespaces, types, 
    assemblies, and components. How does a namespace fit into the assembly concept? 
    The namespace is completely independent of an assembly. You can have different 
    namespaces in a single assembly, but the same namespace can be spread across 
    assemblies. The namespace is just an extension of the type name — it belongs to 
    the name of the type. For example, the assemblies mscorlib and system contain 
    the namespace System.Threading among many other namespaces. Although the 
    assemblies contain the same namespaces, you will not find the same class names.<br />
    <br />
    <br />
    <strong>Satellite Assemblies</strong>
    <br />
    <br />
    A satellite assembly is an assembly that only contains resources. This is 
    extremely useful for localization. Because an assembly has a culture associated, 
    the resource manager looks for satellite assemblies containing the resources of 
    a specific culture.<br />
    <br />
    <br />
    <strong style="font-style: italic">Use ildasm or .Net Reflector to decompile IL 
    and analyze assemblies</strong></div>
    ------------------------------<br />
    <br />
    We will now build a CodeDom example to generate assemblies on the fly using <em>
    CSharpCodeProvider:</em><br />
    <br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Height="302px" 
        ToolTip="Input code here" Width="288px" TextMode="MultiLine" Wrap="true"></asp:TextBox>
    <br />
    <br />
    <asp:TextBox ID="TextBox2" runat="server" Height="126px" 
        style="margin-right: 0px; margin-top: 0px" Width="287px" TextMode="MultiLine" Wrap="true">Ouput</asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" BorderStyle="Ridge" Font-Bold="True" 
        onclick="Button1_Click" Text="Run" Width="87px" />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>


<asp:Content ID="Content1" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
        .style1
        {
            text-decoration: underline;
        }
    </style>
</asp:Content>




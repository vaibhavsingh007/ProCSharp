<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reflection.aspx.cs" Inherits="ProCsharp.Chapters.Reflection" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>


    <span class="style1"><strong>Reflection</strong></span><br />
    <br />
    The class CheckAssembly uses two custom built assemblies to get the info using 
    the attributes defined.<br />
    Refer to the code behind for details.<br />
    <br />
    <br />


    <asp:TextBox ID="TextBox1" runat="server" Height="157px" Width="459px" 
        TextMode="MultiLine"></asp:TextBox>
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

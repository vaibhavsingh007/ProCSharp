<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Security.aspx.cs" Inherits="ProCsharp.Chapters.Security" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>


    <span class="style1">SECURITY</span><br class="style1" />
    <br />
    <strong>Authentication and Authorization</strong><br />
    <br />
    Authentication is the process of identifying the user, and authorization occurs 
    afterward to verify if the identified user is allowed to access a specific 
    resource.<br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <strong>Cryptography</strong><br />
    <br />
    <br />
    <br />
    <br />
    <strong>Access control to resources</strong><br />
    <br />
    <br />
    <br />
    <br />
    <strong>Code Access Security</strong><br />
    <br />
    <br />
    <br />
    <br />
    <strong>Managing Security Policies</strong><br />
    <br />
    ______________________________________________<br />
    <br />
    <span class="style2">Validating JSON</span><br />
    <br />
    Source:
    <a href="http://www.drowningintechnicaldebt.com/ShawnWeisfeld/archive/2010/08/22/using-c-4.0-and-dynamic-to-parse-json.aspx">
    http://www.drowningintechnicaldebt.com/ShawnWeisfeld/archive/2010/08/22/using-c-4.0-and-dynamic-to-parse-json.aspx</a><br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Height="213px" TextMode="MultiLine" 
        Width="527px"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Deserialize JSON from the text file in App_Data" />
    <br />
    <br />
    <br />
    <br />
    ______________________________________<br />
    <br />
    <br />
    The following example demonstrates a Signature using the ECDSA (Elliptic Curve 
    Digital Signature Algorithm):<br />
    <br />
    <asp:TextBox ID="TextBox2" runat="server" Height="86px" TextMode="MultiLine" 
        Width="525px">Output</asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
        Text="Run Encrypted Signature" />
    <br />
    <br />
    <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
        Text="Run for Key Exchange and Secure Transfer" />
    <br />
    <br />
    <span class="style2">KEY EXCHANGE AND SECURE TRANSFER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    </span>
    <br />
    <br />
    Alice creates an encrypted message and sends the encrypted message to Bob. 
    Before that, key pairs are created for Alice and Bob. Bob gets access only to 
    Alice ’ s public key, and Alice gets access only to Bob ’ s public key.<br />
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
            font-style: italic;
            font-weight: 700;
        }
        .style2
        {
            text-decoration: underline;
        }
    </style>
</asp:Content>

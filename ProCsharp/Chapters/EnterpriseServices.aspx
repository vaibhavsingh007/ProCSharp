<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnterpriseServices.aspx.cs" Inherits="ProCsharp.Chapters.EnterpriseServices" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>






    <span class="style1"><strong style="font-style: italic">ENTERPRISE SERVICES</strong></span><br />
    <br />
    <br />
    <br />
    The EnterPriseDemo serviced component named &#39;SimpleServer&#39; is developed as a 
    server and registered using regsvcs &lt;dllname&gt;.<br />
    Or, for automatic deployment of the Serviced Component (using COM+), simply 
    start the client with administrative rights.<br />
    This will auto configure the component using the attributes defined. (Check the 
    code behind for more info).<br />
    Use &#39;Component Explorer&#39; to view the component!<br />
    <br />
    Click on the following button to invoke the client which uses the Welcome() 
    method from the &#39;SimpleServer&#39; and invokes it 10 times.<br />
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="EnterpriseDemoTestClient" />
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


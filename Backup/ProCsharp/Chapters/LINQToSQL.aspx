<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LINQToSQL.aspx.cs"
    Inherits="ProCsharp.Chapters.LINQToSQL" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1">LINQ TO SQL</span><br />
        <br />
        <br />
        In order to exemplify LINQ To SQL, we will create an application that will take
        the query to the DB as a user input using a UI framed template and then using the
        input to parse into a LINQ module in the background to populate the result in a
        DataGrid / Table:<br />
        <br />
        For simplicity, we will use the Products table from the NorthWind DB to fire all
        the queries:<br />
        <br />
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="OnRadioChanged"
            AutoPostBack="True">
            <asp:ListItem Selected="True" Value="SelectAll">Select *</asp:ListItem>
            <asp:ListItem Value="SelectSpecific">Select specific columns</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <br />
        SELECT
        <asp:TextBox ID="TextBox1" runat="server" ToolTip="Enter first column name"></asp:TextBox>
        &nbsp; ,&nbsp;
        <asp:TextBox ID="TextBox2" runat="server" ToolTip="Enter second column name"></asp:TextBox>
        <br />
        <br />
        FROM Products<br />
        <br />
        WHERE
        <asp:TextBox ID="TextBox3" runat="server" ToolTip="Enter condition (each term seperated by a space)"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Run Query" OnClick="Button1_Click" />
        <br />
        <br />
        <br />
        The result from the query is populated below:<br />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
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
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style1
        {
            text-decoration: underline;
            font-style: italic;
            font-weight: 700;
        }
    </style>
</asp:Content>

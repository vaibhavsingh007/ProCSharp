<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LINQ.aspx.cs" Inherits="ProCsharp.Chapters.LINQ" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">

<div>

    <span class="style1"><strong>LINQ</strong></span><br />
    <br />
    The queries as per the topics listed below. In order to dig deeper, refer to 
    the code behind!<br />
    <br />
    First displaying the two lists used in the examples viz. Students and Subjects:<br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Height="169px" Width="443px" 
        TextMode="MultiLine" Wrap="false"></asp:TextBox>
    <br />
    <br />
    <asp:TextBox ID="TextBox2" runat="server" Height="163px" Width="442px" 
        TextMode="MultiLine" Wrap="false"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button1" runat="server" Text="Call LINQ methods" 
        onclick="Button1_Click" />
    &nbsp;For description, refer to the code behind!<br />
    <br />
    <br />
    <br /> <strong>Type Filtering 
    </strong> 
    <br />
    <br />object[] data = { &quot;one&quot;, 2, 3, &quot;four&quot;, &quot;five&quot;, 6 }; <br />var 
    query = data.OfType &lt; string &gt; (); <br />foreach (var s in query) <br />{ <br /> 
    Console.WriteLine(s); <br />} <br /> Compound &#39;from&#39; -&gt; This in turn uses the 
    SelectMany&lt;&gt; extension method (not described here) <br />var ferrariDrivers = from r 
    in Formula1.GetChampions() <br /> from c in r.Cars <br /> where c == &quot;Ferrari&quot; <br /> 
    orderby r.LastName <br /> select r.FirstName + &quot; &quot; + r.LastName; <br /> 
    <br />
    <br />
    <strong>Grouping with 
    Nested Objects 
    </strong> 
    <br />
    <br />var countries = from r in Formula1.GetChampions() <br /> group r by 
    r.Country into g <br /> orderby g.Count() descending, g.Key <br /> where g.Count() &gt; = 2 
    <br /> select new <br /> { <br /> Country = g.Key, <br /> Count = g.Count(), <br /> Racers = from r1 
    in g <br /> orderby r1.LastName <br /> select r1.FirstName + &quot; &quot; <br /> + r1.LastName <br /> };<br />
    <br />
    <br />
    <strong>Immediate Conversion</strong><br />
    <br />In this example the ToList() extension method is invoked to immediately 
    execute the query and get <br />the result into a List &lt; T &gt; : <br />List &lt; Racer &gt; 
    racers = <br />(from r in Formula1.GetChampions() <br />where r.Starts &gt; 150 <br />orderby 
    r.Starts descending <br />select r).ToList();<br />
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



<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ObjectsAndTypes.aspx.cs"
    Inherits="ProCsharp.Chapters._1_ObjectsAndTypes.ClassesAndStructs" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1"><strong>OBJECTS AND TYPES</strong></span><br />
        <br />
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" 
            Text="Classes And Structs" Font-Italic="True" Font-Size="Larger"></asp:Label>
        <br />
        <br />
        Enter your name in the box:&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox1" runat="server" AutoCompleteType="FirstName" BorderStyle="Groove"
            CausesValidation="True"></asp:TextBox>
        <br />
        <br />
        Click on the respective button to see the concatenated result..<br />
        <asp:Button ID="Button1" runat="server" Text="Using Class" Width="141px" OnClick="Button1_Click" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="Using Struct" Width="141px" OnClick="Button2_Click" />
        &nbsp;
        <br />
        <br />
        &nbsp;
        <asp:Label ID="Label2" runat="server"></asp:Label>
        <br />
        <br />
    </div>
    <div>
        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Names="Arial" 
            Text="Ref and Out Params" Font-Italic="True" Font-Size="Larger"></asp:Label>
        <br />
        <br />
        The behavior of strings is different in this case. This is because strings are immutable
        (if you alter a string ’ s value, you create an entirely new string), 
        <br />
        so strings don ’ t display the typical reference - type behavior. Any changes made to a string
        within a method call won ’ t affect the original string.<br />
        <br />
        The value of the variables are initialized before (required in the case of ref):<br />
        <br />
        &nbsp;<asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Run" />
        &nbsp;&nbsp;
        <asp:TextBox Wrap="true" ID="TextBox2" runat="server" Height="90px" Width="372px"
            TextMode="MultiLine"></asp:TextBox>
        <br />
        <br />
        <br />
        <br />
    </div>
    <div>

        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Arial" 
            Text="Extension Method" Font-Italic="True" Font-Size="Larger"></asp:Label>
        <br />
        <br />
        Extension methods are used to extend a class, source code for which is not 
        accessible. Extension methods are always static.<br />
        <br />
        <asp:Button ID="Button4" runat="server" Text="Run" onclick="Button4_Click" />
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox3" runat="server" Height="49px" Width="346px" Wrap="true" TextMode="MultiLine"></asp:TextBox>

        <br />
        <br />
        <br />
        <br />
        Other interfaces:<br />
        <br />
        <span class="style1">IComparable</span><br />
        <br />
        <span style="color: blue;">public</span> <span style="color: blue;">class</span> 
        Temperature : IComparable
        <br />
        {<br />
&nbsp;&nbsp;&nbsp; <span style="color: green;">// The temperature value </span>
        <span style="color: blue;">protected</span> <span style="color: blue;">double</span> 
        temperatureF;<br />
        <br />
&nbsp;&nbsp;&nbsp; <span style="color: blue;">public</span> <span style="color: blue;">
        int</span> CompareTo(<span style="color: blue;">object</span> obj) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: blue;">if</span> (obj ==
        <span style="color: blue;">null</span>) <span style="color: blue;">return</span> 
        1;<br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Temperature otherTemperature = obj
        <span style="color: blue;">as</span> Temperature;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: blue;">if</span> 
        (otherTemperature != <span style="color: blue;">null</span>)
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span style="color: blue;">return</span> <span style="color: blue;">this</span>.temperatureF.CompareTo(otherTemperature.temperatureF);<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: blue;">else</span>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: blue;">
        throw</span> <span style="color: blue;">new</span> ArgumentException(<span 
            style="color: rgb(163, 21, 21);">&quot;Object is not a Temperature&quot;</span>);<br />
&nbsp;&nbsp;&nbsp; }<br />
        ...<br />
        ...<br />
        <br />
        <br />
        _____________<br />
        <br />
        <span class="style1">The Bitwise Right and Left Shift operators (&gt;&gt;, &lt;&lt;):</span>
        <br />
        <p>
            Each operand must have an integral or enumeration type. The compiler performs 
            integral promotions on the operands, and then the right operand is converted to 
            type <span class="style2">int</span>. The result has the same type as the left 
            operand (after the arithmetic conversions).</p>
        <p>
            The right operand should not have a negative value or a value that is greater 
            than or equal to the width in bits of the expression being shifted. The result 
            of bitwise shifts on such values is unpredictable.</p>
        <p>
            If the right operand has the value <tt class="xph">0</tt>, the result is the 
            value of the left operand (after the usual arithmetic conversions).</p>
        <p>
            The <tt class="xph">&lt;&lt;</tt> operator fills vacated bits with zeros. For example, 
            if <tt class="xph">left_op</tt> has the value <tt class="xph">4019</tt>, the bit 
            pattern (in 16-bit format) of <tt class="xph">left_op</tt> is:
        </p>
        <pre class="xmp">0000111110110011</pre>
        <p>
            The expression <tt class="xph">left_op &lt;&lt; 3</tt> yields:
        </p>
        <pre class="xmp">0111110110011000</pre>
        <p>
            The expression <tt class="xph">left_op &gt;&gt; 3</tt> yields:
        </p>
        <pre class="xmp">0000000111110110</pre>
        pretty simple huh!<br />
        ______________________________<br />
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
    
.mv, .pk, .pkdef, .pv { font-family: "Courier New", Courier, monospace; font-size: 100%}


tt, samp {font-family: "Courier New", Courier, monospace; font-size: 100%;}
PRE, pre.cgraphic { font-family: "Courier New", Courier, monospace; font-size:100%; margin-left: 30px; margin-right: 30px; background-color : #dadada; padding: 3px;}

        .style2
        {
            font-weight: bold;
            text-decoration: underline;
        }
    </style>
</asp:Content>


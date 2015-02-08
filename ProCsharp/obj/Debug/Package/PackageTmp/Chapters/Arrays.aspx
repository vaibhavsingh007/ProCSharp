<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Arrays.aspx.cs" Inherits="ProCsharp.Chapters.Arrays" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1">Arrays and Enumerations</span><br />
        <br />
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Italic="True" Font-Names="Arial"
            Font-Size="Larger" Text="Interfaces"></asp:Label>
        <br />
        <br />
        The code for the following demonstration uses the &#39;addition&#39; and &#39;subtraction&#39;
        methods declared<br />
        in the interface implemented by the &#39;MathOperations&#39; class.<br />
        <br />
        Please enter two integers and press the respective button to perform the operation:<br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add" Width="63px" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Subtract" />
        &nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server"></asp:Label>
    </div>
<div>

    <br />
        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Italic="True" Font-Names="Arial"
            Font-Size="Larger" Text="Enumerations"></asp:Label>
        <br />
    <br />
    The Array class implements the following interfaces for accessing and 
    enumerating the
    <br />
    elements of the array.<br />
    <br />
    -IEnumerable<br />
    -ICollection<br />
    -IList<br />
    <br />
    The following illustration depicts the use of foreach, IEnumerator and yield 
    statement.<br />
    <br />
    An understanding of how a foreach statement is converted to the IL:<br />
    <br />
    A simple foreach statement,
    <br />
    <br />
    foreach (Person p in persons) 
    <br />
    {
    <br />
&nbsp;&nbsp;&nbsp; Console.WriteLine(p);
    <br />
   }<br />
    <br />
    is converted to :<br />
    <br />
    IEnumerator enumerator = persons.GetEnumerator();
    <br />
    while (enumerator.MoveNext())
    <br />
    {<br />
&nbsp;&nbsp;&nbsp; Person p = (Person)enumerator.Current; Console.WriteLine(p);
    <br />
    }<br />
    <br />
    For a difference between IEnumerable and IEnumerator, see here:
    <br />
    <a href="http://stackoverflow.com/questions/619564/what-is-the-difference-between-ienumerator-and-ienumerable">
    http://stackoverflow.com/questions/619564/what-is-the-difference-between-ienumerator-and-ienumerable</a><br />
    <br />
    <br />
    <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
        Text="Get Iteration" Width="99px" />
    <br />
    <br />
    <asp:TextBox ID="TextBox4" runat="server" Height="124px" TextMode="MultiLine" 
        ToolTip="Enumerated names" Width="246px"></asp:TextBox>
    <br />
    <br />
    <br />
    <span class="style2">IDisposable</span><br />
    <br />
    <p>
        The point of Dispose <strong class="style3">is</strong> to free unmanaged 
        resources. It needs to be done at some point, otherwise they will never be 
        cleaned up. The garbage collector doesn&#39;t know <strong class="style3">how</strong> 
        to call <code class="style3">DeleteHandle()</code> on a variable of type
        <code class="style3">IntPtr</code>, it doesn&#39;t know <strong class="style3">
        whether</strong> or not it needs to call <code class="style3">DeleteHandle()</code>.</p>
    <blockquote class="style3">
        <p>
            <strong class="style3">Note</strong>: What is an <em class="style3">unmanaged 
            resource</em>? If you found it in the Microsoft .NET Framework: it&#39;s managed. If 
            you went poking around MSDN yourself, it&#39;s unmanaged. Anything you&#39;ve used 
            P/Invoke calls to get outside of the nice comfy world of everything available to 
            you in the .NET Framwork is unmanaged - and you&#39;re now responsible for cleaning 
            it up.</p>
    </blockquote>
    <p>
        The object that you&#39;ve created needs to expose <em class="style3">some</em> 
        method, that the outside world can call, in order to clean up unmanaged 
        resources. There is even a standardized name for this method:</p>
    <pre class="style3"><code class="style3"><span class="style3">public void Dispose()</span></code></pre>
    <p>
        There was even an interface created, <code class="style3">IDisposable</code>, 
        that has just that one method:</p>
    <pre class="style3"><code class="style3"><span class="style3">public interface IDisposable
{
   void Dispose()
}</span></code></pre>
    <p>
        So you make your object expose the <code class="style3">IDisposable</code> 
        interface, and that way you promise that you&#39;ve written that single method to 
        clean up your unmanaged resources:</p>
    <pre class="style3"><code class="style3"><span class="style3">public void Dispose()
{
   Win32.DestroyHandle(this.gdiCursorBitmapStreamFileHandle);
}</span></code></pre>
    <br />
    You may want to even clean the managed resource ahead of the GC to be helpful in 
    freeing the memory efficiently.<br />
    <br />
    ______________<br />
    <br />
    <span class="style2">StringBuilder, StringReader and StringWriter example:</span><br />
    (Refer to the code behind for more info)<br />
    <br />
    <asp:TextBox ID="TextBox5" runat="server" Height="187px" Width="935px" 
        TextMode="MultiLine"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button4" runat="server" Text="Cick me to run!" 
        onclick="Button4_Click" />
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
            font-weight: 700;
        }
        .style2
        {
            text-decoration: underline;
        }
b,strong{font-weight:bold;}p code{padding:1px 5px 1px 5px;}code{font-family:Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, Courier New, monospace, serif;background-color:#eeeeee;}blockquote{margin-bottom:10px;padding:10px 10px 1px 10px;background-color:#eeeeee;}blockquote,q{quotes:none;}i,em{font-style:italic;}pre{max-height:none\9;}pre{padding:5px;font-family:Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, Courier New, monospace, serif;margin-bottom:10px;background-color:#eeeeee;overflow:auto;width:auto;width:650px !ie7;padding-bottom:20px !ie7;max-height:600px;}.post-text pre>code:first-child,.wmd-preview pre>code:first-child{max-height:600px\9;display:block\9;} .kwd{color:#006;font-weight:bold;} .kwd{color:#00008b;} .pln{color:#000;} .pln{color:#000000;} .typ{color:#404;font-weight:bold;} .typ{color:#2b91af;} .pun{color:#440;} .pun{color:#000000;}
        .style3
        {
            font-size: 100%;
            vertical-align: baseline;
            border-style: none;
            border-color: inherit;
            border-width: 0;
            margin: 0;
            padding: 0;
            
        }
    </style>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Parallelization.aspx.cs" Inherits="ProCsharp.Chapters.Parallelization" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>





    <br />
    <span class="style1"><strong>PARALLELIZATION</strong></span><br />
    <br />
    Here, we will implement,
    <br />
    ParallelFor, Plinq, Tasks, continuation tasks, concurrent collections, 
    cancellation.<br />
    <br />
    Creating the Parallel SpellChecker:<br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Height="65px" Width="216px" 
        TextMode="MultiLine" Wrap="true"></asp:TextBox>
    <br />
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Run ParallelSpellChecker" 
        onclick="Button1_Click" />
    <br />
    <br />
    <br />
    Creating the Parallel SpellChecker with Cancellation:<br />
    <br />
    Canceling a PLINQ query whose results you’re consuming in a foreach loop is 
    easy: simply break out of the foreach and the query will be automatically 
    canceled as the enumerator is implicitly disposed.
    <br />
    For a query that terminates with a conversion, element, or aggregation operator, 
    you can cancel it from another thread via a cancellation token. To insert a 
    token, call WithCancellation after calling AsParallel, passing in the Token 
    property of a CancellationTokenSource object. Another thread can then call 
    Cancel on the token source, which throws an OperationCanceledException on the 
    query’s consumer.<br />
    <br />
    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
        Text="Run ParallelSpellChecker with Cancellation" />
    <br />
    <br />
    <br />
    <br />The following sequential for loop:
    <br />
<br />for (int i = 0; i < 100; i++)
<br />Foo (i);
    <br />
<br />is parallelized like this:
<br />Parallel.For (0, 100, i => Foo (i));
<br />or more simply:
    <br />
<br />Parallel.For (0, 100, Foo);
    <br />
<br />And the following sequential foreach:
<br />foreach (char c in "Hello, world")
<br />Foo (c);
    <br />
<br />is parallelized like this:
<br />Parallel.ForEach ("Hello, world", Foo);
    
    <br />
    <br />
    <br />
    <em>Indexed Parallel.ForEach
    <br />
    </em>
    <br />
    Sometimes it’s useful to know the loop iteration index. With a sequential 
    foreach, it’s easy:
    <br />
    int i = 0;
    <br />
    foreach (char c in &quot;Hello, world&quot;)
    <br />
    Console.WriteLine (c.ToString() + i++);
    <br />
    <br />
    Incrementing a shared variable, however, is not thread-safe in a parallel 
    context. You must instead use the following
    <br />
    version of ForEach:
    <br />
    <br />
    public static ParallelLoopResult ForEach&lt;TSource&gt; (
    <br />
    IEnumerable&lt;TSource&gt; source, Action&lt;TSource,ParallelLoopState,long&gt; body)
    <br />
    <br />
    We’ll ignore ParallelLoopState (which we’ll cover in the following section). For 
    now, we’re interested in Action’s
    <br />
    third type parameter of type long, which indicates the loop index:
    <br />
    <br />
    Parallel.ForEach (&quot;Hello, world&quot;, (c, state, i) =&gt;
    <br />
    {
    <br />
    Console.WriteLine (c.ToString() + i);
    <br />
    });
    <br />
    <br />
    <em>TPL : Task Parallel Library</em><br />
    <br />
    <br />
    Task&lt;string&gt; task = Task.Factory.StartNew&lt;string&gt; (() =&gt;
    <br />
    Begin task
    <br />
    {<br />
    using (var wc = new System.Net.WebClient()) 
    <br />
    return wc.DownloadString (&quot;http:<br />
    www.linqpad.net&quot;);
    <br />
    });<br />
    RunSomeOtherMethod(); 
    <br />
    <br />
    //We can do other work in parallel...
    <br />
    string result = task.Result;
    <br />
    //Wait for task to finish and fetch result. Can also use task.Wait(); to simply 
    wait.<br />
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



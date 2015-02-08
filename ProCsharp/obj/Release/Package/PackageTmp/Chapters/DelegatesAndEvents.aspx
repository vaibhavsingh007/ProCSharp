<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DelegatesAndEvents.aspx.cs"
    Inherits="ProCsharp.Chapters.DelegatesAndEvents" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1"><strong>DELEGATES AND EVENTS</strong></span><br />
        <br />
        Delegates in C# always syntactically take a one - parameter constructor, the parameter
        being the method to which the delegate will refer. This method must match the signature
        with which you originally defined the delegate.
        <br />
        <br />
        <strong>Delegate Example
        </strong>
        <br />
        ============<br />
        <br />
        Here, we will use a delegate to point to two methods, AddNumbers() and SubtractNumbers()
        of the MathOperations class from the 'Arrays' page. Please enter two numbers to
        perform the respective operation.
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Run Delegate" />
        <br />
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        <br />
        <br />
        <strong>Anonymous Methods and Lambda Expressions</strong><br />
        ===============================<br />
        <br />
        Enter two numbers above and press the button below to get the result using the 
        respective method(s):<br />
        <br />
        Addition using&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
            Text="Anonymous Method" />
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server"></asp:Label>
        <br />
        Subtraction using
        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
            Text="Lambda Expression" />
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server"></asp:Label>
        <br />
        <br />
        <br />
        <strong>Covariance and Contra-Variance</strong><br />
        =====================<br />
        <br />
        A delegate can exhibit a &#39;return type covariance&#39; or &#39;parameter type 
        contra-variance&#39;.<br />
        What this means is that a delegate may return a different type than the one it 
        was defined to(covariance) or also<br />
        accept a parameter of a different type as in the latter case (contra-variance).<br />
        This is only possible due to inheritance.<br />
        <br />
        See the below example to understand:<br />
        <br />
        public class DelegateReturn
        <br />
        { }
        <br />
        public class DelegateReturn2 : DelegateReturn
        <br />
        { }
        <br />
        <br />
        public delegate DelegateReturn MyDelegate1();
        <br />
        <br />
        class Program<br />
        {
        <br />
&nbsp;&nbsp;&nbsp; static void Main()
        <br />
&nbsp;&nbsp;&nbsp; {
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MyDelegate1 d1 = Method1;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d1();
        <br />
&nbsp;&nbsp;&nbsp; }
        <br />
        <br />
&nbsp;&nbsp;&nbsp; static DelegateReturn2 Method1()&nbsp;&nbsp;&nbsp;&nbsp; //Return 
        type Covariance<br />
&nbsp;&nbsp;&nbsp; {
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DelegateReturn2 d2 = new DelegateReturn2();
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return d2;
        <br />
&nbsp;&nbsp;&nbsp; }
        <br />
        }<br />
        _______________<br />
        <br />
        public class DelegateReturn
        <br />
        { }
        <br />
        public class DelegateReturn2 : DelegateReturn
        <br />
        { }
        <br />
        <br />
        public delegate void MyDelegate2(DelegateParam2 p);
        <br />
        class Program
        <br />
        {
        <br />
&nbsp;&nbsp;&nbsp; static void Main()
        <br />
&nbsp;&nbsp;&nbsp; {
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MyDelegate2 d2 = Method2;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DelegateParam2 p = new DelegateParam2();
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d2(p);
        <br />
&nbsp;&nbsp;&nbsp; }
        <br />
&nbsp;&nbsp;&nbsp; static void Method2(DelegateParam p)&nbsp;&nbsp;&nbsp;&nbsp; 
        //Parameter type Contra-Variance<br />
&nbsp;&nbsp;&nbsp; { }
        <br />
        }<br />
        <br />
        <br />
        <strong>Events</strong><br />
        =====<br />
        <br />
        <br />
        Enter the number in the box to add to the list and then perform the respective 
        operation to test the event notification.<br />
        <br />
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button4" runat="server" onclick="Button4_Click" 
            Text="Add to list" />
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button5" runat="server" onclick="Button5_Click" 
            Text="Clear list" />
        <br />
        <br />
        <asp:Label ID="Label4" runat="server"></asp:Label>
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


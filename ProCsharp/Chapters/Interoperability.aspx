<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Interoperability.aspx.cs"
    Inherits="ProCsharp.Chapters.Interoperability" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <span class="style1"><strong>INTEROPERABILITY</strong></span><br />
        <br />
        <br />COM and .Net <br />============ <br />A COM component may or may not include a type 
        library when in the latter case, <br />using COM with .net, it is necessary to write 
        the type library for the COM using C#. 
        <br />
        <br />Freeing Memory <br />-------------- <br />For 
        this, .net uses the garbage collector however, COM relies on the reference 
        counts. <br />Every COM object is required to implement the interface IUnknown that 
        offers three <br />methods. Two of these are related to reference count: AddRef() to 
        add another interface <br />pointer and increments the reference count. Release() 
        decrements the ref count and destroys <br />the object if the resulting ref count is 
        equal to 0. 
        <br />
        <br />Interfaces <br />---------- <br />COM uses three interfaces types: custom, 
        dispatch and dual interfaces. <br />Custom Interfaces: Defines the order of methods 
        in a virtual table(vtable) so the client can <br />use it directly. <br />Dispatch 
        Interfaces: These are the interfaces actually available to the old scripting 
        clients <br />(ex: made in VB). These (IDispatch) interfaces use two tables to map 
        the method to its ID in <br />the second to map the ID to its implementation. Hence, 
        the two important methods used here are <br />GetIDsOfNames() and Invoke(). <br />Dual 
        Interfaces: Dispatch interface are a lot slower than the custom interfaces and 
        the custom <br />interfaces cannot be used by the scripting clients. Hence, Dual 
        Interfaces provide both the vtable <br />and IDispatch so the client that can use 
        the vtable can do so. 
        <br />
        <br />Method Binding <br />============== <br />Late Binding: The 
        client will use IDispatch or dual interfaces and will search for the method 
        <br />during the runtime. <br />Early Binding: The client will use the vtable and the ID 
        is stored within the client so at the <br />runtime, simply Invoke() is used to call 
        the method. <br />Use QueryInterface() from .net to query the COM interfaces. 
        <br />
        <br />Threading <br />========= <br />COM uses STAs and MTAs. 
        <br />
        <br />Error Handling 
        <br />============== <br />Older COM objects return HRESULT values that can be used to 
        get errors.<br />
        <br />
        Blittable, Non-Blittable data types during Marshalling.<br />
        <br />
        The following application would comprise of and exemplify creating a COM 
        component and then a .net RCW in order to wrap and use its methods:<br />
        <br />
        The ATL project has been created and a Runtime Callable Wrapper (RCW) has been 
        created from it using &#39;tlbimp COMServer.dll /out:Interop.COMServer.dll&#39;.<br />
        <br />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Call IWelcome from COM" />
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
            Text="Call IMath from COM" />
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



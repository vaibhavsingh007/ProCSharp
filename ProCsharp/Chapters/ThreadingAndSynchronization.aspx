<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThreadingAndSynchronization.aspx.cs"
    Inherits="ProCsharp.Chapters.ThreadingAndSynchronization" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
    <div>
        <br />
        Read more about Processes, Threads and Apartments:<br />
        <a href="http://msdn.microsoft.com/en-us/library/windows/desktop/ms693344(v=vs.85).aspx">
        http://msdn.microsoft.com/en-us/library/windows/desktop/ms693344(v=vs.85).aspx</a><br />
        <br />
        <br />
        <span class="style1"><strong>Asynchronous Delegates</strong></span><br />
        <br />
        A simple way to create a thread is by defining a delegate and invoking it asynchronously.
        A delegate uses thread pool for asynchronous tasks.<br />
        <br />
        <strong>Polling</strong>: Using BeginInvoke() to invoke the delegate, we will use
        its IAsyncResult return type to check if the delegate has completed its work.<br />
        <br />
        Refer to the code behind for details:<br />
        <br />
        Press the following method to invoke PollWaitAwhile() that also invokes the WaitAWhile
        delegate asynchronously that refers to the WaitAWhile()
        <br />
        method that increments a number by 1 and returns the result after sleeping for the
        ms passed in the parameters.<br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server" Height="121px" Width="451px" TextMode="MultiLine"
            Wrap="false"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="PollWaitAWhile" OnClick="Button1_Click" />
        <br />
        <br />
        Instead of examining if the delegate is completed, you can also just invoke the
        EndInvoke() method of the delegate type after you are finished
        <br />
        with the work that can be done by the main thread. EndInvoke() itself waits until
        the delegate has completed its work.<br />
        <br />
        If you don’t wait for the delegate to complete its work and end the main thread
        before the delegate is finished, the thread of the delegate will
        <br />
        be stopped.<br />
        <br />
        <br />
        <strong>Wait Handle </strong>can also be used to wait for the asynchronous delegate
        as below:
        <br />
        while (true)<br />
        {
        <br />
        Console.Write(“.");
        <br />
        if (d1Result.AsyncWaitHandle.WaitOne(50, false)) &lt;-- WaitOne() will return false
        after the 50ms timeout
        <br />
        {
        <br />
        Console.WriteLine(“Can get the result now");
        <br />
        break;
        <br />
        }
        <br />
        }
        <br />
        int result = d1.EndInvoke(d1Result);
        <br />
        Console.WriteLine(“result: {0}", result);<br />
        <br />
        <br />
        <strong>Asynchronous Callback</strong><br />
        Press the Button below to get the result in the text box above.<br />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="AsyncCallWaitAWhile" />
        <br />
        <br />
        .....................................................................<span class="style1"><strong><em><br />
            <br />
            THREADS</em></strong></span><br />
        <br />
        <strong>Thread Pools</strong><br />
        <br />
        <br />
        class Program
        <br />
        {
        <br />
        static void Main()
        <br />
        {
        <br />
        int nWorkerThreads;
        <br />
        int nCompletionPortThreads;
        <br />
        ThreadPool.GetMaxThreads(out nWorkerThreads, out nCompletionPortThreads);
        <br />
        Console.WriteLine(“Max worker threads: {0}, “ + “I/O completion threads: {1}",
        <br />
        nWorkerThreads, nCompletionPortThreads);
        <br />
        <br />
        for (int i = 0; i &lt; 5; i++)
        <br />
        {
        <br />
        ThreadPool.QueueUserWorkItem(JobForAThread);
        <br />
        }
        <br />
        Thread.Sleep(3000);
        <br />
        }
        <br />
        <br />
        static void JobForAThread(object state)
        <br />
        {
        <br />
        for (int i = 0; i &lt; 3; i++)
        <br />
        {
        <br />
        Console.WriteLine(“loop {0}, running inside pooled thread {1}",
        <br />
        i, Thread.CurrentThread.ManagedThreadId);
        <br />
        Thread.Sleep(50);
        <br />
        }
        <br />
        }
        <br />
        }<br />
        <br />
        Output:<br />
        <br />
        <br />
        Max worker threads: 50, I/O completion threads: 1000
        <br />
        loop 0, running inside pooled thread 4
        <br />
        loop 0, running inside pooled thread 3
        <br />
        loop 1, running inside pooled thread 4
        <br />
        loop 1, running inside pooled thread 3
        <br />
        loop 2, running inside pooled thread 4
        <br />
        loop 2, running inside pooled thread 3
        <br />
        loop 0, running inside pooled thread 4
        <br />
        loop 0, running inside pooled thread 3
        <br />
        loop 1, running inside pooled thread 4
        <br />
        loop 1, running inside pooled thread 3
        <br />
        loop 2, running inside pooled thread 4
        <br />
        loop 2, running inside pooled thread 3
        <br />
        loop 0, running inside pooled thread 4
        <br />
        loop 1, running inside pooled thread 4
        <br />
        loop 2, running inside pooled thread 4<br />
        <br />
        <strong style="text-decoration: underline">Racing Problem</strong><br />
        <br />
        Racing occurs when a resource is shared between multiple threads and the threads 
        are switched.<br />
        When it occurs depends on the processor. It is more frequent on a multicore 
        processor where several threads are run<br />
        simultaneously. Refer to the code behind for details:<br />
        <br />
        Click on the following button to test Racing in the code behind:<br />
        <br />
        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
            Text="Test Racing" />
        <br />
        <br />
        Another example:<br />
        The Expected value should be 100000. Refer to the code behind for details:<br />
        Use lock in the code behind to see the difference and enable synchronization.<br />
        <br />
        <asp:Button ID="Button4" runat="server" onclick="Button4_Click" 
            Text="Test Racing 2" />
        <br />
        <br />
        <br />
        <br />
        <br />
        <strong>Interlocked<br />
        </strong>
        <br />
        The Interlocked class is used to make simple statements for variables atomic. 
        i++ is not thread - safe. i++ consists of getting a value from the memory, 
        incrementing the value by 1, and storing the value back into memory. These 
        operations can be interrupted by the thread scheduler. The Interlocked class 
        provides methods for incrementing, decrementing, and exchanging values in a 
        thread - safe manner.<br />
        <br />
        Its methods are:
        <br />
        Increment(), Decrement(), Exchange(), CompareExchange(), Add() and Read()<br />
        <br />
        <br />For example, instead of using the lock statement to lock access to the 
        variable someState when setting <br />it to a new value, in case it is null, you can 
        use the Interlocked class, which is faster: <br />lock (this) <br />{ <br />if (someState == 
        null) <br />{ <br />someState = newState; <br />} <br />} <br />The faster version with the same 
        functionality uses the Interlocked.CompareExchange() method: 
        <br />Interlocked.CompareExchange &lt; SomeState &gt; (ref someState, newState, <br />null); 
        <br />And instead of doing an increment inside a lock statement: <br />public int State 
        <br />{ <br />get <br />{ <br />lock (this) <br />{ <br />return ++state; <br />} <br />} <br />} 
        <br />Interlocked.Increment() is faster: <br />public int State <br />{ <br />get <br />{ <br />return 
        Interlocked.Increment(ref state); <br />} <br />}<br />
        <br />
        <br />
        <strong><em>lock(obj) is nothing but the Monitor class&#39;s Monitor.Enter(obj) and 
        Monitor.Exit(obj) methods</em></strong><br />
        <br />
        <span class="style1"><strong>Mutex</strong></span><br />
        <br />
        Mutex provides synchronization across multiple processes and only one thread can 
        be the owner of the synchronized region (or object).<br />
        <br />
        A mutex object is define as:<br />
        bool createdNewMutex;<br />
        Mutex mutex = new Mutex(false, &quot;TestMutex&quot;, out createdNewMutex)<br />
        <br />
        The first param,&#39;false&#39; defines if the mutex should initially be owned by the 
        calling thread, second is the name of the mutex and the third,
        <br />
        is a reference param to recieve a boolean value if the mutex is newly created 
        (if false then the mutex by that name already exists).<br />
        <br />
        Click on the button below to test the working of the mutex. Refer to the code 
        behind for details:<br />
        (Fire the app twice to test)<br />
        <br />
        <asp:Button ID="Button6" runat="server" onclick="Button6_Click" 
            Text="Fire TestApp" />
        <br />
        <br />
        <br />
        <span class="style1"><strong>Semaphore</strong></span><br />
        <br />
        A semaphore is like a nightclub: it has a certain capacity, enforced by a 
        bouncer. Once it’s full, no more people can enter, and a queue builds up 
        outside. Then, for each person that leaves, one person enters from the head of 
        the queue. The constructor requires a minimum of two arguments: the number of 
        places currently available in the nightclub and the club’s total capacity.
        <br />
        A semaphore with a capacity of one is similar to a Mutex or lock, except that 
        the semaphore has no “owner"—it’s thread-agnostic. Any thread can call Release 
        on a Semaphore, whereas with Mutex and lock, only the thread that obtained the 
        lock can release it.<br />
        <br />
        <br />Semaphores can be useful in limiting concurrency—preventing too many threads 
        from executing a particular piece of <br />code at once. In the following example, 
        five threads try to enter a nightclub that allows only three threads in at once: 
        <br />
        <br />class TheClub&nbsp;&nbsp;&nbsp;&nbsp; <br />No door lists! <br />{ <br />static SemaphoreSlim _sem = new 
        SemaphoreSlim (3);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />Capacity of 3 <br />static void Main() <br />{ <br />for (int i = 1; i 
        &lt;= 5; i++) new Thread (Enter).Start (i); <br />} <br />static void Enter (object id) <br />{ 
        <br />Console.WriteLine (id + &quot; wants to enter&quot;); <br />_sem.Wait(); <br />Console.WriteLine 
        (id + &quot; is in!&quot;);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />Only three threads <br />Thread.Sleep (1000 * (int) id);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <br />can 
        be here at <br />Console.WriteLine (id + &quot; is leaving&quot;);&nbsp;&nbsp;&nbsp;&nbsp; 
        <br />a time. 
        <br />_sem.Release(); <br />} <br />} 
        <br />
        <br />1 wants to enter <br />1 is in! <br />2 wants to enter <br />2 
        is in! <br />3 wants to enter <br />3 is in! <br />4 wants to enter <br />5 wants to enter <br />1 
        is leaving <br />4 is in! <br />2 is leaving <br />5 is in!<br />
        <br />
        <span class="style1"><strong>Events</strong></span><br />
        <br />
        The &#39;event&#39; keyword from Delegates and Events has nothing to do with the event 
        classes from the namespace System.Threading!<br />
        Here, two type of events, viz. ManualResetEvent and AutoResetEvent are used to 
        use Set() and Reset() methods to enter a signalled or
        <br />
        non-signaled state.<br />
        When a ManualResetEvent is signaled, all waiting threads are released. If a 
        thread invokes a WaitOne() method and the event is already
        <br />
        signaled, it can continue immediately.<br />
        In the case of an AutoResetEvent, for a waiting thread, it automatically turns 
        from non-signaled to signaled so the thread can continue.<br />
        <br />
        Refer to the theory for details.<br />
        <br />
        <strong><span class="style1">ReaderWriterLockSlim </span>
        <br class="style1" />
        </strong>
        <br />
        For a locking mechanism to allow multiple readers, but just one writer, to a 
        resource, the class ReaderWriterLockSlim can be used.
        <br />
        This class offers a locking functionality in which multiple readers can access 
        the resource if no writer locked it, and only a single writer
        <br />
        can lock the resource. ReaderWriterLockSlim is new with .NET 3.0. The .NET 1.0 
        class with similar functionality is ReaderWriterLock .
        <br />
        ReaderWriterLockSlim was redesigned to prevent deadlocks and to offer better 
        performance.<br />
        <br />
        <span class="style1"><strong>Timers</strong></span><br />
        <br />
        Invokes a method (usually a delegate passed as the first param of its 
        constructor) for a specified time period.<br />
        Refer to theory for details.<br />
        <br />
        <span class="style1"><strong>COM Apartments</strong></span><br />
        <br />
        COM defines apartments for synchronization. With the STA, the COM runtime does 
        the synchronization but not in case of the MTA where<br />
        multiple threads are allowed to access a resource simultaneously. The apartment 
        mode a COM accepts is defined by a registry configuration.<br />
        In case of STA, another thread can access the component only by using a proxy 
        that sends a Windows message to the thread that is connected
        <br />
        to the COM object. STAs use Windows messages for synchronization.<br />
        <br />
        STA or MTA for a method is defined by setting its attribute as follows:<br />
        <br />
        [STAThread]<br />
        static void main()<br />
        {<br />
&nbsp;&nbsp;&nbsp; <br />...<br />
        }<br />
        <br />
        OR by<br />
        <br />
        Thread t1 = new Thread(DoSomeWork);
        <br />
        t1.SetApartmentState(ApartmentState.STA);
        <br />
        t1.Start();<br />
        <br />
        <span class="style1"><strong>Event-based Asynchronous pattern</strong></span><br />
        <br />
        Click the following button to trigger the sample app. Refer to the code for 
        details:<br />
        <br />
        <asp:Button ID="Button5" runat="server" onclick="Button5_Click" 
            Text="Start BackgroundWorker Sample" />
        <br />
        <br />
        <br />
        <strong>The Framework 4.0 lower-level threading constructs: A conclusion</strong><br />
        ==============================================<br />
        <br />
        <em><strong>-The low-latency signaling constructs (SemaphoreSlim, 
        ManualResetEventSlim, CountdownEvent and Barrier) </strong></em>
        <br />
        There are two functionally similar versions of this class: Semaphore and 
        SemaphoreSlim. The latter was introduced in Framework 4.0 and has been optimized 
        to meet the low-latency demands of parallel programming. It’s also useful in 
        traditional multithreading because it lets you specify a cancellation token when 
        waiting. It cannot, however, be used for interprocess signaling. Semaphore 
        incurs about 1 microsecond in calling WaitOne or Release; SemaphoreSlim incurs 
        about a quarter of that.<br />
        <br />
        Semaphores can be useful in limiting concurrency—preventing too many threads 
        from executing a particular piece of <br />code at once. In the following example, 
        five threads try to enter a nightclub that allows only three threads in at once: 
        <br />
        <br />class TheClub <br />No door lists! <br />{ <br />static SemaphoreSlim _sem = new 
        SemaphoreSlim (3); Capacity of 3 <br />static void Main() <br />{ <br />for (int i = 1; i &lt;= 
        5; i++) new Thread (Enter).Start (i); <br />} <br />static void Enter (object id) <br />{ 
        <br />Console.WriteLine (id + &quot; wants to enter&quot;); <br />_sem.Wait(); <br />Console.WriteLine 
        (id + &quot; is in!&quot;); <br />Only three threads <br />Thread.Sleep (1000 * (int) id);&nbsp;&nbsp;&nbsp;&nbsp; 
        <br />can be 
        here at <br />Console.WriteLine (id + &quot; is leaving&quot;); <br />a time. <br />_sem.Release(); <br />} 
        <br />}<br />
        <br />
        <strong><em>-Cancellation tokens for cooperative cancellation 
        </em></strong> 
        <br />
        <br />
        <br />Framework 4.0 provides two types that formalize the cooperative cancellation 
        pattern that we just demonstrated: <br />CancellationTokenSource and 
        CancellationToken. The two types work in tandem: 
        <br />
        <br />· A CancellationTokenSource 
        defines a Cancel method. <br />· A CancellationToken defines an 
        IsCancellationRequested property and <br />ThrowIfCancellationRequested method. 
        <br />
        <br />Because the types are separate, you can 
        isolate the ability to cancel from the ability to check the cancellation flag. 
        <br />To use these types, first instantiate a CancellationTokenSource object: 
        <br />
        <br />var 
        cancelSource = new CancellationTokenSource(); <br />Then, pass its Token property 
        into a method for which you’d like to support cancellation: <br />new Thread (() =&gt; 
        Work (cancelSource.Token)).Start(); <br />Here’s how Work would be defined: 
        <br />
        <br />void 
        Work (CancellationToken cancelToken) <br />{ 
        <br />cancelToken.ThrowIfCancellationRequested(); <br />... <br />} <br />When you want to 
        cancel, simply call Cancel on cancelSource.<br />
        <br />
        CancellationToken is actually a struct, although you can treat it like a class. 
        When implicitly copied, the copies behave identically and reference the original 
        CancellationTokenSource.
        <br />
        The CancellationToken struct provides two additional useful members. The first 
        is WaitHandle, which returns a wait handle that’s signaled when the token is 
        canceled. The second is Register, which lets you register a callback delegate 
        that will be fired upon cancellation.<br />
        <br />
        <strong><em>-The lazy initialization classes
        </em></strong>
        <br />
        <br />
        This means, initializing a class when needed. Lazy&lt;T&gt; does exactly that for us 
        as follows:<br />
        <br />
        To use Lazy&lt;T&gt;, instantiate the class with a value factory delegate that tells 
        it how to initialize a new value, and the argument true. Then access its value 
        via the Value property:
        <br />
        <br />
        Lazy&lt;Expensive&gt; _expensive = new Lazy<Expensive> (() =&gt; new Expensive(), true);
        <br />
        public Expensive Expensive
        <br />
        {
        <br />
        get { return _expensive.Value; }
        <br />
        }
        <br />
        <br />
        If you pass false into Lazy<T>’s constructor, it implements the thread-unsafe 
        lazy initialization pattern—this 
        makes sense when you want to use Lazy<T> in a 
        single-threaded context.<br />
        <br />
        Lazy<T> actually implements a slightly more efficient version of this pattern, 
        called double-checked locking. Double-checked locking performs an additional 
        volatile read to avoid the cost of obtaining a lock if the object is already 
        initialized.<br />
        <br />
        <strong><em>-ThreadLocal</em></strong><T><strong><em>&lt;T&gt;</em></strong><br />
        <br />
        ThreadLocal<T> is new to Framework 4.0. It provides thread-local storage for 
        both static and <em>instance</em> fields—and allows you to specify default values.<br />
        The Random class is not thread-safe, so we have to either lock around using 
        Random (limiting concurrency) or generate a separate Random object for each 
        thread. ThreadLocal<T> makes the latter easy:
        <br />
        <br />
        var localRandom = new ThreadLocal<Random>(() =&gt; new Random());
        <br />
        Console.WriteLine (localRandom.Value.Next());<br />
        <br />
        The easiest way to initialize a thread local static field is to mark it as 
        [ThreadStatic]<br />
        [ThreadStatic] static int _x;<br />
        <br />
        <strong><em>GetData and SetData</em></strong><br />
        <br />
        Another approach towards setting thread local variables is to use the <em>
        LocalDataStoreSlot</em> :<br />
        as:<br />
        class Test<br />
        {<br />
&nbsp;&nbsp;&nbsp; LocalDataStoreSlot _secSlot = new LocalDataStoreSlot();&nbsp;&nbsp;&nbsp; 
        // or = Thread.GetNamedDataSlot(&quot;securityLevel&quot;); for naming it.<br />
&nbsp;&nbsp;&nbsp; .....<br />
        }<br />
        <br />
        now, _secSlot can be used application vide to create local thread data as in the 
        following property:<br />
        <br />
        int SecurityLevel<br />
        {<br />
&nbsp;&nbsp;&nbsp; get<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object data = Thread.GetData( _secSlot);<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return null ? 0 : int(data);<br />
&nbsp;&nbsp;&nbsp; }<br />
&nbsp;&nbsp;&nbsp; set<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thread.SetData( _secSlot, value );<br />
&nbsp;&nbsp;&nbsp; }<br />
        }<br />
        <br />
        // The slot can be freed as:<br />
        Thread.FreeNamedDataSlot(_secSlot);<br />
        <br />
        <span class="style1"><strong>NON BLOCKING SYNCHRONISATION</strong></span><br />
        <br />
        Using memory barriers and volatility for implementing non-blocking 
        synchronisation may be tricky and there must be a very good reason for using it 
        before dismissing the traditional locks. Acquiring and releasing a lock anyway, 
        takes less than 20 ns in a 2010 - era desktop! ;)<br />
        <br />
        The CLR runtime, compiler or CPU may use optimization techniques to perform 
        instruction reordering and/or read-write caching.<br />
        Such a phenomenon may result in a repercussion of a thread-unsafe scenario.<br />
        <br />
        Memory barriers may be used to avoid such a situation.<br />
        <br />
        Use FULL FENCES to easily create a memory barrier using:<br />
        Thread.MemoryBarrier();&nbsp; before any the statement to fence.<br />
        <br />
        A good approach is to start by putting memory barriers <span class="style1"><em>
        before and after every instruction that reads or writes a shared field 
        respectively</em></span>, and then strip away the ones that you don’t need. If 
        you’re uncertain of any, leave them in. Or better: switch back to using locks!<br />
        <br />
        <br />
        VOLATILE KEYWORD<br />
        <br />
        Another (more advanced) way to solve this problem is to apply the volatile 
        keyword to the _complete field: volatile bool _complete; 
        <br />
       The volatile keyword instructs the compiler to generate an acquire-fence on 
        every read from that field, and a releasefence on every write to that field. An 
        acquire-fence prevents other reads/writes from being moved before the fence; a 
        release-fence prevents other reads/writes from being moved after the fence. 
        These “half-fences” are faster than full fences because they give the runtime 
        and hardware more scope for optimization.<br />
        <br />
        The volatile keyword is not supported with pass-by-reference arguments or 
        captured local variables: in these cases you must use the VolatileRead and 
        VolatileWrite methods.<br />
        <br />
        <br />
        <span class="style1">WAIT AND PULSE</span><br />
        Here’s how to use Wait and Pulse: 
        <br />
        <br />
        1. Define a single field for use as the synchronization object, such as: 
        <br />
        readonly object _locker = new object();
        <br />
        2. Define field(s) for use in your custom blocking condition(s). For example:
        <br />
        bool _go; or: int _semaphoreCount;
        <br />
        3. Whenever you want to block, include the following code:
        <br />
        lock (_locker)
        <br />
        while ( <blocking-condition> )
        <br />
        Monitor.Wait (_locker);
        <br />
        4. Whenever you change (or potentially change) a blocking condition, include 
        this code:
        <br />
        lock (_locker)
        <br />
      {<br />
        &lt; alter the field(s) or data that might t
        <br />
        impact the blocking condition(s) &gt;
        <br />
      Monitor.Pulse (_locker);<br />
        or: Monitor.PulseAll (_locker) )
        <br />
        }
        <br />
        (If you change a blocking condition and want to block, you can incorporate steps 
        3 and 4 in a single lock
        <br />
        statement.)
        <br />
        This pattern allows any thread to wait at any time for any condition. Here’s a 
        simple example, where a worker thread
        <br />
      waits until the _go field is set to true:<br />
        <br />
        <span class="style1">WAIT TIMEOUTS</span><br />
        <br />
        lock (_locker)
        <br />
        while ( [blocking-condition] )
        <br />
        Monitor.Wait (_locker, [timeout] );<br />
        <br />
        <br />
        <br />
        <br />
        _______________________________________________________________________________________________________________<br />
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


<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MVC.aspx.cs" Inherits="ProCsharp.Chapters.MVC" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>

    <span class="style1"><strong>MVC</strong></span><br />
    <br />

    Click 
    <a href="http://localhost:54626/">here</a>
     to open the MVC Demo internet application.
     <br />
     <br />
    MVC = Model View Controller is a design pattern where the three roles are 
    segregated in that the data access is in the Model, logic for reading/writing 
    data via the Model and View is the job of the Controller and the View simply 
    takes care of the presentation part. It follows a strong naming standards!<br />
    This enables the developers to directly focus on the key respective areas to 
    leverage the best of what they can to develop the web application.<br />
    It does not care about the data or other layers of the application and simply 
    concentrates on building the UI.<br />
    <br />
    The MVC framework has 4 major goals:<br />
    <br />
    -Embrace the web<br />
    -Run on ASP.net<br />
    -Extensible<br />
    -Testable<br />
    <br />
    <span class="style1"><strong><em>Introduction</em></strong></span><br 
        class="style1" />
    <br />
    Every method in the controller class returning a View() has a corresponding page 
    (ex: .cshtml) for it.<br />
    <br />
    ViewBag is a dynamically type object to which properties can be added on the fly 
    to be accessed elsewhere (ex: In a View to deliver some message that was 
    assigned in a Controller&#39;s method.<br />
    <br />
    <span class="style1"><strong><em>Controllers</em></strong></span><br />
    <br />
    The Routing engine delivers an HTTP request to a controller.<br />
    Action Filters introduce pre and post processing to an action.<br />
    <br />
    more..<br />
    <br />
    ex of a general &#39;route map&#39;:<br />
    <br />
    routes.MapRoute(<br />
    &quot;Default&quot;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    // Route name<br />
    &quot;{controller}/{action}/{id}&quot;,&nbsp;&nbsp;&nbsp; // URL with parameters (pattern 
    for the route)<br />
    new { controller = &quot;Home&quot;,<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; action = &quot;Index&quot;,<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id = UrlParameter.Optional<br />
&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Parameter 
    defaults<br />
    <br />
    <br />
    ex URL: <a href="http://localhost/home/index">http://localhost/home/index</a>/<br />
&nbsp;&nbsp;&nbsp;&nbsp; OR: http://localhost/{controller}/{action}/{id}<br />
    <br />
    if the routing engine does not find a value in the uRL, it will use the values 
    defined inside those curly braces to populate them.<br />
    <br />
    more..<br />
    <br />
    The Global.asax file in a MVC solution has a class derived from the 
    HttpApplication which allows it to hook into application level events like 
    Application_Start.<br />
    This method is invoked before all and is in the Global.asax file. Here we 
    register our Routes, etc.<br />
    <br />
    Parameters / values captured by a route can be accessed in the code using: 
    RouteData.Values[&quot;controller (or) action (or) id&quot;]<br />
    <br />
    A new custom&nbsp; route for the URL <a href="http://localhost/vaibhav/index">
    http://localhost/vaibhav/index</a> can be defined as :<br />
    <br />
    routes.MapRoute(<br />
    &quot;Vaibhav&quot;,<br />
    &quot;vaibhav/{name}&quot;,<br />
    new { controller = &quot;Vaibhav&quot;, action = &quot;index&quot;, id = UrlParameter.Optional }<br />
    <br />
    for the above URL to be rendered, a new class should be added to the 
    &#39;Controllers&#39; folder in the solution as follows:<br />
    <br />
    public class VaibhavController : Controller<br />
    {<br />
&nbsp;&nbsp;&nbsp; // Here is the &#39;action&#39; method.<br />
&nbsp;&nbsp;&nbsp; public ActionResult Index(string name = &quot;someDefaultValue&quot;)&nbsp;&nbsp;&nbsp; 
    // This is the <em>action</em> parameter in the route engine above.<br />
&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    // The param inside is optional and displays how a default value can be assigned 
    directly here.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return View();<br />
&nbsp;&nbsp;&nbsp;&nbsp; }<br />
    }<br />
    <br />
    Differenct type of outputs can be returned from an ActionResult (action) than 
    just the View().<br />
    Like Content, File, JavaScript, JSON, Redirect, etc.<br />
    <br />
    The MVC framework also uses (action selector) attributes to invoke the right 
    public method for the action.<br />
    Ex attributes: [ActionName(&quot;&lt;actionName&gt;&quot;)]&nbsp;&nbsp;&nbsp;&nbsp; // Now you 
    can reach this method by using this action name only. This acts like an alias to 
    the action method.<br />
    and&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    [ActionVerbs(&quot;HttpVerbs.Post&quot;)]&nbsp;&nbsp;&nbsp; // This is like 
    Page.IsPostBack. Short form: simply type [HttpPost]<br />
    <br />
    <em>Action Filters:</em><br />
    <br />
    Output Cache :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    Cache the output of a controller<br />
    Validate Input:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    Turn off request validation and allow dangerous input<br />
    Authorize:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    Restrict an action to authorized users and roles<br />
    ValidateAntiForgeryToken:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    Helps prevent cross site requet forgeries<br />
    HandleError:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    Can specify a friendly view to render in the event of an excption<br />
    <br />
    Building your own custom Action Filters:<br />
    <br />
    Ex: Add a new directory to the solution called <em>Infrastructure</em> and add a 
    new class LogAttribute.cs derived from ActionFilterAttribute.<br />
    <br />
    Now you get an option to override four methods starting with &#39;OnAction.. / 
    OnResult..&#39; each of which is invoked at different intervals of the &#39;action&#39; (in 
    a controller) being performed.<br />
    ex: OnResultExecuted() is invoked when the View() has been delivered to the 
    client.<br />
    <br />
    Instead of applying this to the controllers, you can instead register them in 
    the Global.asax under RegisterGlobalFilters().<br />
    <br />
    <br />
    <strong><span class="style1"><em>Razor Views</em></span></strong><br />
    <br />
    Razor is a syntax / way to insert data in a HTML markup (file extension ex: 
    .cshtml)<br />
    You actually start a C# code expression starting with the @ symbol.<br />
    <br />
    General implicit expression: @item.Rating / 10&nbsp; outputs-&gt;&nbsp; 3 / 10<br />
    but an explicit razor expr:&nbsp;&nbsp;&nbsp;&nbsp; @( item.Rating / 10.0 ) 
    outputs-&gt;&nbsp; 0.3&nbsp; (used 10.0 to get the output as double)<br />
    <br />
    in order to display a text prefixed with @, use the &#39;twitter handle&#39; as 
    @@TestText outputs-&gt; @TestText<br />
    <br />
    You can also insert raw C# code between the @{ } tag to execute on the page.<br />
    <br />
    Use the &lt;text /&gt; tag inside a razor tag to printn a simple text. Ex: <em>@{ 
    &lt;text&gt;TestText&lt;/text&gt; }</em> OR <em>@:TestText</em>, outputs-&gt; TestText<br />
    <br />
    Razor Comment: @* ... ..&nbsp; *@<br />
    <br />
    Razor Layout: Foundin the &#39;Shared&#39; folder under views.<br />
    <br />
    All the view content is placed at the place where the RenderBody() method is 
    called in the Layout.cshtml<br />
    <br />
    The layout page is actually set in the _ViewStart.cshtml so the MVC runtime 
    knows during the startup to use the Layout for the application.<br />
    Ex: @{ Layout = &quot;&lt;path to the layout file&gt;&quot; }<br />
    <br />
    @RenderSection can be used to render a section in the Layout and has to be 
    defined in a razor page as<br />
    <br />
    @section &lt;name&gt;{<br />
    &lt;p&gt;This is a footer&lt;/p&gt;<br />
    }<br />
    <br />
    in the layout:<br />
    @RenderSection(&lt;name&gt;, bool required)<br />
    <br />
    <span class="style1"><em>HTML Helpers</em></span><br />
    <br />
    &#39;Html&#39; is a property of the ViewPage base class and its used to:<br />
    <br />
    - Create inputs<br />
    - Create links<br />
    - Create forms<br />
    <br />
    ex:
    <br />
    @Html.BeginForm()<br />
    @Html.EditFor()<br />
    @Html.ActionLink() and many more<br />
    <br />
    You can define your own extension method on the &#39;Html&#39; type. This has to be done 
    inside a public class.<br />
    Ex:<br />
    For a custom HTML Helper like, @Html.Image(&lt;ImageURL&gt;, &lt;ImageName&gt;)<br />
    <br />
    the extension method can be defined as:<br />
    <br />
    public static class MyHelpers<br />
    {<br />
&nbsp;&nbsp;&nbsp; public static string Image( this HtmlHelper helper, string 
    source, string altText)<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var builder = new TagBuilder(&quot;img&quot;);&nbsp;&nbsp;&nbsp; 
    //TagBuilder builds an image tag for us<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; builder.MergeAttribute(&quot;src&quot;, src);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    //Set attributes by using the MergeAttribute<br />
&nbsp;&nbsp;&nbsp; }<br />
    }<br />
    PS: you may have to use the MvcHtmlString return type above to preclude MVC from 
    html encoding the tag(s) in the view.<br />
&nbsp;&nbsp;&nbsp; you may also need to add the namespace for the above method in 
    the web.config (in the views folder) to be able to use it on the &#39;cshtml page.<br />
    <br />
    Partial Views: Used to share a view between different pages.<br />
    this can be rendered as: @Html.Partial(&lt;partialViewName&gt;, &lt;model&gt;)<br />
    <br />
    Html.Action() can be used to generate a sub request inside a MVC http request. 
    (confusing?) ok, let see an example:<br />
    <br />
    Html.Action(&quot;BestReview&quot;, &quot;Reviews&quot;) means: please render the &#39;BestReview&#39; 
    action on the &#39;Reviews&#39; controller. This is not a seperate http request.<br />
    <br />
    use [ChildActionOnly] to shield it from being invoked if someone types it in the 
    browser URL.<br />
    <br />
    use Html.AntiForgeryToken to prevent CSRF (Cross Site Request Forgery) (more on 
    this later).<br />
    <br />
    <br />
    <span class="style1"><strong>WORKING WITH DATA ENTITY FRAMEWORK</strong></span><br />
    <br />
    The <em>model binder</em> not only takes the data from input and binds it to the 
    model objects but also provide validations.<br />
    <br />
    We will use &#39;Code First&#39; on the Entity Framework to create the DB model and 
    DBSet. Please refer to the MVC solution for details.<br />
    <br />
    Note: If you were to make any changes to the properties of the class associated 
    with the database schema (entity), the MVC application will go out of sync with 
    the DB.<br />
    In order to preclude / fix this, Add the following to the Global.asax -&gt; 
    Application_Start() method:<br />
    <br />
    DbDatabase.SetInitializer( new DropCreateDatabaseIfModelChanges&lt;OdeToFoodDB&gt;() 
    );<br />
    <br />
    This will look at the hash in the EdmMetadata table automatically created by the 
    Entity framework and Drop and Create the tables if anything is found changed in 
    the DBContext class in the code. You need to define how the DB will be 
    initialized.<br />
    <br />
    DB Mapping:<br />
    <br />
    Use (override) the OnModelCreating( ModelBuilder modelBuilder )<br />
    to provide the mapping. This has been demonstrated in the example app.<br />
    <br />
    <br />
    <span class="style1"><em>VALIDATIONS AND ANNOTATIONS</em></span><br />
    <br />
    Validations can be enforced on the properties in the model as displayed on a 
    form (for ex) in the MVC.<br />
    As an example, using the following attributes put a validation for an input 
    range between 1-10 and the body as a required field:<br />
    <br />
    [Range(1,10)]<br />
    public virtual int Rating( get; set; }<br />
    <br />
    And<br />
    <br />
    [Required]<br />
    public virtual string Body{ get; set; }<br />
    <br />
    The above is server side validation however, client side validation is also 
    enabled that prompts immediately on the form if the validation fails:<br />
    The client side validation and can be turned of by setting the following 
    property in the web.config to &#39;false&#39;:<br />
    <br />
    AppSettings &gt; ClientValidationEnabled<br />
    An Html Helper can also be used to turn off client side validation(s) on a view 
    by view basis.<br />
    PS: There is another setting for the same purpose: <em>
    UnobtrusiveJavaScriptEnabled</em> should be true. It provides the &#39;data-..&#39; 
    attributes to the inputs.<br />
    <br />
    Custom validations and attributs:<br />
    <br />
    Custom attributes can be made by defining a custom attribute class derived from 
    &#39;ValidationAttribute&#39;.<br />
    Another approach is to use a self-validating model. Here the model class must 
    implement the IVaildatableObject interface.<br />
    Use its Validate method to implement the self validation logic.<br />
    <br />
    Display Annotation:<br />
    <br />
    Use these attributes on the model class property can change how the property 
    names are displayed on the page and the input they may take.<br />
    <br />
    Ex:<br />
    <br />
    [DataType(DataType.Password)]<br />
    enforces the input box to display round circles for concealing the password.<br />
    <br />
    [DisplayName(&quot;Movie Reviews&quot;)]<br />
    displays the passed text as the label of the input box. Hope thats easy to 
    understand! :)<br />
    <br />
    <br />
    <span class="style1">JAVASCRIPT AND AJAX</span><br />
    <br />
    The script files in the Scripts folder starting with the word &#39;Microsoft..&quot; are 
    optional and are based on the Microsoft Ajax Client. They are there for backward 
    comptibility and are not generally used in MVC3. Hence, these are safe to 
    delete.<br />
    <br />
    The solution includes three types of jQuery files ending in .vsdoc, .js and 
    .min.<br />
    The .vsdoc and .js files are never sent to the client but the .min (the minified 
    version).<br />
    <br />
    Some files like jquery-ui and jquery-validate are open source jquery plug-ins.<br />
    <br />
    We place tags to include the script files to be sent to the client in the &#39;head&#39; 
    sectino of the Layout file.<br />
    <br />
    PS: For a faster load time, use the CDN = Content delivery network, provided by 
    Google, Microsoft, etc.<br />
    <br />
    We can use the razor &#39;Script&#39; methods inside a view to load the scripts as:
    <br />
    <br />
    @helper Script(string scriptName)<br />
    {<br />
&nbsp;&nbsp;&nbsp;
< script src="@Url.Content("../../Scripts/" + scriptName)" type="text/javascript">< /script >
    <br />
    }<br />
    <br />
    and then call the scripts in the head section (or at the bottom to speed up the 
    loading) of the layout page as:<br />
    <br />
    @Script(&quot; jquery-1.5.1.min.js &quot;)<br />
    etc..<br />
    <br />
    for this to work with other views, you may add the asp.net magical folder called 
    &#39;app_code&#39;<br />
    The runtime will compile any razor views inside this folder and make them 
    available as static methods.<br />
    <br />
    Use @RenderSection(&quot; Scripts &quot;, false) and<br />
    @section scripts { }
    <br />
    pairs to place the script tags strategically in an order in the application on 
    various pages.
    <br />
    <br />
    Use Ajax.ActionLink() instead of Html.ActionLink() to send a request 
    asynchronously and more features.<br />
    <br />
    For autocomplete, added a new Movies.js file with some jquery code and included 
    two libraries.<br />
    Provided the data-autocomplete attribute on the text box element that I want the 
    autocomplete to be enabled on.<br />
    Refer to the code for more info.<br />
    <br />
    MVC 3 uses templates to display views, ex: Edit.cshtml in which it uses 
    @Html.EditorFor(..) for displaying an editor field.<br />
    We can make custom templates and place them under special folders under the 
    shared folder.<br />
    <br />
    Adding the DateTime picker using jQuery..<br />
    <br />
    Use JSON for serializing and sending the raw data to the client.<br />
    jQuery is again used to convert this raw data and display as the HTML.<br />
    jQuery Templates are to be used and are not included by default in the MVC 3 
    project. Can be installed using References &gt; Add library package reference &gt; 
    jQuery.Templates via Nuget!<br />
    <br />
    <br />
    <span class="style1"><em>SECURITY</em></span><br />
    <br />
    We can use windows authentication or forms authentication.<br />
    Forms authentication is obviously preferred over the &#39;windows&#39; for public sites!<br />
    <br />
    The web.config file may be configured for either of the authentications. Change 
    the &lt;authentication mode=&quot;Forms/Windows&quot;&gt; .. &lt;/authentication&gt;.<br />
    The Accounts controller and its views are provided by default by the MVC default 
    internet application template.<br />
    <br />
    Put the [Authorize] attribute on the Index() action of the Movies Controller in 
    the app.<br />
    This attribute works with both Forms or Windows authentication.<br />
    <br />
    The LogOn Action in the AccountController uses a MemberShip service to validate 
    the username and the password accepted as a LogOnModel.<br />
    The MembershipService is basically an abstraction. It is an object that 
    implements the IMembershipService interface.<br />
    <br />
    The [Authorize] attrib can also be placed at the top at controller level as a 
    whole. It also uses multiple options eg. roles that can be easily configured 
    using the asp.net configuration tool icon over the solution on the right hand 
    side column. ex: [Authorize(Roles=&quot;domainName\groupName&quot;)]<br />
    <br />
    When working with the usernames and passwords, which are sent as plain text over 
    the http and can be sniffed on the network / url etc, you must use https (SSL) 
    instead.<br />
    SSL can be activated in the project&#39;s properties and IIS.<br />
    <br />
    Instead of making the whole site work under Https, you can simply put the 
    [RequireHttps] attrib on the controller (or even Action) that deals with 
    sensitive information, eg. AccountController.<br />
    PS: Configure the port properly (it uses 443 by default).<br />
    <br />
    To handle this problem, you can rewrite the rule under the web.config &gt; 
    system.webserver setting.<br />
    <br />
    <span class="style1"><strong><em>THREATS</em></strong></span><br />
    <br />
    <span class="style1">CROSS SITE SCRIPTING ATTACK: XSS</span><br 
        class="style1" />
    <br />
    Malicious scripts can try to access the cookies, modify settings in the user&#39;s 
    browser or force it to download malware and make it look like it came from your 
    site.<br />
    <br />
    By default, asp.net rejects any form of HTML text entered by a user on a form. 
    This can be circumvented by adding the attrib [ValidateInput(false)] to the 
    &#39;Edit&#39; Action on the &#39;MoviesController&#39;.<br />
    Add [AllowHtml] to the specific property on the Action.<br />
    Use @Html.Raw on the razor outputting the &#39;user entered html&#39; on the page. This 
    is because razor encodes everything by default.<br />
    <br />
    You can include the Microsoft&#39;s Anti cross site scripting library &#39;AntiXSS&#39; that 
    will include the HtmlSanitizationLibrary too.<br />
    This includes a list of white listed tags that it will allow in the script 
    entered and strip off the rest.<br />
    <br />
    Ex: for an edit function accepting the review param from the form &#39;body&#39;,
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; review.body = 
    Sanitizer.GetSafeHtmlFragment(review.Body);<br />
    <br />
    <br />
    <span class="style1">CROSS SITE SCRIPT FORGERY:&nbsp; CSRF</span><br />
    <br />
    This happens when a user is authenticated once and then accidentally stumbles 
    upon a malicious site presenting a form resembling your&#39;s and submits some info.<br />
    That site can then use the request back to your server as the user is already 
    authenticated and access unauthorized info,etc.<br />
    <br />
    The AntiForgeryToken is used to prevent this.
    <br />
    ex: Added to my form: @Html.AntiForgeryToken()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    This addes a unique value to the form and saves it in the cookie and<br />
    Added to the Action: [ValidateAntiForgeryToken]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    This will validate if the request came from the same form.<br />
    <br />
    <br />
    <span class="style1"><strong>ASP.NET Infrastructure for the ASP.NET MVC 3</strong></span><br />
    <br />
    [OutputCache(duration=60, VaryByParam=&quot;q&quot;)] action filter allows to cache the 
    output of a specific action in the memory.<br />
    Use in lieu of a DB query which is a read only operation and is a perfect 
    candidate for caching to gain performance.<br />
    <br />
    You can also use caching on child Actions too like @Html.BeginForm(..) to 
    improve the performance.<br />
    <br />
    Use CacheProfiles to adjust the cache settings by taking some measurements and 
    testing around it.<br />
    <br />
    For using culture, etc., add &lt;Globalization.. /&gt; in the web.config file.<br />
    <br />
    Resx files can store localized texts and binary assests.<br />
    Add resource files for this. (simple XML files containing name value pairs)<br />
    <br />
    <br />
    <span class="style1">IOC and Injection</span><br />
    <br />
    Use Nuget&#39;s StructureMap-MVC3 for the IOC containers.<br />
    <br />
    Ex for IOC:<br />
    <br />
    Let us say that a class has two constructors, one default and the other 
    prameterized, viz.<br />
    public class ReviewController : Controller<br />
    {<br />
&nbsp;&nbsp;&nbsp; IDBContext _db;<br />
&nbsp;&nbsp;&nbsp;
    <br />
&nbsp;&nbsp;&nbsp; public ReviewController()<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _db = new MoviesDB();<br />
&nbsp;&nbsp;&nbsp; }<br />
&nbsp;&nbsp;&nbsp;
    <br />
&nbsp;&nbsp;&nbsp; public ReviewController(IDBContext db)<br />
&nbsp;&nbsp;&nbsp; {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _db = db;<br />
&nbsp;&nbsp;&nbsp; }<br />
&nbsp;&nbsp;&nbsp; .....<br />
&nbsp;&nbsp;&nbsp; ....<br />
    }<br />
    <br />
    Lets say that the default constructor is for the MVC3 framework to use and the 
    parameterized for the unit test to pass a fake in memory DBContext.<br />
    Now, we don&#39;t want the classes under test to have dependencies and instantiate 
    objects that are hard to test, like &#39;new MoviesDB()&#39;.<br />
    <br />
    This is hence, a candidate for IOC and injection. Inversion of Control or IOC 
    means that (eg here) the controller isn&#39;t in control of its dependencies 
    anymore!<br />
    Instead, we are inverting the control and giving something else the 
    responsibility to supply to the controller, the objects that it needs to work 
    with.<br />
    <br />
    This is done by the PluralSight guy by using the afore mentioned Nuget package, 
    StructureMap-MVC3.<br />
    <br />
    an excerpt from its IOC container is the following line that tells tha compiler 
    what to pass when the IDBContext type object is encountered.<br />
    IOC containers know how to instantiate objects with dependencies.<br />
    Now, the default constructor may be removed from the above code and,
    <br />
    <br />
    The Nuget package adds an app_start piece of code and other classes to the 
    project, ex: IOC.cs<br />
    Excerpt:<br />
    <br />
    ....<br />
    ...<br />
    x.For&lt;IDBContext&gt;().Use&lt;MoviesDB&gt;();<br />
    ...<br />
    ..<br />
    <br />
    ____________________________<br />
    <br />
    Finally, refer to the source of this article for Configuration and Deployment.<br />
    <br />
    Source: <a href="http://www.asp.net/mvc/pluralsight">
    http://www.asp.net/mvc/pluralsight</a><br />
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


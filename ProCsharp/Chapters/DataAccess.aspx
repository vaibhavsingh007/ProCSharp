<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DataAccess.aspx.cs" Inherits="ProCsharp.Chapters.DataAccess" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="SecondaryContent">
<div>


    <span class="style1"><strong>DATA ACCESS<br />
    <br />
    ADO.NET</strong></span><br />
    Currently at version 2.8, ADO consists primarily of the Connection , Command , 
    Recordset , and Field objects. Using ADO, a connection is opened to the 
    database, some data is selected into a record set consisting of fields, that 
    data is then manipulated and updated on the server, and the connection is 
    closed.<br />
    <br />
    <br />
    <strong>Shared Classes</strong><br />
    <br />Class&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description <br />DataSet&nbsp;&nbsp;&nbsp;&nbsp; This object is designed for disconnected use and 
    can contain a set of <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DataTables and relationships between these tables. 
    <br />DataTable A container of data that consists of one or more DataColumns and, 
    when <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; populated, will have one or more DataRows containing data. <br />DataRow&nbsp;&nbsp; A 
    number of values, akin to a row from a database table or a row from a 
    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spreadsheet. 
    <br />
    <br />DataColumn This object contains the definition of a column, 
    such as the name and data <br />type. 
    <br />
    <br />DataRelation A link between two DataTable 
    classes within a DataSet class; used for <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; foreign key and master/detail 
    relationships. <br />Constraint&nbsp;&nbsp;&nbsp;&nbsp; This class defines a rule for a DataColumn class (or 
    set of data columns), <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; such as unique values.<br />
    <br />
    <br />
    <strong>Using Database Connections</strong><br />
    <br />using System.Data.SqlClient; <br />string source = “server=(local);" + 
    <br />“integrated security=SSPI;" + <br />“database=Northwind"; <br />SqlConnection conn = 
    new SqlConnection(source); <br />conn.Open(); <br /><br /> Do something useful 
    <br />conn.Close();<br />
    <br />
    <br />
    <strong>Managing Connection Strings</strong><br />
    <br />
    To define a database connection string, you should use the &lt; connectionStrings 
    &gt; section of the <br />configuration file. Here, you can specify a name for the 
    connection and the actual database connection <br />string parameters; in addition, 
    you can also specify the provider for this connection type. Here is an 
    <br />example: <br />&lt; configuration &gt; <br />... <br />&lt; connectionStrings &gt; <br />&lt; add 
    name="Northwind" <br />providerName="System.Data.SqlClient" 
    <br />connectionString="server=(local);integrated security=SSPI; 
    <br />database=Northwind" / &gt; <br />&lt; /connectionStrings &gt; <br />&lt; /configuration &gt;<br />
    <br />
    THEN,<br />
    <br />private DbConnection GetDatabaseConnection ( string name ) <br />{ 
    <br />ConnectionStringSettings settings = 
    <br />ConfigurationManager.ConnectionStrings[name]; <br />DbProviderFactory factory = 
    DbProviderFactories.GetFactory <br />( settings.ProviderName ) ; <br />DbConnection conn 
    = factory.CreateConnection ( ) ; <br />conn.ConnectionString = 
    settings.ConnectionString ; <br />return conn ; <br />}<br />
    <br />
    <br />
    <strong>The USING clause</strong><br />
    <br />The following code demonstrates how to use the using clause to ensure that 
    <br />objects that implement the IDisposable interface (see Chapter 12 , “ Memory 
    Management and <br />Pointers " ) are cleared up immediately after the block exits: 
    <br />string source = “server=(local);" + <br />“integrated security=SSPI;" + 
    <br />“database=Northwind"; <br />using ( SqlConnection conn = new SqlConnection ( 
    source ) ) <br />{ <br /><br /> Open the connection <br />conn.Open ( ) ; <br /><br /> Do something 
    useful <br />} <br />In this instance, the using clause ensures that the database 
    connection is closed, regardless of how the <br />block is exited.<br />
    <br />
    <br />
    <strong>Transactions</strong><br />
    <br />
    More than one update to a database should always be made within the scope of a 
    transaction. <br />Ex: <br />string source = “server=(local);" + <br />“integrated 
    security=SSPI;" + <br />“database=Northwind"; <br />using (TransactionScope scope = new 
    TransactionScope(TransactionScopeOption <br />.Required)) <br />{ <br />using (SqlConnection 
    conn = new SqlConnection(source)) <br />{ <br /><br /> Do something in SQL <br />... <br /><br /> Then 
    mark complete (w/o this, the transaction will be rolled back) 
    <br />scope.Complete(); <br />} <br />} <br />Isolation levels can be defined in a transaction, 
    viz. <br />-ReadCommitted <br />-ReadUncommitted <br />-RepeatableRead <br />-Serializable 
    <br />
    <br />
    <br /><strong>Commands</strong> <br />======== <br />StoredProcedure <br />SqlCommand cmd = new 
    SqlCommand(&quot;CustOrderHistory&quot;, conn); <br />cmd.CommandType = 
    CommandType.StoredProcedure; <br />cmd.Parameters.AddWithValue(&quot;@CustomerID&quot;, 
    &quot;QUICK&quot;); 
    <br />
    <br />
    <br /><strong>Executing Commands </strong> <br />================== <br />After a command is defined 
    using a similar method as above, <br />The following methods can be used to execute 
    them: <br />ExecuteNonQuery() - does not return any output <br />ExecuteReader() - 
    returns IDataReader (ex: use with a SELECT query) <br />ExecuteScalar() - returns a 
    scalar(single) value (ex: use with UPDATE) <br />ExecuteXmlReader() - returns a 
    XmlReader object 
    <br />
    <br />
    <br /><strong>Fast Data Access: The Data Reader 
    </strong> 
    <br />=======================<br />.... <br />...... <br />OleDbCommand cmd = new 
    OleDbCommand(select , conn); <br />OleDbDataReader aReader = cmd.ExecuteReader(); 
    <br />while(aReader.Read()) <br />Console.WriteLine(“’{0}’ from {1}" , 
    <br />aReader.GetString(0) , aReader.GetString(1)); <br />..... <br />.. <br />
    <strong>Managing Data 
    Relationships </strong> <br />=====================<br />A DataSet contains DataTables. <br />A 
    DataTable is very similar to the physical database table. <br />DataColumns define 
    the properties(attributes) of a column within the DataTable, such as <br />the 
    datatype, if the column is read-only, nullable, etc. <br />Other properties can also 
    be set in the DataColumn using the code as: <br />DataColumn customerID = new 
    DataColumn(“CustomerID" , typeof(int)); <br />customerID.AllowDBNull = false; 
    <br />customerID.ReadOnly = false; <br />customerID.AutoIncrement = true; 
    <br />customerID.AutoIncrementSeed = 1000; <br />DataColumn name = new DataColumn(“Name" 
    , typeof(string)); <br />name.AllowDBNull = false; <br />name.Unique = true; <br />PS: 
    DataSet is like a DB and contains DataTables that in turn contain Rows and 
    Columns. 
    <br />
    <br />
    <br /><strong>How to fill data in a DataSet </strong> <br />====================<br /><br /> 
    First, the connection details <br />string source = &quot;server = (local);&quot; + <br /> 
    &quot;integrated security = SSPI;&quot; + <br /> database = northwind&quot;; <br />string select = 
    &quot;SELECT ContacName, CompanyName FROM Customers&quot;; <br />SqlConnection conn = new 
    SqlConnection(source); <br /><br /> now..use SqlDataAdapter <br />SqlDataAdapter da = new 
    SqlDataAdapter(select, conn); <br />DataSet ds = new DataSet(); <br />da.Fill(ds, 
    &quot;Customers&quot;); <br /><br /> Now, we can iterate through every DataRow in the dataset 
    using a foreach as: <br />foreach (DataRow row in ds.Tables[&quot;Customers&quot;].Rows) 
    <br />Console.WriteLine(&quot;&#39;{0}&#39; from {1}&quot;, row[0], row[1]); <br />... 
    <br />
    <br />
    <br /><strong>Data 
    Relationships </strong> <br />=============<br />The following code segment creates a 
    relationship between the &#39;Building&#39; Table and &#39;Room&#39; Table on <br />the foreign key 
    &#39;BuildingId&#39; in the RoomTable to the primary in the &#39;BuildingTable&#39;. <br />DataSet 
    ds = new DataSet(“Relationships"); <br />ds.Tables.Add(CreateBuildingTable()); 
    <br />ds.Tables.Add(CreateRoomTable()); <br />ds.Relations.Add(“Rooms", 
    <br />ds.Tables[“Building"].Columns[“BuildingID"], 
    <br />ds.Tables[“Room"].Columns[“BuildingID"]); <br /><br /> it is now possible to iterate 
    through the rooms in the RoomTable using the rows from the <br /><br /> BuildingTable. 
    Under ADO.NET, a relationship is traversed simply by calling the GetChildRows() 
    <br /> method: <br />foreach(DataRow theBuilding in ds.Tables[“Building"].Rows) <br /> This 
    can also be written the other way <br /> round as (DataRow theRoom in 
    ds.Tables[&quot;Room&quot;].Rows <br />{ <br />DataRow[] children = 
    theBuilding.GetChildRows(“Rooms"); <br />int roomCount = children.Length; 
    <br />Console.WriteLine(“Building {0} contains {1} room{2}", <br />theBuilding[“Name"], 
    <br />roomCount, <br />roomCount &gt; 1 ? “s" : “"); <br /><br /> Loop through the rooms 
    <br />foreach(DataRow theRoom in children) <br />Console.WriteLine(“Room: {0}", 
    theRoom[“Name"]); <br />} <br />PS: Refer to the theory for constraints and more.<br />
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


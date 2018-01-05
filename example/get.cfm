<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->
<cfif application.config["AppType"] NEQ "Private" AND NOT StructKeyExists(session, "stToken")>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<html>
<head>
	<title>CFML Xero Application</title>
	<cfinclude template="/common/header.cfm" >
	<cfparam name="form.endpoint" default="Account">
	<cfparam name="form.accept" default="application/json">
</head>
<body>
<cfinclude template="/common/resource.cfm">

<cfscript>

/*
// ACCOUNTS ----------------------------------------------
	writeOutput("<strong>ACCOUNTS</strong><br>");
	account=createObject("component","cfc.model.Account").init(); 

	// Create
	account.setName("Generated " & RandRange(1, 100000, "SHA1PRNG"));
	account.setCode(RandRange(1, 10000, "SHA1PRNG"));
	account.setType("CURRENT");

	account.create();
	writeOutput("Create - ID: " & account.getAccountID() & "<br>");

	// Get By ID
	account.getById(account.getAccountID());
	writeOutput("Get By - ID: " & account.getAccountID() & "<br>");

	// Update
	account.setDescription("My Updated Desc");
	account.update();
	writeOutput("Update - ID: " & account.getAccountID() & "<br>");
	
	// Get All
	account.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(account.getList()) & "<br>");

	// Get Object by Array Position
	account.getObject(90);
	writeOutput("Get Item by Array Position -ID: " & account.getAccountID() & " -  " & account.getName()  & " -  " & account.getCode() &  "<br>");

	// ARCHIVED
	account.setStatus("ARCHIVED");
	account.archive();
	writeOutput("ARCHIVED - ID: " & account.getAccountID() & "<br>");

	// DELETED
	account.getObject(100);
	account.delete();
	writeOutput("DELETED - ID: " & account.getAccountID() & "<br>");
	writeOutput("<hr>");


// BANK TRANSACTIONS ----------------------------------------------
	writeOutput("<strong>BANK TRANSACTIONS</strong><br>");
	banktransaction=createObject("component","cfc.model.BankTransaction").init(); 
	bankaccount = createObject("component","cfc.model.BankAccount").init().getAll();
	btContact = createObject("component","cfc.model.Contact").init().getByID("e2b13deb-6213-43ef-9308-7c2389e47f53");
	lineitem=createObject("component","cfc.model.LineItem").init(); 
	lineitem.setDescription("consulting");
	lineitem.setQuantity("2");
	lineitem.setUnitAmount("100");
	lineitem.setAccountCode("400");
	aLineItem = ArrayNew(1);
	aLineItem.append(lineitem.toStruct());
	
	// Create
	banktransaction.setType("SPEND");
	banktransaction.setBankAccount(bankaccount.getObject(1).toStruct());
	banktransaction.setContact(btContact.toStruct());
	banktransaction.setLineitems(aLineItem);
	banktransaction.create();
	writeOutput("Create - ID: " & banktransaction.getBanktransactionID() & "<br>");

	// Get By ID
	banktransaction.getById(banktransaction.getBanktransactionID());
	writeOutput("Get By - ID: " & banktransaction.getBanktransactionID() & "<br>");
	
	// Update
	banktransaction.setURL("http://www.example.com");
	banktransaction.update();
	writeOutput("Update - ID: " & banktransaction.getBanktransactionID() & "<br>");
	
	// Get All
	banktransaction.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(banktransaction.getList()) & "<br>");

	// Get Object by Array Position
	banktransaction.getObject(60);
	writeOutput("Get 3rd Item -ID: " & banktransaction.getBanktransactionID() & "<br>");

	// ARCHIVED
	banktransaction.setStatus("DELETED");
	banktransaction.delete();
	writeOutput("Deleted - ID: " & banktransaction.getBanktransactionID() & "<br>");
	writeOutput("<hr>");

// BANK TRANSFER ----------------------------------------------
	writeOutput("<strong>BANK TRANSFER</strong><br>");
	banktransfer=createObject("component","cfc.model.BankTransfer").init(); 	
	bankaccount = createObject("component","cfc.model.BankAccount").init().getAll();
	
	// Create
	banktransfer.setFromBankAccount(bankaccount.getObject(1).toStruct());
	banktransfer.setToBankAccount(bankaccount.getObject(2).toStruct());
	banktransfer.setAmount("10");
	banktransfer.create();
	writeOutput("Create - ID: " & banktransfer.getBanktransferID() & "<br>");

	// Get By ID
	banktransfer.getById(banktransfer.getBanktransferID());
	writeOutput("Get By - ID: " & banktransfer.getBanktransferID() & "<br>");
	
	// Get All
	banktransfer.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(banktransfer.getList()) & "<br>");

	// Get Object by Array Position
	banktransfer.getObject(1);
	writeOutput("Get 3rd Item -ID: " & banktransfer.getBankTransferID() & "<br>");

	writeOutput("<hr>");


// BANK TRANSFER ----------------------------------------------
	writeOutput("<strong>BRANDING THEME</strong><br>");
	brandingtheme=createObject("component","cfc.model.BrandingTheme").init(); 	
	
	// Get All
	brandingtheme.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(brandingtheme.getList()) & "<br>");

	// Get Object by Array Position
	brandingtheme.getObject(1);
	writeOutput("Get an Item from List -ID: " & brandingtheme.getBrandingthemeID() & "<br>");

	// Get By ID
	brandingtheme.getById(brandingtheme.getBrandingthemeID());
	writeOutput("Get By - ID: " & brandingtheme.getBrandingthemeID() & "<br>");
	writeOutput("<hr>");


// CONTACTS ----------------------------------------------
	writeOutput("<strong>CONTACTS</strong><br>");
	contact=createObject("component","cfc.model.Contact").init(); 

	// Create
	contact.setName("Sid Maestre " & RandRange(1, 100000, "SHA1PRNG"));
	contact.create();
	writeOutput("Create - ID: " & contact.getContactID() & "<br>");

	// Get By ID
	contact.getById(contact.getContactID());
	writeOutput("Get By - ID: " & contact.getContactID() & "<br>");
	
	// Update
	contact.setContactNumber(RandRange(1, 100000, "SHA1PRNG"));
	contact.update();
	writeOutput("Update - ID: " & contact.getContactID() & "<br>");
	
	// Get All
	contact.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(contact.getList()) & "<br>");

	// Get Object by Array Position
	contact.getObject(200);
	writeOutput("Get 3rd Item -ID: " & contact.getContactID() & "<br>");
	
	// ARCHIVED
	contact.setContactStatus("ARCHIVED");
	contact.archive();
	writeOutput("ARCHIVED - ID: " & contact.getContactID() & "<br>");

	writeOutput("<hr>");


// CONTACT GROUP ----------------------------------------------
	writeOutput("<strong>CONTACTGROUP</strong><br>");
	contactgroup=createObject("component","cfc.model.ContactGroup").init(); 

	// Create
	contactgroup.setName("Sid Group " & RandRange(1, 100000, "SHA1PRNG"));
	contactgroup.create();
	writeOutput("Create - ID: " & contactgroup.getContactGroupID() & "<br>");

	// Get By ID
	contactgroup.getById(contactgroup.getContactGroupID());
	writeOutput("Get By - ID: " & contactgroup.getContactGroupID() & "<br>");

	// Update
	contactgroup.setName("Sid Updated Group " &RandRange(1, 100000, "SHA1PRNG"));
	contactgroup.update();
	writeOutput("Update - ID: " & contactgroup.getContactGroupID() & "<br>");

	// Get All
	contactgroup.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(contactgroup.getList()) & "<br>");

	// Get Object by Array Position
	contactgroup.getObject(1);
	writeOutput("Get an Item from List -Name: " & contactgroup.getName() & "<br>");
	writeOutput("Get an Item from List -ID: " & contactgroup.getContactGroupID() & "<br>");

	// Add Contacts to Group
	cgContact = createObject("component","cfc.model.Contact").init().getByID("e2b13deb-6213-43ef-9308-7c2389e47f53");
	aContact = ArrayNew(1);
	aContact.append(cgContact.toStruct(Only="id"));
	contactgroup.setContacts(aContact);
	contactgroup.addContacts();
	writeOutput("Add Contacts - Name: " & contactgroup.getName() & "<br>");

	// Delete a Single Contacts from Group
	contactgroup.removeContact("e2b13deb-6213-43ef-9308-7c2389e47f53");
	writeOutput("Remove Contact from Group Name: " & contactgroup.getName() & "<br>");

	// Delete ALL Contacts from Group
	contactgroup.getObject(2);
	writeOutput("DELETING All Contacts for: " & contactgroup.getName() & "<br>");
	contactgroup.deleteContacts();
	writeOutput("<hr>");


// CREDIT NOTE ----------------------------------------------
	writeOutput("<strong>CREDIT NOTE</strong><br>");
	creditnote=createObject("component","cfc.model.CreditNote").init(); 

	cnContact = createObject("component","cfc.model.Contact").init().getByID("e2b13deb-6213-43ef-9308-7c2389e47f53");
	lineitem=createObject("component","cfc.model.LineItem").init(); 
	lineitem.setDescription("consulting");
	lineitem.setQuantity("2");
	lineitem.setUnitAmount("100");
	lineitem.setAccountCode("400");
	aLineItem = ArrayNew(1);
	aLineItem.append(lineitem.toStruct());

	// Create
	creditnote.setType("ACCPAYCREDIT");
	creditnote.setContact(cnContact.toStruct(Only="id"));
	creditnote.setLineitems(aLineItem);
	creditnote.setStatus("DRAFT");
	creditnote.create();
	writeOutput("Create - ID: " & creditnote.getCreditNoteID() & "<br>");

	// Get By ID
	creditnote.getById(creditnote.getCreditNoteID());
	writeOutput("Get By - ID: " & creditnote.getCreditNoteID() & "<br>");

	// Update
	creditnote.setCreditNoteNumber(RandRange(1, 1000, "SHA1PRNG"));
	creditnote.update();
	writeOutput("Update - ID: " & creditnote.getCreditNoteID() & "<br>");

	// Get All
	creditnote.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(creditnote.getList()) & "<br>");

	// Get Object by Array Position
	creditnote.getObject(1);
	writeOutput("Get an Item from List -ID: " & creditnote.getCreditNoteID() & "<br>");


// CURRENCIES ----------------------------------------------
	writeOutput("<strong>CURRENCY</strong><br>");
	currency=createObject("component","cfc.model.Currency").init(); 

	// Get All
	currency.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(currency.getList()) & "<br>");

	// Get Object by Array Position
	currency.getObject(1);
	writeOutput("Get an Item from List -desc: " & currency.getDescription() & "<br>");
	
	// Create
	currency.setDescription("Aussie Dollar");
	currency.setCode("AUD");
	currency.create();
	writeOutput("Create - Code: " & currency.getCode() & "<br>");

	// Get By ID
	currency.getById(currency.getCode());
	writeOutput("Get By - Code: " & currency.getCode() & "<br>");


// EMPLOYEES ----------------------------------------------
	writeOutput("<strong>EMPLOYEES</strong><br>");
	employee=createObject("component","cfc.model.Employee").init(); 

	// Create
	employee.setFirstName("Joe " & RandRange(1, 100000, "SHA1PRNG"));
	employee.setLastName("Montana");
	employee.create();
	writeOutput("Create - ID: " & employee.getEmployeeID() & "<br>");
	writeOutput("Create - First Name: " & employee.getFirstName() & "<br>");

	// Get By ID
	employee.getById(employee.getEmployeeID());
	writeOutput("Get By - ID: " & employee.getEmployeeID() & "<br>");
	
	// Update
	employee.setFirstName("Sid " & RandRange(1, 100000, "SHA1PRNG"));
	employee.update();
	writeOutput("Update - ID: " & employee.getEmployeeID() & "<br>");
	writeOutput("Update - First Name: " & employee.getFirstName() & "<br>");
	
	// Get All
	employee.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(employee.getList()) & "<br>");

	// Get Object by Array Position
	employee.getObject(2);
	writeOutput("Get an Item by Position -ID: " & employee.getEmployeeID() & "<br>");



// INVOICES ----------------------------------------------
	writeOutput("<strong>INVOICES</strong><br>");
	invoice=createObject("component","cfc.model.Invoice").init(); 
	invContact = createObject("component","cfc.model.Contact").init().getByID("e2b13deb-6213-43ef-9308-7c2389e47f53");
	lineitem=createObject("component","cfc.model.LineItem").init(); 
	lineitem.setDescription("consulting");
	lineitem.setQuantity("2");
	lineitem.setUnitAmount("100");
	lineitem.setAccountCode("400");
	aLineItem = ArrayNew(1);
	aLineItem.append(lineitem.toStruct());
	
	// Create
	invoice.setType("ACCPAY");
	invoice.setContact(invContact.toStruct(Only="id"));
	invoice.setLineitems(aLineItem);
	invoice.setStatus("DRAFT");
	invoice.setDueDate("2018-5-5");
	invoice.create();
	writeOutput("Create - ID: " & invoice.getInvoiceID() & "<br>");

	// Get By ID
	invoice.getById(invoice.getInvoiceID());
	writeOutput("Get By - ID: " & invoice.getInvoiceID() & "<br>");

	// Update
	invoice.setReference("Hello World");
	invoice.update();
	writeOutput("Update - ID: " & invoice.getInvoiceID() & "<br>");

	// VOID
	//invoice.void();
	//writeOutput("VOIDED - ID: " & invoice.getInvoiceID() & "<br>");

	// DELETE
	invoice.delete();
	writeOutput("Deleted - ID: " & invoice.getInvoiceID() & "<br>");

	// Get All
	invoice.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(invoice.getList()) & "<br>");

	// Get Object by Array Position
	invoice.getObject(3);
	writeOutput("Get 3rd Item -ID: " & invoice.getInvoiceID() & "<br>");
	writeOutput("<hr>");

// INVOICE REMINDERS ----------------------------------------------
	writeOutput("<strong>INVOICE REMINDERS</strong><br>");
	invoicereminder=createObject("component","cfc.model.InvoiceReminder").init(); 

	// Get All
	invoicereminder.getAll();
	writeOutput("Get ALL - Enabled?: " & invoicereminder.getEnabled() & "<br>");

// ITEMS ----------------------------------------------
	writeOutput("<strong>ITEMS</strong><br>");
	item=createObject("component","cfc.model.Item").init(); 

	// Create
	item.setCode(RandRange(1, 100000, "SHA1PRNG"));
	item.setName("Sid Group " & RandRange(1, 100000, "SHA1PRNG"));
	item.setDescription("My description");
	item.create();
	writeOutput("Create - ID: " & item.getCode() & "<br>");

	// Get By ID
	item.getById(item.getCode());
	writeOutput("Get By - ID: " & item.getCode() & "<br>");

	// Update
	item.setName("Sid Updated Group " &RandRange(1, 100000, "SHA1PRNG"));
	item.update();
	writeOutput("Update - ID: " & item.getName() & "<br>");

	// Get All
	item.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(item.getList()) & "<br>");

	// Get Object by Array Position
	item.getObject(1);
	writeOutput("Get an Item from List -ID: " & item.getItemID() & "<br>");
	
	// DELETED
	item.delete();
	writeOutput("DELETED - Desc: " & item.getDescription() & "<br>");
	writeOutput("<hr>");

// JOURNALS ----------------------------------------------
	writeOutput("<strong>JOURNALS</strong><br>");
	journal=createObject("component","cfc.model.Journal").init(); 

	// Get All
	journal.getAll();
	writeOutput("Get ALL - count: " & ArrayLen(journal.getList()) & "<br>");

	// Get Object by Array Position
	journal.getObject(1);
	writeOutput("Get an Item from List -ID: " & journal.getJournalID() & "<br>");
*/


</cfscript>


<!--- GET BY ID 
<cfscript>
	contact=createObject("component","cfc.model.Contact").init(); 
	contact.getById("bb056dfd-d1cc-4b0c-8143-43da38c860ce");
</cfscript>
<cfdump var="#contact#" abort>
--->
<!---
<cfoutput>
	<table border="1" cellpadding="4" cellspacing="4">
	<tr>
JOURNALS		<th>ID</th>
		<th>Name</th>
		<th>City</th>
	</tr>		
	<cfloop from="1" to="#ArrayLen(contact.getList())#" index="i">
		<cfset obj = contact.getObject(i)>
		<tr>
			<td>#obj.getContactID()#</td>
			<td>#obj.getName()#</td>
			<td>#obj.getAddresses()[1].getCity()#</td>
		</tr>		
	</cfloop>
	</table>
</cfoutput>
--->



<!---



		<cfset config = application.config.json>

	<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
		<cfset sOAuthToken = session.stToken["oauth_token"]> <!--- returned after an access token call --->
		<cfset sOAuthTokenSecret = session.stToken["oauth_token_secret"]> <!--- returned after an access token call --->
	<cfelse>
		<cfset sOAuthToken = ""> <!--- No oAuth Token - Private apps use Consumer Key --->
		<cfset sOAuthTokenSecret = ""> <!--- No oAuth Token Secret - Private apps use Consumer Secret --->
	</cfif>

	<cfset sResourceEndpoint = "#config.ApiBaseUrl##config.ApiEndpointPath##form.endpoint#">
	
	<cfset stParameters = structNew()>
	<cfset sBody = "">
	<cfset ifModifiedSince = "">


	<!---  sample ORDER clause
	<cfset stParameters["order"] = 'EmailAddress DESC'>
	--->
	<!---  sample WHERE clause
	<cfset stParameters["where"] = 'Status=="PAID"'>
	--->
	<!---  sample modified date/time 
	<cfset dateTime24hoursAgo = DateAdd("d", -1, now())> 
	<cfset ifModifiedSince = DateConvert("local2utc", dateTime24hoursAgo)> 
	--->

	
	<!--- Build and Call API, return new structure of XML results --->
	<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
		sResourceEndpoint = sResourceEndpoint,
		sOAuthToken = sOAuthToken,
		sOAuthTokenSecret= sOAuthTokenSecret,
		stParameters = stParameters,
		sAccept = form.accept,
		sMethod = form.method,
		sIfModifiedSince = ifModifiedSince,
		sBody = sBody)>


	<div class="container">
		<div class="row">
	  		<div class="col-md-6">
	  			<cfif isStruct(oRequestResult.response)>
					<cfdump var="#oRequestResult.response#" >
				<cfelse>
					<pre class="prettyprint">
						<cfoutput>#oRequestResult.response#</cfoutput>
					</pre>
	  			</cfif>
	  		</div>
		</div>
	</div>
	--->
</body>
</html>


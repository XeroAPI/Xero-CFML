<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->
<cfparam name="form.endpoint" default="None">
<cfparam name="form.action" default="None">
<cfparam name="showform" default="true">

<html>
<head>
	<title>Xero-CFML Sample App</title>
	<cfinclude template="/common/header.cfm" >
</head>
<body>

<cfif showform>
	<cfinclude template="/common/resource.cfm">
</cfif>
<div class="container">

<cfscript>

try {

	switch(form.endpoint) {
		case "Accounts": 
		if(showform) {
			writeOutput("<strong>ACCOUNTS</strong><br>");
		}
		account=createObject("component","cfc.model.Account").init(); 

		switch(form.action) {
			case "Create":
				account.setName("Generated " & RandRange(1, 100000, "SHA1PRNG"));
				account.setCode(RandRange(1, 10000, "SHA1PRNG"));
				account.setType("CURRENT");
				account.create();
				writeOutput("Create - ID: " & account.getAccountID() & "<br>");
	        break;
	        case "Read":
				account.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(account.getList()) & "<br>");

				if (ArrayLen(account.getList()) GT 0){ 	
					account.getObject(1);
					writeOutput("Get Item by Array Position -ID: " & account.getAccountID() & " -  " & account.getName()  &  "<br>");

					account.getById(account.getAccountID());
					writeOutput("Get By - ID: " & account.getAccountID() & "<br>");
				}
	        break;
	        case "Update":
		        // Create then ... Update
		        account.setName("Generated " & RandRange(1, 100000, "SHA1PRNG"));
				account.setCode(RandRange(1, 10000, "SHA1PRNG"));
				account.setType("CURRENT");
				account.create();
			
				account.setDescription("My Updated Desc");
				account.update();
				writeOutput("Update - ID: " & account.getAccountID() & "<br>");

	        break;
	        case "Delete":
		         // Create then ... delete
		        account.setName("Generated " & RandRange(1, 100000, "SHA1PRNG"));
				account.setCode(RandRange(1, 10000, "SHA1PRNG"));
				account.setType("CURRENT");
				account.create();

				account.delete();
				writeOutput("Deleted - ID: " & account.getAccountID() & "<br>");

			break;
	        case "Archive":
	         	// Create then ... archive
		        account.setName("Generated " & RandRange(1, 100000, "SHA1PRNG"));
				account.setCode(RandRange(1, 10000, "SHA1PRNG"));
				account.setType("CURRENT");
				account.create();

				account.archive();
				writeOutput("Archive - ID: " & account.getAccountID() & "<br>");
			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
	    case "BankTransactions":
			if(showform) {
				writeOutput("<strong>BANK TRANSACTIONS</strong><br>");
			}
	    	banktransaction=createObject("component","cfc.model.BankTransaction").init(); 
			switch(form.action) {
			case "Create":
				bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"').getObject(1);
				salesaccount =  createObject("component","cfc.model.Account").init().getAll(where='Type=="REVENUE"').getObject(1);
				contact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);

				lineitem=createObject("component","cfc.model.LineItem").init(); 
				lineitem.setDescription("consulting");
				lineitem.setQuantity("2");
				lineitem.setUnitAmount("100");
				lineitem.setAccountCode(salesaccount.getCode());
				aLineItem = ArrayNew(1);
				aLineItem.append(lineitem.toStruct());

				banktransaction.setType("SPEND");
				banktransaction.setBankAccount(bankaccount.toStruct());
				banktransaction.setContact(contact.toStruct());
				banktransaction.setLineitems(aLineItem);
				banktransaction.create();
				writeOutput("Create - ID: " & banktransaction.getBanktransactionID() & "<br>");
				
	        break;
	        case "Read":
				banktransaction.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(banktransaction.getList()) & "<br>");

				banktransaction.getObject(1);
				writeOutput("Get 1st Item -ID: " & banktransaction.getBanktransactionID() & "<br>");

				banktransaction.getById(banktransaction.getBanktransactionID());
				writeOutput("Get By - ID: " & banktransaction.getBanktransactionID() & "<br>");
				
	        break;
	        case "Update":
		        banktransaction.getAll(where='Type=="SPEND"').getObject(1);
				banktransaction.setURL("http://www.example.com");
				banktransaction.update();
				writeOutput("Update - ID: " & banktransaction.getBanktransactionID() & "<br>");
				
	        break;
	        case "Delete":
	            banktransaction.getAll(where='Type=="SPEND"').getObject(1);
				banktransaction.setStatus("DELETED");
				banktransaction.delete();
				writeOutput("Deleted - ID: " & banktransaction.getBanktransactionID() & "<br>");	        

			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "BankTransfers":
			if(showform) {
				writeOutput("<strong>BANK TRANSFER</strong><br>");
			}
			banktransfer=createObject("component","cfc.model.BankTransfer").init(); 	
		
			switch(form.action) {
			case "Create":
				bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"');
				if (ArrayLen(bankaccount.getList()) GT 1) {	
					banktransfer.setFromBankAccount(bankaccount.getObject(1).toStruct());
					banktransfer.setToBankAccount(bankaccount.getObject(2).toStruct());
					banktransfer.setAmount("10");
					banktransfer.create();
					writeOutput("Create - ID: " & banktransfer.getBanktransferID() & "<br>");
				} else {
					writeOutput("You need 2 bank accounts to create a transfer.<br>");
				}

	        break;
	        case "Read":
				banktransfer.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(banktransfer.getList()) & "<br>");
				if (ArrayLen(banktransfer.getList()) GT 0) {	
				
					banktransfer.getObject(1);
					writeOutput("Get 3rd Item -ID: " & banktransfer.getBankTransferID() & "<br>");
				
					banktransfer.getById(banktransfer.getBanktransferID());
					writeOutput("Get By - ID: " & banktransfer.getBanktransferID() & "<br>");
				}
	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "BrandingThemes":
			if(showform) {
				writeOutput("<strong>BRANDING THEME</strong><br>");
			}
			brandingtheme=createObject("component","cfc.model.BrandingTheme").init(); 	
		
			switch(form.action) {
			case "Read":
				brandingtheme.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(brandingtheme.getList()) & "<br>");

				brandingtheme.getObject(1);
				writeOutput("Get an Item from List -ID: " & brandingtheme.getBrandingthemeID() & "<br>");

				brandingtheme.getById(brandingtheme.getBrandingthemeID());
				writeOutput("Get By - ID: " & brandingtheme.getBrandingthemeID() & "<br>");
		    break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
			break;
			}
		break;
		case "Contacts":
			if(showform) {
				writeOutput("<strong>CONTACTS</strong><br>");
			}
			contact=createObject("component","cfc.model.Contact").init(); 

			switch(form.action) {
			case "Create":
				contact.setName("Sid Maestre " & RandRange(1, 100000, "SHA1PRNG"));
				contact.create();
				writeOutput("Create - ID: " & contact.getContactID() & "<br>");

	        break;
	        case "Read":
	    	contact.getAll();
			writeOutput("Get ALL - count: " & ArrayLen(contact.getList()) & "<br>");

			contact.getObject(1);
			writeOutput("Get 1st Item -ID: " & contact.getContactID() & "<br>");

			contact.getById(contact.getContactID());
			writeOutput("Get By - ID: " & contact.getContactID() & "<br>");

	        break;
	        case "Update":
	        	contact.getAll().getObject(1);
	        	contact.setContactNumber(RandRange(1, 100000, "SHA1PRNG"));
				contact.update();
				writeOutput("Update - ID: " & contact.getContactID() & "<br>");
				
	        break;
	        case "Archive":	
	           	contact.getAll().getObject(1);
				contact.setContactStatus("ARCHIVED");
				contact.archive();
				writeOutput("Archived - ID: " & contact.getContactID() & "<br>");

			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
			break;
			}

		break;
		case "ContactGroups":
			if(showform) {
				writeOutput("<strong>CONTACTGROUP</strong><br>");
			}
			contactgroup=createObject("component","cfc.model.ContactGroup").init(); 

			switch(form.action) {
			case "Create":
				contactgroup.setName("Sid Group " & RandRange(1, 100000, "SHA1PRNG"));
				contactgroup.create();
				writeOutput("Create - ID: " & contactgroup.getContactGroupID() & "<br>");
				
	        break;
	        case "Read":
				contactgroup.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(contactgroup.getList()) & "<br>");

				contactgroup.getObject(1);
				writeOutput("Get an Item from List -Name: " & contactgroup.getName() & "<br>");
				writeOutput("Get an Item from List -ID: " & contactgroup.getContactGroupID() & "<br>");

				contactgroup.getById(contactgroup.getContactGroupID());
				writeOutput("Get By - ID: " & contactgroup.getContactGroupID() & "<br>");

	        break;
	        case "Update":
				contactgroup.getAll().getObject(1);
	        	contactgroup.setName("Sid Updated Group " &RandRange(1, 100000, "SHA1PRNG"));
				contactgroup.update();
				writeOutput("Update - ID: " & contactgroup.getContactGroupID() & "<br>");

	        break;
	        case "Add":
				cgContact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
				aContact = ArrayNew(1);
				aContact.append(cgContact.toStruct(Only="id"));
				
				contactgroup.getAll().getObject(1);
				contactgroup.setContacts(aContact);
				contactgroup.addContacts();
				writeOutput("Add Contacts - Name: " & contactgroup.getName() & "<br>");

			break;
	        case "RemoveOne":
	        	// Add the Contact first ... then remove
	        	cgContact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
				aContact = ArrayNew(1);
				aContact.append(cgContact.toStruct(Only="id"));
				contactgroup.getAll().getObject(1);
				contactgroup.setContacts(aContact);
				contactgroup.addContacts();
				contactgroup.getAll().getObject(1);
				contactgroup.removeContact(cgContact.getContactID());
				writeOutput("Remove Contact from Group Name: " & contactgroup.getName() & "<br>");
	         
			break;
			case "Remove":
				contactgroup.getAll().getObject(1);
				contactgroup.deleteContacts();
				writeOutput("DELETING All Contacts for: " & contactgroup.getName() & "<br>");
			break;
			
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}

		break;
		case "CreditNotes":
			if(showform) {
				writeOutput("<strong>CREDIT NOTE</strong><br>");
			}
			creditnote=createObject("component","cfc.model.CreditNote").init(); 

			switch(form.action) {
			case "Create":
				contact=createObject("component","cfc.model.Contact").init(); 
	        	contact.getAll().getObject(1);
				lineitem=createObject("component","cfc.model.LineItem").init(); 
				lineitem.setDescription("consulting");
				lineitem.setQuantity("2");
				lineitem.setUnitAmount("100");
				lineitem.setAccountCode("400");
				aLineItem = ArrayNew(1);
				aLineItem.append(lineitem.toStruct());

				creditnote.setType("ACCPAYCREDIT");
				creditnote.setContact(contact.toStruct(Only="id"));
				creditnote.setLineitems(aLineItem);
				creditnote.setStatus("DRAFT");
				creditnote.create();
				writeOutput("Create - ID: " & creditnote.getCreditNoteID() & "<br>");
				
	        break;
	        case "Read":
			   	creditnote.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(creditnote.getList()) & "<br>");

				creditnote.getObject(1);
				writeOutput("Get an Item from List -ID: " & creditnote.getCreditNoteID() & "<br>");

				creditnote.getById(creditnote.getCreditNoteID());
				writeOutput("Get By - ID: " & creditnote.getCreditNoteID() & "<br>");

	        break;
	        case "Update":
			   	creditnote.getAll().getObject(1);
				creditnote.setCreditNoteNumber(RandRange(1, 1000, "SHA1PRNG"));
				creditnote.update();
				writeOutput("Update - ID: " & creditnote.getCreditNoteID() & "<br>");

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Currencies":
			if(showform) {
				writeOutput("<strong>CURRENCY</strong><br>");
			}
			currency=createObject("component","cfc.model.Currency").init(); 

			switch(form.action) {
			case "Create":
				currency.setDescription("Euro");
				currency.setCode("EUR");
				currency.create();
				writeOutput("Create - Code: " & currency.getCode() & "<br>");
				
	        break;
	        case "Read":
				currency.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(currency.getList()) & "<br>");

				currency.getObject(1);
				writeOutput("Get an Item from List -desc: " & currency.getDescription() & "<br>");
							
				currency.getById(currency.getCode());
				writeOutput("Get By - Code: " & currency.getCode() & "<br>");

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Employees":
			if(showform) {
				writeOutput("<strong>EMPLOYEES</strong><br>");
			}
			employee=createObject("component","cfc.model.Employee").init(); 

			switch(form.action) {
			case "Create":
				employee.setFirstName("Joe " & RandRange(1, 100000, "SHA1PRNG"));
				employee.setLastName("Montana");
				employee.create();
				writeOutput("Create - ID: " & employee.getEmployeeID() & "<br>" & "Create - First Name: " & employee.getFirstName() & "<br>");
				
	        break;
	        case "Read":	
				employee.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(employee.getList()) & "<br>");

				employee.getObject(1);
				writeOutput("Get an Item by Position -ID: " & employee.getEmployeeID() & "<br>");			

				employee.getById(employee.getEmployeeID());
				writeOutput("Get By - ID: " & employee.getEmployeeID() & "<br>");

	        break;
	        case "Update":
	        	employee.getAll().getObject(1);
				employee.setFirstName("Sid " & RandRange(1, 100000, "SHA1PRNG"));
				employee.update();
				writeOutput("Update - ID: " & employee.getEmployeeID() & "<br>" & "Update - First Name: " & employee.getFirstName() & "<br>");
			    
	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Invoices":
			if(showform) {
				writeOutput("<strong>INVOICES</strong><br>");
			}
			invoice=createObject("component","cfc.model.Invoice").init(); 
			
			contact=createObject("component","cfc.model.Contact").init(); 
        	contact.getAll().getObject(1);
		
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setQuantity("2");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode("400");
			aLineItem = ArrayNew(1);
			aLineItem.append(lineitem.toStruct());
		
			switch(form.action) {
			case "Create":
				invoice.setType("ACCPAY");
				invoice.setContact(contact.toStruct(Only="id"));
				invoice.setLineitems(aLineItem);
				invoice.setStatus("DRAFT");
				invoice.setDueDate("2018-5-5");
				invoice.create();
				writeOutput("Create - ID: " & invoice.getInvoiceID() & "<br>");		
				
	        break;
	        case "Read":
				invoice.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(invoice.getList()) & "<br>");

				invoice.getObject(3);
				writeOutput("Get 3rd Item -ID: " & invoice.getInvoiceID() & "<br>");
			
				invoice.getById(invoice.getInvoiceID());
				writeOutput("Get By - ID: " & invoice.getInvoiceID() & "<br>");		

	        break;
	        case "Update":
				// Create invoice ... then Update
	        	invoice.setType("ACCPAY");
				invoice.setContact(contact.toStruct(Only="id"));
				invoice.setLineitems(aLineItem);
				invoice.setStatus("DRAFT");
				invoice.setDueDate("2018-5-5");
				invoice.create();

				invoice.setReference("Hello World");
				invoice.update();
				writeOutput("Update - ID: " & invoice.getInvoiceID() & "<br>");

	        break;
	        case "Delete":
				// Create DRAFT invoice ... then Delete
				invoice.setType("ACCPAY");
				invoice.setContact(contact.toStruct(Only="id"));
				invoice.setLineitems(aLineItem);
				invoice.setStatus("DRAFT");
				invoice.setDueDate("2018-5-5");
				invoice.create();

				invoice.delete();
				writeOutput("Deleted - ID: " & invoice.getInvoiceID() & "<br>");

			break;
	        case "Void":
		        // Create AUTHORISED invoice ... then Delete
				invoice.setType("ACCPAY");
				invoice.setContact(contact.toStruct(Only="id"));
				invoice.setLineitems(aLineItem);
				invoice.setStatus("AUTHORISED");
				invoice.setDueDate("2018-5-5");
				invoice.create();
	    		invoice.void();
				writeOutput("Voided - ID: " & invoice.getInvoiceID() & "<br>");

			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "InvoiceReminders":
			if(showform) {
				writeOutput("<strong>INVOICE REMINDERS</strong><br>");
			}
			invoicereminder=createObject("component","cfc.model.InvoiceReminder").init(); 
		
			switch(form.action) {
	        case "Read":
				invoicereminder.getAll();
				writeOutput("Get ALL - Enabled?: " & invoicereminder.getEnabled() & "<br>");	

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Items":
			if(showform) {
				writeOutput("<strong>ITEMS</strong><br>");
			}
			item=createObject("component","cfc.model.Item").init(); 

			switch(form.action) {
			case "Create":
				item.setCode(RandRange(1, 100000, "SHA1PRNG"));
				item.setName("Sid Group " & RandRange(1, 100000, "SHA1PRNG"));
				item.setDescription("My description");
				item.create();
				writeOutput("Create - ID: " & item.getCode() & "<br>");
				
	        break;
	        case "Read":
				item.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(item.getList()) & "<br>");

				item.getObject(1);
				writeOutput("Get an Item from List -ID: " & item.getItemID() & "<br>");
				
				item.getById(item.getCode());
				writeOutput("Get By - ID: " & item.getCode() & "<br>");

	        break;
	        case "Update":
				item.getAll().getObject(1);
				item.setName("Sid Updated Group " &RandRange(1, 100000, "SHA1PRNG"));
				item.update();
				writeOutput("Update - ID: " & item.getName() & "<br>");
		        
	        break;
	        case "Delete":
				item.getAll().getObject(1);
				writeOutput("About to delete - Item: " & item.getName() & "<br>");					
				item.delete();

				writeOutput("Deleted - Item: <br>");
	         
			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Journals":
			if(showform) {
				writeOutput("<strong>JOURNALS</strong><br>");
			}
			journal=createObject("component","cfc.model.Journal").init(); 

			switch(form.action) {
		    case "Read":
				journal.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(journal.getList()) & "<br>");

				journal.getObject(1);
				writeOutput("Get an Item from List -ID: " & journal.getJournalID() & "<br>");

				journal.getById(journal.getJournalID());
				writeOutput("Get By ID: " & journal.getJournalID() & "<br>");

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "LinkedTransactions":
			if(showform) {
				writeOutput("<strong>LINKED TRANSACTIONS</strong><br>");
			}
			linkedtransaction=createObject("component","cfc.model.LinkedTransaction").init(); 

			banktransaction = createObject("component","cfc.model.BankTransaction").init();
			bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"').getObject(1);
			salesaccount =  createObject("component","cfc.model.Account").init().getAll(where='Type=="REVENUE"').getObject(1);
			contact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setQuantity("2");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode(salesaccount.getCode());
			aLineItem = ArrayNew(1);
			aLineItem.append(lineitem.toStruct());

			banktransaction.setType("SPEND");
			banktransaction.setBankAccount(bankaccount.toStruct());
			banktransaction.setContact(contact.toStruct());
			banktransaction.setLineitems(aLineItem);
			banktransaction.create();
			banktransaction.getById(banktransaction.getBanktransactionID());

			switch(form.action) {
			case "Create":
				linkedtransaction.setSourceTransactionID(banktransaction.getBanktransactionID());
				linkedtransaction.setSourceLineItemID(banktransaction.getLineItems()[1]["LineItemID"]);
				linkedtransaction.create();
				writeOutput("Create - ID: " & linkedtransaction.getLinkedTransactionID() & "<br>");

	        break;
	        case "Read":	
				linkedtransaction.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(linkedtransaction.getList()) & "<br>");

				linkedtransaction.getObject(1);
				writeOutput("Get an Item from List -ID: " & linkedtransaction.getLinkedTransactionID() & "<br>");

				linkedtransaction.getById(linkedtransaction.getLinkedTransactionID());
				writeOutput("Get By - ID: " & linkedtransaction.getLinkedTransactionID() & "<br>");

	        break;
	        case "Update":
	        	// Create linked transaction ... then Update
	        	linkedtransaction.setSourceTransactionID(banktransaction.getBanktransactionID());
				linkedtransaction.setSourceLineItemID(banktransaction.getLineItems()[1]["LineItemID"]);
				linkedtransaction.create();
					        
				linkedtransaction.setContactID(contact.getContactID());
				linkedtransaction.update();
				writeOutput("Update - ID: " & linkedtransaction.getLinkedTransactionID() & "<br>");

	        break;
	        case "Delete":
   	        	// Create linked transaction ... then Delete
	        	linkedtransaction.setSourceTransactionID(banktransaction.getBanktransactionID());
				linkedtransaction.setSourceLineItemID(banktransaction.getLineItems()[1]["LineItemID"]);
				linkedtransaction.create();

				linkedtransaction.delete();
				writeOutput("Deleted - ID: " & linkedtransaction.getLinkedTransactionID() & "<br>");

			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "ManualJournals":
			if(showform) {
				writeOutput("<strong>MANUAL JOURNALS</strong><br>");
			}
			manualjournal=createObject("component","cfc.model.ManualJournal").init(); 
			
			journalline=createObject("component","cfc.model.JournalLine").init(); 
			aJournal = ArrayNew(1);

			journalline.setLineAmount("25");
			journalline.setAccountCode("400");
			journalline.setDescription("Foo");
			aJournal.append(journalline.toStruct());
			
			journalline2=createObject("component","cfc.model.JournalLine").init(); 
			journalline2.setLineAmount("-25");
			journalline2.setAccountCode("500");
			journalline2.setDescription("Bar");
			aJournal.append(journalline2.toStruct());

			switch(form.action) {
			case "Create":
				manualjournal.setLineAmountTypes("inclusive");
				manualjournal.setStatus("DRAFT");
				manualjournal.setNarration("Hello World");
				manualjournal.setJournalLines(aJournal);
				manualjournal.create();
				writeOutput("Create - ID: " & manualjournal.getManualJournalID() & "<br>");
				
	        break;
	        case "Read":				
				manualjournal.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(manualjournal.getList()) & "<br>");

				manualjournal.getObject(1);
				writeOutput("Get an Item from List -ID: " & manualjournal.getManualJournalID() & "<br>");

				manualjournal.getById(manualjournal.getManualJournalID());
				writeOutput("Get By - ID: " & manualjournal.getManualJournalID() & "<br>");

	        break;
	        case "Update":
	        	// Create Manual Journal ... then Update
   				manualjournal.setLineAmountTypes("inclusive");
				manualjournal.setStatus("DRAFT");
				manualjournal.setNarration("Hello World");
				manualjournal.setJournalLines(aJournal);
				manualjournal.create();

				manualjournal.setNarration("Hello Mars");
				manualjournal.update();
				writeOutput("Update - ID: " & manualjournal.getManualJournalID() & "<br>");

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Organisation":
			if(showform) {
				writeOutput("<strong>ORGANISATION</strong><br>");
			}
			organisation=createObject("component","cfc.model.Organisation").init(); 
		
			switch(form.action) {
		    case "Read":
				organisation.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(organisation.getList()) & "<br>");

				organisation.getObject(1);
				writeOutput("Get item and Name: " & organisation.getName() & "<br>");
	
	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Overpayments":
			if(showform) {
				writeOutput("<strong>OVERPAYMENTS</strong><br>");
			}
			overpayment=createObject("component","cfc.model.Overpayment").init(); 

			//CREATE OVERPAYMENT via BANK TRANSACTION
			banktransaction=createObject("component","cfc.model.BankTransaction").init(); 
			bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"').getObject(1);
			contact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode("120");
			aBTLineItem = ArrayNew(1);
			aBTLineItem.append(lineitem.toStruct(exclude="ItemCode,Quantity,TaxAmount,TaxType,Tracking"));
	
			// Create NEW INVOICE
			invoice=createObject("component","cfc.model.Invoice").init(); 
			invContact = createObject("component","cfc.model.Contact").init().getAll().getObject(2);
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setQuantity("2");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode("400");
			aLineItem = ArrayNew(1);
			aLineItem.append(lineitem.toStruct());
			
			invoice.setType("ACCREC");
			invoice.setContact(invContact.toStruct(Only="id"));
			invoice.setLineitems(aLineItem);
			invoice.setStatus("AUTHORISED");
			invoice.setDueDate("2018-6-5");
			invoice.create();
		
			switch(form.action) {
			 case "Create":				
				banktransaction.setType("RECEIVE-OVERPAYMENT");
				banktransaction.setBankAccount(bankaccount.toStruct());
				banktransaction.setContact(contact.toStruct());
				banktransaction.setLineitems(aBTLineItem);
				banktransaction.create();
				writeOutput("Created - ID: " & banktransaction.getOverpaymentID() & "<br>");

	        break;
	        case "Read":				
				overpayment.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(overpayment.getList()) & "<br>");

				overpayment.getObject(1);
				writeOutput("Get an Item from List -ID: " & overpayment.getOverpaymentID() & "<br>");

				overpayment.getById(overpayment.getOverpaymentID());
				writeOutput("Get By - ID: " & overpayment.getOverpaymentID() & "<br>");

	        break;
	        case "Allocate":
		        // Create Overpayment (Bank Transaction) ... then Allocate
				banktransaction.setType("RECEIVE-OVERPAYMENT");
				banktransaction.setBankAccount(bankaccount.toStruct());
				banktransaction.setContact(contact.toStruct());
				banktransaction.setLineitems(aBTLineItem);
				banktransaction.create();

				overpayment.setDate("2018-2-1");
				overpayment.setAmount("10");
				overpayment.setInvoice(invoice.toStruct(Only="id"));
				overpayment.setOverpaymentID(banktransaction.getOverpaymentId());
				
				overpayment.allocate();
				writeOutput("Allocate - ID: " & banktransaction.getOverpaymentID() & "<br>");

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Payments":
			if(showform) {
				writeOutput("<strong>PAYMENTS</strong><br>");
			}
			payment=createObject("component","cfc.model.Payment").init(); 

			invoice=createObject("component","cfc.model.Invoice").init(); 
			contact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setQuantity("2");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode("400");
			aLineItem = ArrayNew(1);
			aLineItem.append(lineitem.toStruct());
			
			invoice.setType("ACCPAY");
			invoice.setContact(contact.toStruct(Only="id"));
			invoice.setLineitems(aLineItem);
			invoice.setStatus("AUTHORISED");
			invoice.setDueDate("2018-5-5");
			invoice.create();

			bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"').getObject(1);

			switch(form.action) {
			case "Create":
				payment.setDate("2018-2-1");
				payment.setAmount("1");
				payment.setAccount(bankaccount.toStruct(Only="id"));
				payment.setInvoice(invoice.toStruct(Only="id"));
				payment.create();
				writeOutput("Create - ID: " & payment.getPaymentID() & "<br>");
				
	        break;
	        case "Read":				
				payment.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(payment.getList()) & "<br>");

				payment.getObject(2);
				writeOutput("Get an Item from List -ID: " & payment.getPaymentID() & "<br>");
						
				payment.getById(payment.getPaymentID());
				writeOutput("Get By - ID: " & payment.getPaymentID() & "<br>");

	        break;
   			case "Delete":
				// Create a Payment ... then Delete
				payment.setDate("2018-2-1");
				payment.setAmount("1");
				payment.setAccount(bankaccount.toStruct(Only="id"));
				payment.setInvoice(invoice.toStruct(Only="id"));
				payment.create();

	        	payment.delete();
				writeOutput("delete - ID: " & payment.getPaymentID() & "<br>");	

	        break;
	 
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Prepayments":
			if(showform) {
				writeOutput("<strong>PREPAYMENTS</strong><br>");
			}
			prepayment=createObject("component","cfc.model.Prepayment").init(); 

			//CREATE OVERPAYMENT via BANK TRANSACTION
			banktransaction=createObject("component","cfc.model.BankTransaction").init(); 
			bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"').getObject(1);
			contact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setUnitAmount("100");
			lineitem.setQuantity("100");
			lineitem.setAccountCode("500");
			aBTLineItem = ArrayNew(1);
			aBTLineItem.append(lineitem.toStruct(exclude="ItemCode,TaxAmount,TaxType,Tracking"));

			// Create NEW INVOICE
			invoice=createObject("component","cfc.model.Invoice").init(); 
			contact = createObject("component","cfc.model.Contact").init().getAll().getObject(2);
			
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setQuantity("2");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode("400");
			aLineItem = ArrayNew(1);
			aLineItem.append(lineitem.toStruct());
			
			invoice.setType("ACCREC");
			invoice.setContact(contact.toStruct(Only="id"));
			invoice.setLineitems(aLineItem);
			invoice.setStatus("AUTHORISED");
			invoice.setDueDate("2018-6-5");
			invoice.create();
			
			switch(form.action) {
	        case "Create":
				banktransaction.setType("RECEIVE-PREPAYMENT");
				banktransaction.setBankAccount(bankaccount.toStruct());
				banktransaction.setContact(contact.toStruct());
				banktransaction.setLineitems(aBTLineItem);
				banktransaction.create();
				writeOutput("Create - ID: " & banktransaction.getBanktransactionID() & "<br>");	        	

	        break;
	        case "Read":
	        	prepayment.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(prepayment.getList()) & "<br>");

				prepayment.getObject(1);
				writeOutput("Get an Item from List -ID: " & prepayment.getPrepaymentID() & "<br>");								

				prepayment.getById(prepayment.getPrepaymentID());
				writeOutput("Get By - ID: " & prepayment.getPrepaymentID() & "<br>");

	        break;
	        case "Allocate":
	        	//Create BankTransaction(Prepayment)... then Allocate to an Invoice
				banktransaction.setType("RECEIVE-PREPAYMENT");
				banktransaction.setBankAccount(bankaccount.toStruct());
				banktransaction.setContact(contact.toStruct());
				banktransaction.setLineitems(aBTLineItem);
				banktransaction.create();

		    	prepayment.setDate("2018-2-1");
				prepayment.setAmount("10");
				prepayment.setInvoice(invoice.toStruct(Only="id"));
				prepayment.setPrepaymentID(banktransaction.getPrepaymentId());
				prepayment.allocate();
				writeOutput("Allocate - ID: " & banktransaction.getPrepaymentID() & "<br>");
	        	
	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "PurchaseOrders":
			if(showform) {
				writeOutput("<strong>PURCHASE ORDERS</strong><br>");
			}
			purchaseorder=createObject("component","cfc.model.Purchaseorder").init(); 

			// Create
			contact = createObject("component","cfc.model.Contact").init().getAll().getObject(1);
			lineitem=createObject("component","cfc.model.LineItem").init(); 
			lineitem.setDescription("consulting");
			lineitem.setQuantity("2");
			lineitem.setUnitAmount("100");
			lineitem.setAccountCode("400");
			aLineItem = ArrayNew(1);
			aLineItem.append(lineitem.toStruct());

			switch(form.action) {
			case "Create":
				purchaseorder.setLineitems(aLineItem);
				purchaseorder.setContact(contact.toStruct());
				purchaseorder.setAttentionTo("Daffy Duck");
			
				purchaseorder.create();
				writeOutput("Create - ID: " & purchaseorder.getPurchaseorderID() & "<br>");
				
	        break;
	        case "Read":					
				purchaseorder.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(purchaseorder.getList()) & "<br>");

				purchaseorder.getObject(1);
				writeOutput("Get an Purchaseorder from List -ID: " & purchaseorder.getPurchaseorderID() & "<br>");

				purchaseorder.getById(purchaseorder.getPurchaseorderID());
				writeOutput("Get By - ID: " & purchaseorder.getPurchaseorderID() & "<br>");

	        break;
	        case "Update":
	        	// Create a PurchaseOrder ... then Update
	        	purchaseorder.setLineitems(aLineItem);
				purchaseorder.setContact(contact.toStruct());
				purchaseorder.setAttentionTo("Daffy Duck");
				purchaseorder.create();

				purchaseorder.setStatus("AUTHORISED");
				purchaseorder.setSentToContact("YES");
				purchaseorder.update();
				writeOutput("Update - ID: " & purchaseorder.getPurchaseorderID() & "<br>");
	        	
	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "RepeatingInvoices":
			if(showform) {
				writeOutput("<strong>REPEATING INVOICES</strong><br>");
			}
			repeatinginvoice=createObject("component","cfc.model.RepeatingInvoice").init(); 
	
			switch(form.action) {
	        case "Read":				
				repeatinginvoice.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(repeatinginvoice.getList()) & "<br>");

				repeatinginvoice.getObject(1);
				writeOutput("Get an item from List -ID: " & repeatinginvoice.getRepeatingInvoiceID() & "<br>");
	
				repeatinginvoice.getById(repeatinginvoice.getRepeatingInvoiceID());
				writeOutput("Get By ID: " & repeatinginvoice.getRepeatingInvoiceID() & "<br>");
							
	        break;
	        
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Reports":
			if(showform) {
				writeOutput("<strong>REPORTS</strong><br>");
			}
			report=createObject("component","cfc.model.Report").init(); 
			contact=createObject("component","cfc.model.Contact").init().getAll().getObject(1); 
			bankaccount = createObject("component","cfc.model.Account").init().getAll(where='Type=="BANK"').getObject(1);
			
	
			switch(form.action) {
	        case "Read":				
				report.getById("TenNinetyNine");
				writeOutput("Get Report: " & report.getReportName() & "<br>");

				report.getById(id="AgedPayablesByContact",ContactID=contact.getContactID());
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById(id="AgedReceivablesByContact",ContactID=contact.getContactID());
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById(id="BalanceSheet",periods="3",timeframe="month");
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById(id="BankStatement",bankAccountID=bankaccount.getAccountID());
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById(id="BankSummary",toDate="2017-03-01",fromDate="2017-01-01");
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById(id="BudgetSummary");
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById(id="ExecutiveSummary");
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById("ProfitAndLoss");
				writeOutput("Get Report: " & report.getReportID() & "<br>");

				report.getById("TrialBalance");
				writeOutput("Get Report: " & report.getReportID() & "<br>");
							
	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "TaxRates":
			if(showform) {
				writeOutput("<strong>TAX RATES</strong><br>");
			}
			taxrate=createObject("component","cfc.model.TaxRate").init(); 

			// Create
			taxcomponent=createObject("component","cfc.model.TaxComponent").init(); 
			taxcomponent.setName("Foobar" &RandRange(1, 10000, "SHA1PRNG"));
			taxcomponent.setRate("6");
			aTaxComponent = ArrayNew(1);
			aTaxComponent.append(taxcomponent.toStruct());

			switch(form.action) {
			case "Create":
				taxrate.setName("My New Tax " &RandRange(1, 10000, "SHA1PRNG"));
				taxrate.setTaxType("TAX099");
				taxrate.setTaxComponents(aTaxComponent);
				taxrate.create();
				writeOutput("Create - ID: " & taxrate.getName() & "<br>");

	        break;
	        case "Read":
				taxrate.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(taxrate.getList()) & "<br>");

				taxrate.getObject(1);
				writeOutput("Get an Taxrate from List -ID: " & taxrate.getName() & "<br>");			

	        break;
	        case "Update":
		        // Create a tax rate ... then update
		        taxrate.setName("My New Tax " &RandRange(1, 10000, "SHA1PRNG"));
				taxrate.setTaxType("TAX"&RandRange(1, 1000, "SHA1PRNG"));
				taxrate.setTaxComponents(aTaxComponent);
				taxrate.create();
		    	taxrate.setName("My New One" &RandRange(1, 10000, "SHA1PRNG"));
				taxrate.update();
				writeOutput("Update - ID: " & taxrate.getName() & "<br>");

	        break;
	        case "Delete":
		        // Create a tax rate ... then delete
		        taxrate.setName("My New Tax " &RandRange(1, 10000, "SHA1PRNG"));
				taxrate.setTaxType("TAX"&RandRange(1, 1000, "SHA1PRNG"));
				taxrate.setTaxComponents(aTaxComponent);
				taxrate.create();

				taxrate.delete();
				writeOutput("Deleted - ID: " & taxrate.getName() & "<br>");

			break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "TrackingCategories":
			if(showform) {
				writeOutput("<strong>TRACKING CATEGORIES</strong><br>");
			}

			trackingcategory=createObject("component","cfc.model.TrackingCategory").init(); 	

			switch(form.action) {
			case "Create":
				trackingcategory.setName("My New Category " &RandRange(1, 10000, "SHA1PRNG"));
				trackingcategory.create();
				writeOutput("Create - ID: " & trackingcategory.getTrackingCategoryId() & "<br>");
				
	        break;
	        case "Read":
				trackingcategory.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(trackingcategory.getList()) & "<br>");

				if (ArrayLen(trackingcategory.getList()) GT 0){ 	
					trackingcategory.getObject(1);
					writeOutput("Get an Object List -ID: " & trackingcategory.getTrackingCategoryID() & "<br>");

					trackingcategory.getById(trackingcategory.getTrackingCategoryID());
					writeOutput("Get by ID: " & trackingcategory.getTrackingCategoryID() & "<br>");	
				}
	        break;
	        case "Update":
				trackingcategory.getAll();    	
	        	if (ArrayLen(trackingcategory.getList()) GT 0){ 	
		        	trackingcategory.getObject(1);
					trackingcategory.setName("Updated Name " &RandRange(1, 10000, "SHA1PRNG"));
					trackingcategory.update();
					writeOutput("Get by ID: " & trackingcategory.getTrackingCategoryID() & "<br>");
		        } else {
		        	writeOutput("No Objects found - try to CREATE");
		        }
	        break;
	        case "Delete":
				trackingcategory.getAll();    	
   	        	if (ArrayLen(trackingcategory.getList()) GT 0){
	   	        	trackingcategory.getObject(1); 	
					trackingcategory.delete();
					writeOutput("Deleted - ID: " & trackingcategory.getTrackingCategoryId() & "<br>");
				 } else {
		        	writeOutput("No Objects found - try to CREATE");
		        }
			break;
	        case "Archive":
				trackingcategory.getAll();    	
	        	if (ArrayLen(trackingcategory.getList()) GT 0){ 	
	        		trackingcategory.getObject(1);
		        	trackingcategory.archive();
					writeOutput("Archived - ID: " & trackingcategory.getTrackingCategoryId() & "<br>");
			 	 } else {
		        	writeOutput("No Objects found - try to CREATE");
		        }
			break;
	        case "Remove":	 
				trackingcategory.getAll();    	
		    	if (ArrayLen(trackingcategory.getList()) GT 0){ 
			    	trackingcategory.getObject(1);	
					trackingoptionToDelete=createObject("component","cfc.model.TrackingOption").init().populate(trackingcategory.getOptions()[1]); 	
					trackingcategory.setOptionId(trackingoptionToDelete.getTrackingOptionId());	
					trackingcategory.deleteOption();
					writeOutput("Remove Options: " & trackingcategory.getTrackingCategoryId() & "<br>");
				} else {
		        	writeOutput("No Objects found - try to CREATE");
		        }
			break;
	        case "Add":
		        trackingcategory.getAll();
	        	if (ArrayLen(trackingcategory.getList()) GT 0){ 	
					trackingcategory.getObject(1);
			        trackingoption=createObject("component","cfc.model.TrackingOption").init(); 
					trackingoption.setName("Foobar" &RandRange(1, 10000, "SHA1PRNG"));
					trackingoption.setTrackingCategoryId(trackingcategory.getTrackingCategoryID());
					trackingoption.setStatus("ACTIVE");
					aTrackingOption = ArrayNew(1);
					aTrackingOption.append(trackingoption.toStruct());

					trackingcategory.setOptions(aTrackingOption);
					trackingcategory.addOptions();
					writeOutput("Options Added - ID: " & trackingcategory.getTrackingCategoryId() & "<br>");
				} else {
		        	writeOutput("No Objects found - try to CREATE");
		        }
			break;
	    
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
		break;
		case "Users":
			if(showform) {
				writeOutput("<strong>USERS</strong><br>");
			}

			user=createObject("component","cfc.model.User").init(); 

			switch(form.action) {
	
	        case "Read":
				user.getAll();
				writeOutput("Get ALL - count: " & ArrayLen(user.getList()) & "<br>");

				user.getObject(1);
				writeOutput("Get an Object List -ID: " & user.getUserId() & "<br>");

				user.getById(user.getUserId());
				writeOutput("Get by ID: " & user.getUserId() & "<br>");				

	        break;
			default: 
				writeOutput(form.action & " not supported on the " & form.endpoint & " endpoint");
				break;
			}
	break;
    default: 
	    writeOutput(form.action & " is not an action");
		break;
	}
}	

catch(ValidationException e){
	error = deserializeJSON(e.Detail);
	writeOutput(e.errorCode & " - " & e.Message & " - " & error[1].Message);
}

catch(Application e){
	if(e.errorCode EQ "401") {
		location("index.cfm?error=#e.Message#", "false");
	}
	writeOutput(e.errorCode & " - " & e.Message);
}

catch(any e){
	writeDump(e);
}

</cfscript>

</div>
</body>
</html>


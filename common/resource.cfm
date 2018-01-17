<cfparam name="form.endpoint" default="">
<cfparam name="form.page" default="">
<cfparam name="form.action" default="Create">
<cfparam name="body" default="">
<cfparam name="contentType" default="">

<cfset aEndpoint=["Accounts","BankTransactions","BankTransfers","BrandingThemes","Contacts","ContactGroups","CreditNotes","Currencies","Employees","Invoices","InvoiceReminders","Items","Journals","LinkedTransactions","ManualJournals","Organisation","Overpayments","Payments","Prepayments","PurchaseOrders","RepeatingInvoices","Reports","TaxRates","TrackingCategories","Users"]>

<cfset aAction=["Create","Read","Update","Delete","--------------","Archive","Void","Allocate","--------------","Add","Remove","RemoveOne"]>

<div class="container">
	<div class="row">
  		<div class="col-md-6">
			<form role="form" action="get.cfm" method="post">
			
			<div class="form-inline">
				<div class="form-group" id="endpoint-group">
			      	<label for="disabledTextInput">Endpoint</label>
					<select id="endpoint" name="endpoint" class="form-control">
					  <cfloop from="1" to="#ArrayLen(aEndpoint)#" index="i">
					  	<cfoutput>
						  	<option <cfif #form.endpoint# EQ #aEndpoint[i]#>selected</cfif> value="#aEndpoint[i]#">#aEndpoint[i]#</option>
						  </cfoutput>
					  </cfloop>
					</select>
				</div>

				<div class="form-group" id="method-group">
					<select name="action" id="action" class="form-control">
						<cfloop from="1" to="#ArrayLen(aAction)#" index="i">
					  	<cfoutput>
						  	<option <cfif #form.action# EQ #aAction[i]#>selected</cfif> value="#aAction[i]#">#aAction[i]#</option>
						  </cfoutput>
					  </cfloop>
					</select>
		      	</div>

		      	<div class="form-group" id="submit-group">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
	      	</div>
			</form>
  		</div>
  		<div class="col-md-6"></div>
	</div>
</div>


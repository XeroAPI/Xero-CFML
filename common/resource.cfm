<cfparam name="form.endpoint" default="">
<cfparam name="form.isCustomer" default="">
<cfparam name="form.page" default="">


<cfset aEndpoint=["Accounts","BankTransactions","BankTransfers","BrandingThemes","Contacts","ContactGroups","CreditNotes","Currencies","Employees","ExpenseClaims","Invoices","Items","Journals","ManualJournals","Organisation","Payments","Receipts","RepeatingInvoices","TaxRates","TrackingCategories","Types","Users"]>

<div class="container">
	<div class="row">
  		<div class="col-md-6">
			<form role="form" action="get.cfm" method="post">
			<div class="form-group">
		      	<label for="disabledTextInput">Select Accounting Endpoint</label>
				<select name="endpoint" class="form-control">
				  <cfloop from="1" to="#ArrayLen(aEndpoint)#" index="i">
				  	<cfoutput>
					  	<option <cfif #form.endpoint# EQ #aEndpoint[i]#>selected</cfif> value="#aEndpoint[i]#">#aEndpoint[i]#</option>
					  </cfoutput>
				  </cfloop>
				</select>
			</div>
			<div class="form-group">
		      	<label for="disabledTextInput">Is Customer</label>
				<select name="isCustomer" class="form-control">
				  <option value="">---</option>
				  <option <cfif form.isCustomer EQ "true">selected</cfif> value="true">Yes</option>
				  <option <cfif form.isCustomer EQ "false">selected</cfif> value="false">No</option>
				</select>
			</div>
			<div class="form-group">
		      	<label for="disabledTextInput">Paging</label>
				<select name="page" class="form-control">
				  <option value="">---</option>
				  	<cfloop from="1" to="10" index="i">
					  	<cfoutput>
					  		<option <cfif i EQ form.page>selected</cfif> value="#i#">#i#</option>
					  	</cfoutput>
					</cfloop>
				  <option value="2">2</option>
				  <option value="3">3</option>
				  <option value="4">4</option>
				</select>
			</div>


			<button type="submit" class="btn btn-primary">Submit</button>
			</form>
  		</div>
  		<div class="col-md-6"></div>
	</div>
</div>


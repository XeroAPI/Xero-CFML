<cfparam name="form.endpoint" default="">
<cfparam name="form.page" default="">
<cfparam name="form.method" default="GET">
<cfparam name="form.accept" default="json/xml">
<cfparam name="body" default="">
<cfparam name="contentType" default="">

<cfset aEndpoint=["Accounts","BankTransactions","BankTransfers","BrandingThemes","Contacts","ContactGroups","CreditNotes","Currencies","Employees","ExpenseClaims","Invoices","Items","Journals","ManualJournals","Organisation","Payments","Receipts","RepeatingInvoices","TaxRates","TrackingCategories","Types","Users"]>

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
					<select name="method" id="method" class="form-control">
					  <option value="GET" <cfif form.method eq "GET">selected</cfif>>GET</option>
					</select>
		      	</div>

		      	<div class="form-group" id="accept-group">
					<label>return:</label>
					<select name="accept" id="accept" class="form-control">
					  <option value="application/json" <cfif form.accept eq "application/json">selected</cfif>>JSON</option>
					  <option value="application/xml" <cfif form.accept eq "application/xml">selected</cfif>>XML</option>
					</select>
		      	</div>

		      	<div class="form-group" id="submit-group">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
	      	</div>


			<div class="form-group" id="page-group">
		      	<label>Paging</label>
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
	      	
			<input type="hidden" name="api" value="accounting">
			</form>
  		</div>
  		<div class="col-md-6"></div>
	</div>
</div>


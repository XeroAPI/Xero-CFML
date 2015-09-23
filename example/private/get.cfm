<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->

<html>
<head>
	<title>CFML Xero Private Application - Get</title>
	<cfinclude template="/common/header.cfm" >
	<cfinclude template="config.cfm" >
</head>
<body>
	<cfinclude template="/common/resource.cfm">

	<cfset sResourceEndpoint = "#sApiEndpoint##form.endpoint#">
	
	<cfset stParameters = structNew()>
	<cfif len(trim(form.isCustomer)) GT 0>
		<cfset stParameters.where = "(isCustomer=#form.isCustomer#)">
	</cfif>
	<cfif len(trim(form.page)) GT 0>
		<cfset stParameters.page = form.page>
	</cfif>
	
	
	<!--- Build and Call API, return new structure of XML results --->
	<cfset sRequestToken = sConsumerKey> <!--- use the consumer key as the access token  --->
	<cfset sResourceEndpoint = "#sApiEndpoint##form.endpoint#">

	<!--- Build an API Call URL --->
	<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
		sXeroAppType = sXeroAppType,
		sConsumerKey = sConsumerKey, 
		sRequestToken = sRequestToken,
		sResourceEndpoint = sResourceEndpoint,
		sPathToPrivateKey = pathToKey,
		stParameters = stParameters)>


	<div class="container">
		<div class="row">
	  		<div class="col-md-6">
				<cfdump var="#oRequestResult#" >
	  		</div>
		</div>
	</div>

</body>
</html>







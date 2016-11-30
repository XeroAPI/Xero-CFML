<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->
<cfif application.config["AppType"] NEQ "Private" AND NOT StructKeyExists(session, "stToken")>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<html>
<head>
	<title>CFML Xero Public Application</title>
	<cfinclude template="/common/header.cfm" >
	<cfparam name="form.endpoint" default="Account">
	<cfparam name="form.accept" default="application/json">
</head>
<body>
	<cfinclude template="/common/resource.cfm">

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
</body>
</html>


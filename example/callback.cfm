<!--- Example callback from Xero Xero Public App
----------------------------------------------------------------------------
1) run request_token.cfm FIRST, this page will be called by Xero's server after successful user authorization.
--->
<html>
<head>
	<title>CFML Xero Public Application - Callback</title>
	<cfinclude template="/common/header.cfm" >
</head>
<body>
	<div class="container">

	<!--- Build accessToken URL --->
	<cfset oAccessResult = CreateObject("component", "cfc.xero").accessToken(aCallbackParams = cgi.query_string)>

	<cfif oAccessResult["content"] EQ "success">
		<!---cflocation url="get.cfm" addtoken="false"--->
		<cfinclude template="/common/resource.cfm">
	<cfelse>
		<cfoutput>#oAccessResult["content"]#</cfoutput>
		<br><br>
		<a class="btn btn-primary" href="request_token.cfm">Connect to Xero</a>
	</cfif>
	</div>
</body>
</html>

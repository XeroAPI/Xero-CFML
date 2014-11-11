<!--- Example callback from Xero Xero Partner App
----------------------------------------------------------------------------
1) add your consumerkey & secret, private key, entrust SSL cert,entrust SSL password and set callback URL to the config.cfm file
2) run request_token.cfm FIRST, this page will be called by Xero's server after successful user authorization.
--->

<html>
<head>
	<title>CFML Xero Public Application - Request Token</title>
	<cfinclude template="header.cfm">
</head>
<body>

<div class="container">
	<!--- Build accessToken URL --->
	<cfset oAccessResult = CreateObject("component", "cfc.xero").accessToken(
		sXeroAppType = sXeroAppType,
		aCallbackParams = cgi.query_string,
		sConsumerKey = sConsumerKey, 
		sConsumerSecret = sConsumerSecret,
		sAccessTokenEndpoint = sAccessTokenEndpoint,
		sPathToPrivateKey = pathToKey,
		sPathToSSLCert = pathToSSLCert,
		sPasswordToSSLCert = passwordToSSLCert)>

	<cfif oAccessResult["content"] EQ "success">
		<cfinclude template="resource.cfm">
	<cfelse>
		<cfoutput>#oAccessResult["content"]#</cfoutput>
		<br><br>
		<a class="btn btn-primary" href="request_token.cfm">Connect to Xero</a>
	</cfif>
</div>
</body>
</html>

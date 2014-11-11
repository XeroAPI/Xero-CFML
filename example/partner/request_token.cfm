<!--- Example to connect to Xero Public App
----------------------------------------------------------------------------
1) add your consumerkey & secret and set callback URL to the config.cfm file
2) save and run
--->
<html>
<head>
<title>CFML Xero Partner Application - Request Token</title>
<cfinclude template="header.cfm">
</head>
<body>

	<!--- Build requestToken URL --->
	<cfset oRequestResult = CreateObject("component", "cfc.xero").requestToken(
		sXeroAppType = sXeroAppType,
		sConsumerKey = sConsumerKey, 
		sConsumerSecret = sConsumerSecret,
		sCallbackURL = sCallbackURL,
		sTokenEndpoint = sTokenEndpoint,
		sAuthorizationEndpoint = sAuthorizationEndpoint,
		sPathToPrivateKey = pathToKey,
		sPathToSSLCert = pathToSSLCert,
		sPasswordToSSLCert = passwordToSSLCert)>

	<!--- Redirect user to Xero to login and authorize --->
	<cflocation url="#oRequestResult["url"]#">

</body>
</html>
<!--- Example to connect to Xero Public App
----------------------------------------------------------------------------
1) Assumes there is a CF mapping of oauth pointing to the oauth folder.
2) add your consumerkey & secret and set callback URL to the config.cfm file
3) save and run
--->
<html>
<head>
<title>CFML Xero Public Application - Request Token</title>
<cfinclude template="header.cfm">
</head>
<body>
<!--- Make requestToken Call and build & return authorization URL --->
<cfset oRequestResult = CreateObject("component", "cfc.xero").requestToken(
	sXeroAppType = sXeroAppType,
	sConsumerKey = sConsumerKey, 
	sConsumerSecret = sConsumerSecret,
	sCallbackURL = sCallbackURL,
	sTokenEndpoint = sTokenEndpoint,
	sAuthorizationEndpoint = sAuthorizationEndpoint)>
<!--- Redirect user to Xero to login and authorize --->
<cflocation url="#oRequestResult["url"]#">
</body>
</html>
<!--- Example to connect to Xero App
----------------------------------------------------------------------------
1) Assumes there is a CF mapping of CFC folder.
2) add your consumerkey & secret and set callback URL to the config.json file
3) save and run
--->
<cfif application.config["AppType"] EQ "PRIVATE">
    <cflocation url="get.cfm" addtoken="false">
</cfif>
<html>
<head>
	<title>CFML Xero Application - Request Token</title>
	<cfinclude template="/common/header.cfm" >
</head>
<body>

<cfscript>

req=createObject("component","cfc.xero").init(); 

try {
	req.requestToken();
	location(req.getAuthorizeUrl());
}	

catch(any e){
	if(e.ErrorCode EQ "401") {
		location("index.cfm?" & e.message);
	} else {
		writeDump(e);
		abort;
	}
}
</cfscript>
</body>
</html>
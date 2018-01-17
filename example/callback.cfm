<!--- Example callback from Xero App
----------------------------------------------------------------------------
1) run request_token.cfm FIRST, this CALLBACK page will be called by Xero's server after successful user authorization.
--->
<html>
<head>
	<title>Xero-CFML Sample App - Callback</title>
	<cfinclude template="/common/header.cfm" >
</head>
<body>
<div class="container">

<cfscript>

res=createObject("component","cfc.xero").init(); 

try {
	res.accessToken(aCallbackParams = cgi.query_string);
	location("get.cfm","false");
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
</div>
</body>
</html>

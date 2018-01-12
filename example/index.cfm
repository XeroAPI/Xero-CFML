<html>
<head>
	<title>CFML Xero Application</title>
	<cfinclude template="/common/header.cfm" >
</head>
<body>
<div class="container">
	<h1>CFML Xero Application</h1>
	<cfif StructKeyExists(url,'error') GT 0>
		<cfoutput>
			<div class="alert alert-warning">#url.error#<br></div>
		</cfoutput>
	</cfif>

	<a class="btn btn-primary" href="request_token.cfm">Connect to Xero</a>
</div>
</body>
</html>
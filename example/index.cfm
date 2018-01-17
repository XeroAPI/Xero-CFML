<html>
<head>
	<title>Xero-CFML Sample App</title>
	<cfinclude template="/common/header.cfm" >
</head>
<body>
<div class="container">
	<h1>Xero-CFML Sample App</h1>
	<cfif StructKeyExists(url,'error') GT 0>
		<cfoutput>
			<div class="alert alert-warning">#url.error#<br></div>
		</cfoutput>
	</cfif>
	Let's start by connecting to your Xero org.
	<br><br>
	<a class="btn btn-primary" href="request_token.cfm">Connect to Xero</a>
</div>
</body>
</html>
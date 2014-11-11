<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->
<cfinclude template="header.cfm">

<cfif NOT StructKeyExists(session, "stToken")>
	<cflocation url="index.cfm">
</cfif>

<cfinclude template="resource.cfm">

<cfset sRequestToken = session.stToken["oauth_token"]> <!--- returned after an access token call --->
<cfset sRequestTokenSecret = session.stToken["oauth_token_secret"]> <!--- returned after an access token call --->
<cfset sResourceEndpoint = "#sApiEndpoint##form.endpoint#">

	<!--- Build and Call API, return new structure of XML results --->
	<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
		sXeroAppType = sXeroAppType,
		sConsumerKey = sConsumerKey, 
		sConsumerSecret = sConsumerSecret,
		sSignatureMethod = "HMAC-SHA1",
		sResourceEndpoint = sResourceEndpoint,
		sRequestToken = sRequestToken,
		sRequestTokenSecret= sRequestTokenSecret)>

<div class="container">
	<div class="row">
  		<div class="col-md-6">
			<cfdump var="#oRequestResult#" >
  		</div>
	</div>
</div>

<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->
<cfinclude template="header.cfm">

<cfinclude template="resource.cfm">

<cfset sRequestToken = sConsumerKey> <!--- use the consumer key as the access token  --->
<cfset sResourceEndpoint = "#sApiEndpoint##form.endpoint#">

	<!--- Build an API Call URL --->
	<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
		sXeroAppType = sXeroAppType,
		sConsumerKey = sConsumerKey, 
		sRequestToken = sRequestToken,
		sResourceEndpoint = sResourceEndpoint,
		sPathToPrivateKey = pathToKey)>

<div class="container">
	<div class="row">
  		<div class="col-md-6">
			<cfdump var="#oRequestResult#" >
  		</div>
	</div>
</div>





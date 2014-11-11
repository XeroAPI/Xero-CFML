<!---
Partner Application Doc: http://developer.xero.com/documentation/getting-started/partner-applications/
--->

<cfset sXeroAppType = "PARTNER"> <!--- PRIVATE, PUBLIC, PARTNER --->

<!--- 
Consumer Key & Secret from Xero when registering you app at http://api.xero.com 
Public and Partner Apps use both 
Private Apps only use consumer key
--->

<cfset sConsumerKey = "__PASTE_YOUR_CONSUMER_KEY__"> 
<cfset sConsumerSecret = "__PASTE_YOUR_CONSUMER_SECRET__"> 

<!--- 
URL Endpoints for token request, authorization, callback, swapping accesstoken, accessing resources
Required by Public & Partner Application Only
--->

<cfset sTokenEndpoint = "https://api-partner.network.xero.com/oauth/RequestToken"> <!--- Request Token URL --->
<cfset sAuthorizationEndpoint = "https://api.xero.com/oauth/Authorize"> <!--- Authorize URL --->
<cfset sAccessTokenEndpoint = "https://api-partner.network.xero.com/oauth/AccessToken"> <!--- AccessToken URL --->
<cfset sApiEndpoint = "https://api-partner.network.xero.com/api.xro/2.0/">
<cfset sCallbackURL = "http://localhost:8500/XeroCFML/example/partner/callback.cfm"> 

<!--- 
PRIVATE KEY from your public/private keys pair
Required by Private & Partner Application Only
These are used to sign RSA-SHA1 oAuth signatures
Public key is uploaded into your Xero App at api.xero.com
Public/Private Key Pair docs: http://developer.xero.com/documentation/advanced-docs/public-private-keypair/
--->
<cfset pathToKey = GetDirectoryFromPath( GetCurrentTemplatePath() ) & "certs/privatekey.pk8" />


<!--- 
ENTRUST SSL CERTIFICATE AND PASSWORD
Required by Partner Application Only
Provided by Xero API team after review of your integration by Developer Relations Team.
contact: api@xero.com
--->
<cfset pathToSSLCert = GetDirectoryFromPath( GetCurrentTemplatePath()) & "certs/your-entrust-cert.p12" />   
<cfset passwordToSSLCert = "your-entrust-password" />   

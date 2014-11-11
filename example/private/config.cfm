<!---
Private Application Doc: http://developer.xero.com/documentation/getting-started/private-applications/
--->

<cfset sXeroAppType = "PRIVATE"> <!--- PRIVATE, PUBLIC, PARTNER --->

<!--- 
Consumer Key & Secret from Xero when registering you app at http://api.xero.com 
Public and Partner Apps use both 
Private Apps only use consumer key
--->
<cfset sConsumerKey = "__PASTE_YOUR_CONSUMER_KEY__"> 

<!--- 
Base URL for API Endpoints 
Required by all XERO application
--->
<cfset sApiEndpoint = "https://api.xero.com/api.xro/2.0/">

<!--- 
PRIVATE KEY from your public/private keys pair
Required by Private & Partner Application Only
These are used to sign RSA-SHA1 oAuth signatures
Public key is uploaded into your Xero App at api.xero.com
Public/Private Key Pair docs: http://developer.xero.com/documentation/advanced-docs/public-private-keypair/
--->

<cfset pathToKey = GetDirectoryFromPath( GetCurrentTemplatePath() ) & "certs/privatekey.pk8" />
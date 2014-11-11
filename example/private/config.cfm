<!---
Determine which TYPE of Xero App you are building
Private Application Doc: http://developer.xero.com/documentation/getting-started/private-applications/
Public Application Doc: http://developer.xero.com/documentation/getting-started/public-applications/
Partner Application Doc: http://developer.xero.com/documentation/getting-started/partner-applications/
--->

<cfset sXeroAppType = "PRIVATE"> <!--- PRIVATE, PUBLIC, PARTNER --->

<!--- 
Consumer Key & Secret from Xero when registering you app at http://api.xero.com 
Public and Partner Apps use both 
Private Apps only use consumer key
--->

<cfset sConsumerKey = "WWEJWM1RNMSNICTPR1YRE2ONFRXTQV"> 
<cfset sConsumerSecret = "4C3TYHBVVC0BJU4MOVDYFFNDN67SOG"> 

<!--- 
URL Endpoints for token request, authorization, callback, swapping accesstoken, accessing resources
Required by Public & Partner Application Only
--->

<cfset sTokenEndpoint = "https://api.xero.com/oauth/RequestToken"> <!--- Request Token URL --->
<cfset sAuthorizationEndpoint = "https://api.xero.com/oauth/Authorize"> <!--- Authorize URL --->
<cfset sAccessTokenEndpoint = "https://api.xero.com/oauth/AccessToken"> <!--- AccessToken URL --->
<cfset sCallbackURL = "http://localhost:8500/XeroCFML/example/partner/callback.cfm"> 

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

<cfset pathToKey = GetDirectoryFromPath( GetCurrentTemplatePath() ) & "certs/privateKey.pk8" />

<!--- 
ENTRUST SSL CERTIFICATE AND PASSWORD
Required by Partner Application Only
Provided by Xero API team after review of your integration by Developer Relations Team.
contact: api@xero.com
--->

<cfset pathToSSLCert = GetDirectoryFromPath( GetCurrentTemplatePath()) & "certs/XeroSidPartnerTestApp.p12" />   
<cfset passwordToSSLCert = "Mad07Liv11" />   

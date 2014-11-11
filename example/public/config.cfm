<!---
Determine which TYPE of Xero App you are building
Private Application Doc: http://developer.xero.com/documentation/getting-started/private-applications/
Public Application Doc: http://developer.xero.com/documentation/getting-started/public-applications/
Partner Application Doc: http://developer.xero.com/documentation/getting-started/partner-applications/
--->

<cfset sXeroAppType = "PUBLIC"> <!--- PRIVATE, PUBLIC, PARTNER --->

<!--- 
Consumer Key & Secret from Xero when registering you app at http://api.xero.com 
Public and Partner Apps use both 
Private Apps only use consumer key
--->

<!--- 
URL Endpoints for token request, authorization, callback, swapping accesstoken, accessing resources
Required by Public & Partner Application Only
--->

<cfset sConsumerKey = "__PASTE_YOUR_CONSUMER_KEY__"> 
<cfset sConsumerSecret = "__PASTE_YOUR_CONSUMER_SECRET__"> 

<!--- 
URL Endpoints for token request, authorization, callback, and swapping accesstoken
Required by Public & Partner Application Only
--->
<cfset sTokenEndpoint = "https://api.xero.com/oauth/RequestToken"> <!--- Request Token URL --->
<cfset sAuthorizationEndpoint = "https://api.xero.com/oauth/Authorize"> <!--- Authorize URL --->
<cfset sAccessTokenEndpoint = "https://api.xero.com/oauth/AccessToken"> <!--- AccessToken URL --->
<cfset sCallbackURL = "http://localhost:8500/XeroCFML/example/public/callback.cfm"> 

<!--- 
Base URL for API Endpoints 
Required by all XERO application
--->
<cfset sApiEndpoint = "https://api.xero.com/api.xro/2.0/">


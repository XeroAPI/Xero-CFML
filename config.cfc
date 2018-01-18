<!---
Description:
============
	Xero oAuth Config

License:
============
This software is published under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

Copyright (c) 2014 Xero Limited

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

History:
============
10/15/14 - Sid Maestre - created
--->

<cfcomponent displayname="config">

	<cfset this.AppType = "">
	<cfset this.UserAgent = "">
	<cfset this.Accept = "application/json">
	<cfset this.ConsumerKey = "">
	<cfset this.ConsumerSecret = "">
	<cfset this.ApiBaseUrl = "">
	<cfset this.ApiEndpointPath = "">
	<cfset this.RequestTokenPath = "">
	<cfset this.AuthenticateUrl = "">
	<cfset this.AccessTokenPath = "">
	<cfset this.CallbackBaseUrl = "">
	<cfset this.CallbackPath = "">
	<cfset this.PrivateKeyCert = "">

	<cfset this.CallbackUrl = "">
	<cfset this.PathToPrivateKey = "">
	<cfset this.RequestTokenUrl = "">
	<cfset this.AccessTokenUrl = "">

	<cffunction name="init" returntype="config">
		<cfargument name="pathToConfigJSON" default="" displayname="path to config.json file" type="string">

		<cffile action="read" file="#pathToConfigJSON#" variable="json">
		<cfset this.json =  DeserializeJSON(json)>
		<cfset this.json["pathToConfigJSON"] = pathToConfigJSON>
		<cfset var pathToConfig = #GetDirectoryFromPath(this.json["pathToConfigJSON"])#>

		<cfif structKeyExists(this.json, "AppType")>
			<cfset this.AppType = this.json["AppType"]>
		</cfif>
		<cfif structKeyExists(this.json, "UserAgent")>
			<cfset this.UserAgent = this.json["UserAgent"] & "-CFML-[0.5.0]">
		</cfif>
		<cfif structKeyExists(this.json, "Accept")>
			<cfset this.Accept = this.json["Accept"]>
		<cfelse>
			<cfset this.Accept = "application/json">
		</cfif>
		<cfif structKeyExists(this.json, "ConsumerKey")>
			<cfset this.ConsumerKey = this.json["ConsumerKey"]>
			<cfif this.ConsumerKey EQ "__YOUR_CONSUMER_KEY__">
				<cfoutput>Looks like your Consumer Key has not been set - look at /resource/config.json and README - Be sure to retart your CFML engine to re-initiliaze this Config.cfc</cfoutput>
				<cfabort>
			</cfif>
		</cfif>
		<cfif structKeyExists(this.json, "ConsumerSecret")>
			<cfset this.ConsumerSecret = this.json["ConsumerSecret"]>
			<cfif this.ConsumerSecret EQ "__YOUR_CONSUMER_KEY_SECRET__">
				<cfoutput>Looks like your Consumer Secret has not been set - look at /resource/config.json and README - Be sure to retart your CFML engine to re-initiliaze this Config.cfc</cfoutput>
				<cfabort>
			</cfif>
		</cfif>
		<cfif structKeyExists(this.json, "ApiBaseUrl")>
			<cfset this.ApiBaseUrl = this.json["ApiBaseUrl"]>
		<cfelse>
			<cfset this.ApiBaseUrl = "https://api.xero.com">
		</cfif>
		<cfif structKeyExists(this.json, "ApiEndpointPath")>
			<cfset this.ApiEndpointPath = this.json["ApiEndpointPath"]>
		<cfelse>
			<cfset this.ApiEndpointPath = "/api.xro/2.0/">
		</cfif>
		<cfif structKeyExists(this.json, "RequestTokenPath")>
			<cfset this.RequestTokenPath = this.json["RequestTokenPath"]>
		<cfelse>
			<cfset this.RequestTokenPath = "/oauth/RequestToken">
		</cfif>
		<cfif structKeyExists(this.json, "AuthenticateUrl")>
			<cfset this.AuthenticateUrl = this.json["AuthenticateUrl"]>
		<cfelse>
			<cfset this.AuthenticateUrl = "https://api.xero.com/oauth/Authorize">
		</cfif>
		<cfif structKeyExists(this.json, "AccessTokenPath")>
			<cfset this.AccessTokenPath = this.json["AccessTokenPath"]>
		<cfelse>
			<cfset this.AccessTokenPath = "/oauth/AccessToken">
		</cfif>
		<cfif structKeyExists(this.json, "CallbackBaseUrl")>
			<cfset this.CallbackBaseUrl = this.json["CallbackBaseUrl"]>
		</cfif>
		<cfif structKeyExists(this.json, "CallbackPath")>
			<cfset this.CallbackPath = this.json["CallbackPath"]>
		</cfif>
		<cfif structKeyExists(this.json, "PrivateKeyCert")>
			<cfset this.PrivateKeyCert = this.json["PrivateKeyCert"]>
		</cfif>
		
		<cfif structKeyExists(this.json, "CallbackBaseUrl")>
			<cfset this.CallbackUrl = this.json["CallbackBaseUrl"] & this.json["CallbackPath"]>
		</cfif>

		<cfif structKeyExists(this.json, "PrivateKeyCert")>
			<cfset this.PathToPrivateKey = pathToConfig & this.json["PrivateKeyCert"]>
			<cfif NOT FileExists(this.PathToPrivateKey)>
				<cfoutput>No Private Key File Found	- Check the path set in /resource/config.json - #this.PathToPrivateKey#</cfoutput>
				<cfabort>
			</cfif>
		</cfif>

		<cfif structKeyExists(this.json, "RequestTokenPath")>
			<cfset this.RequestTokenUrl = this.json["ApiBaseUrl"] & this.json["RequestTokenPath"]>
		</cfif>

		<cfif structKeyExists(this.json, "AccessTokenPath")>
			<cfset this.AccessTokenUrl = this.json["ApiBaseUrl"] & this.json["AccessTokenPath"]>
		</cfif>

		<cfreturn this>
	</cffunction>

</cfcomponent>
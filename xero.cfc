<!---
Description:
============
	Xero oAuth Connector

License:
============
This software is published under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

Copyright (c) 2014-2018 Xero Limited

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
1/12/18 - Sid Maestre - updated
7/17/18 - Martin Webb - updated
--->

<cfcomponent displayname="xero" output="true">
	
	<cfproperty name="authorizeUrl" type="String" default="" />
	<cfproperty name="storage" type="object" default="" />

	<cffunction name="init" access="public" output="false"
    	returntype="any" hint="I am the constructor method for the Xero Class.">
    	<cfargument name="pathToConfigJSON" default="" displayname="path to config.json file" type="string">
    	<cfset this.config = CreateObject("component", "config").init(arguments.pathToConfigJSON)>
      	<cfset this.storage = CreateObject("component", "storage").init(this)>
    	<cfreturn this />
  	</cffunction>

	<cffunction name="getHttpURL" access="public" returntype="string">
		<cfreturn variables.sHttpURL>
	</cffunction>
	<cffunction name="setHttpURL" access="public" returntype="void">
		<cfargument name="sHttpURL" type="string" required="yes">
		<cfset variables.sHttpURL = arguments.sHttpURL>
	</cffunction>

	<cffunction name="getAuthorizeUrl" access="public" returntype="string">
		<cfreturn variables.authorizeUrl>
	</cffunction>
	<cffunction name="setAuthorizeUrl" access="public" returntype="void">
		<cfargument name="authorizeUrl" type="string" required="yes">
		<cfset variables.authorizeUrl = arguments.authorizeUrl>
	</cffunction>

	<!--- attempt to build up a requestToken URL from the config details --->
	<cffunction name="requestToken" access="public" returntype="struct">
	
		<cfset local.oResultRequest = StructNew()>

		<cfset local.oToken = CreateObject("component", "oauth.oauthtoken").createEmptyToken()>

		<!--- set up the required objects including signature method--->
		<cfif this.config.AppType EQ "PUBLIC">
			<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_hmac_sha1")>
			<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
				sKey = this.config.ConsumerKey, 
				sSecret = this.config.ConsumerSecret)>
		<cfelse>
			<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_rsa_sha1")>
			<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
				sKey = this.config.ConsumerKey, 
				sSecret = this.config.ConsumerSecret,
				sPathToPrivateKey = this.config.PathToPrivateKey)>
		</cfif>

			
		<cfset local.stDefault = StructNew()>
		<cfset local.stDefault["oauth_callback"] = this.config.CallbackBaseUrl & this.config.CallbackPath>

		<cfset local.oReq = CreateObject("component", "oauth.oauthrequest").fromConsumerAndToken(
			oConsumer = local.oConsumer,
			oToken = local.oToken,
			sHttpMethod = "GET",
			sHttpURL = this.config.ApiBaseUrl & this.config.RequestTokenPath,
			stParameters = local.stDefault)>
		
		<cfset local.oReq.signRequest(
			oSignatureMethod = local.oReqSigMethodSHA,
			oConsumer = local.oConsumer,
			oToken = local.oToken)>

		<!--- make requestToken call to Xero  --->
		<cfhttp url="#local.oREQ.getString()#" 
				method="GET" 
				result="local.tokenResponse"/>

		<!--- was an oauth_token returned in the response if its there--->
		<cfif findNoCase("oauth_token",local.tokenresponse.filecontent)>
			<cfset this.storage.saveRequestToken(local.tokenresponse.filecontent)>
			<cfset this.setAuthorizeUrl(this.authorize())>
		<cfelse>
			<cfthrow errorCode='#local.tokenResponse["Responseheader"]["Status_Code"]#' detail="#local.tokenResponse.ErrorDetail#" message="#local.tokenResponse.filecontent#">
		</cfif>

		<cfreturn this>
	</cffunction>

	<!--- attempt to build up an authorization URL from what was returned from the server --->
	<cffunction name="authorize" access="public" returntype="String">
						
			<!--- you can add some additional parameters to the callback --->
			<cfset local.sCallbackURL = this.config.CallbackBaseUrl & this.config.CallbackPath & "?" &
				"key=" & this.config.ConsumerKey &
				"&" & "secret=" & this.config.ConsumerSecret &
				"&" & "token=" & this.storage.getRequestOAuthToken() &
				"&" & "token_secret=" & this.storage.getRequestOAuthTokenSecret() &
				"&" & "endpoint=" & this.config.AuthenticateUrl>

			<cfset local.sAuthURL = this.config.AuthenticateUrl & "?oauth_token=" & this.storage.getRequestOAuthToken() & "&" & "oauth_callback=" & URLEncodedFormat(this.config.CallbackBaseUrl & this.config.CallbackPath) >
		<cfreturn local.sAuthURL>
	</cffunction>

	<!--- attempt to build the URL to swap the requestToken for an accessToken from the Xero server --->
	<cffunction name="accessToken" access="public" returntype="boolean" output="true">
		<cfargument name="aCallbackParams" required="true" type="string" default="">
	
			<cfset local.oResultRequest = StructNew()>

			<!--- set up the parameters --->
			<cfset this.storage.saveCallback(arguments.aCallbackParams)>
	
			<cfset local.oToken = CreateObject("component", "oauth.oauthtoken").init(
				sKey= this.storage.getRequestOAuthToken(),
				sSecret=this.storage.getRequestOAuthTokenSecret())>

			<cfif this.config.AppType EQ "PUBLIC">
				<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_hmac_sha1")>
				<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
					sKey = this.config.ConsumerKey, 
					sSecret = this.config.ConsumerSecret)>
			<cfelse>
				<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_rsa_sha1")>
				<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
					sKey = this.config.ConsumerKey, 
					sSecret = this.config.ConsumerSecret,
					sPathToPrivateKey = this.config.PathToPrivateKey)>
			</cfif>

			<cfset local.stParameters = structNew()>
			<cfset local.stParameters.oauth_verifier = this.storage.getVerifier()>

			<cfset local.oReq = CreateObject("component", "oauth.oauthrequest").fromConsumerAndToken(
				oConsumer = local.oConsumer,
				oToken = local.oToken,
				sHttpMethod = "GET",
				sHttpURL = this.config.ApiBaseUrl & this.config.AccessTokenPath,
				stparameters= local.stParameters )>

			<cfset local.oReq.signRequest(
				oSignatureMethod = local.oReqSigMethodSHA,
				oConsumer = local.oConsumer,
				oToken = local.oToken)>

			<!--- make AccessToken call to Xero  --->
			<cfhttp url="#local.oREQ.getString()#" 
				method="GET" 
				result="local.tokenResponse"/>

			<!--- was an oauth_token returned in the response if its there save the new access token --->
			<cfif findNoCase("oauth_token",local.tokenresponse.filecontent)>
				<cfset this.storage.setTimestamp('#DateFormat(now(), "mmm-dd-yyyy")# #TimeFormat(now(), "HH:mm:ss")#') >
				<cfset this.storage.saveAccessToken(local.tokenResponse.filecontent)>
				<cfreturn true>
<!---				<cfset oResultRequest["content"] = "success" >--->
			<cfelse>		
				<cfthrow errorCode='#local.tokenResponse["Responseheader"]["Status_Code"]#' detail="#local.tokenResponse.ErrorDetail#" message="#local.tokenResponse.filecontent#">
			</cfif>

		<cfreturn local.oResultRequest>

	</cffunction>

	<cffunction name="IsTokeExpired" access="public" returntype="boolean">
		<cfset local.expired = false>

		<cfif len(this.storage.getTimestamp()) GT 0>
			<cfif datediff('n',this.storage.getTimestamp(),now()) GTE 29>
				<cfset local.expired = true>
			</cfif>
		</cfif>

		<cfreturn local.expired>
	</cffunction>

	<cffunction name="refreshToken" access="public" returntype="boolean">

		<cfset local.oResultRequest = StructNew()>
			
		<cfset local.oToken = CreateObject("component", "oauth.oauthtoken").init(
			sKey= this.storage.getOAuthToken(),
			sSecret=this.storage.getOAuthToken())>

		<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_rsa_sha1")>
		<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
			sKey = this.config.ConsumerKey, 
			sSecret = this.config.ConsumerSecret,
			sPathToPrivateKey = this.config.PathToPrivateKey)>

		<cfset local.stParameters = structNew()>
		<cfset local.stParameters.oauth_session_handle = this.storage.getOAuthSessionHandle()>

		<cfset local.oReq = CreateObject("component", "oauth.oauthrequest").fromConsumerAndToken(
			oConsumer = local.oConsumer,
			oToken = local.oToken,
			sHttpMethod = "GET",
			sHttpURL = this.config.ApiBaseUrl & this.config.AccessTokenPath,
			stparameters= local.stParameters )>

		<cfset local.oReq.signRequest(
			oSignatureMethod = local.oReqSigMethodSHA,
			oConsumer = local.oConsumer,
			oToken = local.oToken)>

		<!--- make AccessToken call to Xero  --->
		<cfhttp url="#local.oREQ.getString()#" 
			method="GET" 
			result="local.tokenResponse"/>

		<!--- was an oauth_token returned in the response if its there save the new access token --->
		<cfif findNoCase("oauth_token",local.tokenresponse.filecontent)>
			<cfset this.storage.setTimestamp('#DateFormat(now(), "mmm-dd-yyyy")# #TimeFormat(now(), "HH:mm:ss")#') >
			<cfset this.storage.saveAccessToken(local.tokenResponse.filecontent)>
			<cfreturn true>
		<cfelse>		
			<cfthrow errorCode='#local.tokenResponse["Responseheader"]["Status_Code"]#' detail="#local.tokenResponse.ErrorDetail#" message="#local.tokenResponse.filecontent#">
		</cfif>

	</cffunction>

	<!--- attempt to build up a requestData URL from the config details --->
	<cffunction name="requestData" access="public" returntype="struct">
		<cfargument name="sResourceEndpoint" required="true" type="string" default="">
		<cfargument name="sOAuthToken" required="false" type="string" default="">
		<cfargument name="sOAuthTokenSecret" required="false" type="string" default="">
		<cfargument name="stParameters" required="false" type="struct" default="">
		<cfargument name="sAccept" required="false" type="string" default="#this.config.json["Accept"]#">
		<cfargument name="sIfModifiedSince" required="false" type="string" default="">
		<cfargument name="sMethod" required="false" type="string" default="GET">
		<cfargument name="sBody" required="false" type="string" default="">
		<cfargument name="contentType" required="false" type="string" default="application/json">
		<cfargument name="debug" required="false" type="boolean" default="false">

			<cfset local.oResultRequest = StructNew()>
			
			<cfif len(arguments.sOAuthToken) gt 0>
				<cfset local.Token = arguments.sOAuthToken>
			<cfelse>
				<cfset local.Token = this.storage.getOAuthToken()>
			</cfif>

			<cfif len(arguments.sOAuthTokenSecret) gt 0>
				<cfset local.TokenSecret = arguments.sOAuthTokenSecret>
			<cfelse>
				<cfset local.TokenSecret = this.storage.getOAuthTokenSecret()>
			</cfif>
			<cfif IsTokeExpired()>
				<cfif this.config.AppType EQ "PUBLIC">	
					<cfthrow errorCode='401' message="Token Expired" Type='Application'>
				</cfif>
				<cfif this.config.AppType EQ "PARTNER">
					<cfset refreshToken()>
					<cfset local.Token = this.storage.getOAuthToken()>
					<cfset local.TokenSecret = this.storage.getOAuthTokenSecret()>
				</cfif>	
			</cfif>

			<!--- set up the required objects including signature method--->
			<cfif this.config.AppType EQ "PUBLIC">	
				<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_hmac_sha1")>
				<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
					sKey = this.config.ConsumerKey, 
					sSecret = this.config.ConsumerSecret)>
			<cfelse>
				<cfset local.oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_rsa_sha1")>
				<cfset local.oConsumer = CreateObject("component", "oauth.oauthconsumer").init(
					sKey = this.config.ConsumerKey, 
					sSecret = this.config.ConsumerSecret,
					sPathToPrivateKey = this.config.PathToPrivateKey)>
			</cfif>

			<cfif this.config.AppType EQ "PRIVATE">
				<cfset local.TokenToUse = this.config.ConsumerKey>
				<cfset local.TokenSecretToUse = this.config.ConsumerSecret>
			<cfelse>
				<cfset local.TokenToUse = local.Token>
				<cfset local.TokenSecretToUse = local.TokenSecret>
			</cfif>

			<cfset local.oToken = CreateObject("component", "oauth.oauthtoken").init(
					sKey = local.TokenToUse,
					sSecret = local.TokenSecretToUse)>

			<cfset local.oReq = CreateObject("component", "oauth.oauthrequest").fromConsumerAndToken(
				oConsumer = local.oConsumer,
				oToken = local.oToken,
				sHttpMethod = arguments.sMethod,
				sHttpURL = arguments.sResourceEndpoint,
				stparameters= arguments.stParameters )>
				
			<cfset local.oReq.signRequest(
				oSignatureMethod = local.oReqSigMethodSHA,
				oConsumer = local.oConsumer,
				oToken = local.oToken)>

			<!--- Request data from Xero API --->
			<cfhttp 
				url="#local.oREQ.getString()#" 
				method= "#arguments.sMethod#" 
				result="local.tokenResponse" 
				useragent="#this.config.UserAgent#">
				<cfhttpparam type="header" name="accept" value="#arguments.sAccept#">
				<cfhttpparam type="header" name="Content-Type" value="#arguments.sAccept#">
				<cfif len(arguments.sIfModifiedSince)>
					<cfhttpparam type="header" name="If-Modified-Since" value="#DateFormat(arguments.sIfModifiedSince," YYY-MM-DD")#T#TimeFormat(arguments.sIfModifiedSince,"HH:MM:SS")#">
				</cfif>
				<cfif len(arguments.sBody)>
					<cfhttpparam type="body" value="#trim(arguments.sBody)#">
				</cfif>
			</cfhttp>


		<cfset local.stReturn = structNew()>
		<cfif isXML(local.tokenResponse.Filecontent)>
			<cfset local.stReturn.response = ConvertXmlToStruct(local.tokenResponse.Filecontent,structNew())>
		<cfelse>
				<cfif len(local.tokenResponse.Filecontent) EQ 0>
					<cfset local.stReturn.response = '{ "Status": "OK",  "Deleted": "true",  "ValidationErrors": [] }'>
				<cfelse>
					<cfset local.stReturn.response = local.tokenResponse.Filecontent>
				</cfif>
		</cfif>

		<cfreturn local.stReturn>
	</cffunction>

	<cffunction name="ConvertXmlToStruct" access="private" returntype="struct" output="true"
					hint="Parse raw XML response body into ColdFusion structs and arrays and return it.">
		<cfargument name="xmlNode" type="string" required="true" />
		<cfargument name="str" type="struct" required="true" />
		<!---Setup local variables for recurse: --->
		<cfset local.i = 0 />
		<cfset local.axml = arguments.xmlNode />
		<cfset local.astr = arguments.str />
		<cfset local.n = "" />
		<cfset local.tmpContainer = "" />

		<cftry>
			<!---
			Strip out the tag prefixes. This will convert tags from the
			form of soap:nodeName to JUST nodeName. This works for both
			openning and closing tags.
			--->
			<cfset arguments.xmlNode = arguments.xmlNode.ReplaceAll(
			"(</?)(\w+:)",
			"$1"
			) />
			 
			<!---
			Remove all references to XML name spaces. These are node
			attributes that begin with "xmlns:".
			--->
			<cfset arguments.xmlNode = arguments.xmlNode.ReplaceAll(
			"xmlns(:\w+)?=""[^""]*""",
			""
			) />
			 
			<!---
			Remove all references to XML name spaces. These are node
			attributes that begin with "xsi:".
			--->
			<cfset arguments.xmlNode = arguments.xmlNode.ReplaceAll(
			"xsi(:\w+)?=""[^""]*""",
			""
			) />
			<cfcatch type="any"><!--- IGNORE ERRORS. JUST TRYING TO STRIP NAMESPACES WHERE APPROPRIATE ---></cfcatch>
		</cftry>
		
		<cfset local.axml = XmlSearch(XmlParse(arguments.xmlNode),"/node()")>
		<cfset local.axml = local.axml[1] />
		<!--- For each children of context node: --->
		<cfloop from="1" to="#arrayLen(local.axml.XmlChildren)#" index="local.i">
			<!--- Read XML node name without namespace: --->
			<cfset local.n = replace(local.axml.XmlChildren[local.i].XmlName, local.axml.XmlChildren[local.i].XmlNsPrefix&":", "") />
			<!--- If key with that name exists within output struct ... --->
			<cfif structKeyExists(local.astr, local.n)>
				<!--- ... and is not an array... --->
				<cfif not isArray(local.astr[local.n])>
					<!--- ... get this item into temp variable, ... --->
					<cfset local.tmpContainer = local.astr[local.n] />
					<!--- ... setup array for this item beacuse we have multiple items with same name, ... --->
					<cfset local.astr[local.n] = arrayNew(1) />
					<!--- ... and reassing temp item as a first element of new array: --->
					<cfset local.astr[local.n][1] = local.tmpContainer />
				<cfelse>
					<!--- Item is already an array: --->
					
				</cfif>
				<cfif arrayLen(local.axml.XmlChildren[local.i].XmlChildren) gt 0>
						<!--- recurse call: get complex item: --->
						<cfset local.astr[local.n][arrayLen(local.astr[local.n])+1] = ConvertXmlToStruct(local.axml.XmlChildren[local.i], structNew()) />
					<cfelse>
						<!--- else: assign node value as last element of array: --->
						<cfset local.astr[local.n][arrayLen(local.astr[local.n])+1] = local.axml.XmlChildren[local.i].XmlText />
				</cfif>
			<cfelse>
				<!---
					This is not a struct. This may be first tag with some name.
					This may also be one and only tag with this name.
				--->
				<!---
						If context child node has child nodes (which means it will be complex type): --->
				<cfif arrayLen(local.axml.XmlChildren[local.i].XmlChildren) gt 0>
					<!--- recurse call: get complex item: --->
					<cfset local.astr[local.n] = ConvertXmlToStruct(local.axml.XmlChildren[local.i], structNew()) />
				<cfelse>
					<!--- else: assign node value as last element of array: --->
					<!--- if there are any attributes on this element--->
					<cfif IsStruct(local.aXml.XmlChildren[local.i].XmlAttributes) AND StructCount(local.aXml.XmlChildren[local.i].XmlAttributes) GT 0>
						<!--- assign the text --->
						<cfset local.astr[local.n] = local.axml.XmlChildren[local.i].XmlText />
							<!--- check if there are no attributes with xmlns: , we dont want namespaces to be in the response--->
						 <cfset local.attrib_list = StructKeylist(local.axml.XmlChildren[local.i].XmlAttributes) />
						 <cfloop from="1" to="#listLen(local.attrib_list)#" index="local.attrib">
							 <cfif ListgetAt(local.attrib_list,local.attrib) CONTAINS "xmlns:">
								 <!--- remove any namespace attributes--->
								<cfset Structdelete(local.axml.XmlChildren[local.i].XmlAttributes, listgetAt(local.attrib_list,local.attrib))>
							 </cfif>
						 </cfloop>
						 <!--- if there are any atributes left, append them to the response--->
						 <cfif StructCount(local.axml.XmlChildren[local.i].XmlAttributes) GT 0>
							 <cfset local.astr[local.n&'_attributes'] = local.axml.XmlChildren[local.i].XmlAttributes />
						</cfif>
					<cfelse>
						 <cfset local.astr[local.n] = local.axml.XmlChildren[local.i].XmlText />
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
		<!--- return struct: --->

		<cfreturn local.astr />
	</cffunction>


	<cffunction name="getModel" access="public" returntype="any">
		<cfargument name="modelName" required="true" type="string">
		<cfreturn CreateObject("component", "model.#arguments.modelName#").init(this)>
	</cffunction>

</cfcomponent>
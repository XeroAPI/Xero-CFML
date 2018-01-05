
<cfcomponent displayname="xeroclient" output="true">

	<cffunction name="init" returntype="xeroclient" output="true">
		<cfreturn this>
	</cffunction>

	<cffunction name="getOAuthToken" access="public" returntype="string">
		<cfset variables.oauth_token = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_token = session.stToken["oauth_token"]> 	
		</cfif>
		<cfreturn variables.oauth_token>
	</cffunction>

	<cffunction name="getOAuthTokenSecret" access="public" returntype="string">
		<cfset variables.oauth_token_secret = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_token_secret = session.stToken["oauth_token_secret"]> 
		</cfif>
		<cfreturn variables.oauth_token_secret>
	</cffunction>

	<cffunction name="getBaseURL" access="public" returntype="string">
		<cfset variables.baseUrl = "#application.config.ApiBaseUrl##application.config.ApiEndpointPath#"> 
		
		<cfreturn variables.baseUrl>
	</cffunction>

	<cffunction name="getParameters" access="public" returntype="struct">
		
		<cfif NOT structKeyExists(variables, "parameters")>
			<cfset variables.parameters = StructNew()>
		</cfif>
	
		<cfreturn  variables.parameters>
	</cffunction>

	<cffunction name="setParameters" access="public" >
		<cfargument name="parameters"  type="Struct" default="">

		<cfset variables.parameters = arguments.parameters />
	</cffunction>

	<cffunction name="get" access="public" returntype="array">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="ifModifiedSince"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="id"  type="string" default="">
		
		<cfif len(arguments.id) GT 0> 
			<cfset resource = arguments.endpoint & "/" & arguments.id>
		<cfelse>
			<cfset resource = arguments.endpoint>
		</cfif>
		
		<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			sOAuthToken = this.getOAuthToken(),
			sOAuthTokenSecret= this.getOAuthTokenSecret(),
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "GET",
			sIfModifiedSince = arguments.ifModifiedSince)>


		<cfset variables.ArrayResult = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.endpoint]>

		<cfreturn variables.ArrayResult>
	</cffunction>

	<cffunction name="put" access="public" returntype="array">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="body"  type="string" default="">
		<cfargument name="child"  type="string" default="">
		<cfargument name="childId"  type="string" default="">
		<cfargument name="id"  type="string" default="">
		
		<cfif len(arguments.id) GT 0> 
			<cfset resource = arguments.endpoint & "/" & arguments.id>
		<cfelse>
			<cfset resource = arguments.endpoint>
		</cfif>
		<cfset child = arguments.child>
		<cfset childId = arguments.childId>
		
		<cfif len(child) GT 0>
			<cfset resource = resource & "/" & child>
			<cfif len(childId) GT 0>
				<cfset resource = resource & "/" & childId>
			</cfif>
		</cfif>

		<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			sOAuthToken = this.getOAuthToken(),
			sOAuthTokenSecret= this.getOAuthTokenSecret(),
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "PUT",
			sBody = arguments.body)>

		<cfif len(child) GT 0>
			<cfset variables.result = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.child]>	
		<cfelse>
			<cfset variables.result = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.endpoint]>
		</cfif>
		<cfreturn variables.result>	
	</cffunction>

	<cffunction name="post" access="public" returntype="array">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="body"  type="string" default="">
		<cfargument name="id"  type="string" default="">

		<cfset resource = arguments.endpoint & "/" & arguments.id>

		<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			sOAuthToken = this.getOAuthToken(),
			sOAuthTokenSecret= this.getOAuthTokenSecret(),
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "POST",
			sBody = arguments.body)>

		<cfset variables.result = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.endpoint]>
		<cfreturn variables.result>
	</cffunction>

	<cffunction name="delete" access="public" returntype="any">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="body"  type="string" default="">
		<cfargument name="id"  type="string" default="">
		<cfargument name="child"  type="string" default="">
		<cfargument name="childId"  type="string" default="">
		<cfset resource = arguments.endpoint & "/" & arguments.id>

		<cfset child = arguments.child>
		<cfset childId = arguments.childId>
		
		<cfif len(child) GT 0>
			<cfset resource = resource & "/" & child>
			<cfif len(childId) GT 0>
				<cfset resource = resource & "/" & childId>
			</cfif>
		</cfif>

		<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			sOAuthToken = this.getOAuthToken(),
			sOAuthTokenSecret= this.getOAuthTokenSecret(),
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "DELETE",
			sBody = arguments.body)>

		<cfif isJSON(variables.oRequestResult["RESPONSE"])>
			<cfset variables.result = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.endpoint]>
		<cfelse>
			<cfset variables.result = this.toJSON()>
		</cfif>
		<cfreturn variables.result>
	</cffunction>

</cfcomponent>
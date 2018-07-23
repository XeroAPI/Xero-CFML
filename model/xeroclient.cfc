
<cfcomponent displayname="xeroclient">

	<cfset variables.xero = "">

	<cffunction name="getBaseURL" access="public" returntype="string">
		<cfset variables.baseUrl = "#variables.xero.config.ApiBaseUrl##variables.xero.config.ApiEndpointPath#"> 
		
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


	<cffunction name="getModifiedSince" access="public" returntype="string">
		<cfset variables.modifiedsince = "">
	
		<cfreturn  variables.modifiedsince>
	</cffunction>

	<cffunction name="setModifiedSince" access="public" >
		<cfargument name="modifiedsince"  type="string" default="">

		<cfset variables.modifiedsince = arguments.modifiedsince />
	</cffunction>


	<cffunction name="get" access="public" >
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="id"  type="string" default="">
		<cfargument name="child"  type="string" default="">
		<cfargument name="childId"  type="string" default="">
		<cfif len(arguments.id) GT 0> 
			<cfset local.resource = arguments.endpoint & "/" & arguments.id>
		<cfelse>
			<cfset local.resource = arguments.endpoint>
		</cfif>

		<cfset local.child = arguments.child>
		<cfset local.childId = arguments.childId>
		
		<cfif len(local.child) GT 0>
			<cfset local.resource = local.resource & "/" & local.child>
			<cfif len(local.childId) GT 0>
				<cfset local.resource = local.resource & "/" & local.childId>
			</cfif>
		</cfif>
		
		<cfset local.oRequestResult = variables.xero.requestData(
			sResourceEndpoint = this.getBaseURL() & local.resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "GET",
			sIfModifiedSince = this.getModifiedSince())>

		<cfif NOT isJSON(local.oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#local.oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>

		<cfset local.rawResult = deserializeJson(local.oRequestResult["RESPONSE"])>

		<cfif structKeyExists(local.rawResult,"ErrorNumber")>
			<cfthrow errorCode='400' message="#local.rawResult["Message"]#" Type='#local.rawResult["Type"]#' detail="#serializeJSON(local.rawResult["Elements"][1]["ValidationErrors"])#">
		</cfif>

		<cfset local.ArrayResult = deserializeJson(local.oRequestResult["RESPONSE"])[arguments.endpoint]>

		<cfreturn local.ArrayResult>
	
	</cffunction>

	<cffunction name="put" access="public" returntype="array">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="body"  type="string" default="">
		<cfargument name="child"  type="string" default="">
		<cfargument name="childId"  type="string" default="">
		<cfargument name="id"  type="string" default="">
		
		<cfif len(arguments.id) GT 0> 
			<cfset local.resource = arguments.endpoint & "/" & arguments.id>
		<cfelse>
			<cfset local.resource = arguments.endpoint>
		</cfif>
		<cfset local.child = arguments.child>
		<cfset local.childId = arguments.childId>
		
		<cfif len(local.child) GT 0>
			<cfset local.resource = local.resource & "/" & local.child>
			<cfif len(local.childId) GT 0>
				<cfset local.resource = local.resource & "/" & local.childId>
			</cfif>
		</cfif>

		<cfset local.oRequestResult = variables.xero.requestData(
			sResourceEndpoint = this.getBaseURL() & local.resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "PUT",
			sBody = arguments.body)>

		<cfif NOT isJSON(local.oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#local.oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>

		<cfset local.rawResult = deserializeJson(local.oRequestResult["RESPONSE"])>

		<cfif structKeyExists(local.rawResult,"ErrorNumber")>
			<cfthrow errorCode='400' message="#local.rawResult["Message"]#" Type='#local.rawResult["Type"]#' detail="#serializeJSON(local.rawResult["Elements"][1]["ValidationErrors"])#">
		</cfif>

		<cfif len(local.child) GT 0>
			<cfset local.result = deserializeJson(local.oRequestResult["RESPONSE"])[arguments.child]>	
		<cfelse>
			<cfset local.result = deserializeJson(local.oRequestResult["RESPONSE"])[arguments.endpoint]>
		</cfif>
		<cfreturn local.result>	
	</cffunction>

	<cffunction name="post" access="public" returntype="array">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="body"  type="string" default="">
		<cfargument name="id"  type="string" default="">

		<cfset local.resource = arguments.endpoint & "/" & arguments.id>

		<cfset local.oRequestResult = variables.xero.requestData(
			sResourceEndpoint = this.getBaseURL() & local.resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "POST",
			sBody = arguments.body)>

		<cfif NOT isJSON(local.oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#local.oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>
	
		<cfset local.rawResult = deserializeJson(local.oRequestResult["RESPONSE"])>

		<cfif structKeyExists(local.rawResult,"ErrorNumber")>
			<cfthrow errorCode='400' message="#local.rawResult["Message"]#" Type='#local.rawResult["Type"]#' detail="#serializeJSON(local.rawResult["Elements"][1]["ValidationErrors"])#">			
		</cfif>

		<cfset local.result = deserializeJson(local.oRequestResult["RESPONSE"])[arguments.endpoint]>
		<cfreturn local.result>
	</cffunction>

	<cffunction name="delete" access="public" returntype="any">
		<cfargument name="endpoint"  type="string" default="">
		<cfargument name="accept"  type="string" default="application/json">
		<cfargument name="body"  type="string" default="">
		<cfargument name="id"  type="string" default="">
		<cfargument name="child"  type="string" default="">
		<cfargument name="childId"  type="string" default="">
		<cfset local.resource = arguments.endpoint & "/" & arguments.id>

		<cfset local.child = arguments.child>
		<cfset local.childId = arguments.childId>
		
		<cfif len(local.child) GT 0>
			<cfset local.resource = local.resource & "/" & local.child>
			<cfif len(local.childId) GT 0>
				<cfset local.resource = local.resource & "/" & local.childId>
			</cfif>
		</cfif>

		<cfset local.oRequestResult = variables.xero.requestData(
			sResourceEndpoint = this.getBaseURL() & local.resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "DELETE",
			sBody = arguments.body)>


		<cfif NOT isJSON(local.oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#local.oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>
		<cfif len(local.oRequestResult["RESPONSE"]) GT 0 >
			<cfset local.rawResult = deserializeJson(local.oRequestResult["RESPONSE"])>
			<cfif structKeyExists(local.rawResult,"ErrorNumber")>
				<cfthrow errorCode='#local.rawResult["ErrorNumber"]#' message="#local.rawResult["Message"]#" Type='#local.rawResult["Type"]#'>
			</cfif>

			<cfif isJSON(local.oRequestResult["RESPONSE"])>
				<cfif StructKeyExists(local.rawResult,"Deleted")>
					<cfset local.result = StructNew()>
				<cfelseif StructKeyExists(rawResult,arguments.endpoint)>
					<cfset local.result = deserializeJson(local.oRequestResult["RESPONSE"])[arguments.endpoint]>
				<cfelseif StructKeyExists(rawResult,arguments.child)>
					<cfset local.result = deserializeJson(local.oRequestResult["RESPONSE"])[arguments.child]>
				<cfelse>
					<cfthrow errorCode='400' message="#local.oRequestResult["RESPONSE"]["Message"]#" Type='#local.oRequestResult["RESPONSE"]["Type"]#' >	
					
				</cfif>
			<cfelse>
				<cfset local.result = StructNew()>
			</cfif>
		<cfelse>

			<cfset local.myStruct = StructNew()>
			<cfset local.myStruct.foo = "bar">
			<cfset local.result = myStruct>
		</cfif>
		<cfreturn local.result>
	</cffunction>

</cfcomponent>
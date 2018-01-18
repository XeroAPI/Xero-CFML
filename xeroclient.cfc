
<cfcomponent displayname="xeroclient">

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
		
		<cfset oRequestResult = CreateObject("component", "cfc.xero").init().requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "GET",
			sIfModifiedSince = this.getModifiedSince())>

		<cfif NOT isJSON(oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>

		<cfset rawResult = deserializeJson(oRequestResult["RESPONSE"])>

		<cfif structKeyExists(rawResult,"ErrorNumber")>
			<cfthrow errorCode='400' message="#rawResult["Message"]#" Type='#rawResult["Type"]#' detail="#serializeJSON(rawResult["Elements"][1]["ValidationErrors"])#">
		</cfif>

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

		<cfset oRequestResult = CreateObject("component", "cfc.xero").init().requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "PUT",
			sBody = arguments.body)>

		<cfif NOT isJSON(oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>

		<cfset rawResult = deserializeJson(oRequestResult["RESPONSE"])>

		<cfif structKeyExists(rawResult,"ErrorNumber")>
			<cfthrow errorCode='400' message="#rawResult["Message"]#" Type='#rawResult["Type"]#' detail="#serializeJSON(rawResult["Elements"][1]["ValidationErrors"])#">
		</cfif>

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

		<cfset oRequestResult = CreateObject("component", "cfc.xero").init().requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "POST",
			sBody = arguments.body)>

		<cfif NOT isJSON(oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>
	
		<cfset rawResult = deserializeJson(oRequestResult["RESPONSE"])>

		<cfif structKeyExists(rawResult,"ErrorNumber")>
			<cfthrow errorCode='400' message="#rawResult["Message"]#" Type='#rawResult["Type"]#' detail="#serializeJSON(rawResult["Elements"][1]["ValidationErrors"])#">			
		</cfif>

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

		<cfset oRequestResult = CreateObject("component", "cfc.xero").init().requestData(
			sResourceEndpoint = this.getBaseURL() & resource,
			stParameters= this.getParameters(),
			sAccept = arguments.accept,
			sMethod = "DELETE",
			sBody = arguments.body)>


		<cfif NOT isJSON(oRequestResult["RESPONSE"])>
			<cfthrow errorCode='401' message="#oRequestResult["RESPONSE"]#" Type='Application'>
		</cfif>
		<cfif len(oRequestResult["RESPONSE"]) GT 0 >
			<cfset rawResult = deserializeJson(oRequestResult["RESPONSE"])>
			<cfif structKeyExists(rawResult,"ErrorNumber")>
				<cfthrow errorCode='#rawResult["ErrorNumber"]#' message="#rawResult["Message"]#" Type='#rawResult["Type"]#'>
			</cfif>

			<cfif isJSON(variables.oRequestResult["RESPONSE"])>
				<cfif StructKeyExists(rawResult,"Deleted")>
					<cfset variables.result = StructNew()>
				<cfelseif StructKeyExists(rawResult,arguments.endpoint)>
					<cfset variables.result = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.endpoint]>
				<cfelseif StructKeyExists(rawResult,arguments.child)>
					<cfset variables.result = deserializeJson(variables.oRequestResult["RESPONSE"])[arguments.child]>
				<cfelse>
					<cfthrow errorCode='400' message="#oRequestResult["RESPONSE"]["Message"]#" Type='#oRequestResult["RESPONSE"]["Type"]#' >	
					
				</cfif>
			<cfelse>
				<cfset variables.result = StructNew()>
			</cfif>
		<cfelse>

			<cfset myStruct = StructNew()>
			<cfset myStruct.foo = "bar">
			<cfset variables.result = myStruct>
		</cfif>
		<cfreturn variables.result>
	</cffunction>

</cfcomponent>
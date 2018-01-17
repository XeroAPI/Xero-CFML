<cfcomponent displayname="Storage" output="false"  hint="I am the Storage Class.">

<!--- PROPERTIES --->

  <cfproperty name="request_oauth_token" type="String" default="" />
  <cfproperty name="request_oauth_token_secret" type="String" default="" />
  <cfproperty name="oauth_token" type="String" default="" />
  <cfproperty name="oauth_token_secret" type="String" default="" />
  <cfproperty name="oauth_verifier" type="String" default="" />
  <cfproperty name="timestamp" type="String" default="" />
  <cfproperty name="oauth_session_handle" type="String" default="" />
  <cfproperty name="oauth_expires_in" type="String" default="" />
  
<!--- INIT --->
	<cffunction name="init" access="public" output="false" returntype="storage" hint="I am the constructor method for the Storage Class.">
    	<cfreturn this />
  	</cffunction>

  	<cffunction name="getRequestOAuthToken" access="public" returntype="string">
		<cfset variables.request_oauth_token = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.request_oauth_token = session.stToken["request_oauth_token"]> 	
		</cfif>
		<cfreturn variables.request_oauth_token>
	</cffunction>

	<cffunction name="setRequestOAuthToken" access="public" >
		<cfargument name="request_oauth_token" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private">
			<cfset session.stToken["request_oauth_token"] = arguments.request_oauth_token> 	
		</cfif>
	</cffunction>

	<cffunction name="getRequestOAuthTokenSecret" access="public" returntype="string">
		<cfset variables.request_oauth_token_secret = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.request_oauth_token_secret = session.stToken["request_oauth_token_secret"]> 
		</cfif>
		<cfreturn variables.request_oauth_token_secret>
	</cffunction>

	<cffunction name="setRequestOAuthTokenSecret" access="public" >
		<cfargument name="request_oauth_token_secret" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private">
			<cfset session.stToken["request_oauth_token_secret"] = arguments.request_oauth_token_secret> 	
		</cfif>
	</cffunction>

	<cffunction name="getOAuthToken" access="public" returntype="string">
		<cfset variables.oauth_token = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_token = session.stToken["oauth_token"]> 	
		</cfif>
		<cfreturn variables.oauth_token>
	</cffunction>

	<cffunction name="setOAuthToken" access="public" >
		<cfargument name="oauth_token" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset session.stToken["oauth_token"] = arguments.oauth_token> 	
		</cfif>
	</cffunction>

	<cffunction name="getOAuthTokenSecret" access="public" returntype="string">
		<cfset variables.oauth_token_secret = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_token_secret = session.stToken["oauth_token_secret"]> 
		</cfif>
		<cfreturn variables.oauth_token_secret>
	</cffunction>

	<cffunction name="setOAuthTokenSecret" access="public" >
		<cfargument name="oauth_token_secret" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset session.stToken["oauth_token_secret"] = arguments.oauth_token_secret> 	
		</cfif>
	</cffunction>

	<cffunction name="getTimestamp" access="public" returntype="string">
		<cfset variables.timestamp = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.timestamp = session.stToken["timestamp"]> 	
		</cfif>
		<cfreturn variables.timestamp>
	</cffunction>

	<cffunction name="setTimestamp" access="public" >
		<cfargument name="timestamp" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset session.stToken["timestamp"] = arguments.timestamp> 	
		</cfif>
	</cffunction>

	<cffunction name="getOAuthExpiresIn" access="public" returntype="string">
		<cfset variables.oauth_expires_in = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_expires_in = session.stToken["oauth_expires_in"]> 
		</cfif>
		<cfreturn variables.oauth_expires_in>
	</cffunction>

	<cffunction name="setOAuthExpiresIn" access="public" >
		<cfargument name="oauth_expires_in" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset session.stToken["oauth_expires_in"] = arguments.oauth_expires_in> 	
		</cfif>
	</cffunction>

	<cffunction name="getOAuthSessionHandle" access="public" returntype="string">
		<cfset variables.oauth_session_handle = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_session_handle = session.stToken["oauth_session_handle"]> 
		</cfif>
		<cfreturn variables.oauth_session_handle>
	</cffunction>

	<cffunction name="setOAuthSessionHandle" access="public" >
		<cfargument name="oauth_session_handle" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset session.stToken["oauth_session_handle"] = arguments.oauth_session_handle> 	
		</cfif>
	</cffunction>

	<cffunction name="getVerifier" access="public" returntype="string">
		<cfset variables.oauth_verifier = ""> 
		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset variables.oauth_verifier = session.stToken["oauth_verifier"]> 
		</cfif>
		<cfreturn variables.oauth_verifier>
	</cffunction>

	<cffunction name="setVerifier" access="public" >
		<cfargument name="oauth_verifier" required="true" type="String" default="" hint="I am a string of this object." />

		<cfif application.config["AppType"] NEQ "Private" AND StructKeyExists(session, "stToken")>
			<cfset session.stToken["oauth_verifier"] = arguments.oauth_verifier> 	
		</cfif>
	</cffunction>

	<cffunction name="saveRequestToken" access="public" >
		<cfargument name="response" required="true" type="String" default="" hint="I am a string of this object." />

		<cfloop list="#arguments.response#" index="elem" delimiters="&">  
			<cfif #listFirst(elem,"=")# EQ "oauth_token">
				<cfset this.setRequestOAuthToken(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_token_secret">
				<cfset this.setRequestOAuthTokenSecret(listLast(elem,"="))>
			</cfif>
		</cfloop>  
	</cffunction>

	<cffunction name="saveCallback" access="public" >
		<cfargument name="response" required="true" type="String" default="" hint="I am a string of this object." />

		<cfloop list="#arguments.response#" index="elem" delimiters="&">  
			<cfif #listFirst(elem,"=")# EQ "oauth_token">
				<cfset this.setOAuthToken(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_token_secret">
				<cfset this.setOAuthTokenSecret(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_verifier">
				<cfset this.setVerifier(listLast(elem,"="))>
			</cfif>
		</cfloop>  
	</cffunction>

	<cffunction name="saveAccessToken" access="public" >
		<cfargument name="response" required="true" type="String" default="" hint="I am a string of this object." />

		<cfloop list="#arguments.response#" index="elem" delimiters="&">  
			<cfif #listFirst(elem,"=")# EQ "oauth_token">
				<cfset this.setOAuthToken(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_token_secret">
				<cfset this.setOAuthTokenSecret(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_verifier">
				<cfset this.setVerifier(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_session_handle">
				<cfset this.setOAuthSessionHandle(listLast(elem,"="))>
			</cfif>
			<cfif #listFirst(elem,"=")# EQ "oauth_expires_in">
				<cfset this.setOAuthExpiresIn(listLast(elem,"="))>
			</cfif>
		</cfloop>  
	</cffunction>

	<cffunction name="clear" access="public" >
		<cfset session.stToken = structNew()> 
		<cfset session.stCallbackResult = structNew()> 	
	</cffunction>

</cfcomponent>
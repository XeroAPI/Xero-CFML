<cfcomponent
    displayname="XeroCFMLWrapper"
    output="true"
    hint="CFML wrapper for Xero application.">
 
 
    <!--- Set up the application. --->
    <cfset THIS.Name = "XeroCFMLAppCFC" />
    <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 3, 0 ) />
    <cfset THIS.SessionManagement = true />
    <cfset THIS.SetClientCookies = true />

    <cfset this.mappings = structNew() />
    <cfset this.mappings["/cfc"] = getDirectoryFromPath(getCurrentTemplatePath()) & "cfc/" />
    <cfset this.mappings["/common"] = getDirectoryFromPath(getCurrentTemplatePath()) & "common/" />
    <cfset this.mappings["/resources"] = getDirectoryFromPath(getCurrentTemplatePath()) & "resources/" />
 
    <!--- Define the page request properties. --->
    <cfsetting
        requesttimeout="20"
        showdebugoutput="true"
        enablecfoutputonly="false"
        />
 
    <cffunction
        name="OnApplicationStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="Fires when the application is first created.">
        
        <cfset application.basePath = GetBaseTemplatePath() />

        <cfset pathToConfigJSON = getDirectoryFromPath(getCurrentTemplatePath()) & "resources/config.json">
        <cfset application.config = CreateObject("component", "cfc.config").init(pathToConfigJSON)>

        <!--- Return out. --->
        <cfreturn true />
    </cffunction>
 
 
    <cffunction
        name="OnSessionStart"
        access="public"
        returntype="void"
        output="false"
        hint="Fires when the session is first created.">

        <!--- Return out. --->
        <cfreturn />
    </cffunction>
 
 
    <cffunction
        name="OnRequestStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="Fires at first part of page processing.">
 


        <!--- Define arguments. --->
        <cfargument
            name="TargetPage"
            type="string"
            required="true"
            />

        <!--- Return out. --->
        <cfreturn true />
    </cffunction>
 
 
    <cffunction
        name="OnRequest"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after pre page processing is complete.">
 
        <!--- Define arguments. --->
        <cfargument
            name="TargetPage"
            type="string"
            required="true"
            />
        
 
        <!--- Include the requested page. --->
        <cfinclude template="#ARGUMENTS.TargetPage#" />


       
 
        <!--- Return out. --->
        <cfreturn />
    </cffunction>
 
 
    <cffunction
        name="OnRequestEnd"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after the page processing is complete.">
 
        <!--- Return out. --->
        <cfreturn />
    </cffunction>
 
 
    <cffunction
        name="OnSessionEnd"
        access="public"
        returntype="void"
        output="false"
        hint="Fires when the session is terminated.">
 
        <!--- Define arguments. --->
        <cfargument
            name="SessionScope"
            type="struct"
            required="true"
            />
 
        <cfargument
            name="ApplicationScope"
            type="struct"
            required="false"
            default="#StructNew()#"
            />
 
        <!--- Return out. --->
        <cfreturn />
    </cffunction>
 
 
    <cffunction
        name="OnApplicationEnd"
        access="public"
        returntype="void"
        output="false"
        hint="Fires when the application is terminated.">
 
        <!--- Define arguments. --->
        <cfargument
            name="ApplicationScope"
            type="struct"
            required="false"
            default="#StructNew()#"
            />
 
        <!--- Return out. --->
        <cfreturn />
    </cffunction>
 
 
    <cffunction
        name="OnError"
        access="public"
        returntype="void"
        output="true"
        hint="Fires when an exception occures that is not caught by a try/catch.">
 
        <!--- Define arguments. --->
        <cfargument
            name="Exception"
            type="any"
            required="true"
            />
 
        <cfargument
            name="EventName"
            type="string"
            required="false"
            default=""
            />
            
            <cfdump var="#Exception#" >
        <!--- Return out. --->
        <cfreturn />
    </cffunction>
 
</cfcomponent>
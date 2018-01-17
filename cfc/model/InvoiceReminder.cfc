<cfcomponent displayname="InvoiceReminder" output="false" extends="cfc.xeroclient"
  hint="I am the InvoiceReminder Class.">

<!--- PROPERTIES --->

  <cfproperty name="Enabled" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the InvoiceReminder Class.">
      
    <cfreturn this />
  </cffunction>


  <cffunction name="XMLtoObject" access="public" output="false">
     <cfargument name="objects" required="true" type="struct" default="" hint="I am a structure of this object." />

      <cfif isArray(arguments.objects)>
        <cfloop array="#arguments.objects#" index="obj">
          <cfscript>
            populate(obj);
          </cfscript>
        </cfloop>
      <cfelse>
        <cfscript>
          return populate(arguments.objects);
        </cfscript>
     </cfif>
  </cffunction>
  
  <cffunction name="toStruct" access="public" output="false">
        <cfscript>
          myStruct=StructNew();
          myStruct=this.toJSON(returnType="struct");
        </cfscript>
    <cfreturn myStruct />
  </cffunction>

  <cffunction name="toJSON" access="public" output="false">
     <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON payload" />
     <cfargument name="archive" type="boolean" default="false" hint="I flag to return only the req. fields as JSON payload for archiving an object" />
     <cfargument name="returnType" type="String" default="json" hint="I set how the data is returned" />
     
        <cfscript>
          myStruct=StructNew();
          if (structKeyExists(variables.instance,"Enabled")) {
            if (NOT listFindNoCase(arguments.exclude, "Enabled")) {
              myStruct.Enabled=getEnabled();
            }
          }
        </cfscript>

    <cfif returnType EQ "Struct">
       <cfreturn myStruct />
    <cfelse>
      <cfset variables.jsonObj = serializeJSON(myStruct)>
      <cfreturn variables.jsonObj />
    </cfif>
  </cffunction>

  <cffunction name="populate" access="public" output="false">
     <cfargument name="objects" required="true" type="struct" default="" hint="I am a structure of this object." />

        <cfset obj = arguments.objects>
        <cfscript> 
        if (structKeyExists(obj,"Enabled")) {
          setEnabled(obj.Enabled);
        } else {
          setEnabled("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
      <cfset this.setList(this.get(endpoint="InvoiceReminders",child="Settings"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getObject" access="public" returntype="any">
    <cfargument name="position"  type="numeric" default="">
      <cfscript>
        this.populate(this.getList()[position]);
      </cfscript> 
    <cfreturn this>
  </cffunction>

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Currencies">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
      <cfset this.getObject(1)>
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Currencies">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Name of InvoiceReminder
   * @return Enabled
  --->
  <cffunction name="getEnabled" access="public" output="false" hint="I return the Enabled">
    <cfreturn variables.instance.Enabled />
  </cffunction>

  <cffunction name="setEnabled" access="public"  output="false" hint="I set the Enabled into the variables.instance scope.">
    <cfargument name="Enabled" type="String" hint="I am the Enabled." />
      <cfset variables.instance.Enabled = arguments.Enabled />
  </cffunction>

  <cffunction name="getMemento" access="public"
    output="false" hint="I return a dumped struct of the
    variables.instance scope.">
    <cfreturn variables.instance />
  </cffunction>

</cfcomponent>   




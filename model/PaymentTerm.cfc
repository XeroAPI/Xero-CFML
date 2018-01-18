<cfcomponent displayname="PaymentTerm" output="false" extends="cfc.xeroclient"
  hint="I am the PaymentTerm Class.">

<!--- PROPERTIES --->

  <cfproperty name="Day" type="String" default="" />
  <cfproperty name="Type" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the PaymentTerm Class.">
      
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
    <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON" />
    <cfif len(arguments.exclude) GT 0>
      <cfset exclude = arguments.exclude>
    <cfelse>
      <cfset exclude = "">
    </cfif>

      <cfscript>
        myStruct=StructNew();
        myStruct=this.toJSON(exclude=exclude,returnType="struct");
      </cfscript>
    <cfreturn myStruct />
  </cffunction>

  <cffunction name="toJSON" access="public" output="false">
     <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON payload" />
     <cfargument name="archive" type="boolean" default="false" hint="I flag to return only the req. fields as JSON payload for archiving an object" />
     <cfargument name="returnType" type="String" default="json" hint="I set how the data is returned" />
     
        <cfscript>
          myStruct=StructNew();
          if (archive) {
            myStruct.PaymentTermID=getPaymentTermID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Day")) {
              if (NOT listFindNoCase(arguments.exclude, "Day")) {
                myStruct.Day=getDay();
              }
            }
            if (structKeyExists(variables.instance,"Type")) {
              if (NOT listFindNoCase(arguments.exclude, "Type")) {
                myStruct.Type=getType();
              }
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

        if (structKeyExists(obj,"Day")) {
          setDay(obj.Day);
        } else {
          setDay("");
        }
        if (structKeyExists(obj,"Type")) {
          setType(obj.Type);
        } else {
          setType("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="PaymentTerms"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="PaymentTerms",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="PaymentTerms",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="PaymentTerms",body=this.toJSON(),id=this.getPaymentTermID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="PaymentTerms",body=this.toJSON(archive=true),id=this.getPaymentTermID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="PaymentTerms",body=this.toJSON(),id=this.getPaymentTermID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="getObject" access="public" returntype="any">
    <cfargument name="position"  type="numeric" default="">
      <cfscript>
        this.populate(this.getList()[position]);
      </cfscript> 
    <cfreturn this>
  </cffunction>

  <cffunction name="setList" access="public"  output="false" hint="I set the array of PaymentTerms">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of PaymentTerms">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * number of days for the payment term
   * @return Day
  --->
  <cffunction name="getDay" access="public" output="false" hint="I return the Day">
    <cfreturn variables.instance.Day />
  </cffunction>

  <cffunction name="setDay" access="public"  output="false" hint="I set the Day into the variables.instance scope.">
    <cfargument name="Day" type="String" hint="I am the Day." />
      <cfset variables.instance.Day = arguments.Day />
  </cffunction>

  <!---
   * type of payment terms
   * @return Type
  --->
  <cffunction name="getType" access="public" output="false" hint="I return the Type">
    <cfreturn variables.instance.Type />
  </cffunction>

  <cffunction name="setType" access="public"  output="false" hint="I set the Type into the variables.instance scope.">
    <cfargument name="Type" type="String" hint="I am the Type." />
      <cfset variables.instance.Type = arguments.Type />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


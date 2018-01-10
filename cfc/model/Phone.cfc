<cfcomponent displayname="Phone" output="false" extends="cfc.xeroclient"
  hint="I am the Phone Class.">

<!--- PROPERTIES --->

  <cfproperty name="PhoneNumber" type="String" default="" />
  <cfproperty name="PhoneAreaCode" type="String" default="" />
  <cfproperty name="PhoneCountryCode" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Phone Class.">
      
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
            myStruct.PhoneID=getPhoneID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"PhoneNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "PhoneNumber")) {
                myStruct.PhoneNumber=getPhoneNumber();
              }
            }
            if (structKeyExists(variables.instance,"PhoneAreaCode")) {
              if (NOT listFindNoCase(arguments.exclude, "PhoneAreaCode")) {
                myStruct.PhoneAreaCode=getPhoneAreaCode();
              }
            }
            if (structKeyExists(variables.instance,"PhoneCountryCode")) {
              if (NOT listFindNoCase(arguments.exclude, "PhoneCountryCode")) {
                myStruct.PhoneCountryCode=getPhoneCountryCode();
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

        if (structKeyExists(obj,"PhoneNumber")) {
          setPhoneNumber(obj.PhoneNumber);
        } else {
          setPhoneNumber("");
        }
        if (structKeyExists(obj,"PhoneAreaCode")) {
          setPhoneAreaCode(obj.PhoneAreaCode);
        } else {
          setPhoneAreaCode("");
        }
        if (structKeyExists(obj,"PhoneCountryCode")) {
          setPhoneCountryCode(obj.PhoneCountryCode);
        } else {
          setPhoneCountryCode("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="Phones"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Phones",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Phones",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Phones",body=this.toJSON(),id=this.getPhoneID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Phones",body=this.toJSON(archive=true),id=this.getPhoneID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Phones",body=this.toJSON(),id=this.getPhoneID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Phones">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Phones">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * max length = 50
   * @return PhoneNumber
  --->
  <cffunction name="getPhoneNumber" access="public" output="false" hint="I return the PhoneNumber">
    <cfreturn variables.instance.PhoneNumber />
  </cffunction>

  <cffunction name="setPhoneNumber" access="public"  output="false" hint="I set the PhoneNumber into the variables.instance scope.">
    <cfargument name="PhoneNumber" type="String" hint="I am the PhoneNumber." />
      <cfset variables.instance.PhoneNumber = arguments.PhoneNumber />
  </cffunction>

  <!---
   * max length = 10
   * @return PhoneAreaCode
  --->
  <cffunction name="getPhoneAreaCode" access="public" output="false" hint="I return the PhoneAreaCode">
    <cfreturn variables.instance.PhoneAreaCode />
  </cffunction>

  <cffunction name="setPhoneAreaCode" access="public"  output="false" hint="I set the PhoneAreaCode into the variables.instance scope.">
    <cfargument name="PhoneAreaCode" type="String" hint="I am the PhoneAreaCode." />
      <cfset variables.instance.PhoneAreaCode = arguments.PhoneAreaCode />
  </cffunction>

  <!---
   * max length = 20
   * @return PhoneCountryCode
  --->
  <cffunction name="getPhoneCountryCode" access="public" output="false" hint="I return the PhoneCountryCode">
    <cfreturn variables.instance.PhoneCountryCode />
  </cffunction>

  <cffunction name="setPhoneCountryCode" access="public"  output="false" hint="I set the PhoneCountryCode into the variables.instance scope.">
    <cfargument name="PhoneCountryCode" type="String" hint="I am the PhoneCountryCode." />
      <cfset variables.instance.PhoneCountryCode = arguments.PhoneCountryCode />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


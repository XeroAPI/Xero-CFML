<cfcomponent displayname="ContactPerson" output="false" extends="cfc.xeroclient"
  hint="I am the ContactPerson Class.">

<!--- PROPERTIES --->
  <cfproperty name="FirstName" type="String" default="" />
  <cfproperty name="LastName" type="String" default="" />
  <cfproperty name="EmailAddress" type="String" default="" />
  <cfproperty name="IncludeInEmails" type="Boolean" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the ContactPerson Class.">
      
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
          if (archive) {
            myStruct.ContactPersonID=getContactPersonID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"FirstName")) {
              if (NOT listFindNoCase(arguments.exclude, "FirstName")) {
                myStruct.FirstName=getFirstName();
              }
            }
            if (structKeyExists(variables.instance,"LastName")) {
              if (NOT listFindNoCase(arguments.exclude, "LastName")) {
                myStruct.LastName=getLastName();
              }
            }
            if (structKeyExists(variables.instance,"EmailAddress")) {
              if (NOT listFindNoCase(arguments.exclude, "EmailAddress")) {
                myStruct.EmailAddress=getEmailAddress();
              }
            }
            if (structKeyExists(variables.instance,"IncludeInEmails")) {
              if (NOT listFindNoCase(arguments.exclude, "IncludeInEmails")) {
                myStruct.IncludeInEmails=getIncludeInEmails();
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

        if (structKeyExists(obj,"FirstName")) {
          setFirstName(obj.FirstName);
        } else {
          setFirstName("");
        }
        if (structKeyExists(obj,"LastName")) {
          setLastName(obj.LastName);
        } else {
          setLastName("");
        }
        if (structKeyExists(obj,"EmailAddress")) {
          setEmailAddress(obj.EmailAddress);
        } else {
          setEmailAddress("");
        }
        if (structKeyExists(obj,"IncludeInEmails")) {
          setIncludeInEmails(obj.IncludeInEmails);
        } else {
          setIncludeInEmails(false);
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="ContactPersons"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="ContactPersons",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="ContactPersons",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ContactPersons",body=this.toJSON(),id=this.getContactPersonID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ContactPersons",body=this.toJSON(archive=true),id=this.getContactPersonID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="ContactPersons",body=this.toJSON(),id=this.getContactPersonID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of ContactPersons">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of ContactPersons">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * First name of person
   * @return FirstName
  --->
  <cffunction name="getFirstName" access="public" output="false" hint="I return the FirstName">
    <cfreturn variables.instance.FirstName />
  </cffunction>

  <cffunction name="setFirstName" access="public"  output="false" hint="I set the FirstName into the variables.instance scope.">
    <cfargument name="FirstName" type="String" hint="I am the FirstName." />
      <cfset variables.instance.FirstName = arguments.FirstName />
  </cffunction>

  <!---
   * Last name of person
   * @return LastName
  --->
  <cffunction name="getLastName" access="public" output="false" hint="I return the LastName">
    <cfreturn variables.instance.LastName />
  </cffunction>

  <cffunction name="setLastName" access="public"  output="false" hint="I set the LastName into the variables.instance scope.">
    <cfargument name="LastName" type="String" hint="I am the LastName." />
      <cfset variables.instance.LastName = arguments.LastName />
  </cffunction>

  <!---
   * Email address of person
   * @return EmailAddress
  --->
  <cffunction name="getEmailAddress" access="public" output="false" hint="I return the EmailAddress">
    <cfreturn variables.instance.EmailAddress />
  </cffunction>

  <cffunction name="setEmailAddress" access="public"  output="false" hint="I set the EmailAddress into the variables.instance scope.">
    <cfargument name="EmailAddress" type="String" hint="I am the EmailAddress." />
      <cfset variables.instance.EmailAddress = arguments.EmailAddress />
  </cffunction>

  <!---
   * boolean to indicate whether contact should be included on emails with invoices etc.
   * @return IncludeInEmails
  --->
  <cffunction name="getIncludeInEmails" access="public" output="false" hint="I return the IncludeInEmails">
    <cfreturn variables.instance.IncludeInEmails />
  </cffunction>

  <cffunction name="setIncludeInEmails" access="public"  output="false" hint="I set the IncludeInEmails into the variables.instance scope.">
    <cfargument name="IncludeInEmails" type="Boolean" hint="I am the IncludeInEmails." />
      <cfset variables.instance.IncludeInEmails = arguments.IncludeInEmails />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   




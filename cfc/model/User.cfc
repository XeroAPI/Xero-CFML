<cfcomponent displayname="User" output="false" extends="cfc.xeroclient"
  hint="I am the User Class.">

<!--- PROPERTIES --->

  <cfproperty name="UserID" type="String" default="" />
  <cfproperty name="EmailAddress" type="String" default="" />
  <cfproperty name="FirstName" type="String" default="" />
  <cfproperty name="LastName" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="IsSubscriber" type="Boolean" default="" />
  <cfproperty name="OrganisationRole" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the User Class.">
      <cfset populate(StructNew())>
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
            myStruct.UserID=getUserID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"UserID")) {
              if (NOT listFindNoCase(arguments.exclude, "UserID")) {
                myStruct.UserID=getUserID();
              }
            }
            if (structKeyExists(variables.instance,"EmailAddress")) {
              if (NOT listFindNoCase(arguments.exclude, "EmailAddress")) {
                myStruct.EmailAddress=getEmailAddress();
              }
            }
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
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct.UpdatedDateUTC=getUpdatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"IsSubscriber")) {
              if (NOT listFindNoCase(arguments.exclude, "IsSubscriber")) {
                myStruct.IsSubscriber=getIsSubscriber();
              }
            }
            if (structKeyExists(variables.instance,"OrganisationRole")) {
              if (NOT listFindNoCase(arguments.exclude, "OrganisationRole")) {
                myStruct.OrganisationRole=getOrganisationRole();
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

        if (structKeyExists(obj,"UserID")) {
          setUserID(obj.UserID);
        } else {
          setUserID("");
        }
        if (structKeyExists(obj,"EmailAddress")) {
          setEmailAddress(obj.EmailAddress);
        } else {
          setEmailAddress("");
        }
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
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"IsSubscriber")) {
          setIsSubscriber(obj.IsSubscriber);
        } else {
          setIsSubscriber(false);
        }
        if (structKeyExists(obj,"OrganisationRole")) {
          setOrganisationRole(obj.OrganisationRole);
        } else {
          setOrganisationRole("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
    <cfargument name="where"  type="string" default="">
    <cfargument name="order"  type="string" default="">

      <cfset stParam = StructNew()>
      <cfset stParam["where"] = arguments.where>
      <cfset stParam["order"] = arguments.order>
      <cfset this.setParameters(stParam)>    
      <cfset this.setModifiedSince(arguments.ifModifiedSince)>
      
      <cfset this.setList(this.get(endpoint="Users"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Users",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Users",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Users",body=this.toJSON(),id=this.getUserID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Users",body=this.toJSON(archive=true),id=this.getUserID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Users",body=this.toJSON(),id=this.getUserID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Users">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Users">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Xero identifier
   * @return UserID
  --->
  <cffunction name="getUserID" access="public" output="false" hint="I return the UserID">
    <cfreturn variables.instance.UserID />
  </cffunction>

  <cffunction name="setUserID" access="public"  output="false" hint="I set the UserID into the variables.instance scope.">
    <cfargument name="UserID" type="String" hint="I am the UserID." />
      <cfset variables.instance.UserID = arguments.UserID />
  </cffunction>

  <!---
   * Email address of user
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
   * First name of user
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
   * Last name of user
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
   * Timestamp of last change to user
   * @return UpdatedDateUTC
  --->
  <cffunction name="getUpdatedDateUTC" access="public" output="false" hint="I return the UpdatedDateUTC">
    <cfreturn variables.instance.UpdatedDateUTC />
  </cffunction>

  <cffunction name="setUpdatedDateUTC" access="public"  output="false" hint="I set the UpdatedDateUTC into the variables.instance scope.">
    <cfargument name="UpdatedDateUTC" type="String" hint="I am the UpdatedDateUTC." />
      <cfset variables.instance.UpdatedDateUTC = arguments.UpdatedDateUTC />
  </cffunction>

  <!---
   * Boolean to indicate if user is the subscriber
   * @return IsSubscriber
  --->
  <cffunction name="getIsSubscriber" access="public" output="false" hint="I return the IsSubscriber">
    <cfreturn variables.instance.IsSubscriber />
  </cffunction>

  <cffunction name="setIsSubscriber" access="public"  output="false" hint="I set the IsSubscriber into the variables.instance scope.">
    <cfargument name="IsSubscriber" type="Boolean" hint="I am the IsSubscriber." />
      <cfset variables.instance.IsSubscriber = arguments.IsSubscriber />
  </cffunction>

  <!---
   * User role (see Types)
   * @return OrganisationRole
  --->
  <cffunction name="getOrganisationRole" access="public" output="false" hint="I return the OrganisationRole">
    <cfreturn variables.instance.OrganisationRole />
  </cffunction>

  <cffunction name="setOrganisationRole" access="public"  output="false" hint="I set the OrganisationRole into the variables.instance scope.">
    <cfargument name="OrganisationRole" type="String" hint="I am the OrganisationRole." />
      <cfset variables.instance.OrganisationRole = arguments.OrganisationRole />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


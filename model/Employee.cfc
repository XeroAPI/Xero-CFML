<cfcomponent displayname="Employee" output="false" extends="xeroclient"
  hint="I am the Employee Class.">

<!--- PROPERTIES --->

  <cfproperty name="EmployeeID" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="FirstName" type="String" default="" />
  <cfproperty name="LastName" type="String" default="" />
  <cfproperty name="ExternalLink" type="array" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Employee Class.">
    <cfargument name="xero" type="any">
    <cfset variables.xero = arguments.xero>
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
            myStruct["EmployeeID"]=getEmployeeID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"EmployeeID")) {
              if (NOT listFindNoCase(arguments.exclude, "EmployeeID")) {
                myStruct["EmployeeID"]=getEmployeeID();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"FirstName")) {
              if (NOT listFindNoCase(arguments.exclude, "FirstName")) {
                myStruct["FirstName"]=getFirstName();
              }
            }
            if (structKeyExists(variables.instance,"LastName")) {
              if (NOT listFindNoCase(arguments.exclude, "LastName")) {
                myStruct["LastName"]=getLastName();
              }
            }
            if (structKeyExists(variables.instance,"ExternalLink")) {
              if (NOT listFindNoCase(arguments.exclude, "ExternalLink")) {
                if (NOT structIsEmpty(getExternalLink())){
                  myStruct["ExternalLink"]=getExternalLink();
                }
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

        if (structKeyExists(obj,"EmployeeID")) {
          setEmployeeID(obj.EmployeeID);
        } else {
          setEmployeeID("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
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
        if (structKeyExists(obj,"ExternalLink")) {
          setExternalLink(obj.ExternalLink);
        } else {
          setExternalLink(StructNew());
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
      
      <cfset this.setList(this.get(endpoint="Employees"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Employees",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Employees",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Employees",body=this.toJSON(),id=this.getEmployeeID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Employees",body=this.toJSON(archive=true),id=this.getEmployeeID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Employees",body=this.toJSON(),id=this.getEmployeeID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Employees">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Employees">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * The Xero identifier for an employee e.g. 297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return EmployeeID
  --->
  <cffunction name="getEmployeeID" access="public" output="false" hint="I return the EmployeeID">
    <cfreturn variables.instance.EmployeeID />
  </cffunction>

  <cffunction name="setEmployeeID" access="public"  output="false" hint="I set the EmployeeID into the variables.instance scope.">
    <cfargument name="EmployeeID" type="String" hint="I am the EmployeeID." />
      <cfset variables.instance.EmployeeID = arguments.EmployeeID />
  </cffunction>

  <!---
   * Current status of an employee – see contact status types
   * @return Status
  --->
  <cffunction name="getStatus" access="public" output="false" hint="I return the Status">
    <cfreturn variables.instance.Status />
  </cffunction>

  <cffunction name="setStatus" access="public"  output="false" hint="I set the Status into the variables.instance scope.">
    <cfargument name="Status" type="String" hint="I am the Status." />
      <cfset variables.instance.Status = arguments.Status />
  </cffunction>

  <!---
   * First name of an employee (max length = 255)
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
   * Last name of an employee (max length = 255)
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
   * See ExternalLink
   * @return ExternalLink
  --->
  <cffunction name="getExternalLink" access="public" output="false" hint="I return the ExternalLink">
    <cfreturn variables.instance.ExternalLink />
  </cffunction>

  <cffunction name="setExternalLink" access="public"  output="false" hint="I set the ExternalLink into the variables.instance scope.">
    <cfargument name="ExternalLink" type="Struct" hint="I am the ExternalLink." />
      <cfset variables.instance.ExternalLink = arguments.ExternalLink />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



<cfcomponent displayname="BankAccount" output="false" extends="cfc.xeroclient"
  hint="I am the BankAccount Class.">

<!--- PROPERTIES --->

  <cfproperty name="Code" type="String" default="" />
  <cfproperty name="AccountID" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />

  <!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the BankAccount Class.">
      
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
            myStruct.BankAccountID=getBankAccountID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Code")) {
              if (NOT listFindNoCase(arguments.exclude, "Code")) {
                myStruct.Code=getCode();
              }
            }
            if (structKeyExists(variables.instance,"AccountID")) {
              if (NOT listFindNoCase(arguments.exclude, "AccountID")) {
                myStruct.AccountID=getAccountID();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct.Name=getName();
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

        if (structKeyExists(obj,"Code")) {
          setCode(obj.Code);
        } else {
          setCode("");
        }
        if (structKeyExists(obj,"AccountID")) {
          setAccountID(obj.AccountID);
        } else {
          setAccountID("");
        }
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset stParam = StructNew()>
      <cfset stParam["where"] = 'Type=="BANK"'>
      <cfset this.setParameters(stParam)>
    
      <cfset this.setList(this.get(endpoint="Accounts"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Accounts",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Accounts",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Accounts",body=this.toJSON(),id=this.getBankAccountID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Accounts",body=this.toJSON(),id=this.getBankAccountID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Accounts",body=this.toJSON(),id=this.getBankAccountID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of BankAccounts">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of BankAccounts">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * The Account Code of the Bank Account
   * @return Code
  --->
  <cffunction name="getCode" access="public" output="false" hint="I return the Code">
    <cfreturn variables.instance.Code />
  </cffunction>

  <cffunction name="setCode" access="public"  output="false" hint="I set the Code into the variables.instance scope.">
    <cfargument name="Code" type="String" hint="I am the Code." />
      <cfset variables.instance.Code = arguments.Code />
  </cffunction>

  <!---
   * The ID of the Bank Account
   * @return AccountID
  --->
  <cffunction name="getAccountID" access="public" output="false" hint="I return the AccountID">
    <cfreturn variables.instance.AccountID />
  </cffunction>

  <cffunction name="setAccountID" access="public"  output="false" hint="I set the AccountID into the variables.instance scope.">
    <cfargument name="AccountID" type="String" hint="I am the AccountID." />
      <cfset variables.instance.AccountID = arguments.AccountID />
  </cffunction>

  <!---
   * The Name Bank Account
   * @return Name
  --->
  <cffunction name="getName" access="public" output="false" hint="I return the Name">
    <cfreturn variables.instance.Name />
  </cffunction>

  <cffunction name="setName" access="public"  output="false" hint="I set the Name into the variables.instance scope.">
    <cfargument name="Name" type="String" hint="I am the Name." />
      <cfset variables.instance.Name = arguments.Name />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



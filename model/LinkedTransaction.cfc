<cfcomponent displayname="LinkedTransaction" output="false" extends="xeroclient"
  hint="I am the LinkedTransaction Class.">

<!--- PROPERTIES --->

  <cfproperty name="SourceTransactionID" type="String" default="" />
  <cfproperty name="SourceLineItemID" type="String" default="" />
  <cfproperty name="ContactID" type="String" default="" />
  <cfproperty name="TargetTransactionID" type="String" default="" />
  <cfproperty name="TargetLineItemID" type="String" default="" />
  <cfproperty name="LinkedTransactionID" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="Type" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="SourceTransactionTypeCode" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the LinkedTransaction Class.">
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
            myStruct["LinkedTransactionID"]=getLinkedTransactionID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"SourceTransactionID")) {
              if (NOT listFindNoCase(arguments.exclude, "SourceTransactionID")) {
                myStruct["SourceTransactionID"]=getSourceTransactionID();
              }
            }
            if (structKeyExists(variables.instance,"SourceLineItemID")) {
              if (NOT listFindNoCase(arguments.exclude, "SourceLineItemID")) {
                myStruct["SourceLineItemID"]=getSourceLineItemID();
              }
            }
            if (structKeyExists(variables.instance,"ContactID")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactID")) {
                myStruct["ContactID"]=getContactID();
              }
            }
            if (structKeyExists(variables.instance,"TargetTransactionID")) {
              if (NOT listFindNoCase(arguments.exclude, "TargetTransactionID")) {
                myStruct["TargetTransactionID"]=getTargetTransactionID();
              }
            }
            if (structKeyExists(variables.instance,"TargetLineItemID")) {
              if (NOT listFindNoCase(arguments.exclude, "TargetLineItemID")) {
                myStruct["TargetLineItemID"]=getTargetLineItemID();
              }
            }
            if (structKeyExists(variables.instance,"LinkedTransactionID")) {
              if (NOT listFindNoCase(arguments.exclude, "LinkedTransactionID")) {
                myStruct["LinkedTransactionID"]=getLinkedTransactionID();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"Type")) {
              if (NOT listFindNoCase(arguments.exclude, "Type")) {
                myStruct["Type"]=getType();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct["UpdatedDateUTC"]=getUpdatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"SourceTransactionTypeCode")) {
              if (NOT listFindNoCase(arguments.exclude, "SourceTransactionTypeCode")) {
                myStruct["SourceTransactionTypeCode"]=getSourceTransactionTypeCode();
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

        if (structKeyExists(obj,"SourceTransactionID")) {
          setSourceTransactionID(obj.SourceTransactionID);
        } else {
          setSourceTransactionID("");
        }
        if (structKeyExists(obj,"SourceLineItemID")) {
          setSourceLineItemID(obj.SourceLineItemID);
        } else {
          setSourceLineItemID("");
        }
        if (structKeyExists(obj,"ContactID")) {
          setContactID(obj.ContactID);
        } else {
          setContactID("");
        }
        if (structKeyExists(obj,"TargetTransactionID")) {
          setTargetTransactionID(obj.TargetTransactionID);
        } else {
          setTargetTransactionID("");
        }
        if (structKeyExists(obj,"TargetLineItemID")) {
          setTargetLineItemID(obj.TargetLineItemID);
        } else {
          setTargetLineItemID("");
        }
        if (structKeyExists(obj,"LinkedTransactionID")) {
          setLinkedTransactionID(obj.LinkedTransactionID);
        } else {
          setLinkedTransactionID("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"Type")) {
          setType(obj.Type);
        } else {
          setType("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"SourceTransactionTypeCode")) {
          setSourceTransactionTypeCode(obj.SourceTransactionTypeCode);
        } else {
          setSourceTransactionTypeCode("");
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
      
      <cfset this.setList(this.get(endpoint="LinkedTransactions"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="LinkedTransactions",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="LinkedTransactions",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="LinkedTransactions",body=this.toJSON(),id=this.getLinkedTransactionID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="LinkedTransactions",body=this.toJSON(archive=true),id=this.getLinkedTransactionID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="LinkedTransactions",body=this.toJSON(),id=this.getLinkedTransactionID())>
    
      <cfset temp = this.populate(variables.result)>

    <cfreturn this />
  </cffunction>

  <cffunction name="getObject" access="public" returntype="any">
    <cfargument name="position"  type="numeric" default="">
      <cfscript>
        this.populate(this.getList()[position]);
      </cfscript> 
    <cfreturn this>
  </cffunction>

  <cffunction name="setList" access="public"  output="false" hint="I set the array of LinkedTransactions">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of LinkedTransactions">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Filter by the SourceTransactionID. Get all the linked transactions created from a particular ACCPAY invoice
   * @return SourceTransactionID
  --->
  <cffunction name="getSourceTransactionID" access="public" output="false" hint="I return the SourceTransactionID">
    <cfreturn variables.instance.SourceTransactionID />
  </cffunction>

  <cffunction name="setSourceTransactionID" access="public"  output="false" hint="I set the SourceTransactionID into the variables.instance scope.">
    <cfargument name="SourceTransactionID" type="String" hint="I am the SourceTransactionID." />
      <cfset variables.instance.SourceTransactionID = arguments.SourceTransactionID />
  </cffunction>

  <!---
   * The line item identifier from the source transaction.
   * @return SourceLineItemID
  --->
  <cffunction name="getSourceLineItemID" access="public" output="false" hint="I return the SourceLineItemID">
    <cfreturn variables.instance.SourceLineItemID />
  </cffunction>

  <cffunction name="setSourceLineItemID" access="public"  output="false" hint="I set the SourceLineItemID into the variables.instance scope.">
    <cfargument name="SourceLineItemID" type="String" hint="I am the SourceLineItemID." />
      <cfset variables.instance.SourceLineItemID = arguments.SourceLineItemID />
  </cffunction>

  <!---
   * Filter by the combination of ContactID and Status. Get all the linked transactions that have been assigned to a particular customer and have a particular status e.g. GET /LinkedTransactions?ContactID=4bb34b03-3378-4bb2-a0ed-6345abf3224e&Status=APPROVED.
   * @return ContactID
  --->
  <cffunction name="getContactID" access="public" output="false" hint="I return the ContactID">
    <cfreturn variables.instance.ContactID />
  </cffunction>

  <cffunction name="setContactID" access="public"  output="false" hint="I set the ContactID into the variables.instance scope.">
    <cfargument name="ContactID" type="String" hint="I am the ContactID." />
      <cfset variables.instance.ContactID = arguments.ContactID />
  </cffunction>

  <!---
   * Filter by the TargetTransactionID. Get all the linked transactions allocated to a particular ACCREC invoice
   * @return TargetTransactionID
  --->
  <cffunction name="getTargetTransactionID" access="public" output="false" hint="I return the TargetTransactionID">
    <cfreturn variables.instance.TargetTransactionID />
  </cffunction>

  <cffunction name="setTargetTransactionID" access="public"  output="false" hint="I set the TargetTransactionID into the variables.instance scope.">
    <cfargument name="TargetTransactionID" type="String" hint="I am the TargetTransactionID." />
      <cfset variables.instance.TargetTransactionID = arguments.TargetTransactionID />
  </cffunction>

  <!---
   * The line item identifier from the target transaction. It is possible to link multiple billable expenses to the same TargetLineItemID.
   * @return TargetLineItemID
  --->
  <cffunction name="getTargetLineItemID" access="public" output="false" hint="I return the TargetLineItemID">
    <cfreturn variables.instance.TargetLineItemID />
  </cffunction>

  <cffunction name="setTargetLineItemID" access="public"  output="false" hint="I set the TargetLineItemID into the variables.instance scope.">
    <cfargument name="TargetLineItemID" type="String" hint="I am the TargetLineItemID." />
      <cfset variables.instance.TargetLineItemID = arguments.TargetLineItemID />
  </cffunction>

  <!---
   * The Xero identifier for an Linked Transaction e.g. /LinkedTransactions/297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return LinkedTransactionID
  --->
  <cffunction name="getLinkedTransactionID" access="public" output="false" hint="I return the LinkedTransactionID">
    <cfreturn variables.instance.LinkedTransactionID />
  </cffunction>

  <cffunction name="setLinkedTransactionID" access="public"  output="false" hint="I set the LinkedTransactionID into the variables.instance scope.">
    <cfargument name="LinkedTransactionID" type="String" hint="I am the LinkedTransactionID." />
      <cfset variables.instance.LinkedTransactionID = arguments.LinkedTransactionID />
  </cffunction>

  <!---
   * Filter by the combination of ContactID and Status. Get all the linked transactions that have been assigned to a particular customer and have a particular status e.g. GET /LinkedTransactions?ContactID=4bb34b03-3378-4bb2-a0ed-6345abf3224e&Status=APPROVED.
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
   * This will always be BILLABLEEXPENSE. More types may be added in future.
   * @return Type
  --->
  <cffunction name="getType" access="public" output="false" hint="I return the Type">
    <cfreturn variables.instance.Type />
  </cffunction>

  <cffunction name="setType" access="public"  output="false" hint="I set the Type into the variables.instance scope.">
    <cfargument name="Type" type="String" hint="I am the Type." />
      <cfset variables.instance.Type = arguments.Type />
  </cffunction>

  <!---
   * The last modified date in UTC format
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
   * The Type of the source tranasction. This will be ACCPAY if the linked transaction was created from an invoice and SPEND if it was created from a bank transaction.
   * @return SourceTransactionTypeCode
  --->
  <cffunction name="getSourceTransactionTypeCode" access="public" output="false" hint="I return the SourceTransactionTypeCode">
    <cfreturn variables.instance.SourceTransactionTypeCode />
  </cffunction>

  <cffunction name="setSourceTransactionTypeCode" access="public"  output="false" hint="I set the SourceTransactionTypeCode into the variables.instance scope.">
    <cfargument name="SourceTransactionTypeCode" type="String" hint="I am the SourceTransactionTypeCode." />
      <cfset variables.instance.SourceTransactionTypeCode = arguments.SourceTransactionTypeCode />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   

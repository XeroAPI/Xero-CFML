<cfcomponent displayname="BankTransfer" output="false" extends="cfc.xeroclient"
  hint="I am the BankTransfer Class.">

<!--- PROPERTIES --->

  <cfproperty name="FromBankAccount" type="Struct" default="" />
  <cfproperty name="ToBankAccount" type="Struct" default="" />
  <cfproperty name="Amount" type="String" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="BankTransferID" type="String" default="" />
  <cfproperty name="CurrencyRate" type="String" default="" />
  <cfproperty name="FromBankTransactionID" type="String" default="" />
  <cfproperty name="ToBankTransactionID" type="String" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />
  <cfproperty name="CreatedDateUTC" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the BankTransfer Class.">
      
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
            myStruct.BankTransferID=getBankTransferID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"FromBankAccount")) {
              if (NOT listFindNoCase(arguments.exclude, "FromBankAccount")) {
                myStruct.FromBankAccount=getFromBankAccount();
              }
            }
            if (structKeyExists(variables.instance,"ToBankAccount")) {
              if (NOT listFindNoCase(arguments.exclude, "ToBankAccount")) {
                myStruct.ToBankAccount=getToBankAccount();
              }
            }
            if (structKeyExists(variables.instance,"Amount")) {
              if (NOT listFindNoCase(arguments.exclude, "Amount")) {
                myStruct.Amount=getAmount();
              }
            }
            if (structKeyExists(variables.instance,"Date")) {
              if (NOT listFindNoCase(arguments.exclude, "Date")) {
                myStruct.Date=getDate();
              }
            }
            if (structKeyExists(variables.instance,"BankTransferID")) {
              if (NOT listFindNoCase(arguments.exclude, "BankTransferID")) {
                myStruct.BankTransferID=getBankTransferID();
              }
            }
            if (structKeyExists(variables.instance,"CurrencyRate")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyRate")) {
                myStruct.CurrencyRate=getCurrencyRate();
              }
            }
            if (structKeyExists(variables.instance,"FromBankTransactionID")) {
              if (NOT listFindNoCase(arguments.exclude, "FromBankTransactionID")) {
                myStruct.FromBankTransactionID=getFromBankTransactionID();
              }
            }
            if (structKeyExists(variables.instance,"ToBankTransactionID")) {
              if (NOT listFindNoCase(arguments.exclude, "ToBankTransactionID")) {
                myStruct.ToBankTransactionID=getToBankTransactionID();
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                myStruct.HasAttachments=getHasAttachments();
              }
            }
            if (structKeyExists(variables.instance,"CreatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "CreatedDateUTC")) {
                myStruct.CreatedDateUTC=getCreatedDateUTC();
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

        if (structKeyExists(obj,"FromBankAccount")) {
          setFromBankAccount(obj.FromBankAccount);
        } else {
          setFromBankAccount(StructNew());
        }
        if (structKeyExists(obj,"ToBankAccount")) {
          setToBankAccount(obj.ToBankAccount);
        } else {
          setToBankAccount(StructNew());
        }
        if (structKeyExists(obj,"Amount")) {
          setAmount(obj.Amount);
        } else {
          setAmount("");
        }
        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
        }
        if (structKeyExists(obj,"BankTransferID")) {
          setBankTransferID(obj.BankTransferID);
        } else {
          setBankTransferID("");
        }
        if (structKeyExists(obj,"CurrencyRate")) {
          setCurrencyRate(obj.CurrencyRate);
        } else {
          setCurrencyRate("");
        }
        if (structKeyExists(obj,"FromBankTransactionID")) {
          setFromBankTransactionID(obj.FromBankTransactionID);
        } else {
          setFromBankTransactionID("");
        }
        if (structKeyExists(obj,"ToBankTransactionID")) {
          setToBankTransactionID(obj.ToBankTransactionID);
        } else {
          setToBankTransactionID("");
        }
        if (structKeyExists(obj,"HasAttachments")) {
          setHasAttachments(obj.HasAttachments);
        } else {
          setHasAttachments(false);
        }
        if (structKeyExists(obj,"CreatedDateUTC")) {
          setCreatedDateUTC(obj.CreatedDateUTC);
        } else {
          setCreatedDateUTC("");
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

      <cfset this.setList(this.get(endpoint="BankTransfers"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="BankTransfers",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="BankTransfers",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BankTransfers",body=this.toJSON(),id=this.getBankTransferID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BankTransfers",body=this.toJSON(archive=true),id=this.getBankTransferID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="BankTransfers",body=this.toJSON(),id=this.getBankTransferID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of BankTransfers">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of BankTransfers">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See FromBankAccount
   * @return FromBankAccount
  --->
  <cffunction name="getFromBankAccount" access="public" output="false" hint="I return the FromBankAccount">
    <cfreturn variables.instance.FromBankAccount />
  </cffunction>

  <cffunction name="setFromBankAccount" access="public"  output="false" hint="I set the FromBankAccount into the variables.instance scope.">
    <cfargument name="FromBankAccount" type="Struct" hint="I am the FromBankAccount." />
      <cfset variables.instance.FromBankAccount = arguments.FromBankAccount />
  </cffunction>

  <!---
   * See ToBankAccount
   * @return ToBankAccount
  --->
  <cffunction name="getToBankAccount" access="public" output="false" hint="I return the ToBankAccount">
    <cfreturn variables.instance.ToBankAccount />
  </cffunction>

  <cffunction name="setToBankAccount" access="public"  output="false" hint="I set the ToBankAccount into the variables.instance scope.">
    <cfargument name="ToBankAccount" type="Struct" hint="I am the ToBankAccount." />
      <cfset variables.instance.ToBankAccount = arguments.ToBankAccount />
  </cffunction>

  <!---
   * 
   * @return Amount
  --->
  <cffunction name="getAmount" access="public" output="false" hint="I return the Amount">
    <cfreturn variables.instance.Amount />
  </cffunction>

  <cffunction name="setAmount" access="public"  output="false" hint="I set the Amount into the variables.instance scope.">
    <cfargument name="Amount" type="String" hint="I am the Amount." />
      <cfset variables.instance.Amount = arguments.Amount />
  </cffunction>

  <!---
   * The date of the Transfer YYYY-MM-DD
   * @return Date
  --->
  <cffunction name="getDate" access="public" output="false" hint="I return the Date">
    <cfreturn variables.instance.Date />
  </cffunction>

  <cffunction name="setDate" access="public"  output="false" hint="I set the Date into the variables.instance scope.">
    <cfargument name="Date" type="String" hint="I am the Date." />
      <cfset variables.instance.Date = arguments.Date />
  </cffunction>

  <!---
   * The identifier of the Bank Transfer
   * @return BankTransferID
  --->
  <cffunction name="getBankTransferID" access="public" output="false" hint="I return the BankTransferID">
    <cfreturn variables.instance.BankTransferID />
  </cffunction>

  <cffunction name="setBankTransferID" access="public"  output="false" hint="I set the BankTransferID into the variables.instance scope.">
    <cfargument name="BankTransferID" type="String" hint="I am the BankTransferID." />
      <cfset variables.instance.BankTransferID = arguments.BankTransferID />
  </cffunction>

  <!---
   * The currency rate
   * @return CurrencyRate
  --->
  <cffunction name="getCurrencyRate" access="public" output="false" hint="I return the CurrencyRate">
    <cfreturn variables.instance.CurrencyRate />
  </cffunction>

  <cffunction name="setCurrencyRate" access="public"  output="false" hint="I set the CurrencyRate into the variables.instance scope.">
    <cfargument name="CurrencyRate" type="String" hint="I am the CurrencyRate." />
      <cfset variables.instance.CurrencyRate = arguments.CurrencyRate />
  </cffunction>

  <!---
   * The Bank Transaction ID for the source account
   * @return FromBankTransactionID
  --->
  <cffunction name="getFromBankTransactionID" access="public" output="false" hint="I return the FromBankTransactionID">
    <cfreturn variables.instance.FromBankTransactionID />
  </cffunction>

  <cffunction name="setFromBankTransactionID" access="public"  output="false" hint="I set the FromBankTransactionID into the variables.instance scope.">
    <cfargument name="FromBankTransactionID" type="String" hint="I am the FromBankTransactionID." />
      <cfset variables.instance.FromBankTransactionID = arguments.FromBankTransactionID />
  </cffunction>

  <!---
   * The Bank Transaction ID for the destination account
   * @return ToBankTransactionID
  --->
  <cffunction name="getToBankTransactionID" access="public" output="false" hint="I return the ToBankTransactionID">
    <cfreturn variables.instance.ToBankTransactionID />
  </cffunction>

  <cffunction name="setToBankTransactionID" access="public"  output="false" hint="I set the ToBankTransactionID into the variables.instance scope.">
    <cfargument name="ToBankTransactionID" type="String" hint="I am the ToBankTransactionID." />
      <cfset variables.instance.ToBankTransactionID = arguments.ToBankTransactionID />
  </cffunction>

  <!---
   * Boolean to indicate if a Bank Transfer has an attachment
   * @return HasAttachments
  --->
  <cffunction name="getHasAttachments" access="public" output="false" hint="I return the HasAttachments">
    <cfreturn variables.instance.HasAttachments />
  </cffunction>

  <cffunction name="setHasAttachments" access="public"  output="false" hint="I set the HasAttachments into the variables.instance scope.">
    <cfargument name="HasAttachments" type="Boolean" hint="I am the HasAttachments." />
      <cfset variables.instance.HasAttachments = arguments.HasAttachments />
  </cffunction>

  <!---
   * UTC timestamp of creation date of bank transfer
   * @return CreatedDateUTC
  --->
  <cffunction name="getCreatedDateUTC" access="public" output="false" hint="I return the CreatedDateUTC">
    <cfreturn variables.instance.CreatedDateUTC />
  </cffunction>

  <cffunction name="setCreatedDateUTC" access="public"  output="false" hint="I set the CreatedDateUTC into the variables.instance scope.">
    <cfargument name="CreatedDateUTC" type="String" hint="I am the CreatedDateUTC." />
      <cfset variables.instance.CreatedDateUTC = arguments.CreatedDateUTC />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


<cfcomponent displayname="Account" output="false" extends="xeroclient"
  hint="I am the Account Class.">

<!--- PROPERTIES --->

  <cfproperty name="Code" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="Type" type="String" default="" />
  <cfproperty name="BankAccountNumber" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="Description" type="String" default="" />
  <cfproperty name="BankAccountType" type="String" default="" />
  <cfproperty name="CurrencyCode" type="String" default="" />
  <cfproperty name="TaxType" type="String" default="" />
  <cfproperty name="EnablePaymentsToAccount" type="Boolean" default="" />
  <cfproperty name="ShowInExpenseClaims" type="Boolean" default="" />
  <cfproperty name="AccountID" type="String" default="" />
  <cfproperty name="Class" type="String" default="" />
  <cfproperty name="SystemAccount" type="String" default="" />
  <cfproperty name="ReportingCode" type="String" default="" />
  <cfproperty name="ReportingCodeName" type="String" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />

  

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Account Class.">
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
    <cfargument name="Only" type="String" default="" hint="I am a list of attributes to exclude from JSON" />
     
      <cfif len(arguments.exclude) GT 0>
        <cfset exclude = arguments.exclude>
      <cfelse>
        <cfset exclude = "">
      </cfif>

       <cfif Only EQ "id">
        <cfset exclude = "Code,Name">
      </cfif>

      <cfscript>
        myStruct=StructNew();
        myStruct=this.toJSON(exclude=exclude,returnType="struct");
      </cfscript>
    <cfreturn myStruct />


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
            myStruct["AccountID"]=getAccountID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Code")) {
              if (NOT listFindNoCase(arguments.exclude, "Code")) {
                myStruct["Code"]=getCode();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct["Name"]=getName();
              }
            }
            if (structKeyExists(variables.instance,"Type")) {
              if (NOT listFindNoCase(arguments.exclude, "Type")) {
                myStruct["Type"]=getType();
              }
            }
            if (structKeyExists(variables.instance,"BankAccountNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "BankAccountNumber")) {
                myStruct["BankAccountNumber"]=getBankAccountNumber();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"Description")) {
              if (NOT listFindNoCase(arguments.exclude, "Description")) {
                myStruct["Description"]=getDescription();
              }
            }
            if (structKeyExists(variables.instance,"BankAccountType")) {
              if (NOT listFindNoCase(arguments.exclude, "BankAccountType")) {
                myStruct["BankAccountType"]=getBankAccountType();
              }
            }
            if (structKeyExists(variables.instance,"CurrencyCode")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyCode")) {
                myStruct["CurrencyCode"]=getCurrencyCode();
              }
            }
            if (structKeyExists(variables.instance,"TaxType")) {
              if (NOT listFindNoCase(arguments.exclude, "TaxType")) {
                myStruct["TaxType"]=getTaxType();
              }
            }
            if (structKeyExists(variables.instance,"EnablePaymentsToAccount")) {
              if (NOT listFindNoCase(arguments.exclude, "EnablePaymentsToAccount")) {
                myStruct["EnablePaymentsToAccount"]=getEnablePaymentsToAccount();
              }
            }
            if (structKeyExists(variables.instance,"ShowInExpenseClaims")) {
              if (NOT listFindNoCase(arguments.exclude, "ShowInExpenseClaims")) {
                myStruct["ShowInExpenseClaims"]=getShowInExpenseClaims();
              }
            }
            if (structKeyExists(variables.instance,"AccountID")) {
              if (NOT listFindNoCase(arguments.exclude, "AccountID")) {
                myStruct["AccountID"]=getAccountID();
              }
            }
            if (structKeyExists(variables.instance,"Class")) {
              if (NOT listFindNoCase(arguments.exclude, "Class")) {
                myStruct["Class"]=getAccountClass();
              }
            }
            if (structKeyExists(variables.instance,"SystemAccount")) {
              if (NOT listFindNoCase(arguments.exclude, "SystemAccount")) {
                myStruct["SystemAccount"]=getSystemAccount();
              }
            }
            if (structKeyExists(variables.instance,"ReportingCode")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportingCode")) {
                myStruct["ReportingCode"]=getReportingCode();
              }
            }
            if (structKeyExists(variables.instance,"ReportingCodeName")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportingCodeName")) {
                myStruct["ReportingCodeName"]=getReportingCodeName();
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                myStruct["HasAttachments"]=getHasAttachments();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct["UpdatedDateUTC"]=getUpdatedDateUTC();
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
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"Type")) {
          setType(obj.Type);
        } else {
          setType("");
        }
        if (structKeyExists(obj,"BankAccountNumber")) {
          setBankAccountNumber(obj.BankAccountNumber);
        } else {
          setBankAccountNumber("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"Description")) {
          setDescription(obj.Description);
        } else {
          setDescription("");
        }
        if (structKeyExists(obj,"BankAccountType")) {
          setBankAccountType(obj.BankAccountType);
        } else {
          setBankAccountType("");
        }
        if (structKeyExists(obj,"CurrencyCode")) {
          setCurrencyCode(obj.CurrencyCode);
        } else {
          setCurrencyCode("");
        }
        if (structKeyExists(obj,"TaxType")) {
          setTaxType(obj.TaxType);
        } else {
          setTaxType("");
        }
        if (structKeyExists(obj,"EnablePaymentsToAccount")) {
          setEnablePaymentsToAccount(obj.EnablePaymentsToAccount);
        } else {
          setEnablePaymentsToAccount("");
        }
        if (structKeyExists(obj,"ShowInExpenseClaims")) {
          setShowInExpenseClaims(obj.ShowInExpenseClaims);
        } else {
          setShowInExpenseClaims("");
        }
        if (structKeyExists(obj,"AccountID")) {
          setAccountID(obj.AccountID);
        } else {
          setAccountID("");
        }
        if (structKeyExists(obj,"Class")) {
          setAccountClass(obj.Class);
        } else {
          setAccountClass("");
        }
        if (structKeyExists(obj,"SystemAccount")) {
          setSystemAccount(obj.SystemAccount);
        } else {
          setSystemAccount("");
        }
        if (structKeyExists(obj,"ReportingCode")) {
          setReportingCode(obj.ReportingCode);
        } else {
          setReportingCode("");
        }
        if (structKeyExists(obj,"ReportingCodeName")) {
          setReportingCodeName(obj.ReportingCodeName);
        } else {
          setReportingCodeName("");
        }
        if (structKeyExists(obj,"HasAttachments")) {
          setHasAttachments(obj.HasAttachments);
        } else {
          setHasAttachments(false);
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
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
    <cfset variables.result = Super.post(endpoint="Accounts",body=this.toJSON(exclude="Status,Class"),id=this.getAccountID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Accounts",body=this.toJSON(archive=true),id=this.getAccountID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Accounts",body=this.toJSON(),id=this.getAccountID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Accounts">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Accounts">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Customer defined alpha numeric account code e.g 200 or SALES (max length = 10)
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
   * Name of account (max length = 150)
   * @return Name
  --->
  <cffunction name="getName" access="public" output="false" hint="I return the Name">
    <cfreturn variables.instance.Name />
  </cffunction>

  <cffunction name="setName" access="public"  output="false" hint="I set the Name into the variables.instance scope.">
    <cfargument name="Name" type="String" hint="I am the Name." />
      <cfset variables.instance.Name = arguments.Name />
  </cffunction>

  <!---
   * See Account Types
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
   * For bank accounts only (Account Type BANK)
   * @return BankAccountNumber
  --->
  <cffunction name="getBankAccountNumber" access="public" output="false" hint="I return the BankAccountNumber">
    <cfreturn variables.instance.BankAccountNumber />
  </cffunction>

  <cffunction name="setBankAccountNumber" access="public"  output="false" hint="I set the BankAccountNumber into the variables.instance scope.">
    <cfargument name="BankAccountNumber" type="String" hint="I am the BankAccountNumber." />
      <cfset variables.instance.BankAccountNumber = arguments.BankAccountNumber />
  </cffunction>

  <!---
   * Accounts with a status of ACTIVE can be updated to ARCHIVED. See Account Status Codes
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
   * Description of the Account. Valid for all types of accounts except bank accounts (max length = 4000)
   * @return Description
  --->
  <cffunction name="getDescription" access="public" output="false" hint="I return the Description">
    <cfreturn variables.instance.Description />
  </cffunction>

  <cffunction name="setDescription" access="public"  output="false" hint="I set the Description into the variables.instance scope.">
    <cfargument name="Description" type="String" hint="I am the Description." />
      <cfset variables.instance.Description = arguments.Description />
  </cffunction>

  <!---
   * For bank accounts only. See Bank Account types
   * @return BankAccountType
  --->
  <cffunction name="getBankAccountType" access="public" output="false" hint="I return the BankAccountType">
    <cfreturn variables.instance.BankAccountType />
  </cffunction>

  <cffunction name="setBankAccountType" access="public"  output="false" hint="I set the BankAccountType into the variables.instance scope.">
    <cfargument name="BankAccountType" type="String" hint="I am the BankAccountType." />
      <cfset variables.instance.BankAccountType = arguments.BankAccountType />
  </cffunction>

  <!---
   * For bank accounts only
   * @return CurrencyCode
  --->
  <cffunction name="getCurrencyCode" access="public" output="false" hint="I return the CurrencyCode">
    <cfreturn variables.instance.CurrencyCode />
  </cffunction>

  <cffunction name="setCurrencyCode" access="public"  output="false" hint="I set the CurrencyCode into the variables.instance scope.">
    <cfargument name="CurrencyCode" type="String" hint="I am the CurrencyCode." />
      <cfset variables.instance.CurrencyCode = arguments.CurrencyCode />
  </cffunction>

  <!---
   * See Tax Types
   * @return TaxType
  --->
  <cffunction name="getTaxType" access="public" output="false" hint="I return the TaxType">
    <cfreturn variables.instance.TaxType />
  </cffunction>

  <cffunction name="setTaxType" access="public"  output="false" hint="I set the TaxType into the variables.instance scope.">
    <cfargument name="TaxType" type="String" hint="I am the TaxType." />
      <cfset variables.instance.TaxType = arguments.TaxType />
  </cffunction>

  <!---
   * Boolean – describes whether account can have payments applied to it
   * @return EnablePaymentsToAccount
  --->
  <cffunction name="getEnablePaymentsToAccount" access="public" output="false" hint="I return the EnablePaymentsToAccount">
    <cfreturn variables.instance.EnablePaymentsToAccount />
  </cffunction>

  <cffunction name="setEnablePaymentsToAccount" access="public"  output="false" hint="I set the EnablePaymentsToAccount into the variables.instance scope.">
    <cfargument name="EnablePaymentsToAccount" type="Boolean" hint="I am the EnablePaymentsToAccount." />
      <cfset variables.instance.EnablePaymentsToAccount = arguments.EnablePaymentsToAccount />
  </cffunction>

  <!---
   * Boolean – describes whether account code is available for use with expense claims
   * @return ShowInExpenseClaims
  --->
  <cffunction name="getShowInExpenseClaims" access="public" output="false" hint="I return the ShowInExpenseClaims">
    <cfreturn variables.instance.ShowInExpenseClaims />
  </cffunction>

  <cffunction name="setShowInExpenseClaims" access="public"  output="false" hint="I set the ShowInExpenseClaims into the variables.instance scope.">
    <cfargument name="ShowInExpenseClaims" type="Boolean" hint="I am the ShowInExpenseClaims." />
      <cfset variables.instance.ShowInExpenseClaims = arguments.ShowInExpenseClaims />
  </cffunction>

  <!---
   * The Xero identifier for an account – specified as a string following the endpoint name e.g. /297c2dc5-cc47-4afd-8ec8-74990b8761e9
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
   * See Account Class Types
   * @return Class
  --->
  <cffunction name="getAccountClass" access="public" output="false" hint="I return the Class">
    <cfreturn variables.instance.Class />
  </cffunction>

  <cffunction name="setAccountClass" access="public"  output="false" hint="I set the Class into the variables.instance scope.">
    <cfargument name="Class" type="String" hint="I am the Class." />
      <cfset variables.instance.Class = arguments.Class />
  </cffunction>

  <!---
   * If this is a system account then this element is returned. See System Account types. Note that non-system accounts may have this element set as either “” or null.
   * @return SystemAccount
  --->
  <cffunction name="getSystemAccount" access="public" output="false" hint="I return the SystemAccount">
    <cfreturn variables.instance.SystemAccount />
  </cffunction>

  <cffunction name="setSystemAccount" access="public"  output="false" hint="I set the SystemAccount into the variables.instance scope.">
    <cfargument name="SystemAccount" type="String" hint="I am the SystemAccount." />
      <cfset variables.instance.SystemAccount = arguments.SystemAccount />
  </cffunction>

  <!---
   * Shown if set
   * @return ReportingCode
  --->
  <cffunction name="getReportingCode" access="public" output="false" hint="I return the ReportingCode">
    <cfreturn variables.instance.ReportingCode />
  </cffunction>

  <cffunction name="setReportingCode" access="public"  output="false" hint="I set the ReportingCode into the variables.instance scope.">
    <cfargument name="ReportingCode" type="String" hint="I am the ReportingCode." />
      <cfset variables.instance.ReportingCode = arguments.ReportingCode />
  </cffunction>

  <!---
   * Shown if set
   * @return ReportingCodeName
  --->
  <cffunction name="getReportingCodeName" access="public" output="false" hint="I return the ReportingCodeName">
    <cfreturn variables.instance.ReportingCodeName />
  </cffunction>

  <cffunction name="setReportingCodeName" access="public"  output="false" hint="I set the ReportingCodeName into the variables.instance scope.">
    <cfargument name="ReportingCodeName" type="String" hint="I am the ReportingCodeName." />
      <cfset variables.instance.ReportingCodeName = arguments.ReportingCodeName />
  </cffunction>

  <!---
   * boolean to indicate if an account has an attachment (read only)
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
   * Last modified date UTC format
   * @return UpdatedDateUTC
  --->
  <cffunction name="getUpdatedDateUTC" access="public" output="false" hint="I return the UpdatedDateUTC">
    <cfreturn variables.instance.UpdatedDateUTC />
  </cffunction>

  <cffunction name="setUpdatedDateUTC" access="public"  output="false" hint="I set the UpdatedDateUTC into the variables.instance scope.">
    <cfargument name="UpdatedDateUTC" type="String" hint="I am the UpdatedDateUTC." />
      <cfset variables.instance.UpdatedDateUTC = arguments.UpdatedDateUTC />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



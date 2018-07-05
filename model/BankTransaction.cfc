<cfcomponent displayname="BankTransaction" output="false" extends="xeroclient"
  hint="I am the BankTransaction Class.">

<!--- PROPERTIES --->

  <cfproperty name="Type" type="String" default="" />
  <cfproperty name="Contact" type="Struct" default="" />
  <cfproperty name="BankAccount" type="Struct" default="" />
  <cfproperty name="Lineitems" type="array" default="" />
  <cfproperty name="IsReconciled" type="Boolean" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="Reference" type="String" default="" />
  <cfproperty name="CurrencyCode" type="String" default="" />
  <cfproperty name="CurrencyRate" type="String" default="" />
  <cfproperty name="Url" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="LineAmountTypes" type="String" default="" />
  <cfproperty name="SubTotal" type="String" default="" />
  <cfproperty name="TotalTax" type="String" default="" />
  <cfproperty name="Total" type="String" default="" />
  <cfproperty name="BankTransactionID" type="String" default="" />
  <cfproperty name="PrepaymentID" type="String" default="" />
  <cfproperty name="OverpaymentID" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the BankTransaction Class.">
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

  <cffunction name="toJSON" access="public" output="false">
     <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON payload" />
     <cfargument name="archive" type="boolean" default="false" hint="I flag to return only the req. fields as JSON payload for archiving an object" />
    
     
        <cfscript>
          myStruct=StructNew();
          if (archive) {
            myStruct["BankTransactionID"]=getBankTransactionID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Type")) {
              if (NOT listFindNoCase(arguments.exclude, "Type")) {
                myStruct["Type"]=getType();
              }
            }
            if (structKeyExists(variables.instance,"Contact")) {
              if (NOT listFindNoCase(arguments.exclude, "Contact")) {
                myStruct["Contact"]=getContact();
              }
            }
            if (structKeyExists(variables.instance,"BankAccount")) {
              if (NOT listFindNoCase(arguments.exclude, "BankAccount")) {
                myStruct["BankAccount"]=getBankAccount();
              }
            }
            if (structKeyExists(variables.instance,"Lineitems")) {
              if (NOT listFindNoCase(arguments.exclude, "Lineitems")) {
                myStruct["Lineitems"]=getLineitems();
              }
            }
            if (structKeyExists(variables.instance,"IsReconciled")) {
              if (NOT listFindNoCase(arguments.exclude, "IsReconciled")) {
                myStruct["IsReconciled"]=getIsReconciled();
              }
            }
            if (structKeyExists(variables.instance,"Date")) {
              if (NOT listFindNoCase(arguments.exclude, "Date")) {
                myStruct["Date"]=getDate();
              }
            }
            if (structKeyExists(variables.instance,"Reference")) {
              if (NOT listFindNoCase(arguments.exclude, "Reference")) {
                myStruct["Reference"]=getReference();
              }
            }
            if (structKeyExists(variables.instance,"CurrencyCode")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyCode")) {
                myStruct["CurrencyCode"]=getCurrencyCode();
              }
            }
            if (structKeyExists(variables.instance,"CurrencyRate")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyRate")) {
                myStruct["CurrencyRate"]=getCurrencyRate();
              }
            }
            if (structKeyExists(variables.instance,"Url")) {
              if (NOT listFindNoCase(arguments.exclude, "Url")) {
                myStruct["Url"]=getUrl();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"LineAmountTypes")) {
              if (NOT listFindNoCase(arguments.exclude, "LineAmountTypes")) {
                myStruct["LineAmountTypes"]=getLineAmountTypes();
              }
            }
            if (structKeyExists(variables.instance,"SubTotal")) {
              if (NOT listFindNoCase(arguments.exclude, "SubTotal")) {
                myStruct["SubTotal"]=getSubTotal();
              }
            }
            if (structKeyExists(variables.instance,"TotalTax")) {
              if (NOT listFindNoCase(arguments.exclude, "TotalTax")) {
                myStruct["TotalTax"]=getTotalTax();
              }
            }
            if (structKeyExists(variables.instance,"Total")) {
              if (NOT listFindNoCase(arguments.exclude, "Total")) {

                myStruct["Total"]=getTotal();
              }
            }
            if (structKeyExists(variables.instance,"BankTransactionID")) {
              if (NOT listFindNoCase(arguments.exclude, "BankTransactionID")) {
                myStruct["BankTransactionID"]=getBankTransactionID();
              }
            }
            if (structKeyExists(variables.instance,"PrepaymentID")) {
              if (NOT listFindNoCase(arguments.exclude, "PrepaymentID")) {
                myStruct["PrepaymentID"]=getPrepaymentID();
              }
            }
            if (structKeyExists(variables.instance,"OverpaymentID")) {
              if (NOT listFindNoCase(arguments.exclude, "OverpaymentID")) {
                myStruct["OverpaymentID"]=getOverpaymentID();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct["UpdatedDateUTC"]=getUpdatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                myStruct["HasAttachments"]=getHasAttachments();
              }
            }
          }
        </cfscript>

      <cfset variables.jsonObj = serializeJSON(myStruct)>

   <cfreturn variables.jsonObj />
  </cffunction>

  <cffunction name="populate" access="public" output="false">
     <cfargument name="objects" required="true" type="struct" default="" hint="I am a structure of this object." />

        <cfset obj = arguments.objects>
        <cfscript>

        if (structKeyExists(obj,"Type")) {
          setType(obj.Type);
        } else {
          setType("");
        }
        if (structKeyExists(obj,"Contact")) {
          setContact(obj.Contact);
        } else {
          setContact(StructNew());
        }
        if (structKeyExists(obj,"BankAccount")) {
          setBankAccount(obj.BankAccount);
        } else {
          setBankAccount(StructNew());
        }
        if (structKeyExists(obj,"Lineitems")) {
          setLineitems(obj.Lineitems);
        } else {
          setLineitems(ArrayNew(1));
        }
        if (structKeyExists(obj,"IsReconciled")) {
          setIsReconciled(obj.IsReconciled);
        } else {
          setIsReconciled("");
        }
        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
        }
        if (structKeyExists(obj,"Reference")) {
          setReference(obj.Reference);
        } else {
          setReference("");
        }
        if (structKeyExists(obj,"CurrencyCode")) {
          setCurrencyCode(obj.CurrencyCode);
        } else {
          setCurrencyCode("");
        }
        if (structKeyExists(obj,"CurrencyRate")) {
          setCurrencyRate(obj.CurrencyRate);
        } else {
          setCurrencyRate("");
        }
        if (structKeyExists(obj,"Url")) {
          setUrl(obj.Url);
        } else {
          setUrl("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"LineAmountTypes")) {
          setLineAmountTypes(obj.LineAmountTypes);
        } else {
          setLineAmountTypes("");
        }
        if (structKeyExists(obj,"SubTotal")) {
          setSubTotal(obj.SubTotal);
        } else {
          setSubTotal("");
        }
        if (structKeyExists(obj,"TotalTax")) {
          setTotalTax(obj.TotalTax);
        } else {
          setTotalTax("");
        }
        if (structKeyExists(obj,"Total")) {
          setTotal(obj.Total);
        } else {
          setTotal("");
        }
        if (structKeyExists(obj,"BankTransactionID")) {
          setBankTransactionID(obj.BankTransactionID);
        } else {
          setBankTransactionID("");
        }
        if (structKeyExists(obj,"PrepaymentID")) {
          setPrepaymentID(obj.PrepaymentID);
        } else {
          setPrepaymentID("");
        }
        if (structKeyExists(obj,"OverpaymentID")) {
          setOverpaymentID(obj.OverpaymentID);
        } else {
          setOverpaymentID("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"HasAttachments")) {
          setHasAttachments(obj.HasAttachments);
        } else {
          setHasAttachments(false);
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

      <cfset this.setList(this.get(endpoint="BankTransactions"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="BankTransactions",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">

    <cfset variables.result = Super.put(endpoint="BankTransactions",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BankTransactions",body=this.toJSON(exclude="Total,SubTotal"),id=this.getBankTransactionID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BankTransactions",body=this.toJSON(archive=true),id=this.getBankTransactionID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of BankTransactions">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of BankTransactions">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See Bank Transaction Types
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
   * See Contact
   * @return Contact
  --->
  <cffunction name="getContact" access="public" output="false" hint="I return the Contact">
    <cfreturn variables.instance.Contact />
  </cffunction>

  <cffunction name="setContact" access="public"  output="false" hint="I set the Contact into the variables.instance scope.">
    <cfargument name="Contact" type="struct" hint="I am the Contact." />
      <cfset variables.instance.Contact = arguments.Contact />
  </cffunction>

  <!---
   * See BankAccount
   * @return BankAccount
  --->
  <cffunction name="getBankAccount" access="public" output="false" hint="I return the BankAccount">
    <cfreturn variables.instance.BankAccount />
  </cffunction>

  <cffunction name="setBankAccount" access="public"  output="false" hint="I set the BankAccount into the variables.instance scope.">
    <cfargument name="BankAccount" type="struct" hint="I am the BankAccount." />
      <cfset variables.instance.BankAccount = arguments.BankAccount />
  </cffunction>

  <!---
   * See LineItems
   * @return Lineitems
  --->
  <cffunction name="getLineitems" access="public" output="false" hint="I return the Lineitems">

    <cfset var lines = variables.instance.Lineitems>
    <cfset var exclude = "">
    <cfif this.getType() EQ "RECEIVE-OVERPAYMENT" OR this.getType() EQ "RECEIVE-PREPAYMENT">
      <cfset exclude = "ItemCode,Quantity,TaxAmount,TaxType,Tracking,DiscountRate,LineAmount,RepeatingInvoiceID">
    </cfif>
    <cfscript>
        var arr = ArrayNew(1);
        for (var i=1;i LTE ArrayLen(lines);i=i+1) {
          ArrayAppend(arr,lines[i].toStruct(exclude=exclude));
        }
    </cfscript>

    <cfreturn arr />


    <!--- OLD 
    <cfreturn variables.instance.Lineitems />
  --->
  </cffunction>

  <cffunction name="setLineitems" access="public"  output="false" hint="I set the Lineitems into the variables.instance scope.">
    <cfargument name="Lineitems" type="array" hint="I am the Lineitems." />
       <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(arguments.Lineitems);i=i+1) {
              var item=createObject("component","Lineitem").init(variables.xero).populate(arguments.Lineitems[i]); 
              ArrayAppend(arr,item);
            }
      </cfscript>
      <cfset variables.instance.Lineitems = arr />

      <!---
      <cfset variables.instance.Lineitems = arguments.Lineitems />
    --->
  </cffunction>

  <!---
   * Boolean to show if transaction is reconciled
   * @return IsReconciled
  --->
  <cffunction name="getIsReconciled" access="public" output="false" hint="I return the IsReconciled">
    <cfreturn variables.instance.IsReconciled />
  </cffunction>

  <cffunction name="setIsReconciled" access="public"  output="false" hint="I set the IsReconciled into the variables.instance scope.">
    <cfargument name="IsReconciled" type="Boolean" hint="I am the IsReconciled." />
      <cfset variables.instance.IsReconciled = arguments.IsReconciled />
  </cffunction>

  <!---
   * Date of transaction – YYYY-MM-DD
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
   * Reference for the transaction. Only supported for SPEND and RECEIVE transactions.
   * @return Reference
  --->
  <cffunction name="getReference" access="public" output="false" hint="I return the Reference">
    <cfreturn variables.instance.Reference />
  </cffunction>

  <cffunction name="setReference" access="public"  output="false" hint="I set the Reference into the variables.instance scope.">
    <cfargument name="Reference" type="String" hint="I am the Reference." />
      <cfset variables.instance.Reference = arguments.Reference />
  </cffunction>

  <!---
   * The currency that bank transaction has been raised in (see Currencies). Setting currency is only supported on overpayments.
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
   * Exchange rate to base currency when money is spent or received. e.g. 0.7500 Only used for bank transactions in non base currency. If this isn’t specified for non base currency accounts then either the user-defined rate (preference) or the XE.com day rate will be used. Setting currency is only supported on overpayments.
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
   * URL link to a source document – shown as “Go to App Name”
   * @return Url
  --->
  <cffunction name="getUrl" access="public" output="false" hint="I return the Url">
    <cfreturn variables.instance.Url />
  </cffunction>

  <cffunction name="setUrl" access="public"  output="false" hint="I set the Url into the variables.instance scope.">
    <cfargument name="Url" type="String" hint="I am the Url." />
      <cfset variables.instance.Url = arguments.Url />
  </cffunction>

  <!---
   * See Bank Transaction Status Codes
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
   * Line amounts are exclusive of tax by default if you don’t specify this element. See Line Amount Types
   * @return LineAmountTypes
  --->
  <cffunction name="getLineAmountTypes" access="public" output="false" hint="I return the LineAmountTypes">
    <cfreturn variables.instance.LineAmountTypes />
  </cffunction>

  <cffunction name="setLineAmountTypes" access="public"  output="false" hint="I set the LineAmountTypes into the variables.instance scope.">
    <cfargument name="LineAmountTypes" type="String" hint="I am the LineAmountTypes." />
      <cfset variables.instance.LineAmountTypes = arguments.LineAmountTypes />
  </cffunction>

  <!---
   * Total of bank transaction excluding taxes
   * @return SubTotal
  --->
  <cffunction name="getSubTotal" access="public" output="false" hint="I return the SubTotal">
    <cfreturn variables.instance.SubTotal />
  </cffunction>

  <cffunction name="setSubTotal" access="public"  output="false" hint="I set the SubTotal into the variables.instance scope.">
    <cfargument name="SubTotal" type="String" hint="I am the SubTotal." />
      <cfset variables.instance.SubTotal = arguments.SubTotal />
  </cffunction>

  <!---
   * Total tax on bank transaction
   * @return TotalTax
  --->
  <cffunction name="getTotalTax" access="public" output="false" hint="I return the TotalTax">
    <cfreturn variables.instance.TotalTax />
  </cffunction>

  <cffunction name="setTotalTax" access="public"  output="false" hint="I set the TotalTax into the variables.instance scope.">
    <cfargument name="TotalTax" type="String" hint="I am the TotalTax." />
      <cfset variables.instance.TotalTax = arguments.TotalTax />
  </cffunction>

  <!---
   * Total of bank transaction tax inclusive
   * @return Total
  --->
  <cffunction name="getTotal" access="public" output="false" hint="I return the Total">
    <cfreturn variables.instance.Total />
  </cffunction>

  <cffunction name="setTotal" access="public"  output="false" hint="I set the Total into the variables.instance scope.">
    <cfargument name="Total" type="String" hint="I am the Total." />
      <cfset variables.instance.Total = arguments.Total />
  </cffunction>

  <!---
   * Xero generated unique identifier for bank transaction
   * @return BankTransactionID
  --->
  <cffunction name="getBankTransactionID" access="public" output="false" hint="I return the BankTransactionID">
    <cfreturn variables.instance.BankTransactionID />
  </cffunction>

  <cffunction name="setBankTransactionID" access="public"  output="false" hint="I set the BankTransactionID into the variables.instance scope.">
    <cfargument name="BankTransactionID" type="String" hint="I am the BankTransactionID." />
      <cfset variables.instance.BankTransactionID = arguments.BankTransactionID />
  </cffunction>

  <!---
   * Xero generated unique identifier for a Prepayment. This will be returned on BankTransactions with a Type of SPEND-PREPAYMENT or RECEIVE-PREPAYMENT
   * @return PrepaymentID
  --->
  <cffunction name="getPrepaymentID" access="public" output="false" hint="I return the PrepaymentID">
    <cfreturn variables.instance.PrepaymentID />
  </cffunction>

  <cffunction name="setPrepaymentID" access="public"  output="false" hint="I set the PrepaymentID into the variables.instance scope.">
    <cfargument name="PrepaymentID" type="String" hint="I am the PrepaymentID." />
      <cfset variables.instance.PrepaymentID = arguments.PrepaymentID />
  </cffunction>

  <!---
   * Xero generated unique identifier for an Overpayment. This will be returned on BankTransactions with a Type of SPEND-OVERPAYMENT or RECEIVE-OVERPAYMENT
   * @return OverpaymentID
  --->
  <cffunction name="getOverpaymentID" access="public" output="false" hint="I return the OverpaymentID">
    <cfreturn variables.instance.OverpaymentID />
  </cffunction>

  <cffunction name="setOverpaymentID" access="public"  output="false" hint="I set the OverpaymentID into the variables.instance scope.">
    <cfargument name="OverpaymentID" type="String" hint="I am the OverpaymentID." />
      <cfset variables.instance.OverpaymentID = arguments.OverpaymentID />
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

  <!---
   * Boolean to indicate if a bank transaction has an attachment
   * @return HasAttachments
  --->
  <cffunction name="getHasAttachments" access="public" output="false" hint="I return the HasAttachments">
    <cfreturn variables.instance.HasAttachments />
  </cffunction>

  <cffunction name="setHasAttachments" access="public"  output="false" hint="I set the HasAttachments into the variables.instance scope.">
    <cfargument name="HasAttachments" type="Boolean" hint="I am the HasAttachments." />
      <cfset variables.instance.HasAttachments = arguments.HasAttachments />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



<cfcomponent displayname="Overpayment" output="false" extends="cfc.xeroclient"
  hint="I am the Overpayment Class.">

<!--- PROPERTIES --->

  <cfproperty name="Type" type="String" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="Status" type="StatusEnum" default="" />
  <cfproperty name="LineAmountTypes" type="String" default="" />
  <cfproperty name="LineItems" type="List[LineItem]" default="" />
  <cfproperty name="SubTotal" type="String" default="" />
  <cfproperty name="TotalTax" type="String" default="" />
  <cfproperty name="Total" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="CurrencyCode" type="String" default="" />
  <cfproperty name="OverpaymentID" type="String" default="" />
  <cfproperty name="CurrencyRate" type="String" default="" />
  <cfproperty name="RemainingCredit" type="String" default="" />
  <cfproperty name="Allocations" type="List[Allocation]" default="" />
  <cfproperty name="Payments" type="List[Payment]" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Overpayment Class.">
      
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
    
     
        <cfscript>
          myStruct=StructNew();

          if (structKeyExists(variables.instance,"Type")) {
            if (NOT listFindNoCase(arguments.exclude, "Type")) {
              myStruct.Type=getType();
            }
          }
          if (structKeyExists(variables.instance,"Date")) {
            if (NOT listFindNoCase(arguments.exclude, "Date")) {
              myStruct.Date=getDate();
            }
          }
          if (structKeyExists(variables.instance,"Status")) {
            if (NOT listFindNoCase(arguments.exclude, "Status")) {
              myStruct.Status=getStatus();
            }
          }
          if (structKeyExists(variables.instance,"LineAmountTypes")) {
            if (NOT listFindNoCase(arguments.exclude, "LineAmountTypes")) {
              myStruct.LineAmountTypes=getLineAmountTypes();
            }
          }
          if (structKeyExists(variables.instance,"LineItems")) {
            if (NOT listFindNoCase(arguments.exclude, "LineItems")) {
              myStruct.LineItems=getLineItems();
            }
          }
          if (structKeyExists(variables.instance,"SubTotal")) {
            if (NOT listFindNoCase(arguments.exclude, "SubTotal")) {
              myStruct.SubTotal=getSubTotal();
            }
          }
          if (structKeyExists(variables.instance,"TotalTax")) {
            if (NOT listFindNoCase(arguments.exclude, "TotalTax")) {
              myStruct.TotalTax=getTotalTax();
            }
          }
          if (structKeyExists(variables.instance,"Total")) {
            if (NOT listFindNoCase(arguments.exclude, "Total")) {
              myStruct.Total=getTotal();
            }
          }
          if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
            if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
              myStruct.UpdatedDateUTC=getUpdatedDateUTC();
            }
          }
          if (structKeyExists(variables.instance,"CurrencyCode")) {
            if (NOT listFindNoCase(arguments.exclude, "CurrencyCode")) {
              myStruct.CurrencyCode=getCurrencyCode();
            }
          }
          if (structKeyExists(variables.instance,"OverpaymentID")) {
            if (NOT listFindNoCase(arguments.exclude, "OverpaymentID")) {
              myStruct.OverpaymentID=getOverpaymentID();
            }
          }
          if (structKeyExists(variables.instance,"CurrencyRate")) {
            if (NOT listFindNoCase(arguments.exclude, "CurrencyRate")) {
              myStruct.CurrencyRate=getCurrencyRate();
            }
          }
          if (structKeyExists(variables.instance,"RemainingCredit")) {
            if (NOT listFindNoCase(arguments.exclude, "RemainingCredit")) {
              myStruct.RemainingCredit=getRemainingCredit();
            }
          }
          if (structKeyExists(variables.instance,"Allocations")) {
            if (NOT listFindNoCase(arguments.exclude, "Allocations")) {
              myStruct.Allocations=getAllocations();
            }
          }
          if (structKeyExists(variables.instance,"Payments")) {
            if (NOT listFindNoCase(arguments.exclude, "Payments")) {
              myStruct.Payments=getPayments();
            }
          }
          if (structKeyExists(variables.instance,"HasAttachments")) {
            if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
              myStruct.HasAttachments=getHasAttachments();
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
        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
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
        if (structKeyExists(obj,"LineItems")) {
          setLineItems(obj.LineItems);
        } else {
          setLineItems("");
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
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"CurrencyCode")) {
          setCurrencyCode(obj.CurrencyCode);
        } else {
          setCurrencyCode("");
        }
        if (structKeyExists(obj,"OverpaymentID")) {
          setOverpaymentID(obj.OverpaymentID);
        } else {
          setOverpaymentID("");
        }
        if (structKeyExists(obj,"CurrencyRate")) {
          setCurrencyRate(obj.CurrencyRate);
        } else {
          setCurrencyRate("");
        }
        if (structKeyExists(obj,"RemainingCredit")) {
          setRemainingCredit(obj.RemainingCredit);
        } else {
          setRemainingCredit("");
        }
        if (structKeyExists(obj,"Allocations")) {
          setAllocations(obj.Allocations);
        } else {
          setAllocations("");
        }
        if (structKeyExists(obj,"Payments")) {
          setPayments(obj.Payments);
        } else {
          setPayments("");
        }
        if (structKeyExists(obj,"HasAttachments")) {
          setHasAttachments(obj.HasAttachments);
        } else {
          setHasAttachments("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="Overpayments"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Overpayments",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Overpayments",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Overpayments",body=this.toJSON(),id=this.getOverpaymentID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Overpayments",body=this.toJSON(),id=this.getOverpaymentID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Overpayments",body=this.toJSON(),id=this.getOverpaymentID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Overpayments">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Overpayments">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See Overpayment Types
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
   * The date the overpayment is created YYYY-MM-DD
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
   * See Overpayment Status Codes
   * @return Status
  --->
  <cffunction name="getStatus" access="public" output="false" hint="I return the Status">
    <cfreturn variables.instance.Status />
  </cffunction>

  <cffunction name="setStatus" access="public"  output="false" hint="I set the Status into the variables.instance scope.">
    <cfargument name="Status" type="StatusEnum" hint="I am the Status." />
      <cfset variables.instance.Status = arguments.Status />
  </cffunction>

  <!---
   * See Overpayment Line Amount Types
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
   * See Overpayment Line Items
   * @return LineItems
  --->
  <cffunction name="getLineItems" access="public" output="false" hint="I return the LineItems">
    <cfreturn variables.instance.LineItems />
  </cffunction>

  <cffunction name="setLineItems" access="public"  output="false" hint="I set the LineItems into the variables.instance scope.">
    <cfargument name="LineItems" type="List[LineItem]" hint="I am the LineItems." />
      <cfset variables.instance.LineItems = arguments.LineItems />
  </cffunction>

  <!---
   * The subtotal of the overpayment excluding taxes
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
   * The total tax on the overpayment
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
   * The total of the overpayment (subtotal + total tax)
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
   * UTC timestamp of last update to the overpayment
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
   * Currency used for the overpayment
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
   * Xero generated unique identifier
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
   * The currency rate for a multicurrency overpayment. If no rate is specified, the XE.com day rate is used
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
   * The remaining credit balance on the overpayment
   * @return RemainingCredit
  --->
  <cffunction name="getRemainingCredit" access="public" output="false" hint="I return the RemainingCredit">
    <cfreturn variables.instance.RemainingCredit />
  </cffunction>

  <cffunction name="setRemainingCredit" access="public"  output="false" hint="I set the RemainingCredit into the variables.instance scope.">
    <cfargument name="RemainingCredit" type="String" hint="I am the RemainingCredit." />
      <cfset variables.instance.RemainingCredit = arguments.RemainingCredit />
  </cffunction>

  <!---
   * See Allocations
   * @return Allocations
  --->
  <cffunction name="getAllocations" access="public" output="false" hint="I return the Allocations">
    <cfreturn variables.instance.Allocations />
  </cffunction>

  <cffunction name="setAllocations" access="public"  output="false" hint="I set the Allocations into the variables.instance scope.">
    <cfargument name="Allocations" type="List[Allocation]" hint="I am the Allocations." />
      <cfset variables.instance.Allocations = arguments.Allocations />
  </cffunction>

  <!---
   * See Payments
   * @return Payments
  --->
  <cffunction name="getPayments" access="public" output="false" hint="I return the Payments">
    <cfreturn variables.instance.Payments />
  </cffunction>

  <cffunction name="setPayments" access="public"  output="false" hint="I set the Payments into the variables.instance scope.">
    <cfargument name="Payments" type="List[Payment]" hint="I am the Payments." />
      <cfset variables.instance.Payments = arguments.Payments />
  </cffunction>

  <!---
   * boolean to indicate if a overpayment has an attachment
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

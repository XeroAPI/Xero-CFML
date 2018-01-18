<cfcomponent displayname="ExpenseClaim" output="false" extends="cfc.xeroclient"
  hint="I am the ExpenseClaim Class.">

<!--- PROPERTIES --->

  <cfproperty name="Receipts" type="List[Receipt]" default="" />
  <cfproperty name="ExpenseClaimID" type="String" default="" />
  <cfproperty name="Payments" type="List[Payment]" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="Total" type="String" default="" />
  <cfproperty name="AmountDue" type="String" default="" />
  <cfproperty name="AmountPaid" type="String" default="" />
  <cfproperty name="PaymentDueDate" type="String" default="" />
  <cfproperty name="ReportingDate" type="String" default="" />
  <cfproperty name="ReceiptID" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the ExpenseClaim Class.">
      
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
            myStruct.ExpenseClaimID=getExpenseClaimID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Receipts")) {
              if (NOT listFindNoCase(arguments.exclude, "Receipts")) {
                myStruct.Receipts=getReceipts();
              }
            }
            if (structKeyExists(variables.instance,"ExpenseClaimID")) {
              if (NOT listFindNoCase(arguments.exclude, "ExpenseClaimID")) {
                myStruct.ExpenseClaimID=getExpenseClaimID();
              }
            }
            if (structKeyExists(variables.instance,"Payments")) {
              if (NOT listFindNoCase(arguments.exclude, "Payments")) {
                myStruct.Payments=getPayments();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct.Status=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct.UpdatedDateUTC=getUpdatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"Total")) {
              if (NOT listFindNoCase(arguments.exclude, "Total")) {
                myStruct.Total=getTotal();
              }
            }
            if (structKeyExists(variables.instance,"AmountDue")) {
              if (NOT listFindNoCase(arguments.exclude, "AmountDue")) {
                myStruct.AmountDue=getAmountDue();
              }
            }
            if (structKeyExists(variables.instance,"AmountPaid")) {
              if (NOT listFindNoCase(arguments.exclude, "AmountPaid")) {
                myStruct.AmountPaid=getAmountPaid();
              }
            }
            if (structKeyExists(variables.instance,"PaymentDueDate")) {
              if (NOT listFindNoCase(arguments.exclude, "PaymentDueDate")) {
                myStruct.PaymentDueDate=getPaymentDueDate();
              }
            }
            if (structKeyExists(variables.instance,"ReportingDate")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportingDate")) {
                myStruct.ReportingDate=getReportingDate();
              }
            }
            if (structKeyExists(variables.instance,"ReceiptID")) {
              if (NOT listFindNoCase(arguments.exclude, "ReceiptID")) {
                myStruct.ReceiptID=getReceiptID();
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

        if (structKeyExists(obj,"Receipts")) {
          setReceipts(obj.Receipts);
        } else {
          setReceipts("");
        }
        if (structKeyExists(obj,"ExpenseClaimID")) {
          setExpenseClaimID(obj.ExpenseClaimID);
        } else {
          setExpenseClaimID("");
        }
        if (structKeyExists(obj,"Payments")) {
          setPayments(obj.Payments);
        } else {
          setPayments("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"Total")) {
          setTotal(obj.Total);
        } else {
          setTotal("");
        }
        if (structKeyExists(obj,"AmountDue")) {
          setAmountDue(obj.AmountDue);
        } else {
          setAmountDue("");
        }
        if (structKeyExists(obj,"AmountPaid")) {
          setAmountPaid(obj.AmountPaid);
        } else {
          setAmountPaid("");
        }
        if (structKeyExists(obj,"PaymentDueDate")) {
          setPaymentDueDate(obj.PaymentDueDate);
        } else {
          setPaymentDueDate("");
        }
        if (structKeyExists(obj,"ReportingDate")) {
          setReportingDate(obj.ReportingDate);
        } else {
          setReportingDate("");
        }
        if (structKeyExists(obj,"ReceiptID")) {
          setReceiptID(obj.ReceiptID);
        } else {
          setReceiptID("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="ExpenseClaims"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="ExpenseClaims",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="ExpenseClaims",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ExpenseClaims",body=this.toJSON(),id=this.getExpenseClaimID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ExpenseClaims",body=this.toJSON(archive=true),id=this.getExpenseClaimID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="ExpenseClaims",body=this.toJSON(),id=this.getExpenseClaimID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of ExpenseClaims">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of ExpenseClaims">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See Receipts
   * @return Receipts
  --->
  <cffunction name="getReceipts" access="public" output="false" hint="I return the Receipts">
    <cfreturn variables.instance.Receipts />
  </cffunction>

  <cffunction name="setReceipts" access="public"  output="false" hint="I set the Receipts into the variables.instance scope.">
    <cfargument name="Receipts" type="List[Receipt]" hint="I am the Receipts." />
      <cfset variables.instance.Receipts = arguments.Receipts />
  </cffunction>

  <!---
   * Xero generated unique identifier for an expense claim
   * @return ExpenseClaimID
  --->
  <cffunction name="getExpenseClaimID" access="public" output="false" hint="I return the ExpenseClaimID">
    <cfreturn variables.instance.ExpenseClaimID />
  </cffunction>

  <cffunction name="setExpenseClaimID" access="public"  output="false" hint="I set the ExpenseClaimID into the variables.instance scope.">
    <cfargument name="ExpenseClaimID" type="String" hint="I am the ExpenseClaimID." />
      <cfset variables.instance.ExpenseClaimID = arguments.ExpenseClaimID />
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
   * Current status of an expense claim – see status types
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
   * The total of an expense claim being paid
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
   * The amount due to be paid for an expense claim
   * @return AmountDue
  --->
  <cffunction name="getAmountDue" access="public" output="false" hint="I return the AmountDue">
    <cfreturn variables.instance.AmountDue />
  </cffunction>

  <cffunction name="setAmountDue" access="public"  output="false" hint="I set the AmountDue into the variables.instance scope.">
    <cfargument name="AmountDue" type="String" hint="I am the AmountDue." />
      <cfset variables.instance.AmountDue = arguments.AmountDue />
  </cffunction>

  <!---
   * The amount still to pay for an expense claim
   * @return AmountPaid
  --->
  <cffunction name="getAmountPaid" access="public" output="false" hint="I return the AmountPaid">
    <cfreturn variables.instance.AmountPaid />
  </cffunction>

  <cffunction name="setAmountPaid" access="public"  output="false" hint="I set the AmountPaid into the variables.instance scope.">
    <cfargument name="AmountPaid" type="String" hint="I am the AmountPaid." />
      <cfset variables.instance.AmountPaid = arguments.AmountPaid />
  </cffunction>

  <!---
   * The date when the expense claim is due to be paid YYYY-MM-DD
   * @return PaymentDueDate
  --->
  <cffunction name="getPaymentDueDate" access="public" output="false" hint="I return the PaymentDueDate">
    <cfreturn variables.instance.PaymentDueDate />
  </cffunction>

  <cffunction name="setPaymentDueDate" access="public"  output="false" hint="I set the PaymentDueDate into the variables.instance scope.">
    <cfargument name="PaymentDueDate" type="String" hint="I am the PaymentDueDate." />
      <cfset variables.instance.PaymentDueDate = arguments.PaymentDueDate />
  </cffunction>

  <!---
   * The date the expense claim will be reported in Xero YYYY-MM-DD
   * @return ReportingDate
  --->
  <cffunction name="getReportingDate" access="public" output="false" hint="I return the ReportingDate">
    <cfreturn variables.instance.ReportingDate />
  </cffunction>

  <cffunction name="setReportingDate" access="public"  output="false" hint="I set the ReportingDate into the variables.instance scope.">
    <cfargument name="ReportingDate" type="String" hint="I am the ReportingDate." />
      <cfset variables.instance.ReportingDate = arguments.ReportingDate />
  </cffunction>

  <!---
   * The Xero identifier for the Receipt e.g. e59a2c7f-1306-4078-a0f3-73537afcbba9
   * @return ReceiptID
  --->
  <cffunction name="getReceiptID" access="public" output="false" hint="I return the ReceiptID">
    <cfreturn variables.instance.ReceiptID />
  </cffunction>

  <cffunction name="setReceiptID" access="public"  output="false" hint="I set the ReceiptID into the variables.instance scope.">
    <cfargument name="ReceiptID" type="String" hint="I am the ReceiptID." />
      <cfset variables.instance.ReceiptID = arguments.ReceiptID />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   

<cfcomponent displayname="Payment" output="false" extends="xeroclient"
  hint="I am the Payment Class.">

<!--- PROPERTIES --->

  <cfproperty name="Invoice" type="Struct" default="" />
  <cfproperty name="CreditNote" type="Struct" default="" />
  <cfproperty name="Prepayment" type="Struct" default="" />
  <cfproperty name="Overpayment" type="Struct" default="" />
  <cfproperty name="InvoiceNumber" type="String" default="" />
  <cfproperty name="CreditNoteNumber" type="String" default="" />
  <cfproperty name="Account" type="Struct" default="" />
  <cfproperty name="Code" type="String" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="CurrencyRate" type="String" default="" />
  <cfproperty name="Amount" type="String" default="" />
  <cfproperty name="Reference" type="String" default="" />
  <cfproperty name="IsReconciled" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="PaymentType" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="PaymentID" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Payment Class.">
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
            myStruct["PaymentID"]=getPaymentID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Invoice")) {
              if (NOT listFindNoCase(arguments.exclude, "Invoice")) {
                myStruct["Invoice"]=getInvoice();
              }
            }
            if (structKeyExists(variables.instance,"CreditNote")) {
              if (NOT listFindNoCase(arguments.exclude, "CreditNote")) {
                myStruct["CreditNote"]=getCreditNote();
              }
            }
            if (structKeyExists(variables.instance,"Prepayment")) {
              if (NOT listFindNoCase(arguments.exclude, "Prepayment")) {
                myStruct["Prepayment"]=getPrepayment();
              }
            }
            if (structKeyExists(variables.instance,"Overpayment")) {
              if (NOT listFindNoCase(arguments.exclude, "Overpayment")) {
                myStruct["Overpayment"]=getOverpayment();
              }
            }
            if (structKeyExists(variables.instance,"InvoiceNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "InvoiceNumber")) {
                myStruct["InvoiceNumber"]=getInvoiceNumber();
              }
            }
            if (structKeyExists(variables.instance,"CreditNoteNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "CreditNoteNumber")) {
                myStruct["CreditNoteNumber"]=getCreditNoteNumber();
              }
            }
            if (structKeyExists(variables.instance,"Account")) {
              if (NOT listFindNoCase(arguments.exclude, "Account")) {
                myStruct["Account"]=getAccount();
              }
            }
            if (structKeyExists(variables.instance,"Code")) {
              if (NOT listFindNoCase(arguments.exclude, "Code")) {
                myStruct["Code"]=getCode();
              }
            }
            if (structKeyExists(variables.instance,"Date")) {
              if (NOT listFindNoCase(arguments.exclude, "Date")) {
                myStruct["Date"]=getDate();
              }
            }
            if (structKeyExists(variables.instance,"CurrencyRate")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyRate")) {
                myStruct["CurrencyRate"]=getCurrencyRate();
              }
            }
            if (structKeyExists(variables.instance,"Amount")) {
              if (NOT listFindNoCase(arguments.exclude, "Amount")) {
                myStruct["Amount"]=getAmount();
              }
            }
            if (structKeyExists(variables.instance,"Reference")) {
              if (NOT listFindNoCase(arguments.exclude, "Reference")) {
                myStruct["Reference"]=getReference();
              }
            }
            if (structKeyExists(variables.instance,"IsReconciled")) {
              if (NOT listFindNoCase(arguments.exclude, "IsReconciled")) {
                myStruct["IsReconciled"]=getIsReconciled();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"PaymentType")) {
              if (NOT listFindNoCase(arguments.exclude, "PaymentType")) {
                myStruct["PaymentType"]=getPaymentType();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct["UpdatedDateUTC"]=getUpdatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"PaymentID")) {
              if (NOT listFindNoCase(arguments.exclude, "PaymentID")) {
                myStruct["PaymentID"]=getPaymentID();
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

        if (structKeyExists(obj,"Invoice")) {
          setInvoice(obj.Invoice);
        } else {
          setInvoice(StructNew());
        }
        if (structKeyExists(obj,"CreditNote")) {
          setCreditNote(obj.CreditNote);
        } else {
          setCreditNote(StructNew());
        }
        if (structKeyExists(obj,"Prepayment")) {
          setPrepayment(obj.Prepayment);
        } else {
          setPrepayment(StructNew());
        }
        if (structKeyExists(obj,"Overpayment")) {
          setOverpayment(obj.Overpayment);
        } else {
          setOverpayment(StructNew());
        }
        if (structKeyExists(obj,"InvoiceNumber")) {
          setInvoiceNumber(obj.InvoiceNumber);
        } else {
          setInvoiceNumber("");
        }
        if (structKeyExists(obj,"CreditNoteNumber")) {
          setCreditNoteNumber(obj.CreditNoteNumber);
        } else {
          setCreditNoteNumber("");
        }
        if (structKeyExists(obj,"Account")) {
          setAccount(obj.Account);
        } else {
          setAccount(StructNew());
        }
        if (structKeyExists(obj,"Code")) {
          setCode(obj.Code);
        } else {
          setCode("");
        }
        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
        }
        if (structKeyExists(obj,"CurrencyRate")) {
          setCurrencyRate(obj.CurrencyRate);
        } else {
          setCurrencyRate("");
        }
        if (structKeyExists(obj,"Amount")) {
          setAmount(obj.Amount);
        } else {
          setAmount("");
        }
        if (structKeyExists(obj,"Reference")) {
          setReference(obj.Reference);
        } else {
          setReference("");
        }
        if (structKeyExists(obj,"IsReconciled")) {
          setIsReconciled(obj.IsReconciled);
        } else {
          setIsReconciled("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"PaymentType")) {
          setPaymentType(obj.PaymentType);
        } else {
          setPaymentType("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"PaymentID")) {
          setPaymentID(obj.PaymentID);
        } else {
          setPaymentID("");
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
      
      <cfset this.setList(this.get(endpoint="Payments"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Payments",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Payments",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset this.setStatus("DELETED")>
    <cfset variables.result = Super.post(endpoint="Payments",body=this.toJSON(archive="true"),id=this.getPaymentID())>
   
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Payments">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Payments">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See Invoice
   * @return Invoice
  --->
  <cffunction name="getInvoice" access="public" output="false" hint="I return the Invoice">
    <cfreturn variables.instance.Invoice />
  </cffunction>

  <cffunction name="setInvoice" access="public"  output="false" hint="I set the Invoice into the variables.instance scope.">
    <cfargument name="Invoice" type="Struct" hint="I am the Invoice." />
      <cfset variables.instance.Invoice = arguments.Invoice />
  </cffunction>

  <!---
   * See CreditNotes
   * @return CreditNote
  --->
  <cffunction name="getCreditNote" access="public" output="false" hint="I return the CreditNote">
    <cfreturn variables.instance.CreditNote />
  </cffunction>

  <cffunction name="setCreditNote" access="public"  output="false" hint="I set the CreditNote into the variables.instance scope.">
    <cfargument name="CreditNote" type="Struct" hint="I am the CreditNote." />
      <cfset variables.instance.CreditNote = arguments.CreditNote />
  </cffunction>

  <!---
   * See Prepayment
   * @return Prepayment
  --->
  <cffunction name="getPrepayment" access="public" output="false" hint="I return the Prepayment">
    <cfreturn variables.instance.Prepayment />
  </cffunction>

  <cffunction name="setPrepayment" access="public"  output="false" hint="I set the Prepayment into the variables.instance scope.">
    <cfargument name="Prepayment" type="Struct" hint="I am the Prepayment." />
      <cfset variables.instance.Prepayment = arguments.Prepayment />
  </cffunction>

  <!---
   * See Overpayment
   * @return Overpayment
  --->
  <cffunction name="getOverpayment" access="public" output="false" hint="I return the Overpayment">
    <cfreturn variables.instance.Overpayment />
  </cffunction>

  <cffunction name="setOverpayment" access="public"  output="false" hint="I set the Overpayment into the variables.instance scope.">
    <cfargument name="Overpayment" type="Struct" hint="I am the Overpayment." />
      <cfset variables.instance.Overpayment = arguments.Overpayment />
  </cffunction>

  <!---
   * Number of invoice or credit note you are applying payment to e.g. INV-4003
   * @return InvoiceNumber
  --->
  <cffunction name="getInvoiceNumber" access="public" output="false" hint="I return the InvoiceNumber">
    <cfreturn variables.instance.InvoiceNumber />
  </cffunction>

  <cffunction name="setInvoiceNumber" access="public"  output="false" hint="I set the InvoiceNumber into the variables.instance scope.">
    <cfargument name="InvoiceNumber" type="String" hint="I am the InvoiceNumber." />
      <cfset variables.instance.InvoiceNumber = arguments.InvoiceNumber />
  </cffunction>

  <!---
   * Number of invoice or credit note you are applying payment to e.g. INV-4003
   * @return CreditNoteNumber
  --->
  <cffunction name="getCreditNoteNumber" access="public" output="false" hint="I return the CreditNoteNumber">
    <cfreturn variables.instance.CreditNoteNumber />
  </cffunction>

  <cffunction name="setCreditNoteNumber" access="public"  output="false" hint="I set the CreditNoteNumber into the variables.instance scope.">
    <cfargument name="CreditNoteNumber" type="String" hint="I am the CreditNoteNumber." />
      <cfset variables.instance.CreditNoteNumber = arguments.CreditNoteNumber />
  </cffunction>

  <!---
   * See Account
   * @return Account
  --->
  <cffunction name="getAccount" access="public" output="false" hint="I return the Account">
    <cfreturn variables.instance.Account />
  </cffunction>

  <cffunction name="setAccount" access="public"  output="false" hint="I set the Account into the variables.instance scope.">
    <cfargument name="Account" type="Struct" hint="I am the Account." />
      <cfset variables.instance.Account = arguments.Account />
  </cffunction>

  <!---
   * Code of account you are using to make the payment e.g. 001 (note: not all accounts have a code value)
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
   * Date the payment is being made (YYYY-MM-DD) e.g. 2009-09-06
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
   * Exchange rate when payment is received. Only used for non base currency invoices and credit notes e.g. 0.7500
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
   * The amount of the payment. Must be less than or equal to the outstanding amount owing on the invoice e.g. 200.00
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
   * An optional description for the payment e.g. Direct Debit
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
   * An optional parameter for the payment. A boolean indicating whether you would like the payment to be created as reconciled when using PUT, or whether a payment has been reconciled when using GET
   * @return IsReconciled
  --->
  <cffunction name="getIsReconciled" access="public" output="false" hint="I return the IsReconciled">
    <cfreturn variables.instance.IsReconciled />
  </cffunction>

  <cffunction name="setIsReconciled" access="public"  output="false" hint="I set the IsReconciled into the variables.instance scope.">
    <cfargument name="IsReconciled" type="String" hint="I am the IsReconciled." />
      <cfset variables.instance.IsReconciled = arguments.IsReconciled />
  </cffunction>

  <!---
   * The status of the payment.
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
   * See Payment Types.
   * @return PaymentType
  --->
  <cffunction name="getPaymentType" access="public" output="false" hint="I return the PaymentType">
    <cfreturn variables.instance.PaymentType />
  </cffunction>

  <cffunction name="setPaymentType" access="public"  output="false" hint="I set the PaymentType into the variables.instance scope.">
    <cfargument name="PaymentType" type="String" hint="I am the PaymentType." />
      <cfset variables.instance.PaymentType = arguments.PaymentType />
  </cffunction>

  <!---
   * UTC timestamp of last update to the payment
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
   * The Xero identifier for an Payment e.g. 297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return PaymentID
  --->
  <cffunction name="getPaymentID" access="public" output="false" hint="I return the PaymentID">
    <cfreturn variables.instance.PaymentID />
  </cffunction>

  <cffunction name="setPaymentID" access="public"  output="false" hint="I set the PaymentID into the variables.instance scope.">
    <cfargument name="PaymentID" type="String" hint="I am the PaymentID." />
      <cfset variables.instance.PaymentID = arguments.PaymentID />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


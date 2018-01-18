<cfcomponent displayname="CreditNote" output="false" extends="cfc.xeroclient"
  hint="I am the CreditNote Class.">

<!--- PROPERTIES --->

  <cfproperty name="Type" type="String" default="" />
  <cfproperty name="Contact" type="Struct" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="LineAmountTypes" type="String" default="" />
  <cfproperty name="LineItems" type="array" default="" />
  <cfproperty name="SubTotal" type="String" default="" />
  <cfproperty name="TotalTax" type="String" default="" />
  <cfproperty name="Total" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="CurrencyCode" type="String" default="" />
  <cfproperty name="FullyPaidOnDate" type="String" default="" />
  <cfproperty name="CreditNoteID" type="String" default="" />
  <cfproperty name="CreditNoteNumber" type="String" default="" />
  <cfproperty name="Reference" type="String" default="" />
  <cfproperty name="SentToContact" type="Boolean" default="" />
  <cfproperty name="CurrencyRate" type="String" default="" />
  <cfproperty name="RemainingCredit" type="String" default="" />
  <cfproperty name="Allocations" type="array" default="" />
  <cfproperty name="BrandingThemeID" type="String" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the CreditNote Class.">
      
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
            myStruct.CreditNoteID=getCreditNoteID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Type")) {
              if (NOT listFindNoCase(arguments.exclude, "Type")) {
                myStruct.Type=getType();
              }
            }
            if (structKeyExists(variables.instance,"Contact")) {
              if (NOT listFindNoCase(arguments.exclude, "Contact")) {
                myStruct.Contact=getContact();
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
            if (structKeyExists(variables.instance,"FullyPaidOnDate")) {
              if (NOT listFindNoCase(arguments.exclude, "FullyPaidOnDate")) {
                myStruct.FullyPaidOnDate=getFullyPaidOnDate();
              }
            }
            if (structKeyExists(variables.instance,"CreditNoteID")) {
              if (NOT listFindNoCase(arguments.exclude, "CreditNoteID")) {
                myStruct.CreditNoteID=getCreditNoteID();
              }
            }
            if (structKeyExists(variables.instance,"CreditNoteNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "CreditNoteNumber")) {
                myStruct.CreditNoteNumber=getCreditNoteNumber();
              }
            }
            if (structKeyExists(variables.instance,"Reference")) {
              if (NOT listFindNoCase(arguments.exclude, "Reference")) {
                myStruct.Reference=getReference();
              }
            }
            if (structKeyExists(variables.instance,"SentToContact")) {
              if (NOT listFindNoCase(arguments.exclude, "SentToContact")) {
                myStruct.SentToContact=getSentToContact();
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
            if (structKeyExists(variables.instance,"BrandingThemeID")) {
              if (NOT listFindNoCase(arguments.exclude, "BrandingThemeID")) {
                if(len(variables.instance.BrandingThemeID) GT 0) {
                  myStruct.BrandingThemeID=getBrandingThemeID();
                }
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                myStruct.HasAttachments=getHasAttachments();
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
          setLineItems(ArrayNew(1));
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
        if (structKeyExists(obj,"FullyPaidOnDate")) {
          setFullyPaidOnDate(obj.FullyPaidOnDate);
        } else {
          setFullyPaidOnDate("");
        }
        if (structKeyExists(obj,"CreditNoteID")) {
          setCreditNoteID(obj.CreditNoteID);
        } else {
          setCreditNoteID("");
        }
        if (structKeyExists(obj,"CreditNoteNumber")) {
          setCreditNoteNumber(obj.CreditNoteNumber);
        } else {
          setCreditNoteNumber("");
        }
        if (structKeyExists(obj,"Reference")) {
          setReference(obj.Reference);
        } else {
          setReference("");
        }
        if (structKeyExists(obj,"SentToContact")) {
          setSentToContact(obj.SentToContact);
        } else {
          setSentToContact(false);
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
          setAllocations(ArrayNew(1));
        }
        if (structKeyExists(obj,"BrandingThemeID")) {
          setBrandingThemeID(obj.BrandingThemeID);
        } else {
          setBrandingThemeID("");
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
      
      <cfset this.setList(this.get(endpoint="CreditNotes"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="CreditNotes",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">

    <cfset variables.result = Super.post(endpoint="CreditNotes",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="CreditNotes",body=this.toJSON(),id=this.getCreditNoteID())>

    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="CreditNotes",body=this.toJSON(archive=true),id=this.getCreditNoteID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="CreditNotes",body=this.toJSON(),id=this.getCreditNoteID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of CreditNotes">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of CreditNotes">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See Credit Note Types
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
   * The date the credit note is issued YYYY-MM-DD. If the Date element is not specified then it will default to the current date based on the timezone setting of the organisation
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
   * See Credit Note Status Codes
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
   * See Invoice Line Amount Types
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
   * See Invoice Line Items
   * @return LineItems
  --->
  <cffunction name="getLineItems" access="public" output="false" hint="I return the LineItems">
    <cfreturn variables.instance.LineItems />
  </cffunction>

  <cffunction name="setLineItems" access="public"  output="false" hint="I set the LineItems into the variables.instance scope.">
    <cfargument name="LineItems" type="array" hint="I am the LineItems." />
			<cfscript>
        var arr = ArrayNew(1);
        for (var i=1;i LTE ArrayLen(arguments.LineItems);i=i+1) {
          var item=createObject("component","cfc.model.LineItem").init().populate(arguments.LineItems[i]); 
          ArrayAppend(arr,item.toStruct());
        }
      </cfscript>
      <cfset variables.instance.LineItems = arr />
		
  </cffunction>

  <!---
   * The subtotal of the credit note excluding taxes
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
   * The total tax on the credit note
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
   * The total of the Credit Note(subtotal + total tax)
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
   * UTC timestamp of last update to the credit note
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
   * Currency used for the Credit Note
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
   * Date when credit note was fully paid(UTC format)
   * @return FullyPaidOnDate
  --->
  <cffunction name="getFullyPaidOnDate" access="public" output="false" hint="I return the FullyPaidOnDate">
    <cfreturn variables.instance.FullyPaidOnDate />
  </cffunction>

  <cffunction name="setFullyPaidOnDate" access="public"  output="false" hint="I set the FullyPaidOnDate into the variables.instance scope.">
    <cfargument name="FullyPaidOnDate" type="String" hint="I am the FullyPaidOnDate." />
      <cfset variables.instance.FullyPaidOnDate = arguments.FullyPaidOnDate />
  </cffunction>

  <!---
   * Xero generated unique identifier
   * @return CreditNoteID
  --->
  <cffunction name="getCreditNoteID" access="public" output="false" hint="I return the CreditNoteID">
    <cfreturn variables.instance.CreditNoteID />
  </cffunction>

  <cffunction name="setCreditNoteID" access="public"  output="false" hint="I set the CreditNoteID into the variables.instance scope.">
    <cfargument name="CreditNoteID" type="String" hint="I am the CreditNoteID." />
      <cfset variables.instance.CreditNoteID = arguments.CreditNoteID />
  </cffunction>

  <!---
   * ACCRECCREDIT – Unique alpha numeric code identifying credit note (when missing will auto-generate from your Organisation Invoice Settings)
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
   * ACCRECCREDIT only – additional reference number
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
   * boolean to indicate if a credit note has been sent to a contact via the Xero app (currently read only)
   * @return SentToContact
  --->
  <cffunction name="getSentToContact" access="public" output="false" hint="I return the SentToContact">
    <cfreturn variables.instance.SentToContact />
  </cffunction>

  <cffunction name="setSentToContact" access="public"  output="false" hint="I set the SentToContact into the variables.instance scope.">
    <cfargument name="SentToContact" type="Boolean" hint="I am the SentToContact." />
      <cfset variables.instance.SentToContact = arguments.SentToContact />
  </cffunction>

  <!---
   * The currency rate for a multicurrency invoice. If no rate is specified, the XE.com day rate is used
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
   * The remaining credit balance on the Credit Note
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
    <cfargument name="Allocations" type="array" hint="I am the Allocations." />
			<cfscript>
		        var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.Allocations);i=i+1) {
		          var item=createObject("component","cfc.model.Allocation").init().populate(arguments.Allocations[i]); 
		          ArrayAppend(arr,item);
		        }
		      </cfscript>
		      <cfset variables.instance.Allocations = arr />
		
  </cffunction>

  <!---
   * See BrandingThemes
   * @return BrandingThemeID
  --->
  <cffunction name="getBrandingThemeID" access="public" output="false" hint="I return the BrandingThemeID">
    <cfreturn variables.instance.BrandingThemeID />
  </cffunction>

  <cffunction name="setBrandingThemeID" access="public"  output="false" hint="I set the BrandingThemeID into the variables.instance scope.">
    <cfargument name="BrandingThemeID" type="String" hint="I am the BrandingThemeID." />
      <cfset variables.instance.BrandingThemeID = arguments.BrandingThemeID />
  </cffunction>

  <!---
   * boolean to indicate if a credit note has an attachment
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


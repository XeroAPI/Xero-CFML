<cfcomponent displayname="Receipt" output="false" extends="xeroclient"
  hint="I am the Receipt Class.">

<!--- PROPERTIES --->

  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="Lineitems" type="List[LineItem]" default="" />
  <cfproperty name="Reference" type="String" default="" />
  <cfproperty name="LineAmountTypes" type="String" default="" />
  <cfproperty name="SubTotal" type="BigDecimal" default="" />
  <cfproperty name="TotalTax" type="BigDecimal" default="" />
  <cfproperty name="Total" type="BigDecimal" default="" />
  <cfproperty name="ReceiptID" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="ReceiptNumber" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />
  <cfproperty name="Url" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Receipt Class.">
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
            myStruct["ReceiptID"]=getReceiptID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Date")) {
              if (NOT listFindNoCase(arguments.exclude, "Date")) {
                myStruct["Date"]=getDate();
              }
            }
            if (structKeyExists(variables.instance,"Lineitems")) {
              if (NOT listFindNoCase(arguments.exclude, "Lineitems")) {
                myStruct["Lineitems"]=getLineitems();
              }
            }
            if (structKeyExists(variables.instance,"Reference")) {
              if (NOT listFindNoCase(arguments.exclude, "Reference")) {
                myStruct["Reference"]=getReference();
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
            if (structKeyExists(variables.instance,"ReceiptID")) {
              if (NOT listFindNoCase(arguments.exclude, "ReceiptID")) {
                myStruct["ReceiptID"]=getReceiptID();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"ReceiptNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "ReceiptNumber")) {
                myStruct["ReceiptNumber"]=getReceiptNumber();
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
            if (structKeyExists(variables.instance,"Url")) {
              if (NOT listFindNoCase(arguments.exclude, "Url")) {
                myStruct["Url"]=getUrl();
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

        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
        }
        if (structKeyExists(obj,"Lineitems")) {
          setLineitems(obj.Lineitems);
        } else {
          setLineitems("");
        }
        if (structKeyExists(obj,"Reference")) {
          setReference(obj.Reference);
        } else {
          setReference("");
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
        if (structKeyExists(obj,"ReceiptID")) {
          setReceiptID(obj.ReceiptID);
        } else {
          setReceiptID("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"ReceiptNumber")) {
          setReceiptNumber(obj.ReceiptNumber);
        } else {
          setReceiptNumber("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"HasAttachments")) {
          setHasAttachments(obj.HasAttachments);
        } else {
          setHasAttachments("");
        }
        if (structKeyExists(obj,"Url")) {
          setUrl(obj.Url);
        } else {
          setUrl("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="Receipts"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Receipts",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Receipts",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Receipts",body=this.toJSON(),id=this.getReceiptID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Receipts",body=this.toJSON(archive=true),id=this.getReceiptID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Receipts",body=this.toJSON(),id=this.getReceiptID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Receipts">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Receipts">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Date of receipt – YYYY-MM-DD
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
   * See LineItems
   * @return Lineitems
  --->
  <cffunction name="getLineitems" access="public" output="false" hint="I return the Lineitems">
    <cfreturn variables.instance.Lineitems />
  </cffunction>

  <cffunction name="setLineitems" access="public"  output="false" hint="I set the Lineitems into the variables.instance scope.">
    <cfargument name="Lineitems" type="List[LineItem]" hint="I am the Lineitems." />
      <cfset variables.instance.Lineitems = arguments.Lineitems />
  </cffunction>

  <!---
   * Additional reference number
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
   * See Line Amount Types
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
   * Total of receipt excluding taxes
   * @return SubTotal
  --->
  <cffunction name="getSubTotal" access="public" output="false" hint="I return the SubTotal">
    <cfreturn variables.instance.SubTotal />
  </cffunction>

  <cffunction name="setSubTotal" access="public"  output="false" hint="I set the SubTotal into the variables.instance scope.">
    <cfargument name="SubTotal" type="BigDecimal" hint="I am the SubTotal." />
      <cfset variables.instance.SubTotal = arguments.SubTotal />
  </cffunction>

  <!---
   * Total tax on receipt
   * @return TotalTax
  --->
  <cffunction name="getTotalTax" access="public" output="false" hint="I return the TotalTax">
    <cfreturn variables.instance.TotalTax />
  </cffunction>

  <cffunction name="setTotalTax" access="public"  output="false" hint="I set the TotalTax into the variables.instance scope.">
    <cfargument name="TotalTax" type="BigDecimal" hint="I am the TotalTax." />
      <cfset variables.instance.TotalTax = arguments.TotalTax />
  </cffunction>

  <!---
   * Total of receipt tax inclusive (i.e. SubTotal + TotalTax)
   * @return Total
  --->
  <cffunction name="getTotal" access="public" output="false" hint="I return the Total">
    <cfreturn variables.instance.Total />
  </cffunction>

  <cffunction name="setTotal" access="public"  output="false" hint="I set the Total into the variables.instance scope.">
    <cfargument name="Total" type="BigDecimal" hint="I am the Total." />
      <cfset variables.instance.Total = arguments.Total />
  </cffunction>

  <!---
   * Xero generated unique identifier for receipt
   * @return ReceiptID
  --->
  <cffunction name="getReceiptID" access="public" output="false" hint="I return the ReceiptID">
    <cfreturn variables.instance.ReceiptID />
  </cffunction>

  <cffunction name="setReceiptID" access="public"  output="false" hint="I set the ReceiptID into the variables.instance scope.">
    <cfargument name="ReceiptID" type="String" hint="I am the ReceiptID." />
      <cfset variables.instance.ReceiptID = arguments.ReceiptID />
  </cffunction>

  <!---
   * Current status of receipt – see status types
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
   * Xero generated sequence number for receipt in current claim for a given user
   * @return ReceiptNumber
  --->
  <cffunction name="getReceiptNumber" access="public" output="false" hint="I return the ReceiptNumber">
    <cfreturn variables.instance.ReceiptNumber />
  </cffunction>

  <cffunction name="setReceiptNumber" access="public"  output="false" hint="I set the ReceiptNumber into the variables.instance scope.">
    <cfargument name="ReceiptNumber" type="String" hint="I am the ReceiptNumber." />
      <cfset variables.instance.ReceiptNumber = arguments.ReceiptNumber />
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
   * boolean to indicate if a receipt has an attachment
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
   * URL link to a source document – shown as “Go to [appName]” in the Xero app
   * @return Url
  --->
  <cffunction name="getUrl" access="public" output="false" hint="I return the Url">
    <cfreturn variables.instance.Url />
  </cffunction>

  <cffunction name="setUrl" access="public"  output="false" hint="I set the Url into the variables.instance scope.">
    <cfargument name="Url" type="String" hint="I am the Url." />
      <cfset variables.instance.Url = arguments.Url />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   

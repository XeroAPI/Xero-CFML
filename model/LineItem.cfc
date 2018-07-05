<cfcomponent displayname="LineItem" output="false" extends="xeroclient"
  hint="I am the LineItem Class.">

<!--- PROPERTIES --->

  <cfproperty name="Description" type="String" default="" />
  <cfproperty name="Quantity" type="String" default="" />
  <cfproperty name="UnitAmount" type="String" default="" />
  <cfproperty name="ItemCode" type="String" default="" />
  <cfproperty name="AccountCode" type="String" default="" />
  <cfproperty name="TaxType" type="String" default="" />
  <cfproperty name="TaxAmount" type="String" default="" />
  <cfproperty name="LineAmount" type="String" default="" />
  <cfproperty name="Tracking" type="array" default="" />
  <cfproperty name="DiscountRate" type="String" default="" />
  <cfproperty name="RepeatingInvoiceID" type="String" default="" />
  <cfproperty name="LineItemID" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the LineItem Class.">
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
    <cfargument name="Only" type="String" default="" hint="I am a list of attributes to exclude from JSON" />
    <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON" />
      <cfif len(arguments.exclude) GT 0>
        <cfset exclude = arguments.exclude>
      <cfelse>
        <cfset exclude = "">
      </cfif>

      <cfif Only EQ "id">
        <cfset exclude = "Description,Quantity,UnitAmount,ItemCode,AccountCode,TaxType,TaxAmount,LineAmount,Tracking,DiscountRate,RepeatingInvoiceID">
      </cfif>

        <cfscript>
          myStruct=StructNew();
          myStruct=this.toJSON(exclude=exclude,returnType="struct");
        </cfscript>
    <cfreturn myStruct />
  </cffunction>

  <cffunction name="toJSON" access="public" output="false">
     <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON payload" />
     <cfargument name="returnType" type="String" default="json" hint="I set how the data is returned" />
    
     
        <cfscript>
          myStruct=StructNew();

          if (structKeyExists(variables.instance,"Description")) {
            if (NOT listFindNoCase(arguments.exclude, "Description")) {
              myStruct["Description"]=getDescription();
            }
          }
          if (structKeyExists(variables.instance,"Quantity")) {
            if (NOT listFindNoCase(arguments.exclude, "Quantity")) {
              myStruct["Quantity"]=getQuantity();
            }
          }
          if (structKeyExists(variables.instance,"UnitAmount")) {
            if (NOT listFindNoCase(arguments.exclude, "UnitAmount")) {
              myStruct["UnitAmount"]=getUnitAmount();
            }
          }
          if (structKeyExists(variables.instance,"ItemCode")) {
            if (NOT listFindNoCase(arguments.exclude, "ItemCode")) {
              if(len(variables.instance.ItemCode) GT 0){
                myStruct["ItemCode"]=getItemCode();
              }
            }
          }
          if (structKeyExists(variables.instance,"AccountCode")) {
            if (NOT listFindNoCase(arguments.exclude, "AccountCode")) {
              myStruct["AccountCode"]=getAccountCode();
            }
          }
          if (structKeyExists(variables.instance,"TaxType")) {
            if (NOT listFindNoCase(arguments.exclude, "TaxType")) {
              myStruct["TaxType"]=getTaxType();
            }
          }
          if (structKeyExists(variables.instance,"TaxAmount")) {
            if (NOT listFindNoCase(arguments.exclude, "TaxAmount")) {
              myStruct["TaxAmount"]=getTaxAmount();
            }
          }
          if (structKeyExists(variables.instance,"LineAmount")) {
            if (NOT listFindNoCase(arguments.exclude, "LineAmount")) {
              myStruct["LineAmount"]=getLineAmount();
            }
          }
          if (structKeyExists(variables.instance,"Tracking")) {
            if (NOT listFindNoCase(arguments.exclude, "Tracking")) {
              myStruct["Tracking"]=getTracking();
            }
          }
          if (structKeyExists(variables.instance,"DiscountRate")) {
            if (NOT listFindNoCase(arguments.exclude, "DiscountRate")) {
              myStruct["DiscountRate"]=getDiscountRate();
            }
          }
          if (structKeyExists(variables.instance,"RepeatingInvoiceID")) {
            if (NOT listFindNoCase(arguments.exclude, "RepeatingInvoiceID")) {
              myStruct["RepeatingInvoiceID"]=getRepeatingInvoiceID();
            }
          }
         if (structKeyExists(variables.instance,"LineItemID")) {
            if (NOT listFindNoCase(arguments.exclude, "LineItemID")) {
              myStruct["LineItemID"]=getLineItemID();
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

        if (structKeyExists(obj,"Description")) {
          setDescription(obj.Description);
        } else {
          setDescription("");
        }
        if (structKeyExists(obj,"Quantity")) {
          setQuantity(obj.Quantity);
        } else {
          setQuantity("");
        }
        if (structKeyExists(obj,"UnitAmount")) {
          setUnitAmount(obj.UnitAmount);
        } else {
          setUnitAmount("");
        }
        if (structKeyExists(obj,"ItemCode")) {
          setItemCode(obj.ItemCode);
        } else {
          setItemCode("");
        }
        if (structKeyExists(obj,"AccountCode")) {
          setAccountCode(obj.AccountCode);
        } else {
          setAccountCode("");
        }
        if (structKeyExists(obj,"TaxType")) {
          setTaxType(obj.TaxType);
        } else {
          setTaxType("");
        }
        if (structKeyExists(obj,"TaxAmount")) {
          setTaxAmount(obj.TaxAmount);
        } else {
          setTaxAmount("");
        }
        if (structKeyExists(obj,"LineAmount")) {
          setLineAmount(obj.LineAmount);
        } else {
          setLineAmount("");
        }
        if (structKeyExists(obj,"Tracking")) {
          setTracking(obj.Tracking);
        } else {
          setTracking(ArrayNew(1));
        }
        if (structKeyExists(obj,"DiscountRate")) {
          setDiscountRate(obj.DiscountRate);
        } else {
          setDiscountRate("");
        }
        if (structKeyExists(obj,"RepeatingInvoiceID")) {
          setRepeatingInvoiceID(obj.RepeatingInvoiceID);
        } else {
          setRepeatingInvoiceID("");
        }
        if (structKeyExists(obj,"LineItemID")) {
          setLineItemID(obj.LineItemID);
        } else {
          setLineItemID("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="LineItems"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="LineItems",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="LineItems",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="LineItems",body=this.toJSON(),id=this.getLineItemID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="LineItems",body=this.toJSON(),id=this.getLineItemID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="LineItems",body=this.toJSON(),id=this.getLineItemID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of LineItems">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of LineItems">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Description needs to be at least 1 char long. A line item with just a description (i.e no unit amount or quantity) can be created by specifying just a <Description> element that contains at least 1 character
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
   * LineItem Quantity
   * @return Quantity
  --->
  <cffunction name="getQuantity" access="public" output="false" hint="I return the Quantity">
    <cfreturn variables.instance.Quantity />
  </cffunction>

  <cffunction name="setQuantity" access="public"  output="false" hint="I set the Quantity into the variables.instance scope.">
    <cfargument name="Quantity" type="String" hint="I am the Quantity." />
      <cfset variables.instance.Quantity = arguments.Quantity />
  </cffunction>

  <!---
   * LineItem Unit Amount
   * @return UnitAmount
  --->
  <cffunction name="getUnitAmount" access="public" output="false" hint="I return the UnitAmount">
    <cfreturn variables.instance.UnitAmount />
  </cffunction>

  <cffunction name="setUnitAmount" access="public"  output="false" hint="I set the UnitAmount into the variables.instance scope.">
    <cfargument name="UnitAmount" type="String" hint="I am the UnitAmount." />
      <cfset variables.instance.UnitAmount = arguments.UnitAmount />
  </cffunction>

  <!---
   * See Items
   * @return ItemCode
  --->
  <cffunction name="getItemCode" access="public" output="false" hint="I return the ItemCode">
    <cfreturn variables.instance.ItemCode />
  </cffunction>

  <cffunction name="setItemCode" access="public"  output="false" hint="I set the ItemCode into the variables.instance scope.">
    <cfargument name="ItemCode" type="String" hint="I am the ItemCode." />
      <cfset variables.instance.ItemCode = arguments.ItemCode />
  </cffunction>

  <!---
   * See Accounts
   * @return AccountCode
  --->
  <cffunction name="getAccountCode" access="public" output="false" hint="I return the AccountCode">
    <cfreturn variables.instance.AccountCode />
  </cffunction>

  <cffunction name="setAccountCode" access="public"  output="false" hint="I set the AccountCode into the variables.instance scope.">
    <cfargument name="AccountCode" type="String" hint="I am the AccountCode." />
      <cfset variables.instance.AccountCode = arguments.AccountCode />
  </cffunction>

  <!---
   * Used as an override if the default Tax Code for the selected <AccountCode> is not correct – see TaxTypes.
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
   * The tax amount is auto calculated as a percentage of the line amount (see below) based on the tax rate. This value can be overriden if the calculated <TaxAmount> is not correct.
   * @return TaxAmount
  --->
  <cffunction name="getTaxAmount" access="public" output="false" hint="I return the TaxAmount">
    <cfreturn variables.instance.TaxAmount />
  </cffunction>

  <cffunction name="setTaxAmount" access="public"  output="false" hint="I set the TaxAmount into the variables.instance scope.">
    <cfargument name="TaxAmount" type="String" hint="I am the TaxAmount." />
      <cfset variables.instance.TaxAmount = arguments.TaxAmount />
  </cffunction>

  <!---
   * If you wish to omit either of the <Quantity> or <UnitAmount> you can provide a LineAmount and Xero will calculate the missing amount for you. The line amount reflects the discounted price if a DiscountRate has been used . i.e LineAmount = Quantity * Unit Amount * ((100 – DiscountRate)/100)
   * @return LineAmount
  --->
  <cffunction name="getLineAmount" access="public" output="false" hint="I return the LineAmount">
    <cfreturn variables.instance.LineAmount />
  </cffunction>

  <cffunction name="setLineAmount" access="public"  output="false" hint="I set the LineAmount into the variables.instance scope.">
    <cfargument name="LineAmount" type="String" hint="I am the LineAmount." />
      <cfset variables.instance.LineAmount = arguments.LineAmount />
  </cffunction>

  <!---
   * Optional Tracking Category – see Tracking.  Any LineItem can have a maximum of 2 <TrackingCategory> elements.
   * @return Tracking
  --->
  <cffunction name="getTracking" access="public" output="false" hint="I return the Tracking">
    <cfreturn variables.instance.Tracking />
  </cffunction>

  <cffunction name="setTracking" access="public"  output="false" hint="I set the Tracking into the variables.instance scope.">
    <cfargument name="Tracking" type="array" hint="I am the Tracking." />
      <cfset variables.instance.Tracking = arguments.Tracking />
  </cffunction>

  <!---
   * Percentage discount being applied to a line item (only supported on ACCREC invoices – ACC PAY invoices and credit notes in Xero do not support discounts
   * @return DiscountRate
  --->
  <cffunction name="getDiscountRate" access="public" output="false" hint="I return the DiscountRate">
    <cfreturn variables.instance.DiscountRate />
  </cffunction>

  <cffunction name="setDiscountRate" access="public"  output="false" hint="I set the DiscountRate into the variables.instance scope.">
    <cfargument name="DiscountRate" type="String" hint="I am the DiscountRate." />
      <cfset variables.instance.DiscountRate = arguments.DiscountRate />
  </cffunction>

  <!---
   * The Xero identifier for a Repeating Invoicee.g. 297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return RepeatingInvoiceID
  --->
  <cffunction name="getRepeatingInvoiceID" access="public" output="false" hint="I return the RepeatingInvoiceID">
    <cfreturn variables.instance.RepeatingInvoiceID />
  </cffunction>

  <cffunction name="setRepeatingInvoiceID" access="public"  output="false" hint="I set the RepeatingInvoiceID into the variables.instance scope.">
    <cfargument name="RepeatingInvoiceID" type="String" hint="I am the RepeatingInvoiceID." />
      <cfset variables.instance.RepeatingInvoiceID = arguments.RepeatingInvoiceID />
  </cffunction>


  <!---
   * The Xero identifier for a LineItem.g. 297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return LineItemID
  --->
  <cffunction name="getLineItemID" access="public" output="false" hint="I return the RepeatingInvoiceID">
    <cfreturn variables.instance.LineItemID />
  </cffunction>

  <cffunction name="setLineItemID" access="public"  output="false" hint="I set the RepeatingInvoiceID into the variables.instance scope.">
    <cfargument name="LineItemID" type="String" hint="I am the RepeatingInvoiceID." />
      <cfset variables.instance.LineItemID = arguments.LineItemID />
  </cffunction>

<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   




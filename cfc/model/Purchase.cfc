<cfcomponent displayname="Purchase" output="false" extends="cfc.xeroclient"
  hint="I am the Purchase Class.">

<!--- PROPERTIES --->

  <cfproperty name="UnitPrice" type="String" default="" />
  <cfproperty name="AccountCode" type="String" default="" />
  <cfproperty name="COGSAccountCode" type="String" default="" />
  <cfproperty name="TaxType" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Purchase Class.">
      
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

          if (structKeyExists(variables.instance,"UnitPrice")) {
            if (NOT listFindNoCase(arguments.exclude, "UnitPrice")) {
              myStruct.UnitPrice=getUnitPrice();
            }
          }
          if (structKeyExists(variables.instance,"AccountCode")) {
            if (NOT listFindNoCase(arguments.exclude, "AccountCode")) {
              myStruct.AccountCode=getAccountCode();
            }
          }
          if (structKeyExists(variables.instance,"COGSAccountCode")) {
            if (NOT listFindNoCase(arguments.exclude, "COGSAccountCode")) {
              myStruct.COGSAccountCode=getCOGSAccountCode();
            }
          }
          if (structKeyExists(variables.instance,"TaxType")) {
            if (NOT listFindNoCase(arguments.exclude, "TaxType")) {
              myStruct.TaxType=getTaxType();
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

        if (structKeyExists(obj,"UnitPrice")) {
          setUnitPrice(obj.UnitPrice);
        } else {
          setUnitPrice("");
        }
        if (structKeyExists(obj,"AccountCode")) {
          setAccountCode(obj.AccountCode);
        } else {
          setAccountCode("");
        }
        if (structKeyExists(obj,"COGSAccountCode")) {
          setCOGSAccountCode(obj.COGSAccountCode);
        } else {
          setCOGSAccountCode("");
        }
        if (structKeyExists(obj,"TaxType")) {
          setTaxType(obj.TaxType);
        } else {
          setTaxType("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="Purchases"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Purchases",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Purchases",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Purchases",body=this.toJSON(),id=this.getPurchaseID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Purchases",body=this.toJSON(),id=this.getPurchaseID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Purchases",body=this.toJSON(),id=this.getPurchaseID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Purchases">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Purchases">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Unit Price of the item. By default UnitPrice is rounded to two decimal places. You can use 4 decimal places by adding the unitdp=4 querystring parameter to your request.
   * @return UnitPrice
  --->
  <cffunction name="getUnitPrice" access="public" output="false" hint="I return the UnitPrice">
    <cfreturn variables.instance.UnitPrice />
  </cffunction>

  <cffunction name="setUnitPrice" access="public"  output="false" hint="I set the UnitPrice into the variables.instance scope.">
    <cfargument name="UnitPrice" type="String" hint="I am the UnitPrice." />
      <cfset variables.instance.UnitPrice = arguments.UnitPrice />
  </cffunction>

  <!---
   * Default account code to be used for purchased/sale. Not applicable to the purchase details of tracked items
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
   * Cost of goods sold account. Only applicable to the purchase details of tracked items.
   * @return COGSAccountCode
  --->
  <cffunction name="getCOGSAccountCode" access="public" output="false" hint="I return the COGSAccountCode">
    <cfreturn variables.instance.COGSAccountCode />
  </cffunction>

  <cffunction name="setCOGSAccountCode" access="public"  output="false" hint="I set the COGSAccountCode into the variables.instance scope.">
    <cfargument name="COGSAccountCode" type="String" hint="I am the COGSAccountCode." />
      <cfset variables.instance.COGSAccountCode = arguments.COGSAccountCode />
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



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   

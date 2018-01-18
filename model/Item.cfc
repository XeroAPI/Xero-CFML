<cfcomponent displayname="Item" output="false" extends="cfc.xeroclient"
  hint="I am the Item Class.">

<!--- PROPERTIES --->

  <cfproperty name="Code" type="String" default="" />
  <cfproperty name="InventoryAssetAccountCode" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="IsSold" type="Boolean" default="" />
  <cfproperty name="IsPurchased" type="Boolean" default="" />
  <cfproperty name="Description" type="String" default="" />
  <cfproperty name="PurchaseDescription" type="String" default="" />
  <cfproperty name="PurchaseDetails" type="Struct" default="" />
  <cfproperty name="SalesDetails" type="Struct" default="" />
  <cfproperty name="IsTrackedAsInventory" type="Boolean" default="" />
  <cfproperty name="TotalCostPool" type="String" default="" />
  <cfproperty name="QuantityOnHand" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="ItemID" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Item Class.">
      
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
            myStruct.ItemID=getItemID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Code")) {
              if (NOT listFindNoCase(arguments.exclude, "Code")) {
                myStruct.Code=getCode();
              }
            }
            if (structKeyExists(variables.instance,"InventoryAssetAccountCode")) {
              if (NOT listFindNoCase(arguments.exclude, "InventoryAssetAccountCode")) {
                myStruct.InventoryAssetAccountCode=getInventoryAssetAccountCode();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct.Name=getName();
              }
            }
            if (structKeyExists(variables.instance,"IsSold")) {
              if (NOT listFindNoCase(arguments.exclude, "IsSold")) {
                myStruct.IsSold=getIsSold();
              }
            }
            if (structKeyExists(variables.instance,"IsPurchased")) {
              if (NOT listFindNoCase(arguments.exclude, "IsPurchased")) {
                myStruct.IsPurchased=getIsPurchased();
              }
            }
            if (structKeyExists(variables.instance,"Description")) {
              if (NOT listFindNoCase(arguments.exclude, "Description")) {
                myStruct.Description=getDescription();
              }
            }
            if (structKeyExists(variables.instance,"PurchaseDescription")) {
              if (NOT listFindNoCase(arguments.exclude, "PurchaseDescription")) {
                myStruct.PurchaseDescription=getPurchaseDescription();
              }
            }
            if (structKeyExists(variables.instance,"PurchaseDetails")) {
              if (NOT listFindNoCase(arguments.exclude, "PurchaseDetails")) {
                myStruct.PurchaseDetails=getPurchaseDetails();
              }
            }
            if (structKeyExists(variables.instance,"SalesDetails")) {
              if (NOT listFindNoCase(arguments.exclude, "SalesDetails")) {
                myStruct.SalesDetails=getSalesDetails();
              }
            }
            if (structKeyExists(variables.instance,"IsTrackedAsInventory")) {
              if (NOT listFindNoCase(arguments.exclude, "IsTrackedAsInventory")) {
                myStruct.IsTrackedAsInventory=getIsTrackedAsInventory();
              }
            }
            if (structKeyExists(variables.instance,"TotalCostPool")) {
              if (NOT listFindNoCase(arguments.exclude, "TotalCostPool")) {
                myStruct.TotalCostPool=getTotalCostPool();
              }
            }
            if (structKeyExists(variables.instance,"QuantityOnHand")) {
              if (NOT listFindNoCase(arguments.exclude, "QuantityOnHand")) {
                myStruct.QuantityOnHand=getQuantityOnHand();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct.UpdatedDateUTC=getUpdatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"ItemID")) {
              if (NOT listFindNoCase(arguments.exclude, "ItemID")) {
                myStruct.ItemID=getItemID();
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
        if (structKeyExists(obj,"InventoryAssetAccountCode")) {
          setInventoryAssetAccountCode(obj.InventoryAssetAccountCode);
        } else {
          setInventoryAssetAccountCode("");
        }
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"IsSold")) {
          setIsSold(obj.IsSold);
        } else {
          setIsSold(false);
        }
        if (structKeyExists(obj,"IsPurchased")) {
          setIsPurchased(obj.IsPurchased);
        } else {
          setIsPurchased(false);
        }
        if (structKeyExists(obj,"Description")) {
          setDescription(obj.Description);
        } else {
          setDescription("");
        }
        if (structKeyExists(obj,"PurchaseDescription")) {
          setPurchaseDescription(obj.PurchaseDescription);
        } else {
          setPurchaseDescription("");
        }
        if (structKeyExists(obj,"PurchaseDetails")) {
          setPurchaseDetails(obj.PurchaseDetails);
        } else {
          setPurchaseDetails(StructNew());
        }
        if (structKeyExists(obj,"SalesDetails")) {
          setSalesDetails(obj.SalesDetails);
        } else {
          setSalesDetails(StructNew());
        }
        if (structKeyExists(obj,"IsTrackedAsInventory")) {
          setIsTrackedAsInventory(obj.IsTrackedAsInventory);
        } else {
          setIsTrackedAsInventory(false);
        }
        if (structKeyExists(obj,"TotalCostPool")) {
          setTotalCostPool(obj.TotalCostPool);
        } else {
          setTotalCostPool("");
        }
        if (structKeyExists(obj,"QuantityOnHand")) {
          setQuantityOnHand(obj.QuantityOnHand);
        } else {
          setQuantityOnHand("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"ItemID")) {
          setItemID(obj.ItemID);
        } else {
          setItemID("");
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
      
      <cfset this.setList(this.get(endpoint="Items"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Items",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Items",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Items",body=this.toJSON(),id=this.getItemID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Items",body=this.toJSON(archive=true),id=this.getItemID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Items",body=this.toJSON(),id=this.getItemID())>
      
     <cfset temp = this.populate(variables.result)>
    <cfreturn this />
  </cffunction>

  <cffunction name="getObject" access="public" returntype="any">
    <cfargument name="position"  type="numeric" default="">
      <cfscript>
        this.populate(this.getList()[position]);
      </cfscript> 
    <cfreturn this>
  </cffunction>

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Items">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Items">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * User defined item code (max length = 30)
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
   * The inventory asset account for the item. The account must be of type INVENTORY. The  COGSAccountCode in PurchaseDetails is also required to create a tracked item
   * @return InventoryAssetAccountCode
  --->
  <cffunction name="getInventoryAssetAccountCode" access="public" output="false" hint="I return the InventoryAssetAccountCode">
    <cfreturn variables.instance.InventoryAssetAccountCode />
  </cffunction>

  <cffunction name="setInventoryAssetAccountCode" access="public"  output="false" hint="I set the InventoryAssetAccountCode into the variables.instance scope.">
    <cfargument name="InventoryAssetAccountCode" type="String" hint="I am the InventoryAssetAccountCode." />
      <cfset variables.instance.InventoryAssetAccountCode = arguments.InventoryAssetAccountCode />
  </cffunction>

  <!---
   * The name of the item (max length = 50)
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
   * Boolean value, defaults to true. When IsSold is true the item will be available on sales transactions in the Xero UI. If IsSold is updated to false then Description and SalesDetails values will be nulled.
   * @return IsSold
  --->
  <cffunction name="getIsSold" access="public" output="false" hint="I return the IsSold">
    <cfreturn variables.instance.IsSold />
  </cffunction>

  <cffunction name="setIsSold" access="public"  output="false" hint="I set the IsSold into the variables.instance scope.">
    <cfargument name="IsSold" type="Boolean" hint="I am the IsSold." />
      <cfset variables.instance.IsSold = arguments.IsSold />
  </cffunction>

  <!---
   * Boolean value, defaults to true. When IsPurchased is true the item is available for purchase transactions in the Xero UI. If IsPurchased is updated to false then PurchaseDescription and PurchaseDetails values will be nulled.
   * @return IsPurchased
  --->
  <cffunction name="getIsPurchased" access="public" output="false" hint="I return the IsPurchased">
    <cfreturn variables.instance.IsPurchased />
  </cffunction>

  <cffunction name="setIsPurchased" access="public"  output="false" hint="I set the IsPurchased into the variables.instance scope.">
    <cfargument name="IsPurchased" type="Boolean" hint="I am the IsPurchased." />
      <cfset variables.instance.IsPurchased = arguments.IsPurchased />
  </cffunction>

  <!---
   * The sales description of the item (max length = 4000)
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
   * The purchase description of the item (max length = 4000)
   * @return PurchaseDescription
  --->
  <cffunction name="getPurchaseDescription" access="public" output="false" hint="I return the PurchaseDescription">
    <cfreturn variables.instance.PurchaseDescription />
  </cffunction>

  <cffunction name="setPurchaseDescription" access="public"  output="false" hint="I set the PurchaseDescription into the variables.instance scope.">
    <cfargument name="PurchaseDescription" type="String" hint="I am the PurchaseDescription." />
      <cfset variables.instance.PurchaseDescription = arguments.PurchaseDescription />
  </cffunction>

  <!---
   * See Purchases & Sales
   * @return PurchaseDetails
  --->
  <cffunction name="getPurchaseDetails" access="public" output="false" hint="I return the PurchaseDetails">
    <cfreturn variables.instance.PurchaseDetails />
  </cffunction>

  <cffunction name="setPurchaseDetails" access="public"  output="false" hint="I set the PurchaseDetails into the variables.instance scope.">
    <cfargument name="PurchaseDetails" type="Struct" hint="I am the PurchaseDetails." />
      <cfset variables.instance.PurchaseDetails = arguments.PurchaseDetails />
  </cffunction>

  <!---
   * See Purchases & Sales
   * @return SalesDetails
  --->
  <cffunction name="getSalesDetails" access="public" output="false" hint="I return the SalesDetails">
    <cfreturn variables.instance.SalesDetails />
  </cffunction>

  <cffunction name="setSalesDetails" access="public"  output="false" hint="I set the SalesDetails into the variables.instance scope.">
    <cfargument name="SalesDetails" type="Struct" hint="I am the SalesDetails." />
      <cfset variables.instance.SalesDetails = arguments.SalesDetails />
  </cffunction>

  <!---
   * True for items that are tracked as inventory. An item will be tracked as inventory if the InventoryAssetAccountCode and COGSAccountCode are set.
   * @return IsTrackedAsInventory
  --->
  <cffunction name="getIsTrackedAsInventory" access="public" output="false" hint="I return the IsTrackedAsInventory">
    <cfreturn variables.instance.IsTrackedAsInventory />
  </cffunction>

  <cffunction name="setIsTrackedAsInventory" access="public"  output="false" hint="I set the IsTrackedAsInventory into the variables.instance scope.">
    <cfargument name="IsTrackedAsInventory" type="Boolean" hint="I am the IsTrackedAsInventory." />
      <cfset variables.instance.IsTrackedAsInventory = arguments.IsTrackedAsInventory />
  </cffunction>

  <!---
   * The value of the item on hand. Calculated using average cost accounting.
   * @return TotalCostPool
  --->
  <cffunction name="getTotalCostPool" access="public" output="false" hint="I return the TotalCostPool">
    <cfreturn variables.instance.TotalCostPool />
  </cffunction>

  <cffunction name="setTotalCostPool" access="public"  output="false" hint="I set the TotalCostPool into the variables.instance scope.">
    <cfargument name="TotalCostPool" type="String" hint="I am the TotalCostPool." />
      <cfset variables.instance.TotalCostPool = arguments.TotalCostPool />
  </cffunction>

  <!---
   * The quantity of the item on hand
   * @return QuantityOnHand
  --->
  <cffunction name="getQuantityOnHand" access="public" output="false" hint="I return the QuantityOnHand">
    <cfreturn variables.instance.QuantityOnHand />
  </cffunction>

  <cffunction name="setQuantityOnHand" access="public"  output="false" hint="I set the QuantityOnHand into the variables.instance scope.">
    <cfargument name="QuantityOnHand" type="String" hint="I am the QuantityOnHand." />
      <cfset variables.instance.QuantityOnHand = arguments.QuantityOnHand />
  </cffunction>

  <!---
   * Last modified date in UTC format
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
   * The Xero identifier for an Item
   * @return ItemID
  --->
  <cffunction name="getItemID" access="public" output="false" hint="I return the ItemID">
    <cfreturn variables.instance.ItemID />
  </cffunction>

  <cffunction name="setItemID" access="public"  output="false" hint="I set the ItemID into the variables.instance scope.">
    <cfargument name="ItemID" type="String" hint="I am the ItemID." />
      <cfset variables.instance.ItemID = arguments.ItemID />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



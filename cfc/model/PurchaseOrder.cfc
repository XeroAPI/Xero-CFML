<cfcomponent displayname="PurchaseOrder" output="false" extends="cfc.xeroclient"
  hint="I am the PurchaseOrder Class.">

<!--- PROPERTIES --->

  <cfproperty name="Contact" type="Struct" default="" />
  <cfproperty name="LineItems" type="array" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="DeliveryDate" type="String" default="" />
  <cfproperty name="LineAmountTypes" type="String" default="" />
  <cfproperty name="PurchaseOrderNumber" type="String" default="" />
  <cfproperty name="Reference" type="String" default="" />
  <cfproperty name="BrandingThemeID" type="String" default="" />
  <cfproperty name="CurrencyCode" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="SentToContact" type="Boolean" default="" />
  <cfproperty name="DeliveryAddress" type="String" default="" />
  <cfproperty name="AttentionTo" type="String" default="" />
  <cfproperty name="Telephone" type="String" default="" />
  <cfproperty name="DeliveryInstructions" type="String" default="" />
  <cfproperty name="ExpectedArrivalDate" type="String" default="" />
  <cfproperty name="PurchaseOrderID" type="String" default="" />
  <cfproperty name="CurrencyRate" type="String" default="" />
  <cfproperty name="SubTotal" type="String" default="" />
  <cfproperty name="TotalTax" type="String" default="" />
  <cfproperty name="Total" type="String" default="" />
  <cfproperty name="TotalDiscount" type="String" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the PurchaseOrder Class.">
     <cfset temp = this.populate(StructNew())>
 
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
            myStruct.PurchaseOrderID=getPurchaseOrderID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Contact")) {
              if (NOT listFindNoCase(arguments.exclude, "Contact")) {
                myStruct.Contact=getContact();
              }
            }
            if (structKeyExists(variables.instance,"LineItems")) {
              if (NOT listFindNoCase(arguments.exclude, "LineItems")) {
                myStruct.LineItems=getLineItems();
              }
            }
            if (structKeyExists(variables.instance,"Date")) {
              if (NOT listFindNoCase(arguments.exclude, "Date")) {
                myStruct.Date=getDate();
              }
            }
            if (structKeyExists(variables.instance,"DeliveryDate")) {
              if (NOT listFindNoCase(arguments.exclude, "DeliveryDate")) {
                myStruct.DeliveryDate=getDeliveryDate();
              }
            }
            if (structKeyExists(variables.instance,"LineAmountTypes")) {
              if (NOT listFindNoCase(arguments.exclude, "LineAmountTypes")) {
                if(len(getLineAmountTypes()) GT 0) {
                  myStruct.LineAmountTypes=getLineAmountTypes();
                }
              }
            } 
            if (structKeyExists(variables.instance,"PurchaseOrderNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "PurchaseOrderNumber")) {
                if(len(getPurchaseOrderNumber()) GT 0) {
                  myStruct.PurchaseOrderNumber=getPurchaseOrderNumber();
                }
              }
            }
            if (structKeyExists(variables.instance,"Reference")) {
              if (NOT listFindNoCase(arguments.exclude, "Reference")) {
                myStruct.Reference=getReference();
              }
            }
            if (structKeyExists(variables.instance,"BrandingThemeID")) {
              if (NOT listFindNoCase(arguments.exclude, "BrandingThemeID")) {
                if(len(getBrandingThemeID()) GT 0) {
                  myStruct.BrandingThemeID=getBrandingThemeID();
                }
              }
            }
            if (structKeyExists(variables.instance,"CurrencyCode")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyCode")) {
               if(len(getCurrencyCode()) GT 0) {
                  myStruct.CurrencyCode=getCurrencyCode();
                } 
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                if(len(getStatus()) GT 0) {
                  myStruct.Status=getStatus();
                } 
              }
            }
            if (structKeyExists(variables.instance,"SentToContact")) {
              if (NOT listFindNoCase(arguments.exclude, "SentToContact")) {
                if(len(getSentToContact()) GT 0) {
                  myStruct.SentToContact=getSentToContact();
                }
              }
            }
            if (structKeyExists(variables.instance,"DeliveryAddress")) {
              if (NOT listFindNoCase(arguments.exclude, "DeliveryAddress")) {
                myStruct.DeliveryAddress=getDeliveryAddress();
              }
            }
            if (structKeyExists(variables.instance,"AttentionTo")) {
              if (NOT listFindNoCase(arguments.exclude, "AttentionTo")) {
                myStruct.AttentionTo=getAttentionTo();
              }
            }
            if (structKeyExists(variables.instance,"Telephone")) {
              if (NOT listFindNoCase(arguments.exclude, "Telephone")) {
                myStruct.Telephone=getTelephone();
              }
            }
            if (structKeyExists(variables.instance,"DeliveryInstructions")) {
              if (NOT listFindNoCase(arguments.exclude, "DeliveryInstructions")) {
                myStruct.DeliveryInstructions=getDeliveryInstructions();
              }
            }
            if (structKeyExists(variables.instance,"ExpectedArrivalDate")) {
              if (NOT listFindNoCase(arguments.exclude, "ExpectedArrivalDate")) {
                myStruct.ExpectedArrivalDate=getExpectedArrivalDate();
              }
            }
            if (structKeyExists(variables.instance,"PurchaseOrderID")) {
              if (NOT listFindNoCase(arguments.exclude, "PurchaseOrderID")) {
                if(len(getPurchaseOrderID()) GT 0) {
                  myStruct.PurchaseOrderID=getPurchaseOrderID();
                }
              }
            }
            if (structKeyExists(variables.instance,"CurrencyRate")) {
              if (NOT listFindNoCase(arguments.exclude, "CurrencyRate")) {
                myStruct.CurrencyRate=getCurrencyRate();
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
            if (structKeyExists(variables.instance,"TotalDiscount")) {
              if (NOT listFindNoCase(arguments.exclude, "TotalDiscount")) {
                myStruct.TotalDiscount=getTotalDiscount();
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                myStruct.HasAttachments=getHasAttachments();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct.UpdatedDateUTC=getUpdatedDateUTC();
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

        if (structKeyExists(obj,"Contact")) {
          setContact(obj.Contact);
        } else {
          setContact(StructNew());
        }
        if (structKeyExists(obj,"LineItems")) {
          setLineItems(obj.LineItems);
        } else {
          setLineItems(ArrayNew(1));
        }
        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
        }
        if (structKeyExists(obj,"DeliveryDate")) {
          setDeliveryDate(obj.DeliveryDate);
        } else {
          setDeliveryDate("");
        }
        if (structKeyExists(obj,"LineAmountTypes")) {
          setLineAmountTypes(obj.LineAmountTypes);
        } else {
          setLineAmountTypes("");
        }
        if (structKeyExists(obj,"PurchaseOrderNumber")) {
          setPurchaseOrderNumber(obj.PurchaseOrderNumber);
        } else {
          setPurchaseOrderNumber("");
        }
        if (structKeyExists(obj,"Reference")) {
          setReference(obj.Reference);
        } else {
          setReference("");
        }
        if (structKeyExists(obj,"BrandingThemeID")) {
          setBrandingThemeID(obj.BrandingThemeID);
        } else {
          setBrandingThemeID("");
        }
        if (structKeyExists(obj,"CurrencyCode")) {
          setCurrencyCode(obj.CurrencyCode);
        } else {
          setCurrencyCode("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"SentToContact")) {
          setSentToContact(obj.SentToContact);
        } else {
          setSentToContact(false);
        }
        if (structKeyExists(obj,"DeliveryAddress")) {
          setDeliveryAddress(obj.DeliveryAddress);
        } else {
          setDeliveryAddress("");
        }
        if (structKeyExists(obj,"AttentionTo")) {
          setAttentionTo(obj.AttentionTo);
        } else {
          setAttentionTo("");
        }
        if (structKeyExists(obj,"Telephone")) {
          setTelephone(obj.Telephone);
        } else {
          setTelephone("");
        }
        if (structKeyExists(obj,"DeliveryInstructions")) {
          setDeliveryInstructions(obj.DeliveryInstructions);
        } else {
          setDeliveryInstructions("");
        }
        if (structKeyExists(obj,"ExpectedArrivalDate")) {
          setExpectedArrivalDate(obj.ExpectedArrivalDate);
        } else {
          setExpectedArrivalDate("");
        }
        if (structKeyExists(obj,"PurchaseOrderID")) {
          setPurchaseOrderID(obj.PurchaseOrderID);
        } else {
          setPurchaseOrderID("");
        }
        if (structKeyExists(obj,"CurrencyRate")) {
          setCurrencyRate(obj.CurrencyRate);
        } else {
          setCurrencyRate("");
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
        if (structKeyExists(obj,"TotalDiscount")) {
          setTotalDiscount(obj.TotalDiscount);
        } else {
          setTotalDiscount("");
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
      
      <cfset this.setList(this.get(endpoint="PurchaseOrders"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="PurchaseOrders",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="PurchaseOrders",body=this.toJSON(exclude="SentToContact"))>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="PurchaseOrders",body=this.toJSON(),id=this.getPurchaseOrderID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="PurchaseOrders",body=this.toJSON(archive=true),id=this.getPurchaseOrderID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="PurchaseOrders",body=this.toJSON(),id=this.getPurchaseOrderID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of PurchaseOrders">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of PurchaseOrders">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See Contact
   * @return Contact
  --->
  <cffunction name="getContact" access="public" output="false" hint="I return the Contact">
    <cfreturn variables.instance.Contact />
  </cffunction>

  <cffunction name="setContact" access="public"  output="false" hint="I set the Contact into the variables.instance scope.">
    <cfargument name="Contact" type="Struct" hint="I am the Contact." />
      <cfset variables.instance.Contact = arguments.Contact />
  </cffunction>

  <!---
   * See LineItems
   * @return LineItems
  --->
  <cffunction name="getLineItems" access="public" output="false" hint="I return the LineItems">
    <cfset var lines = variables.instance.Lineitems>
    <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(lines);i=i+1) {
              ArrayAppend(arr,lines[i].toStruct());
            }
    </cfscript>
    <cfreturn arr />
  </cffunction>

  <cffunction name="setLineItems" access="public"  output="false" hint="I set the LineItems into the variables.instance scope.">
    <cfargument name="LineItems" type="array" hint="I am the LineItems." />
			<cfscript>
		        var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.LineItems);i=i+1) {
		          var item=createObject("component","cfc.model.LineItem").init().populate(arguments.LineItems[i]); 
		          ArrayAppend(arr,item);
		        }
		      </cfscript>
		      <cfset variables.instance.LineItems = arr />
		
  </cffunction>

  <!---
   * Date purchase order was issued – YYYY-MM-DD. If the Date element is not specified then it will default to the current date based on the timezone setting of the organisation
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
   * Date the goods are to be delivered – YYYY-MM-DD
   * @return DeliveryDate
  --->
  <cffunction name="getDeliveryDate" access="public" output="false" hint="I return the DeliveryDate">
    <cfreturn variables.instance.DeliveryDate />
  </cffunction>

  <cffunction name="setDeliveryDate" access="public"  output="false" hint="I set the DeliveryDate into the variables.instance scope.">
    <cfargument name="DeliveryDate" type="String" hint="I am the DeliveryDate." />
      <cfset variables.instance.DeliveryDate = arguments.DeliveryDate />
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
   * Unique alpha numeric code identifying purchase order (when missing will auto-generate from your Organisation Invoice Settings)
   * @return PurchaseOrderNumber
  --->
  <cffunction name="getPurchaseOrderNumber" access="public" output="false" hint="I return the PurchaseOrderNumber">
    <cfreturn variables.instance.PurchaseOrderNumber />
  </cffunction>

  <cffunction name="setPurchaseOrderNumber" access="public"  output="false" hint="I set the PurchaseOrderNumber into the variables.instance scope.">
    <cfargument name="PurchaseOrderNumber" type="String" hint="I am the PurchaseOrderNumber." />
      <cfset variables.instance.PurchaseOrderNumber = arguments.PurchaseOrderNumber />
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
   * The currency that purchase order has been raised in (see Currencies)
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
   * See Purchase Order Status Codes
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
   * Boolean to set whether the purchase order should be marked as “sent”. This can be set only on purchase orders that have been approved or billed
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
   * The address the goods are to be delivered to
   * @return DeliveryAddress
  --->
  <cffunction name="getDeliveryAddress" access="public" output="false" hint="I return the DeliveryAddress">
    <cfreturn variables.instance.DeliveryAddress />
  </cffunction>

  <cffunction name="setDeliveryAddress" access="public"  output="false" hint="I set the DeliveryAddress into the variables.instance scope.">
    <cfargument name="DeliveryAddress" type="String" hint="I am the DeliveryAddress." />
      <cfset variables.instance.DeliveryAddress = arguments.DeliveryAddress />
  </cffunction>

  <!---
   * The person that the delivery is going to
   * @return AttentionTo
  --->
  <cffunction name="getAttentionTo" access="public" output="false" hint="I return the AttentionTo">
    <cfreturn variables.instance.AttentionTo />
  </cffunction>

  <cffunction name="setAttentionTo" access="public"  output="false" hint="I set the AttentionTo into the variables.instance scope.">
    <cfargument name="AttentionTo" type="String" hint="I am the AttentionTo." />
      <cfset variables.instance.AttentionTo = arguments.AttentionTo />
  </cffunction>

  <!---
   * The phone number for the person accepting the delivery
   * @return Telephone
  --->
  <cffunction name="getTelephone" access="public" output="false" hint="I return the Telephone">
    <cfreturn variables.instance.Telephone />
  </cffunction>

  <cffunction name="setTelephone" access="public"  output="false" hint="I set the Telephone into the variables.instance scope.">
    <cfargument name="Telephone" type="String" hint="I am the Telephone." />
      <cfset variables.instance.Telephone = arguments.Telephone />
  </cffunction>

  <!---
   * A free text feild for instructions (500 characters max)
   * @return DeliveryInstructions
  --->
  <cffunction name="getDeliveryInstructions" access="public" output="false" hint="I return the DeliveryInstructions">
    <cfreturn variables.instance.DeliveryInstructions />
  </cffunction>

  <cffunction name="setDeliveryInstructions" access="public"  output="false" hint="I set the DeliveryInstructions into the variables.instance scope.">
    <cfargument name="DeliveryInstructions" type="String" hint="I am the DeliveryInstructions." />
      <cfset variables.instance.DeliveryInstructions = arguments.DeliveryInstructions />
  </cffunction>

  <!---
   * The date the goods are expected to arrive.
   * @return ExpectedArrivalDate
  --->
  <cffunction name="getExpectedArrivalDate" access="public" output="false" hint="I return the ExpectedArrivalDate">
    <cfreturn variables.instance.ExpectedArrivalDate />
  </cffunction>

  <cffunction name="setExpectedArrivalDate" access="public"  output="false" hint="I set the ExpectedArrivalDate into the variables.instance scope.">
    <cfargument name="ExpectedArrivalDate" type="String" hint="I am the ExpectedArrivalDate." />
      <cfset variables.instance.ExpectedArrivalDate = arguments.ExpectedArrivalDate />
  </cffunction>

  <!---
   * Xero generated unique identifier for purchase order
   * @return PurchaseOrderID
  --->
  <cffunction name="getPurchaseOrderID" access="public" output="false" hint="I return the PurchaseOrderID">
    <cfreturn variables.instance.PurchaseOrderID />
  </cffunction>

  <cffunction name="setPurchaseOrderID" access="public"  output="false" hint="I set the PurchaseOrderID into the variables.instance scope.">
    <cfargument name="PurchaseOrderID" type="String" hint="I am the PurchaseOrderID." />
      <cfset variables.instance.PurchaseOrderID = arguments.PurchaseOrderID />
  </cffunction>

  <!---
   * The currency rate for a multicurrency purchase order. As no rate can be specified, the XE.com day rate is used.
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
   * Total of purchase order excluding taxes
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
   * Total tax on purchase order
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
   * Total of Purchase Order tax inclusive (i.e. SubTotal + TotalTax)
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
   * Total of discounts applied on the purchase order line items
   * @return TotalDiscount
  --->
  <cffunction name="getTotalDiscount" access="public" output="false" hint="I return the TotalDiscount">
    <cfreturn variables.instance.TotalDiscount />
  </cffunction>

  <cffunction name="setTotalDiscount" access="public"  output="false" hint="I set the TotalDiscount into the variables.instance scope.">
    <cfargument name="TotalDiscount" type="String" hint="I am the TotalDiscount." />
      <cfset variables.instance.TotalDiscount = arguments.TotalDiscount />
  </cffunction>

  <!---
   * boolean to indicate if a purchase order has an attachment
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


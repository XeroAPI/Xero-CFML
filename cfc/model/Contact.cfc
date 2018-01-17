<cfcomponent displayname="Contact" output="false" extends="cfc.xeroclient"
  hint="I am the Contact Class.">

<!--- PROPERTIES --->

  <cfproperty name="ContactID" type="String" default="" />
  <cfproperty name="ContactNumber" type="String" default="" />
  <cfproperty name="AccountNumber" type="String" default="" />
  <cfproperty name="ContactStatus" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="FirstName" type="String" default="" />
  <cfproperty name="LastName" type="String" default="" />
  <cfproperty name="EmailAddress" type="String" default="" />
  <cfproperty name="SkypeUserName" type="String" default="" />
  <cfproperty name="ContactPersons" type="array" default="" />
  <cfproperty name="BankAccountDetails" type="String" default="" />
  <cfproperty name="TaxNumber" type="String" default="" />
  <cfproperty name="AccountsReceivableTaxType" type="String" default="" />
  <cfproperty name="AccountsPayableTaxType" type="String" default="" />
  <cfproperty name="Addresses" type="array" default="" />
  <cfproperty name="Phones" type="array" default="" />
  <cfproperty name="IsSupplier" type="Boolean" default="" />
  <cfproperty name="IsCustomer" type="Boolean" default="" />
  <cfproperty name="DefaultCurrency" type="String" default="" />
  <cfproperty name="XeroNetworkKey" type="String" default="" />
  <cfproperty name="SalesDefaultAccountCode" type="String" default="" />
  <cfproperty name="PurchasesDefaultAccountCode" type="String" default="" />
  <cfproperty name="SalesTrackingCategories" type="array" default="" />
  <cfproperty name="PurchasesTrackingCategories" type="array" default="" />
  <cfproperty name="TrackingCategoryName" type="String" default="" />
  <cfproperty name="TrackingCategoryOption" type="String" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="ContactGroups" type="array" default="" />
  <cfproperty name="Website" type="String" default="" />
  <cfproperty name="BatchPayments" type="String" default="" />
  <cfproperty name="Discount" type="String" default="" />
  <cfproperty name="Balances" type="Struct" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Contact Class.">
      
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
        <cfset exclude = "ContactStatus,ContactNumber,AccountNumber,Name,FirstName,LastName,EmailAddress,SkypeUserName,ContactPersons,BankAccountDetails,TaxNumber,AccountsReceivableTaxType,AccountsPayableTaxType,Addresses,Phones,IsSupplier,IsCustomer,DefaultCurrency,XeroNetworkKey,SalesDefaultAccountCode,PurchasesDefaultAccountCode,SalesTrackingCategories,PurchasesTrackingCategories,TrackingCategoryName,TrackingCategoryOption,UpdatedDateUTC,ContactGroups,Website,BatchPayments,Discount,Balances,HasAttachments">
      </cfif>
        <cfscript>
          myStruct=StructNew();
          myStruct=this.toJSON(exclude=exclude,returnType="struct");
        </cfscript>
    <cfreturn myStruct />
  </cffunction>

  <cffunction name="toJSON" access="public" output="false">
    <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON" />
    <cfargument name="archive" type="boolean" default="false" hint="Return only the req. fields as JSON for archiving an object" />
    <cfargument name="returnType" type="String" default="json" hint="I set how the data is returned" />
    
        <cfscript>
          myStruct=StructNew();
          if (archive) {
            myStruct.ContactID=getContactID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"ContactID")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactID")) {
                if (len(variables.instance.ContactID) GT 0) {
                  myStruct.ContactID=getContactID();
                }
              }
            }
            if (structKeyExists(variables.instance,"ContactNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactNumber")) {
                if (len(variables.instance.ContactNumber) GT 0) {
                  myStruct.ContactNumber=getContactNumber();
                }
              }
            }
            if (structKeyExists(variables.instance,"AccountNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "AccountNumber")) {
                if (len(variables.instance.AccountNumber) GT 0) {
                  myStruct.AccountNumber=getAccountNumber();
                }
              }
            }
            if (structKeyExists(variables.instance,"ContactStatus")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactStatus")) {
                if (len(variables.instance.ContactStatus) GT 0) {
                  myStruct.ContactStatus=getContactStatus();
                }
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                if (len(variables.instance.Name) GT 0) {
                  myStruct.Name=getName();
                }
              }
            }
            if (structKeyExists(variables.instance,"FirstName")) {
              if (NOT listFindNoCase(arguments.exclude, "FirstName")) {
                if (len(variables.instance.FirstName) GT 0) {
                  myStruct.FirstName=getFirstName();
                }
              }
            }
            if (structKeyExists(variables.instance,"LastName")) {
              if (NOT listFindNoCase(arguments.exclude, "LastName")) {
                if (len(variables.instance.LastName) GT 0) {
                  myStruct.LastName=getLastName();
                }
              }
            }
            if (structKeyExists(variables.instance,"EmailAddress")) {
              if (NOT listFindNoCase(arguments.exclude, "EmailAddress")) {
                if (len(variables.instance.EmailAddress) GT 0) {
                  myStruct.EmailAddress=getEmailAddress();
                }
              }
            }
            if (structKeyExists(variables.instance,"SkypeUserName")) {
              if (NOT listFindNoCase(arguments.exclude, "SkypeUserName")) {
                if (len(variables.instance.SkypeUserName) GT 0) {
                  myStruct.SkypeUserName=getSkypeUserName();
                }
              }
            }
            if (structKeyExists(variables.instance,"ContactPersons")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactPersons")) {
                if (ArrayLen(variables.instance.ContactPersons) GT 0) {
                  myStruct.ContactPersons=getContactPersons();
                }
              }
            }
            if (structKeyExists(variables.instance,"BankAccountDetails")) {
              if (NOT listFindNoCase(arguments.exclude, "BankAccountDetails")) {
                if (len(variables.instance.BankAccountDetails) GT 0) {
                  myStruct.BankAccountDetails=getBankAccountDetails();
                }
              }
            }
            if (structKeyExists(variables.instance,"TaxNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "TaxNumber")) {
                if (len(variables.instance.TaxNumber) GT 0) {
                  myStruct.TaxNumber=getTaxNumber();
                }
              }
            }
            if (structKeyExists(variables.instance,"AccountsReceivableTaxType")) {
              if (NOT listFindNoCase(arguments.exclude, "AccountsReceivableTaxType")) {
                if (len(variables.instance.AccountsReceivableTaxType) GT 0) {
                  myStruct.AccountsReceivableTaxType=getAccountsReceivableTaxType();
                }
              }
            }
            if (structKeyExists(variables.instance,"AccountsPayableTaxType")) {
              if (NOT listFindNoCase(arguments.exclude, "AccountsPayableTaxType")) {
                if (len(variables.instance.AccountsPayableTaxType) GT 0) {
                  myStruct.AccountsPayableTaxType=getAccountsPayableTaxType();
                }
              }
            }
            if (structKeyExists(variables.instance,"Addresses")) {
              if (NOT listFindNoCase(arguments.exclude, "Addresses")) {
                if (ArrayLen(variables.instance.Addresses) GT 0) {
                  myStruct.Addresses=getAddresses();
                }
              }
            }
            if (structKeyExists(variables.instance,"Phones")) {
              if (NOT listFindNoCase(arguments.exclude, "Phones")) {
                if (ArrayLen(variables.instance.Phones) GT 0) {
                  myStruct.Phones=getPhones();
                }
              }
            }
            if (structKeyExists(variables.instance,"IsSupplier")) {
              if (NOT listFindNoCase(arguments.exclude, "IsSupplier")) {
                if (len(variables.instance.IsSupplier) GT 0) {
                  myStruct.IsSupplier=getIsSupplier();
                }
              }
            }
            if (structKeyExists(variables.instance,"IsCustomer")) {
              if (NOT listFindNoCase(arguments.exclude, "IsCustomer")) {
                if (len(variables.instance.IsCustomer) GT 0) {
                  myStruct.IsCustomer=getIsCustomer();
                }
              }
            }
            if (structKeyExists(variables.instance,"DefaultCurrency")) {
              if (NOT listFindNoCase(arguments.exclude, "DefaultCurrency")) {
                if (len(variables.instance.DefaultCurrency) GT 0) {
                  myStruct.DefaultCurrency=getDefaultCurrency();
                }
              }
            }
            if (structKeyExists(variables.instance,"XeroNetworkKey")) {
              if (NOT listFindNoCase(arguments.exclude, "XeroNetworkKey")) {
                if (len(variables.instance.XeroNetworkKey) GT 0) {
                  myStruct.XeroNetworkKey=getXeroNetworkKey();
                }
              }
            }
            if (structKeyExists(variables.instance,"SalesDefaultAccountCode")) {
              if (NOT listFindNoCase(arguments.exclude, "SalesDefaultAccountCode")) {
                if (len(variables.instance.SalesDefaultAccountCode) GT 0) {
                  myStruct.SalesDefaultAccountCode=getSalesDefaultAccountCode();
                }
              }
            }
            if (structKeyExists(variables.instance,"PurchasesDefaultAccountCode")) {
              if (NOT listFindNoCase(arguments.exclude, "PurchasesDefaultAccountCode")) {
                if (len(variables.instance.PurchasesDefaultAccountCode) GT 0) {
                  myStruct.PurchasesDefaultAccountCode=getPurchasesDefaultAccountCode();
                }
              }
            }
            if (structKeyExists(variables.instance,"SalesTrackingCategories")) {
              if (NOT listFindNoCase(arguments.exclude, "SalesTrackingCategories")) {
                if (ArrayLen(variables.instance.SalesTrackingCategories) GT 0) {
                  myStruct.SalesTrackingCategories=getSalesTrackingCategories();
                }
              }
            }
            if (structKeyExists(variables.instance,"PurchasesTrackingCategories")) {
              if (NOT listFindNoCase(arguments.exclude, "PurchasesTrackingCategories")) {
                if (ArrayLen(variables.instance.PurchasesTrackingCategories) GT 0) {
                  myStruct.PurchasesTrackingCategories=getPurchasesTrackingCategories();
                }
              }
            }
            if (structKeyExists(variables.instance,"TrackingCategoryName")) {
              if (NOT listFindNoCase(arguments.exclude, "TrackingCategoryName")) {
                if (len(variables.instance.TrackingCategoryName) GT 0) {
                  myStruct.TrackingCategoryName=getTrackingCategoryName();
                }
              }
            }
            if (structKeyExists(variables.instance,"TrackingCategoryOption")) {
              if (NOT listFindNoCase(arguments.exclude, "TrackingCategoryOption")) {
                if (len(variables.instance.TrackingCategoryOption) GT 0) {
                  myStruct.TrackingCategoryOption=getTrackingCategoryOption();
                }
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                if (len(variables.instance.UpdatedDateUTC) GT 0) {
                  myStruct.UpdatedDateUTC=getUpdatedDateUTC();
                }
              }
            }
            if (structKeyExists(variables.instance,"ContactGroups")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactGroups")) {
                if (ArrayLen(variables.instance.ContactGroups) GT 0) {
                  myStruct.ContactGroups=getContactGroups();
                }
              }
            }
            if (structKeyExists(variables.instance,"Website")) {
              if (NOT listFindNoCase(arguments.exclude, "Website")) {
                if (len(variables.instance.Website) GT 0) {
                  myStruct.Website=getWebsite();
                }
              }
            }
            if (structKeyExists(variables.instance,"BatchPayments")) {
              if (NOT listFindNoCase(arguments.exclude, "BatchPayments")) {
                if (len(variables.instance.BatchPayments) GT 0) {
                  myStruct.BatchPayments=getBatchPayments();
                }
              }
            }
            if (structKeyExists(variables.instance,"Discount")) {
              if (NOT listFindNoCase(arguments.exclude, "Discount")) {
                if (len(variables.instance.Discount) GT 0) {
                  myStruct.Discount=getDiscount();
                }
              }
            }
            if (structKeyExists(variables.instance,"Balances")) {
              if (NOT listFindNoCase(arguments.exclude, "Balances")) {
                if (NOT structIsEmpty(variables.instance.Balances) GT 0) {
                  myStruct.Balances=getBalances();
                }
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                if (len(variables.instance.HasAttachments) GT 0) {
                  myStruct.HasAttachments=getHasAttachments();
                }
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

        if (structKeyExists(obj,"ContactID")) {
          setContactID(obj.ContactID);
        } else {
          setContactID("");
        }
        if (structKeyExists(obj,"ContactNumber")) {
          setContactNumber(obj.ContactNumber);
        } else {
          setContactNumber("");
        }
        if (structKeyExists(obj,"AccountNumber")) {
          setAccountNumber(obj.AccountNumber);
        } else {
          setAccountNumber("");
        }
        if (structKeyExists(obj,"ContactStatus")) {
          setContactStatus(obj.ContactStatus);
        } else {
          setContactStatus("");
        }
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"FirstName")) {
          setFirstName(obj.FirstName);
        } else {
          setFirstName("");
        }
        if (structKeyExists(obj,"LastName")) {
          setLastName(obj.LastName);
        } else {
          setLastName("");
        }
        if (structKeyExists(obj,"EmailAddress")) {
          setEmailAddress(obj.EmailAddress);
        } else {
          setEmailAddress("");
        }
        if (structKeyExists(obj,"SkypeUserName")) {
          setSkypeUserName(obj.SkypeUserName);
        } else {
          setSkypeUserName("");
        }
        if (structKeyExists(obj,"ContactPersons")) {
          setContactPersons(obj.ContactPersons);
        } else {
          setContactPersons(ArrayNew(1));
        }
        if (structKeyExists(obj,"BankAccountDetails")) {
          setBankAccountDetails(obj.BankAccountDetails);
        } else {
          setBankAccountDetails("");
        }
        if (structKeyExists(obj,"TaxNumber")) {
          setTaxNumber(obj.TaxNumber);
        } else {
          setTaxNumber("");
        }
        if (structKeyExists(obj,"AccountsReceivableTaxType")) {
          setAccountsReceivableTaxType(obj.AccountsReceivableTaxType);
        } else {
          setAccountsReceivableTaxType("");
        }
        if (structKeyExists(obj,"AccountsPayableTaxType")) {
          setAccountsPayableTaxType(obj.AccountsPayableTaxType);
        } else {
          setAccountsPayableTaxType("");
        }
        if (structKeyExists(obj,"Addresses")) {
          setAddresses(obj.Addresses);
        } else {
          setAddresses(ArrayNew(1));
        }
        if (structKeyExists(obj,"Phones")) {
          setPhones(obj.Phones);
        } else {
          setPhones(ArrayNew(1));
        }
        if (structKeyExists(obj,"IsSupplier")) {
          setIsSupplier(obj.IsSupplier);
        } else {
          setIsSupplier(false);
        }
        if (structKeyExists(obj,"IsCustomer")) {
          setIsCustomer(obj.IsCustomer);
        } else {
          setIsCustomer(false);
        }
        if (structKeyExists(obj,"DefaultCurrency")) {
          setDefaultCurrency(obj.DefaultCurrency);
        } else {
          setDefaultCurrency("");
        }
        if (structKeyExists(obj,"XeroNetworkKey")) {
          setXeroNetworkKey(obj.XeroNetworkKey);
        } else {
          setXeroNetworkKey("");
        }
        if (structKeyExists(obj,"SalesDefaultAccountCode")) {
          setSalesDefaultAccountCode(obj.SalesDefaultAccountCode);
        } else {
          setSalesDefaultAccountCode("");
        }
        if (structKeyExists(obj,"PurchasesDefaultAccountCode")) {
          setPurchasesDefaultAccountCode(obj.PurchasesDefaultAccountCode);
        } else {
          setPurchasesDefaultAccountCode("");
        }
        if (structKeyExists(obj,"SalesTrackingCategories")) {
          setSalesTrackingCategories(obj.SalesTrackingCategories);
        } else {
          setSalesTrackingCategories(ArrayNew(1));
        }
        if (structKeyExists(obj,"PurchasesTrackingCategories")) {
          setPurchasesTrackingCategories(obj.PurchasesTrackingCategories);
        } else {
          setPurchasesTrackingCategories(ArrayNew(1));
        }
        if (structKeyExists(obj,"TrackingCategoryName")) {
          setTrackingCategoryName(obj.TrackingCategoryName);
        } else {
          setTrackingCategoryName("");
        }
        if (structKeyExists(obj,"TrackingCategoryOption")) {
          setTrackingCategoryOption(obj.TrackingCategoryOption);
        } else {
          setTrackingCategoryOption("");
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"ContactGroups")) {
          setContactGroups(obj.ContactGroups);
        } else {
          setContactGroups(ArrayNew(1));
        }
        if (structKeyExists(obj,"Website")) {
          setWebsite(obj.Website);
        } else {
          setWebsite("");
        }
        if (structKeyExists(obj,"BatchPayments")) {
          setBatchPayments(obj.BatchPayments);
        } else {
          setBatchPayments("");
        }
        if (structKeyExists(obj,"Discount")) {
          setDiscount(obj.Discount);
        } else {
          setDiscount("");
        }
        if (structKeyExists(obj,"Balances")) {
          setBalances(obj.Balances);
        } else {
          setBalances(StructNew());
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
      
      <cfset this.setList(this.get(endpoint="Contacts"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Contacts",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Contacts",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Contacts",body=this.toJSON(),id=this.getContactID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Contacts",body=this.toJSON(),id=this.getContactID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Contacts",body=this.toJSON(),id=this.getContactID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Contacts">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Contacts">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Xero identifier
   * @return ContactID
  --->
  <cffunction name="getContactID" access="public" output="false" hint="I return the ContactID">
    <cfreturn variables.instance.ContactID />
  </cffunction>

  <cffunction name="setContactID" access="public"  output="false" hint="I set the ContactID into the variables.instance scope.">
    <cfargument name="ContactID" type="String" hint="I am the ContactID." />
      <cfset variables.instance.ContactID = arguments.ContactID />
  </cffunction>

  <!---
   * This can be updated via the API only i.e. This field is read only on the Xero contact screen, used to identify contacts in external systems (max length = 50). If the Contact Number is used, this is displayed as Contact Code in the Contacts UI in Xero.
   * @return ContactNumber
  --->
  <cffunction name="getContactNumber" access="public" output="false" hint="I return the ContactNumber">
    <cfreturn variables.instance.ContactNumber />
  </cffunction>

  <cffunction name="setContactNumber" access="public"  output="false" hint="I set the ContactNumber into the variables.instance scope.">
    <cfargument name="ContactNumber" type="String" hint="I am the ContactNumber." />
      <cfset variables.instance.ContactNumber = arguments.ContactNumber />
  </cffunction>

  <!---
   * A user defined account number. This can be updated via the API and the Xero UI (max length = 50)
   * @return AccountNumber
  --->
  <cffunction name="getAccountNumber" access="public" output="false" hint="I return the AccountNumber">
    <cfreturn variables.instance.AccountNumber />
  </cffunction>

  <cffunction name="setAccountNumber" access="public"  output="false" hint="I set the AccountNumber into the variables.instance scope.">
    <cfargument name="AccountNumber" type="String" hint="I am the AccountNumber." />
      <cfset variables.instance.AccountNumber = arguments.AccountNumber />
  </cffunction>

  <!---
   * Current status of a contact – see contact status types
   * @return ContactStatus
  --->
  <cffunction name="getContactStatus" access="public" output="false" hint="I return the ContactStatus">
    <cfreturn variables.instance.ContactStatus />
  </cffunction>

  <cffunction name="setContactStatus" access="public"  output="false" hint="I set the ContactStatus into the variables.instance scope.">
    <cfargument name="ContactStatus" type="String" hint="I am the ContactStatus." />
      <cfset variables.instance.ContactStatus = arguments.ContactStatus />
  </cffunction>

  <!---
   * Full name of contact/organisation (max length = 255)
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
   * First name of contact person (max length = 255)
   * @return FirstName
  --->
  <cffunction name="getFirstName" access="public" output="false" hint="I return the FirstName">
    <cfreturn variables.instance.FirstName />
  </cffunction>

  <cffunction name="setFirstName" access="public"  output="false" hint="I set the FirstName into the variables.instance scope.">
    <cfargument name="FirstName" type="String" hint="I am the FirstName." />
      <cfset variables.instance.FirstName = arguments.FirstName />
  </cffunction>

  <!---
   * Last name of contact person (max length = 255)
   * @return LastName
  --->
  <cffunction name="getLastName" access="public" output="false" hint="I return the LastName">
    <cfreturn variables.instance.LastName />
  </cffunction>

  <cffunction name="setLastName" access="public"  output="false" hint="I set the LastName into the variables.instance scope.">
    <cfargument name="LastName" type="String" hint="I am the LastName." />
      <cfset variables.instance.LastName = arguments.LastName />
  </cffunction>

  <!---
   * Email address of contact person (umlauts not supported) (max length = 255)
   * @return EmailAddress
  --->
  <cffunction name="getEmailAddress" access="public" output="false" hint="I return the EmailAddress">
    <cfreturn variables.instance.EmailAddress />
  </cffunction>

  <cffunction name="setEmailAddress" access="public"  output="false" hint="I set the EmailAddress into the variables.instance scope.">
    <cfargument name="EmailAddress" type="String" hint="I am the EmailAddress." />
      <cfset variables.instance.EmailAddress = arguments.EmailAddress />
  </cffunction>

  <!---
   * Skype user name of contact
   * @return SkypeUserName
  --->
  <cffunction name="getSkypeUserName" access="public" output="false" hint="I return the SkypeUserName">
    <cfreturn variables.instance.SkypeUserName />
  </cffunction>

  <cffunction name="setSkypeUserName" access="public"  output="false" hint="I set the SkypeUserName into the variables.instance scope.">
    <cfargument name="SkypeUserName" type="String" hint="I am the SkypeUserName." />
      <cfset variables.instance.SkypeUserName = arguments.SkypeUserName />
  </cffunction>

  <!---
   * See contact persons
   * @return ContactPersons
  --->
  <cffunction name="getContactPersons" access="public" output="false" hint="I return the ContactPersons">
    <cfreturn variables.instance.ContactPersons />
  </cffunction>

  <cffunction name="setContactPersons" access="public"  output="false" hint="I set the ContactPersons into the variables.instance scope.">
    <cfargument name="ContactPersons" type="array" hint="I am the ContactPersons." />
			<cfscript>
		        var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.ContactPersons);i=i+1) {
		          var item=createObject("component","cfc.model.ContactPerson").init().populate(arguments.ContactPersons[i]); 
		          ArrayAppend(arr,item);
		        }
		      </cfscript>
		      <cfset variables.instance.ContactPersons = arr />
		
  </cffunction>

  <!---
   * Bank account number of contact
   * @return BankAccountDetails
  --->
  <cffunction name="getBankAccountDetails" access="public" output="false" hint="I return the BankAccountDetails">
    <cfreturn variables.instance.BankAccountDetails />
  </cffunction>

  <cffunction name="setBankAccountDetails" access="public"  output="false" hint="I set the BankAccountDetails into the variables.instance scope.">
    <cfargument name="BankAccountDetails" type="String" hint="I am the BankAccountDetails." />
      <cfset variables.instance.BankAccountDetails = arguments.BankAccountDetails />
  </cffunction>

  <!---
   * Tax number of contact – this is also known as the ABN (Australia), GST Number (New Zealand), VAT Number (UK) or Tax ID Number (US and global) in the Xero UI depending on which regionalized version of Xero you are using (max length = 50)
   * @return TaxNumber
  --->
  <cffunction name="getTaxNumber" access="public" output="false" hint="I return the TaxNumber">
    <cfreturn variables.instance.TaxNumber />
  </cffunction>

  <cffunction name="setTaxNumber" access="public"  output="false" hint="I set the TaxNumber into the variables.instance scope.">
    <cfargument name="TaxNumber" type="String" hint="I am the TaxNumber." />
      <cfset variables.instance.TaxNumber = arguments.TaxNumber />
  </cffunction>

  <!---
   * Default tax type used for contact on AR invoices
   * @return AccountsReceivableTaxType
  --->
  <cffunction name="getAccountsReceivableTaxType" access="public" output="false" hint="I return the AccountsReceivableTaxType">
    <cfreturn variables.instance.AccountsReceivableTaxType />
  </cffunction>

  <cffunction name="setAccountsReceivableTaxType" access="public"  output="false" hint="I set the AccountsReceivableTaxType into the variables.instance scope.">
    <cfargument name="AccountsReceivableTaxType" type="String" hint="I am the AccountsReceivableTaxType." />
      <cfset variables.instance.AccountsReceivableTaxType = arguments.AccountsReceivableTaxType />
  </cffunction>

  <!---
   * Default tax type used for contact on AP invoices
   * @return AccountsPayableTaxType
  --->
  <cffunction name="getAccountsPayableTaxType" access="public" output="false" hint="I return the AccountsPayableTaxType">
    <cfreturn variables.instance.AccountsPayableTaxType />
  </cffunction>

  <cffunction name="setAccountsPayableTaxType" access="public"  output="false" hint="I set the AccountsPayableTaxType into the variables.instance scope.">
    <cfargument name="AccountsPayableTaxType" type="String" hint="I am the AccountsPayableTaxType." />
      <cfset variables.instance.AccountsPayableTaxType = arguments.AccountsPayableTaxType />
  </cffunction>

  <!---
   * Store certain address types for a contact – see address types
   * @return Addresses
  --->
  <cffunction name="getAddresses" access="public" output="false" hint="I return the Addresses">
    <cfreturn variables.instance.Addresses />
  </cffunction>

  <cffunction name="setAddresses" access="public"  output="false" hint="I set the Addresses into the variables.instance scope.">
    <cfargument name="Addresses" type="array" hint="I am the Addresses." />
			<cfscript>
        var arr = ArrayNew(1);
        for (var i=1;i LTE ArrayLen(arguments.Addresses);i=i+1) {
          var item=createObject("component","cfc.model.Address").init().populate(arguments.Addresses[i]); 
          ArrayAppend(arr,item);
        }
      </cfscript>
      <cfset variables.instance.Addresses = arr />
  </cffunction>

  <!---
   * Store certain phone types for a contact – see phone types
   * @return Phones
  --->
  <cffunction name="getPhones" access="public" output="false" hint="I return the Phones">
    <cfreturn variables.instance.Phones />
  </cffunction>

  <cffunction name="setPhones" access="public"  output="false" hint="I set the Phones into the variables.instance scope.">
    <cfargument name="Phones" type="array" hint="I am the Phones." />
			<cfscript>
		        var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.Phones);i=i+1) {
		          var item=createObject("component","cfc.model.Phone").init().populate(arguments.Phones[i]); 
		          ArrayAppend(arr,item);
		        }
		      </cfscript>
		      <cfset variables.instance.Phones = arr />
		
  </cffunction>

  <!---
   * true or false – Boolean that describes if a contact that has any AP invoices entered against them. Cannot be set via PUT or POST – it is automatically set when an accounts payable invoice is generated against this contact.
   * @return IsSupplier
  --->
  <cffunction name="getIsSupplier" access="public" output="false" hint="I return the IsSupplier">
    <cfreturn variables.instance.IsSupplier />
  </cffunction>

  <cffunction name="setIsSupplier" access="public"  output="false" hint="I set the IsSupplier into the variables.instance scope.">
    <cfargument name="IsSupplier" type="Boolean" hint="I am the IsSupplier." />
      <cfset variables.instance.IsSupplier = arguments.IsSupplier />
  </cffunction>

  <!---
   * true or false – Boolean that describes if a contact has any AR invoices entered against them. Cannot be set via PUT or POST – it is automatically set when an accounts receivable invoice is generated against this contact.
   * @return IsCustomer
  --->
  <cffunction name="getIsCustomer" access="public" output="false" hint="I return the IsCustomer">
    <cfreturn variables.instance.IsCustomer />
  </cffunction>

  <cffunction name="setIsCustomer" access="public"  output="false" hint="I set the IsCustomer into the variables.instance scope.">
    <cfargument name="IsCustomer" type="Boolean" hint="I am the IsCustomer." />
      <cfset variables.instance.IsCustomer = arguments.IsCustomer />
  </cffunction>

  <!---
   * Default currency for raising invoices against contact
   * @return DefaultCurrency
  --->
  <cffunction name="getDefaultCurrency" access="public" output="false" hint="I return the DefaultCurrency">
    <cfreturn variables.instance.DefaultCurrency />
  </cffunction>

  <cffunction name="setDefaultCurrency" access="public"  output="false" hint="I set the DefaultCurrency into the variables.instance scope.">
    <cfargument name="DefaultCurrency" type="String" hint="I am the DefaultCurrency." />
      <cfset variables.instance.DefaultCurrency = arguments.DefaultCurrency />
  </cffunction>

  <!---
   * Store XeroNetworkKey for contacts.
   * @return XeroNetworkKey
  --->
  <cffunction name="getXeroNetworkKey" access="public" output="false" hint="I return the XeroNetworkKey">
    <cfreturn variables.instance.XeroNetworkKey />
  </cffunction>

  <cffunction name="setXeroNetworkKey" access="public"  output="false" hint="I set the XeroNetworkKey into the variables.instance scope.">
    <cfargument name="XeroNetworkKey" type="String" hint="I am the XeroNetworkKey." />
      <cfset variables.instance.XeroNetworkKey = arguments.XeroNetworkKey />
  </cffunction>

  <!---
   * The default sales account code for contacts
   * @return SalesDefaultAccountCode
  --->
  <cffunction name="getSalesDefaultAccountCode" access="public" output="false" hint="I return the SalesDefaultAccountCode">
    <cfreturn variables.instance.SalesDefaultAccountCode />
  </cffunction>

  <cffunction name="setSalesDefaultAccountCode" access="public"  output="false" hint="I set the SalesDefaultAccountCode into the variables.instance scope.">
    <cfargument name="SalesDefaultAccountCode" type="String" hint="I am the SalesDefaultAccountCode." />
      <cfset variables.instance.SalesDefaultAccountCode = arguments.SalesDefaultAccountCode />
  </cffunction>

  <!---
   * The default purchases account code for contacts
   * @return PurchasesDefaultAccountCode
  --->
  <cffunction name="getPurchasesDefaultAccountCode" access="public" output="false" hint="I return the PurchasesDefaultAccountCode">
    <cfreturn variables.instance.PurchasesDefaultAccountCode />
  </cffunction>

  <cffunction name="setPurchasesDefaultAccountCode" access="public"  output="false" hint="I set the PurchasesDefaultAccountCode into the variables.instance scope.">
    <cfargument name="PurchasesDefaultAccountCode" type="String" hint="I am the PurchasesDefaultAccountCode." />
      <cfset variables.instance.PurchasesDefaultAccountCode = arguments.PurchasesDefaultAccountCode />
  </cffunction>

  <!---
   * The default sales tracking categories for contacts
   * @return SalesTrackingCategories
  --->
  <cffunction name="getSalesTrackingCategories" access="public" output="false" hint="I return the SalesTrackingCategories">
    <cfreturn variables.instance.SalesTrackingCategories />
  </cffunction>

  <cffunction name="setSalesTrackingCategories" access="public"  output="false" hint="I set the SalesTrackingCategories into the variables.instance scope.">
    <cfargument name="SalesTrackingCategories" type="array" hint="I am the SalesTrackingCategories." />
      <cfset variables.instance.SalesTrackingCategories = arguments.SalesTrackingCategories />
  </cffunction>

  <!---
   * The default purchases tracking categories for contacts
   * @return PurchasesTrackingCategories
  --->
  <cffunction name="getPurchasesTrackingCategories" access="public" output="false" hint="I return the PurchasesTrackingCategories">
    <cfreturn variables.instance.PurchasesTrackingCategories />
  </cffunction>

  <cffunction name="setPurchasesTrackingCategories" access="public"  output="false" hint="I set the PurchasesTrackingCategories into the variables.instance scope.">
    <cfargument name="PurchasesTrackingCategories" type="array" hint="I am the PurchasesTrackingCategories." />
      <cfset variables.instance.PurchasesTrackingCategories = arguments.PurchasesTrackingCategories />
  </cffunction>

  <!---
   * The name of the Tracking Category assigned to the contact under SalesTrackingCategories and PurchasesTrackingCategories
   * @return TrackingCategoryName
  --->
  <cffunction name="getTrackingCategoryName" access="public" output="false" hint="I return the TrackingCategoryName">
    <cfreturn variables.instance.TrackingCategoryName />
  </cffunction>

  <cffunction name="setTrackingCategoryName" access="public"  output="false" hint="I set the TrackingCategoryName into the variables.instance scope.">
    <cfargument name="TrackingCategoryName" type="String" hint="I am the TrackingCategoryName." />
      <cfset variables.instance.TrackingCategoryName = arguments.TrackingCategoryName />
  </cffunction>

  <!---
   * The name of the Tracking Option assigned to the contact under SalesTrackingCategories and PurchasesTrackingCategories
   * @return TrackingCategoryOption
  --->
  <cffunction name="getTrackingCategoryOption" access="public" output="false" hint="I return the TrackingCategoryOption">
    <cfreturn variables.instance.TrackingCategoryOption />
  </cffunction>

  <cffunction name="setTrackingCategoryOption" access="public"  output="false" hint="I set the TrackingCategoryOption into the variables.instance scope.">
    <cfargument name="TrackingCategoryOption" type="String" hint="I am the TrackingCategoryOption." />
      <cfset variables.instance.TrackingCategoryOption = arguments.TrackingCategoryOption />
  </cffunction>

  <!---
   * UTC timestamp of last update to contact
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
   * Displays which contact groups a contact is included in
   * @return ContactGroups
  --->
  <cffunction name="getContactGroups" access="public" output="false" hint="I return the ContactGroups">
    <cfreturn variables.instance.ContactGroups />
  </cffunction>

  <cffunction name="setContactGroups" access="public"  output="false" hint="I set the ContactGroups into the variables.instance scope.">
    <cfargument name="ContactGroups" type="array" hint="I am the ContactGroups." />
			<cfscript>
		        var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.ContactGroups);i=i+1) {
		          var item=createObject("component","cfc.model.ContactGroup").init().populate(arguments.ContactGroups[i]); 
		          ArrayAppend(arr,item);
		        }
		      </cfscript>
		      <cfset variables.instance.ContactGroups = arr />
		
  </cffunction>

  <!---
   * Website address for contact (read only)
   * @return Website
  --->
  <cffunction name="getWebsite" access="public" output="false" hint="I return the Website">
    <cfreturn variables.instance.Website />
  </cffunction>

  <cffunction name="setWebsite" access="public"  output="false" hint="I set the Website into the variables.instance scope.">
    <cfargument name="Website" type="String" hint="I am the Website." />
      <cfset variables.instance.Website = arguments.Website />
  </cffunction>

  <!---
   * batch payment details for contact (read only)
   * @return BatchPayments
  --->
  <cffunction name="getBatchPayments" access="public" output="false" hint="I return the BatchPayments">
    <cfreturn variables.instance.BatchPayments />
  </cffunction>

  <cffunction name="setBatchPayments" access="public"  output="false" hint="I set the BatchPayments into the variables.instance scope.">
    <cfargument name="BatchPayments" type="String" hint="I am the BatchPayments." />
      <cfset variables.instance.BatchPayments = arguments.BatchPayments />
  </cffunction>

  <!---
   * The default discount rate for the contact (read only)
   * @return Discount
  --->
  <cffunction name="getDiscount" access="public" output="false" hint="I return the Discount">
    <cfreturn variables.instance.Discount />
  </cffunction>

  <cffunction name="setDiscount" access="public"  output="false" hint="I set the Discount into the variables.instance scope.">
    <cfargument name="Discount" type="String" hint="I am the Discount." />
      <cfset variables.instance.Discount = arguments.Discount />
  </cffunction>

  <!---
   * The raw AccountsReceivable(sales invoices) and AccountsPayable(bills) outstanding and overdue amounts, not converted to base currency (read only)
   * @return Balances
  --->
  <cffunction name="getBalances" access="public" output="false" hint="I return the Balances">
    <cfreturn variables.instance.Balances />
  </cffunction>

  <cffunction name="setBalances" access="public"  output="false" hint="I set the Balances into the variables.instance scope.">
    <cfargument name="Balances" type="Struct" hint="I am the Balances." />
      <cfset variables.instance.Balances = arguments.Balances />
  </cffunction>

  <!---
   * A boolean to indicate if a contact has an attachment
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


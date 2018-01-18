<cfcomponent displayname="Organisation" output="false" extends="cfc.xeroclient"
  hint="I am the Organisation Class.">

<!--- PROPERTIES --->

  <cfproperty name="APIKey" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="LegalName" type="String" default="" />
  <cfproperty name="PaysTax" type="Boolean" default="" />
  <cfproperty name="Version" type="String" default="" />
  <cfproperty name="OrganisationType" type="String" default="" />
  <cfproperty name="BaseCurrency" type="String" default="" />
  <cfproperty name="CountryCode" type="String" default="" />
  <cfproperty name="IsDemoCompany" type="Boolean" default="" />
  <cfproperty name="OrganisationStatus" type="String" default="" />
  <cfproperty name="RegistrationNumber" type="String" default="" />
  <cfproperty name="TaxNumber" type="String" default="" />
  <cfproperty name="FinancialYearEndDay" type="String" default="" />
  <cfproperty name="FinancialYearEndMonth" type="String" default="" />
  <cfproperty name="SalesTaxBasis" type="String" default="" />
  <cfproperty name="SalesTaxPeriod" type="String" default="" />
  <cfproperty name="DefaultSalesTax" type="String" default="" />
  <cfproperty name="DefaultPurchasesTax" type="String" default="" />
  <cfproperty name="PeriodLockDate" type="String" default="" />
  <cfproperty name="EndOfYearLockDate" type="String" default="" />
  <cfproperty name="CreatedDateUTC" type="String" default="" />
  <cfproperty name="Timezone" type="String" default="" />
  <cfproperty name="OrganisationEntityType" type="String" default="" />
  <cfproperty name="ShortCode" type="String" default="" />
  <cfproperty name="LineOfBusiness" type="String" default="" />
  <cfproperty name="Addresses" type="array" default="" />
  <cfproperty name="Phones" type="array" default="" />
  <cfproperty name="ExternalLinks" type="array" default="" />
  <cfproperty name="PaymentTerms" type="Struct" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Organisation Class.">
      
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
            myStruct.OrganisationID=getOrganisationID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"APIKey")) {
              if (NOT listFindNoCase(arguments.exclude, "APIKey")) {
                myStruct.APIKey=getAPIKey();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct.Name=getName();
              }
            }
            if (structKeyExists(variables.instance,"LegalName")) {
              if (NOT listFindNoCase(arguments.exclude, "LegalName")) {
                myStruct.LegalName=getLegalName();
              }
            }
            if (structKeyExists(variables.instance,"PaysTax")) {
              if (NOT listFindNoCase(arguments.exclude, "PaysTax")) {
                myStruct.PaysTax=getPaysTax();
              }
            }
            if (structKeyExists(variables.instance,"Version")) {
              if (NOT listFindNoCase(arguments.exclude, "Version")) {
                myStruct.Version=getVersion();
              }
            }
            if (structKeyExists(variables.instance,"OrganisationType")) {
              if (NOT listFindNoCase(arguments.exclude, "OrganisationType")) {
                myStruct.OrganisationType=getOrganisationType();
              }
            }
            if (structKeyExists(variables.instance,"BaseCurrency")) {
              if (NOT listFindNoCase(arguments.exclude, "BaseCurrency")) {
                myStruct.BaseCurrency=getBaseCurrency();
              }
            }
            if (structKeyExists(variables.instance,"CountryCode")) {
              if (NOT listFindNoCase(arguments.exclude, "CountryCode")) {
                myStruct.CountryCode=getCountryCode();
              }
            }
            if (structKeyExists(variables.instance,"IsDemoCompany")) {
              if (NOT listFindNoCase(arguments.exclude, "IsDemoCompany")) {
                myStruct.IsDemoCompany=getIsDemoCompany();
              }
            }
            if (structKeyExists(variables.instance,"OrganisationStatus")) {
              if (NOT listFindNoCase(arguments.exclude, "OrganisationStatus")) {
                myStruct.OrganisationStatus=getOrganisationStatus();
              }
            }
            if (structKeyExists(variables.instance,"RegistrationNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "RegistrationNumber")) {
                myStruct.RegistrationNumber=getRegistrationNumber();
              }
            }
            if (structKeyExists(variables.instance,"TaxNumber")) {
              if (NOT listFindNoCase(arguments.exclude, "TaxNumber")) {
                myStruct.TaxNumber=getTaxNumber();
              }
            }
            if (structKeyExists(variables.instance,"FinancialYearEndDay")) {
              if (NOT listFindNoCase(arguments.exclude, "FinancialYearEndDay")) {
                myStruct.FinancialYearEndDay=getFinancialYearEndDay();
              }
            }
            if (structKeyExists(variables.instance,"FinancialYearEndMonth")) {
              if (NOT listFindNoCase(arguments.exclude, "FinancialYearEndMonth")) {
                myStruct.FinancialYearEndMonth=getFinancialYearEndMonth();
              }
            }
            if (structKeyExists(variables.instance,"SalesTaxBasis")) {
              if (NOT listFindNoCase(arguments.exclude, "SalesTaxBasis")) {
                myStruct.SalesTaxBasis=getSalesTaxBasis();
              }
            }
            if (structKeyExists(variables.instance,"SalesTaxPeriod")) {
              if (NOT listFindNoCase(arguments.exclude, "SalesTaxPeriod")) {
                myStruct.SalesTaxPeriod=getSalesTaxPeriod();
              }
            }
            if (structKeyExists(variables.instance,"DefaultSalesTax")) {
              if (NOT listFindNoCase(arguments.exclude, "DefaultSalesTax")) {
                myStruct.DefaultSalesTax=getDefaultSalesTax();
              }
            }
            if (structKeyExists(variables.instance,"DefaultPurchasesTax")) {
              if (NOT listFindNoCase(arguments.exclude, "DefaultPurchasesTax")) {
                myStruct.DefaultPurchasesTax=getDefaultPurchasesTax();
              }
            }
            if (structKeyExists(variables.instance,"PeriodLockDate")) {
              if (NOT listFindNoCase(arguments.exclude, "PeriodLockDate")) {
                myStruct.PeriodLockDate=getPeriodLockDate();
              }
            }
            if (structKeyExists(variables.instance,"EndOfYearLockDate")) {
              if (NOT listFindNoCase(arguments.exclude, "EndOfYearLockDate")) {
                myStruct.EndOfYearLockDate=getEndOfYearLockDate();
              }
            }
            if (structKeyExists(variables.instance,"CreatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "CreatedDateUTC")) {
                myStruct.CreatedDateUTC=getCreatedDateUTC();
              }
            }
            if (structKeyExists(variables.instance,"Timezone")) {
              if (NOT listFindNoCase(arguments.exclude, "Timezone")) {
                myStruct.Timezone=getTimezone();
              }
            }
            if (structKeyExists(variables.instance,"OrganisationEntityType")) {
              if (NOT listFindNoCase(arguments.exclude, "OrganisationEntityType")) {
                myStruct.OrganisationEntityType=getOrganisationEntityType();
              }
            }
            if (structKeyExists(variables.instance,"ShortCode")) {
              if (NOT listFindNoCase(arguments.exclude, "ShortCode")) {
                myStruct.ShortCode=getShortCode();
              }
            }
            if (structKeyExists(variables.instance,"LineOfBusiness")) {
              if (NOT listFindNoCase(arguments.exclude, "LineOfBusiness")) {
                myStruct.LineOfBusiness=getLineOfBusiness();
              }
            }
            if (structKeyExists(variables.instance,"Addresses")) {
              if (NOT listFindNoCase(arguments.exclude, "Addresses")) {
                myStruct.Addresses=getAddresses();
              }
            }
            if (structKeyExists(variables.instance,"Phones")) {
              if (NOT listFindNoCase(arguments.exclude, "Phones")) {
                myStruct.Phones=getPhones();
              }
            }
            if (structKeyExists(variables.instance,"ExternalLinks")) {
              if (NOT listFindNoCase(arguments.exclude, "ExternalLinks")) {
                myStruct.ExternalLinks=getExternalLinks();
              }
            }
            if (structKeyExists(variables.instance,"PaymentTerms")) {
              if (NOT listFindNoCase(arguments.exclude, "PaymentTerms")) {
                myStruct.PaymentTerms=getPaymentTerms();
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

        if (structKeyExists(obj,"APIKey")) {
          setAPIKey(obj.APIKey);
        } else {
          setAPIKey("");
        }
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"LegalName")) {
          setLegalName(obj.LegalName);
        } else {
          setLegalName("");
        }
        if (structKeyExists(obj,"PaysTax")) {
          setPaysTax(obj.PaysTax);
        } else {
          setPaysTax(false);
        }
        if (structKeyExists(obj,"Version")) {
          setVersion(obj.Version);
        } else {
          setVersion("");
        }
        if (structKeyExists(obj,"OrganisationType")) {
          setOrganisationType(obj.OrganisationType);
        } else {
          setOrganisationType("");
        }
        if (structKeyExists(obj,"BaseCurrency")) {
          setBaseCurrency(obj.BaseCurrency);
        } else {
          setBaseCurrency("");
        }
        if (structKeyExists(obj,"CountryCode")) {
          setCountryCode(obj.CountryCode);
        } else {
          setCountryCode("");
        }
        if (structKeyExists(obj,"IsDemoCompany")) {
          setIsDemoCompany(obj.IsDemoCompany);
        } else {
          setIsDemoCompany(false);
        }
        if (structKeyExists(obj,"OrganisationStatus")) {
          setOrganisationStatus(obj.OrganisationStatus);
        } else {
          setOrganisationStatus("");
        }
        if (structKeyExists(obj,"RegistrationNumber")) {
          setRegistrationNumber(obj.RegistrationNumber);
        } else {
          setRegistrationNumber("");
        }
        if (structKeyExists(obj,"TaxNumber")) {
          setTaxNumber(obj.TaxNumber);
        } else {
          setTaxNumber("");
        }
        if (structKeyExists(obj,"FinancialYearEndDay")) {
          setFinancialYearEndDay(obj.FinancialYearEndDay);
        } else {
          setFinancialYearEndDay("");
        }
        if (structKeyExists(obj,"FinancialYearEndMonth")) {
          setFinancialYearEndMonth(obj.FinancialYearEndMonth);
        } else {
          setFinancialYearEndMonth("");
        }
        if (structKeyExists(obj,"SalesTaxBasis")) {
          setSalesTaxBasis(obj.SalesTaxBasis);
        } else {
          setSalesTaxBasis("");
        }
        if (structKeyExists(obj,"SalesTaxPeriod")) {
          setSalesTaxPeriod(obj.SalesTaxPeriod);
        } else {
          setSalesTaxPeriod("");
        }
        if (structKeyExists(obj,"DefaultSalesTax")) {
          setDefaultSalesTax(obj.DefaultSalesTax);
        } else {
          setDefaultSalesTax("");
        }
        if (structKeyExists(obj,"DefaultPurchasesTax")) {
          setDefaultPurchasesTax(obj.DefaultPurchasesTax);
        } else {
          setDefaultPurchasesTax("");
        }
        if (structKeyExists(obj,"PeriodLockDate")) {
          setPeriodLockDate(obj.PeriodLockDate);
        } else {
          setPeriodLockDate("");
        }
        if (structKeyExists(obj,"EndOfYearLockDate")) {
          setEndOfYearLockDate(obj.EndOfYearLockDate);
        } else {
          setEndOfYearLockDate("");
        }
        if (structKeyExists(obj,"CreatedDateUTC")) {
          setCreatedDateUTC(obj.CreatedDateUTC);
        } else {
          setCreatedDateUTC("");
        }
        if (structKeyExists(obj,"Timezone")) {
          setTimezone(obj.Timezone);
        } else {
          setTimezone("");
        }
        if (structKeyExists(obj,"OrganisationEntityType")) {
          setOrganisationEntityType(obj.OrganisationEntityType);
        } else {
          setOrganisationEntityType("");
        }
        if (structKeyExists(obj,"ShortCode")) {
          setShortCode(obj.ShortCode);
        } else {
          setShortCode("");
        }
        if (structKeyExists(obj,"LineOfBusiness")) {
          setLineOfBusiness(obj.LineOfBusiness);
        } else {
          setLineOfBusiness("");
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
        if (structKeyExists(obj,"ExternalLinks")) {
          setExternalLinks(obj.ExternalLinks);
        } else {
          setExternalLinks(ArrayNew(1));
        }
        if (structKeyExists(obj,"PaymentTerms")) {
          setPaymentTerms(obj.PaymentTerms);
        } else {
          setPaymentTerms(StructNew());
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
      
      <cfset this.setList(this.get(endpoint="Organisations"))>

      <cfset var ArrayResult = this.get(endpoint="Organisations")>
      <cfscript>
        this.populate(ArrayResult[1]);
      </cfscript>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Organisations",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Organisations",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Organisations",body=this.toJSON(),id=this.getOrganisationID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Organisations",body=this.toJSON(archive=true),id=this.getOrganisationID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Organisations",body=this.toJSON(),id=this.getOrganisationID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Organisations">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Organisations">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Display a unique key used for Xero-to-Xero transactions
   * @return APIKey
  --->
  <cffunction name="getAPIKey" access="public" output="false" hint="I return the APIKey">
    <cfreturn variables.instance.APIKey />
  </cffunction>

  <cffunction name="setAPIKey" access="public"  output="false" hint="I set the APIKey into the variables.instance scope.">
    <cfargument name="APIKey" type="String" hint="I am the APIKey." />
      <cfset variables.instance.APIKey = arguments.APIKey />
  </cffunction>

  <!---
   * Display name of organisation shown in Xero
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
   * Organisation name shown on Reports
   * @return LegalName
  --->
  <cffunction name="getLegalName" access="public" output="false" hint="I return the LegalName">
    <cfreturn variables.instance.LegalName />
  </cffunction>

  <cffunction name="setLegalName" access="public"  output="false" hint="I set the LegalName into the variables.instance scope.">
    <cfargument name="LegalName" type="String" hint="I am the LegalName." />
      <cfset variables.instance.LegalName = arguments.LegalName />
  </cffunction>

  <!---
   * Boolean to describe if organisation is registered with a local tax authority i.e. true, false
   * @return PaysTax
  --->
  <cffunction name="getPaysTax" access="public" output="false" hint="I return the PaysTax">
    <cfreturn variables.instance.PaysTax />
  </cffunction>

  <cffunction name="setPaysTax" access="public"  output="false" hint="I set the PaysTax into the variables.instance scope.">
    <cfargument name="PaysTax" type="Boolean" hint="I am the PaysTax." />
      <cfset variables.instance.PaysTax = arguments.PaysTax />
  </cffunction>

  <!---
   * See Version Types
   * @return Version
  --->
  <cffunction name="getVersion" access="public" output="false" hint="I return the Version">
    <cfreturn variables.instance.Version />
  </cffunction>

  <cffunction name="setVersion" access="public"  output="false" hint="I set the Version into the variables.instance scope.">
    <cfargument name="Version" type="String" hint="I am the Version." />
      <cfset variables.instance.Version = arguments.Version />
  </cffunction>

  <!---
   * Organisation Type
   * @return OrganisationType
  --->
  <cffunction name="getOrganisationType" access="public" output="false" hint="I return the OrganisationType">
    <cfreturn variables.instance.OrganisationType />
  </cffunction>

  <cffunction name="setOrganisationType" access="public"  output="false" hint="I set the OrganisationType into the variables.instance scope.">
    <cfargument name="OrganisationType" type="String" hint="I am the OrganisationType." />
      <cfset variables.instance.OrganisationType = arguments.OrganisationType />
  </cffunction>

  <!---
   * Default currency for organisation. See ISO 4217 Currency Codes
   * @return BaseCurrency
  --->
  <cffunction name="getBaseCurrency" access="public" output="false" hint="I return the BaseCurrency">
    <cfreturn variables.instance.BaseCurrency />
  </cffunction>

  <cffunction name="setBaseCurrency" access="public"  output="false" hint="I set the BaseCurrency into the variables.instance scope.">
    <cfargument name="BaseCurrency" type="String" hint="I am the BaseCurrency." />
      <cfset variables.instance.BaseCurrency = arguments.BaseCurrency />
  </cffunction>

  <!---
   * Country code for organisation. See ISO 3166-2 Country Codes
   * @return CountryCode
  --->
  <cffunction name="getCountryCode" access="public" output="false" hint="I return the CountryCode">
    <cfreturn variables.instance.CountryCode />
  </cffunction>

  <cffunction name="setCountryCode" access="public"  output="false" hint="I set the CountryCode into the variables.instance scope.">
    <cfargument name="CountryCode" type="String" hint="I am the CountryCode." />
      <cfset variables.instance.CountryCode = arguments.CountryCode />
  </cffunction>

  <!---
   * Boolean to describe if organisation is a demo company.
   * @return IsDemoCompany
  --->
  <cffunction name="getIsDemoCompany" access="public" output="false" hint="I return the IsDemoCompany">
    <cfreturn variables.instance.IsDemoCompany />
  </cffunction>

  <cffunction name="setIsDemoCompany" access="public"  output="false" hint="I set the IsDemoCompany into the variables.instance scope.">
    <cfargument name="IsDemoCompany" type="Boolean" hint="I am the IsDemoCompany." />
      <cfset variables.instance.IsDemoCompany = arguments.IsDemoCompany />
  </cffunction>

  <!---
   * Will be set to ACTIVE if you can connect to organisation via the Xero API
   * @return OrganisationStatus
  --->
  <cffunction name="getOrganisationStatus" access="public" output="false" hint="I return the OrganisationStatus">
    <cfreturn variables.instance.OrganisationStatus />
  </cffunction>

  <cffunction name="setOrganisationStatus" access="public"  output="false" hint="I set the OrganisationStatus into the variables.instance scope.">
    <cfargument name="OrganisationStatus" type="String" hint="I am the OrganisationStatus." />
      <cfset variables.instance.OrganisationStatus = arguments.OrganisationStatus />
  </cffunction>

  <!---
   * Shows for New Zealand, Australian and UK organisations
   * @return RegistrationNumber
  --->
  <cffunction name="getRegistrationNumber" access="public" output="false" hint="I return the RegistrationNumber">
    <cfreturn variables.instance.RegistrationNumber />
  </cffunction>

  <cffunction name="setRegistrationNumber" access="public"  output="false" hint="I set the RegistrationNumber into the variables.instance scope.">
    <cfargument name="RegistrationNumber" type="String" hint="I am the RegistrationNumber." />
      <cfset variables.instance.RegistrationNumber = arguments.RegistrationNumber />
  </cffunction>

  <!---
   * Shown if set. Displays in the Xero UI as Tax File Number (AU), GST Number (NZ), VAT Number (UK) and Tax ID Number (US & Global).
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
   * Calendar day e.g. 0-31
   * @return FinancialYearEndDay
  --->
  <cffunction name="getFinancialYearEndDay" access="public" output="false" hint="I return the FinancialYearEndDay">
    <cfreturn variables.instance.FinancialYearEndDay />
  </cffunction>

  <cffunction name="setFinancialYearEndDay" access="public"  output="false" hint="I set the FinancialYearEndDay into the variables.instance scope.">
    <cfargument name="FinancialYearEndDay" type="String" hint="I am the FinancialYearEndDay." />
      <cfset variables.instance.FinancialYearEndDay = arguments.FinancialYearEndDay />
  </cffunction>

  <!---
   * Calendar Month e.g. 1-12
   * @return FinancialYearEndMonth
  --->
  <cffunction name="getFinancialYearEndMonth" access="public" output="false" hint="I return the FinancialYearEndMonth">
    <cfreturn variables.instance.FinancialYearEndMonth />
  </cffunction>

  <cffunction name="setFinancialYearEndMonth" access="public"  output="false" hint="I set the FinancialYearEndMonth into the variables.instance scope.">
    <cfargument name="FinancialYearEndMonth" type="String" hint="I am the FinancialYearEndMonth." />
      <cfset variables.instance.FinancialYearEndMonth = arguments.FinancialYearEndMonth />
  </cffunction>

  <!---
   * The accounting basis used for tax returns. See Sales Tax Basis
   * @return SalesTaxBasis
  --->
  <cffunction name="getSalesTaxBasis" access="public" output="false" hint="I return the SalesTaxBasis">
    <cfreturn variables.instance.SalesTaxBasis />
  </cffunction>

  <cffunction name="setSalesTaxBasis" access="public"  output="false" hint="I set the SalesTaxBasis into the variables.instance scope.">
    <cfargument name="SalesTaxBasis" type="String" hint="I am the SalesTaxBasis." />
      <cfset variables.instance.SalesTaxBasis = arguments.SalesTaxBasis />
  </cffunction>

  <!---
   * The frequency with which tax returns are processed. See Sales Tax Period
   * @return SalesTaxPeriod
  --->
  <cffunction name="getSalesTaxPeriod" access="public" output="false" hint="I return the SalesTaxPeriod">
    <cfreturn variables.instance.SalesTaxPeriod />
  </cffunction>

  <cffunction name="setSalesTaxPeriod" access="public"  output="false" hint="I set the SalesTaxPeriod into the variables.instance scope.">
    <cfargument name="SalesTaxPeriod" type="String" hint="I am the SalesTaxPeriod." />
      <cfset variables.instance.SalesTaxPeriod = arguments.SalesTaxPeriod />
  </cffunction>

  <!---
   * The default for LineAmountTypes on sales transactions
   * @return DefaultSalesTax
  --->
  <cffunction name="getDefaultSalesTax" access="public" output="false" hint="I return the DefaultSalesTax">
    <cfreturn variables.instance.DefaultSalesTax />
  </cffunction>

  <cffunction name="setDefaultSalesTax" access="public"  output="false" hint="I set the DefaultSalesTax into the variables.instance scope.">
    <cfargument name="DefaultSalesTax" type="String" hint="I am the DefaultSalesTax." />
      <cfset variables.instance.DefaultSalesTax = arguments.DefaultSalesTax />
  </cffunction>

  <!---
   * The default for LineAmountTypes on purchase transactions
   * @return DefaultPurchasesTax
  --->
  <cffunction name="getDefaultPurchasesTax" access="public" output="false" hint="I return the DefaultPurchasesTax">
    <cfreturn variables.instance.DefaultPurchasesTax />
  </cffunction>

  <cffunction name="setDefaultPurchasesTax" access="public"  output="false" hint="I set the DefaultPurchasesTax into the variables.instance scope.">
    <cfargument name="DefaultPurchasesTax" type="String" hint="I am the DefaultPurchasesTax." />
      <cfset variables.instance.DefaultPurchasesTax = arguments.DefaultPurchasesTax />
  </cffunction>

  <!---
   * Shown if set. See lock dates
   * @return PeriodLockDate
  --->
  <cffunction name="getPeriodLockDate" access="public" output="false" hint="I return the PeriodLockDate">
    <cfreturn variables.instance.PeriodLockDate />
  </cffunction>

  <cffunction name="setPeriodLockDate" access="public"  output="false" hint="I set the PeriodLockDate into the variables.instance scope.">
    <cfargument name="PeriodLockDate" type="String" hint="I am the PeriodLockDate." />
      <cfset variables.instance.PeriodLockDate = arguments.PeriodLockDate />
  </cffunction>

  <!---
   * Shown if set. See lock dates
   * @return EndOfYearLockDate
  --->
  <cffunction name="getEndOfYearLockDate" access="public" output="false" hint="I return the EndOfYearLockDate">
    <cfreturn variables.instance.EndOfYearLockDate />
  </cffunction>

  <cffunction name="setEndOfYearLockDate" access="public"  output="false" hint="I set the EndOfYearLockDate into the variables.instance scope.">
    <cfargument name="EndOfYearLockDate" type="String" hint="I am the EndOfYearLockDate." />
      <cfset variables.instance.EndOfYearLockDate = arguments.EndOfYearLockDate />
  </cffunction>

  <!---
   * Timestamp when the organisation was created in Xero
   * @return CreatedDateUTC
  --->
  <cffunction name="getCreatedDateUTC" access="public" output="false" hint="I return the CreatedDateUTC">
    <cfreturn variables.instance.CreatedDateUTC />
  </cffunction>

  <cffunction name="setCreatedDateUTC" access="public"  output="false" hint="I set the CreatedDateUTC into the variables.instance scope.">
    <cfargument name="CreatedDateUTC" type="String" hint="I am the CreatedDateUTC." />
      <cfset variables.instance.CreatedDateUTC = arguments.CreatedDateUTC />
  </cffunction>

  <!---
   * Timezone specifications
   * @return Timezone
  --->
  <cffunction name="getTimezone" access="public" output="false" hint="I return the Timezone">
    <cfreturn variables.instance.Timezone />
  </cffunction>

  <cffunction name="setTimezone" access="public"  output="false" hint="I set the Timezone into the variables.instance scope.">
    <cfargument name="Timezone" type="String" hint="I am the Timezone." />
      <cfset variables.instance.Timezone = arguments.Timezone />
  </cffunction>

  <!---
   * Organisation Type
   * @return OrganisationEntityType
  --->
  <cffunction name="getOrganisationEntityType" access="public" output="false" hint="I return the OrganisationEntityType">
    <cfreturn variables.instance.OrganisationEntityType />
  </cffunction>

  <cffunction name="setOrganisationEntityType" access="public"  output="false" hint="I set the OrganisationEntityType into the variables.instance scope.">
    <cfargument name="OrganisationEntityType" type="String" hint="I am the OrganisationEntityType." />
      <cfset variables.instance.OrganisationEntityType = arguments.OrganisationEntityType />
  </cffunction>

  <!---
   * A unique identifier for the organisation. Potential uses.
   * @return ShortCode
  --->
  <cffunction name="getShortCode" access="public" output="false" hint="I return the ShortCode">
    <cfreturn variables.instance.ShortCode />
  </cffunction>

  <cffunction name="setShortCode" access="public"  output="false" hint="I set the ShortCode into the variables.instance scope.">
    <cfargument name="ShortCode" type="String" hint="I am the ShortCode." />
      <cfset variables.instance.ShortCode = arguments.ShortCode />
  </cffunction>

  <!---
   * Description of business type as defined in Organisation settings
   * @return LineOfBusiness
  --->
  <cffunction name="getLineOfBusiness" access="public" output="false" hint="I return the LineOfBusiness">
    <cfreturn variables.instance.LineOfBusiness />
  </cffunction>

  <cffunction name="setLineOfBusiness" access="public"  output="false" hint="I set the LineOfBusiness into the variables.instance scope.">
    <cfargument name="LineOfBusiness" type="String" hint="I am the LineOfBusiness." />
      <cfset variables.instance.LineOfBusiness = arguments.LineOfBusiness />
  </cffunction>

  <!---
   * Address details for organisation – see Addresses
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
   * Phones details for organisation – see Phones
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
   * Organisation profile links for popular services such as Facebook, Twitter, GooglePlus and LinkedIn. You can also add link to your website here. Shown if Organisation settings  is updated in Xero. See ExternalLinks below
   * @return ExternalLinks
  --->
  <cffunction name="getExternalLinks" access="public" output="false" hint="I return the ExternalLinks">
    <cfreturn variables.instance.ExternalLinks />
  </cffunction>

  <cffunction name="setExternalLinks" access="public"  output="false" hint="I set the ExternalLinks into the variables.instance scope.">
    <cfargument name="ExternalLinks" type="array" hint="I am the ExternalLinks." />
			<cfscript>
		        var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.ExternalLinks);i=i+1) {
		          var item=createObject("component","cfc.model.ExternalLink").init().populate(arguments.ExternalLinks[i]); 
		          ArrayAppend(arr,item);
		        }
		      </cfscript>
		      <cfset variables.instance.ExternalLinks = arr />
		
  </cffunction>

  <!---
   * See PaymentTerms
   * @return PaymentTerms
  --->
  <cffunction name="getPaymentTerms" access="public" output="false" hint="I return the PaymentTerms">
    <cfreturn variables.instance.PaymentTerms />
  </cffunction>

  <cffunction name="setPaymentTerms" access="public"  output="false" hint="I set the PaymentTerms into the variables.instance scope.">
    <cfargument name="PaymentTerms" type="Struct" hint="I am the PaymentTerms." />
      <cfset variables.instance.PaymentTerms = arguments.PaymentTerms />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



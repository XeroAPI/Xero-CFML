<cfcomponent displayname="JournalLine" output="false" extends="cfc.xeroclient"
  hint="I am the JournalLine Class.">

<!--- PROPERTIES --->

  <cfproperty name="LineAmount" type="String" default="" />
  <cfproperty name="AccountCode" type="String" default="" />
  <cfproperty name="Description" type="String" default="" />
  <cfproperty name="TaxType" type="String" default="" />
  <cfproperty name="Tracking" type="array" default="" />
  <cfproperty name="TaxAmount" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the JournalLine Class.">
      
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
            myStruct.JournalLineID=getJournalLineID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"LineAmount")) {
              if (NOT listFindNoCase(arguments.exclude, "LineAmount")) {
                myStruct.LineAmount=getLineAmount();
              }
            }
            if (structKeyExists(variables.instance,"AccountCode")) {
              if (NOT listFindNoCase(arguments.exclude, "AccountCode")) {
                myStruct.AccountCode=getAccountCode();
              }
            }
            if (structKeyExists(variables.instance,"Description")) {
              if (NOT listFindNoCase(arguments.exclude, "Description")) {
                if(len(getDescription()) GT 0) {
                  myStruct.Description=getDescription();
                }
              }
            }
            if (structKeyExists(variables.instance,"TaxType")) {
              if (NOT listFindNoCase(arguments.exclude, "TaxType")) {
                myStruct.TaxType=getTaxType();
              }
            }
            if (structKeyExists(variables.instance,"Tracking")) {
              if (NOT listFindNoCase(arguments.exclude, "Tracking")) {
                myStruct.Tracking=getTracking();
              }
            }
            if (structKeyExists(variables.instance,"TaxAmount")) {
              if (NOT listFindNoCase(arguments.exclude, "TaxAmount")) {
                myStruct.TaxAmount=getTaxAmount();
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

        if (structKeyExists(obj,"LineAmount")) {
          setLineAmount(obj.LineAmount);
        } else {
          setLineAmount("");
        }
        if (structKeyExists(obj,"AccountCode")) {
          setAccountCode(obj.AccountCode);
        } else {
          setAccountCode("");
        }
        if (structKeyExists(obj,"Description")) {
          setDescription(obj.Description);
        } else {
          setDescription("");
        }
        if (structKeyExists(obj,"TaxType")) {
          setTaxType(obj.TaxType);
        } else {
          setTaxType("");
        }
        if (structKeyExists(obj,"Tracking")) {
          setTracking(obj.Tracking);
        } else {
          setTracking(ArrayNew(1));
        }
        if (structKeyExists(obj,"TaxAmount")) {
          setTaxAmount(obj.TaxAmount);
        } else {
          setTaxAmount("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="JournalLines"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="JournalLines",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="JournalLines",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="JournalLines",body=this.toJSON(),id=this.getJournalLineID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="JournalLines",body=this.toJSON(archive=true),id=this.getJournalLineID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="JournalLines",body=this.toJSON(),id=this.getJournalLineID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of JournalLines">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of JournalLines">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * total for line. Debits are positive, credits are negative value
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
   * Description for journal line
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
   * Optional Tracking Category – see Tracking. Any JournalLine can have a maximum of 2 <TrackingCategory> elements.
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
   * The calculated tax amount based on the TaxType and LineAmount
   * @return TaxAmount
  --->
  <cffunction name="getTaxAmount" access="public" output="false" hint="I return the TaxAmount">
    <cfreturn variables.instance.TaxAmount />
  </cffunction>

  <cffunction name="setTaxAmount" access="public"  output="false" hint="I set the TaxAmount into the variables.instance scope.">
    <cfargument name="TaxAmount" type="String" hint="I am the TaxAmount." />
      <cfset variables.instance.TaxAmount = arguments.TaxAmount />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


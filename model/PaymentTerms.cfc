<cfcomponent displayname="PaymentTerms" output="false" extends="xeroclient"
  hint="I am the PaymentTerms Class.">

<!--- PROPERTIES --->

  <cfproperty name="Bills" type="List[PaymentTerm]" default="" />
  <cfproperty name="Sales" type="List[PaymentTerm]" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the PaymentTerms Class.">
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
            myStruct["PaymentTermsID"]=getPaymentTermsID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Bills")) {
              if (NOT listFindNoCase(arguments.exclude, "Bills")) {
                myStruct["Bills"]=getBills();
              }
            }
            if (structKeyExists(variables.instance,"Sales")) {
              if (NOT listFindNoCase(arguments.exclude, "Sales")) {
                myStruct["Sales"]=getSales();
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

        if (structKeyExists(obj,"Bills")) {
          setBills(obj.Bills);
        } else {
          setBills("");
        }
        if (structKeyExists(obj,"Sales")) {
          setSales(obj.Sales);
        } else {
          setSales("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="PaymentTermss"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="PaymentTermss",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="PaymentTermss",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="PaymentTermss",body=this.toJSON(),id=this.getPaymentTermsID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="PaymentTermss",body=this.toJSON(archive=true),id=this.getPaymentTermsID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="PaymentTermss",body=this.toJSON(),id=this.getPaymentTermsID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of PaymentTermss">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of PaymentTermss">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Default payment terms for bills (accounts payable) - see Payment Terms
   * @return Bills
  --->
  <cffunction name="getBills" access="public" output="false" hint="I return the Bills">
    <cfreturn variables.instance.Bills />
  </cffunction>

  <cffunction name="setBills" access="public"  output="false" hint="I set the Bills into the variables.instance scope.">
    <cfargument name="Bills" type="List[PaymentTerm]" hint="I am the Bills." />
      <cfset variables.instance.Bills = arguments.Bills />
  </cffunction>

  <!---
   * Default payment terms for sales invoices(accounts receivable) see Payment Terms
   * @return Sales
  --->
  <cffunction name="getSales" access="public" output="false" hint="I return the Sales">
    <cfreturn variables.instance.Sales />
  </cffunction>

  <cffunction name="setSales" access="public"  output="false" hint="I set the Sales into the variables.instance scope.">
    <cfargument name="Sales" type="List[PaymentTerm]" hint="I am the Sales." />
      <cfset variables.instance.Sales = arguments.Sales />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   

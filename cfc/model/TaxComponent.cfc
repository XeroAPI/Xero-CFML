<cfcomponent displayname="TaxComponent" output="false" extends="cfc.xeroclient"
  hint="I am the TaxComponent Class.">

<!--- PROPERTIES --->

  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="Rate" type="BigDecimal" default="" />
  <cfproperty name="IsCompound" type="BigDecimal" default="" />
  <cfproperty name="TaxType" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the TaxComponent Class.">
      
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

          if (structKeyExists(variables.instance,"Name")) {
            if (NOT listFindNoCase(arguments.exclude, "Name")) {
              myStruct.Name=getName();
            }
          }
          if (structKeyExists(variables.instance,"Rate")) {
            if (NOT listFindNoCase(arguments.exclude, "Rate")) {
              myStruct.Rate=getRate();
            }
          }
          if (structKeyExists(variables.instance,"IsCompound")) {
            if (NOT listFindNoCase(arguments.exclude, "IsCompound")) {
              myStruct.IsCompound=getIsCompound();
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

        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"Rate")) {
          setRate(obj.Rate);
        } else {
          setRate("");
        }
        if (structKeyExists(obj,"IsCompound")) {
          setIsCompound(obj.IsCompound);
        } else {
          setIsCompound("");
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
      <cfset this.setList(this.get(endpoint="TaxComponents"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="TaxComponents",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="TaxComponents",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="TaxComponents",body=this.toJSON(),id=this.getTaxComponentID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="TaxComponents",body=this.toJSON(),id=this.getTaxComponentID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="TaxComponents",body=this.toJSON(),id=this.getTaxComponentID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of TaxComponents">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of TaxComponents">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Name of Tax Component
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
   * Tax Rate (up to 4dp)
   * @return Rate
  --->
  <cffunction name="getRate" access="public" output="false" hint="I return the Rate">
    <cfreturn variables.instance.Rate />
  </cffunction>

  <cffunction name="setRate" access="public"  output="false" hint="I set the Rate into the variables.instance scope.">
    <cfargument name="Rate" type="BigDecimal" hint="I am the Rate." />
      <cfset variables.instance.Rate = arguments.Rate />
  </cffunction>

  <!---
   * Boolean to describe if Tax rate is compounded.Learn more
   * @return IsCompound
  --->
  <cffunction name="getIsCompound" access="public" output="false" hint="I return the IsCompound">
    <cfreturn variables.instance.IsCompound />
  </cffunction>

  <cffunction name="setIsCompound" access="public"  output="false" hint="I set the IsCompound into the variables.instance scope.">
    <cfargument name="IsCompound" type="BigDecimal" hint="I am the IsCompound." />
      <cfset variables.instance.IsCompound = arguments.IsCompound />
  </cffunction>

  <!---
   * Filter by a Tax Type
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

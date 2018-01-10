<cfcomponent displayname="TaxComponent" output="false" extends="cfc.xeroclient"
  hint="I am the TaxComponent Class.">

<!--- PROPERTIES --->

  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="Rate" type="String" default="" />
  <cfproperty name="IsCompound" type="Boolean" default="" />
  <cfproperty name="IsNonRecoverable" type="Boolean" default="" />

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
            myStruct.TaxComponentID=getTaxComponentID();
            myStruct.Status=getStatus();
          } else {

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
            if (structKeyExists(variables.instance,"IsNonRecoverable")) {
              if (NOT listFindNoCase(arguments.exclude, "IsNonRecoverable")) {
                myStruct.IsNonRecoverable=getIsNonRecoverable();
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
          setIsCompound(false);
        }
        if (structKeyExists(obj,"IsNonRecoverable")) {
          setIsNonRecoverable(obj.IsNonRecoverable);
        } else {
          setIsNonRecoverable(false);
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="TaxComponents"))>
      <cfset temp = this.populate(StructNew())>
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
    <cfset variables.result = Super.post(endpoint="TaxComponents",body=this.toJSON(archive=true),id=this.getTaxComponentID())>
    
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
    <cfargument name="Rate" type="String" hint="I am the Rate." />
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
    <cfargument name="IsCompound" type="boolean" hint="I am the IsCompound." />
      <cfset variables.instance.IsCompound = arguments.IsCompound />
  </cffunction>

  <!---
   * Filter by a Tax Type
   * @return IsNonRecoverable
  --->
  <cffunction name="getIsNonRecoverable" access="public" output="false" hint="I return the IsNonRecoverable">
    <cfreturn variables.instance.IsNonRecoverable />
  </cffunction>

  <cffunction name="setIsNonRecoverable" access="public"  output="false" hint="I set the IsNonRecoverable into the variables.instance scope.">
    <cfargument name="IsNonRecoverable" type="boolean" hint="I am the IsNonRecoverable." />
      <cfset variables.instance.IsNonRecoverable = arguments.IsNonRecoverable />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


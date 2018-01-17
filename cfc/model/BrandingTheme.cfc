<cfcomponent displayname="BrandingTheme" output="false" extends="cfc.xeroclient"
  hint="I am the BrandingTheme Class.">

<!--- PROPERTIES --->

  <cfproperty name="BrandingThemeID" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="SortOrder" type="String" default="" />
  <cfproperty name="CreatedDateUTC" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the BrandingTheme Class.">
      
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
     <cfargument name="archive" type="boolean" default="false" hint="I flag to return only the req. fields as JSON payload for archiving an object" />
    
     
        <cfscript>
          myStruct=StructNew();
          if (archive) {
            myStruct.BrandingThemeID=getBrandingThemeID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"BrandingThemeID")) {
              if (NOT listFindNoCase(arguments.exclude, "BrandingThemeID")) {
                myStruct.BrandingThemeID=getBrandingThemeID();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct.Name=getName();
              }
            }
            if (structKeyExists(variables.instance,"SortOrder")) {
              if (NOT listFindNoCase(arguments.exclude, "SortOrder")) {
                myStruct.SortOrder=getSortOrder();
              }
            }
            if (structKeyExists(variables.instance,"CreatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "CreatedDateUTC")) {
                myStruct.CreatedDateUTC=getCreatedDateUTC();
              }
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

        if (structKeyExists(obj,"BrandingThemeID")) {
          setBrandingThemeID(obj.BrandingThemeID);
        } else {
          setBrandingThemeID("");
        }
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"SortOrder")) {
          setSortOrder(obj.SortOrder);
        } else {
          setSortOrder("");
        }
        if (structKeyExists(obj,"CreatedDateUTC")) {
          setCreatedDateUTC(obj.CreatedDateUTC);
        } else {
          setCreatedDateUTC("");
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
      
      <cfset this.setList(this.get(endpoint="BrandingThemes"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="BrandingThemes",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="BrandingThemes",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BrandingThemes",body=this.toJSON(),id=this.getBrandingThemeID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BrandingThemes",body=this.toJSON(),id=this.getBrandingThemeID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="BrandingThemes",body=this.toJSON(),id=this.getBrandingThemeID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of BrandingThemes">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of BrandingThemes">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Xero identifier
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
   * Name of branding theme
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
   * Integer – ranked order of branding theme. The default branding theme has a value of 0
   * @return SortOrder
  --->
  <cffunction name="getSortOrder" access="public" output="false" hint="I return the SortOrder">
    <cfreturn variables.instance.SortOrder />
  </cffunction>

  <cffunction name="setSortOrder" access="public"  output="false" hint="I set the SortOrder into the variables.instance scope.">
    <cfargument name="SortOrder" type="String" hint="I am the SortOrder." />
      <cfset variables.instance.SortOrder = arguments.SortOrder />
  </cffunction>

  <!---
   * UTC timestamp of creation date of branding theme
   * @return CreatedDateUTC
  --->
  <cffunction name="getCreatedDateUTC" access="public" output="false" hint="I return the CreatedDateUTC">
    <cfreturn variables.instance.CreatedDateUTC />
  </cffunction>

  <cffunction name="setCreatedDateUTC" access="public"  output="false" hint="I set the CreatedDateUTC into the variables.instance scope.">
    <cfargument name="CreatedDateUTC" type="String" hint="I am the CreatedDateUTC." />
      <cfset variables.instance.CreatedDateUTC = arguments.CreatedDateUTC />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


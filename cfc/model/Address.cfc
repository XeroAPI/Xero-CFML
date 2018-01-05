<cfcomponent displayname="Address" output="false" extends="cfc.xeroclient"
  hint="I am the Address Class.">

<!--- PROPERTIES --->

  <cfproperty name="AddressLine1" type="String" default="" />
  <cfproperty name="AddressLine2" type="String" default="" />
  <cfproperty name="AddressLine3" type="String" default="" />
  <cfproperty name="AddressLine4" type="String" default="" />
  <cfproperty name="City" type="String" default="" />
  <cfproperty name="Region" type="String" default="" />
  <cfproperty name="PostalCode" type="String" default="" />
  <cfproperty name="Country" type="String" default="" />
  <cfproperty name="AttentionTo" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Address Class.">
      
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
            myStruct.AddressID=getAddressID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"AddressLine1")) {
              if (NOT listFindNoCase(arguments.exclude, "AddressLine1")) {
                myStruct.AddressLine1=getAddressLine1();
              }
            }
            if (structKeyExists(variables.instance,"AddressLine2")) {
              if (NOT listFindNoCase(arguments.exclude, "AddressLine2")) {
                myStruct.AddressLine2=getAddressLine2();
              }
            }
            if (structKeyExists(variables.instance,"AddressLine3")) {
              if (NOT listFindNoCase(arguments.exclude, "AddressLine3")) {
                myStruct.AddressLine3=getAddressLine3();
              }
            }
            if (structKeyExists(variables.instance,"AddressLine4")) {
              if (NOT listFindNoCase(arguments.exclude, "AddressLine4")) {
                myStruct.AddressLine4=getAddressLine4();
              }
            }
            if (structKeyExists(variables.instance,"City")) {
              if (NOT listFindNoCase(arguments.exclude, "City")) {
                myStruct.City=getCity();
              }
            }
            if (structKeyExists(variables.instance,"Region")) {
              if (NOT listFindNoCase(arguments.exclude, "Region")) {
                myStruct.Region=getRegion();
              }
            }
            if (structKeyExists(variables.instance,"PostalCode")) {
              if (NOT listFindNoCase(arguments.exclude, "PostalCode")) {
                myStruct.PostalCode=getPostalCode();
              }
            }
            if (structKeyExists(variables.instance,"Country")) {
              if (NOT listFindNoCase(arguments.exclude, "Country")) {
                myStruct.Country=getCountry();
              }
            }
            if (structKeyExists(variables.instance,"AttentionTo")) {
              if (NOT listFindNoCase(arguments.exclude, "AttentionTo")) {
                myStruct.AttentionTo=getAttentionTo();
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

        if (structKeyExists(obj,"AddressLine1")) {
          setAddressLine1(obj.AddressLine1);
        } else {
          setAddressLine1("");
        }
        if (structKeyExists(obj,"AddressLine2")) {
          setAddressLine2(obj.AddressLine2);
        } else {
          setAddressLine2("");
        }
        if (structKeyExists(obj,"AddressLine3")) {
          setAddressLine3(obj.AddressLine3);
        } else {
          setAddressLine3("");
        }
        if (structKeyExists(obj,"AddressLine4")) {
          setAddressLine4(obj.AddressLine4);
        } else {
          setAddressLine4("");
        }
        if (structKeyExists(obj,"City")) {
          setCity(obj.City);
        } else {
          setCity("");
        }
        if (structKeyExists(obj,"Region")) {
          setRegion(obj.Region);
        } else {
          setRegion("");
        }
        if (structKeyExists(obj,"PostalCode")) {
          setPostalCode(obj.PostalCode);
        } else {
          setPostalCode("");
        }
        if (structKeyExists(obj,"Country")) {
          setCountry(obj.Country);
        } else {
          setCountry("");
        }
        if (structKeyExists(obj,"AttentionTo")) {
          setAttentionTo(obj.AttentionTo);
        } else {
          setAttentionTo("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="Addresss"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Addresss",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Addresss",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Addresss",body=this.toJSON(),id=this.getAddressID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Addresss",body=this.toJSON(),id=this.getAddressID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Addresss",body=this.toJSON(),id=this.getAddressID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Addresss">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Addresss">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * max length = 500
   * @return AddressLine1
  --->
  <cffunction name="getAddressLine1" access="public" output="false" hint="I return the AddressLine1">
    <cfreturn variables.instance.AddressLine1 />
  </cffunction>

  <cffunction name="setAddressLine1" access="public"  output="false" hint="I set the AddressLine1 into the variables.instance scope.">
    <cfargument name="AddressLine1" type="String" hint="I am the AddressLine1." />
      <cfset variables.instance.AddressLine1 = arguments.AddressLine1 />
  </cffunction>

  <!---
   * max length = 500
   * @return AddressLine2
  --->
  <cffunction name="getAddressLine2" access="public" output="false" hint="I return the AddressLine2">
    <cfreturn variables.instance.AddressLine2 />
  </cffunction>

  <cffunction name="setAddressLine2" access="public"  output="false" hint="I set the AddressLine2 into the variables.instance scope.">
    <cfargument name="AddressLine2" type="String" hint="I am the AddressLine2." />
      <cfset variables.instance.AddressLine2 = arguments.AddressLine2 />
  </cffunction>

  <!---
   * max length = 500
   * @return AddressLine3
  --->
  <cffunction name="getAddressLine3" access="public" output="false" hint="I return the AddressLine3">
    <cfreturn variables.instance.AddressLine3 />
  </cffunction>

  <cffunction name="setAddressLine3" access="public"  output="false" hint="I set the AddressLine3 into the variables.instance scope.">
    <cfargument name="AddressLine3" type="String" hint="I am the AddressLine3." />
      <cfset variables.instance.AddressLine3 = arguments.AddressLine3 />
  </cffunction>

  <!---
   * max length = 500
   * @return AddressLine4
  --->
  <cffunction name="getAddressLine4" access="public" output="false" hint="I return the AddressLine4">
    <cfreturn variables.instance.AddressLine4 />
  </cffunction>

  <cffunction name="setAddressLine4" access="public"  output="false" hint="I set the AddressLine4 into the variables.instance scope.">
    <cfargument name="AddressLine4" type="String" hint="I am the AddressLine4." />
      <cfset variables.instance.AddressLine4 = arguments.AddressLine4 />
  </cffunction>

  <!---
   * max length = 255
   * @return City
  --->
  <cffunction name="getCity" access="public" output="false" hint="I return the City">
    <cfreturn variables.instance.City />
  </cffunction>

  <cffunction name="setCity" access="public"  output="false" hint="I set the City into the variables.instance scope.">
    <cfargument name="City" type="String" hint="I am the City." />
      <cfset variables.instance.City = arguments.City />
  </cffunction>

  <!---
   * max length = 255
   * @return Region
  --->
  <cffunction name="getRegion" access="public" output="false" hint="I return the Region">
    <cfreturn variables.instance.Region />
  </cffunction>

  <cffunction name="setRegion" access="public"  output="false" hint="I set the Region into the variables.instance scope.">
    <cfargument name="Region" type="String" hint="I am the Region." />
      <cfset variables.instance.Region = arguments.Region />
  </cffunction>

  <!---
   * max length = 50
   * @return PostalCode
  --->
  <cffunction name="getPostalCode" access="public" output="false" hint="I return the PostalCode">
    <cfreturn variables.instance.PostalCode />
  </cffunction>

  <cffunction name="setPostalCode" access="public"  output="false" hint="I set the PostalCode into the variables.instance scope.">
    <cfargument name="PostalCode" type="String" hint="I am the PostalCode." />
      <cfset variables.instance.PostalCode = arguments.PostalCode />
  </cffunction>

  <!---
   * max length = 50, [A-Z], [a-z] only
   * @return Country
  --->
  <cffunction name="getCountry" access="public" output="false" hint="I return the Country">
    <cfreturn variables.instance.Country />
  </cffunction>

  <cffunction name="setCountry" access="public"  output="false" hint="I set the Country into the variables.instance scope.">
    <cfargument name="Country" type="String" hint="I am the Country." />
      <cfset variables.instance.Country = arguments.Country />
  </cffunction>

  <!---
   * max length = 255
   * @return AttentionTo
  --->
  <cffunction name="getAttentionTo" access="public" output="false" hint="I return the AttentionTo">
    <cfreturn variables.instance.AttentionTo />
  </cffunction>

  <cffunction name="setAttentionTo" access="public"  output="false" hint="I set the AttentionTo into the variables.instance scope.">
    <cfargument name="AttentionTo" type="String" hint="I am the AttentionTo." />
      <cfset variables.instance.AttentionTo = arguments.AttentionTo />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



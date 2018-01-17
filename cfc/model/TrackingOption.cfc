<cfcomponent displayname="TrackingOption" output="false" extends="cfc.xeroclient"
  hint="I am the TrackingOption Class.">

<!--- PROPERTIES --->

  <cfproperty name="TrackingOptionID" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="TrackingCategoryID" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the TrackingOption Class.">
      
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
            myStruct.TrackingOptionID=getTrackingOptionID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"TrackingOptionID")) {
              if (NOT listFindNoCase(arguments.exclude, "TrackingOptionID")) {
                myStruct.TrackingOptionID=getTrackingOptionID();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct.Name=getName();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct.Status=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"TrackingCategoryID")) {
              if (NOT listFindNoCase(arguments.exclude, "TrackingCategoryID")) {
                myStruct.TrackingCategoryID=getTrackingCategoryID();
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

        if (structKeyExists(obj,"TrackingOptionID")) {
          setTrackingOptionID(obj.TrackingOptionID);
        } else {
          setTrackingOptionID("");
        }
        if (structKeyExists(obj,"Name")) {
          setName(obj.Name);
        } else {
          setName("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"TrackingCategoryID")) {
          setTrackingCategoryID(obj.TrackingCategoryID);
        } else {
          setTrackingCategoryID("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="TrackingOptions"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="TrackingOptions",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="TrackingOptions",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="TrackingOptions",body=this.toJSON(),id=this.getTrackingOptionID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="TrackingOptions",body=this.toJSON(archive=true),id=this.getTrackingOptionID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="TrackingOptions",body=this.toJSON(),id=this.getTrackingOptionID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of TrackingOptions">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of TrackingOptions">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * The Xero identifier for a tracking optione.g. ae777a87-5ef3-4fa0-a4f0-d10e1f13073a
   * @return TrackingOptionID
  --->
  <cffunction name="getTrackingOptionID" access="public" output="false" hint="I return the TrackingOptionID">
    <cfreturn variables.instance.TrackingOptionID />
  </cffunction>

  <cffunction name="setTrackingOptionID" access="public"  output="false" hint="I set the TrackingOptionID into the variables.instance scope.">
    <cfargument name="TrackingOptionID" type="String" hint="I am the TrackingOptionID." />
      <cfset variables.instance.TrackingOptionID = arguments.TrackingOptionID />
  </cffunction>

  <!---
   * The name of the tracking option e.g. Marketing, East (max length = 50)
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
   * The status of a tracking option
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
   * Filter by a tracking categorye.g. 297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return TrackingCategoryID
  --->
  <cffunction name="getTrackingCategoryID" access="public" output="false" hint="I return the TrackingCategoryID">
    <cfreturn variables.instance.TrackingCategoryID />
  </cffunction>

  <cffunction name="setTrackingCategoryID" access="public"  output="false" hint="I set the TrackingCategoryID into the variables.instance scope.">
    <cfargument name="TrackingCategoryID" type="String" hint="I am the TrackingCategoryID." />
      <cfset variables.instance.TrackingCategoryID = arguments.TrackingCategoryID />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


<cfcomponent displayname="TrackingCategory" output="false" extends="xeroclient"
  hint="I am the TrackingCategory Class.">

<!--- PROPERTIES --->

  <cfproperty name="TrackingCategoryID" type="String" default="" />
  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="Options" type="array" default="" />
  <cfproperty name="OptionId" type="array" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the TrackingCategory Class.">
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
            myStruct["TrackingCategoryID"]=getTrackingCategoryID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"TrackingCategoryID")) {
              if (NOT listFindNoCase(arguments.exclude, "TrackingCategoryID")) {
                myStruct["TrackingCategoryID"]=getTrackingCategoryID();
              }
            }
            if (structKeyExists(variables.instance,"Name")) {
              if (NOT listFindNoCase(arguments.exclude, "Name")) {
                myStruct["Name"]=getName();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"Options")) {
              if (NOT listFindNoCase(arguments.exclude, "Options")) {
                myStruct["Options"]=getOptions();
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

        if (structKeyExists(obj,"TrackingCategoryID")) {
          setTrackingCategoryID(obj.TrackingCategoryID);
        } else {
          setTrackingCategoryID("");
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
        if (structKeyExists(obj,"Options")) {
          setOptions(obj.Options);
        } else {
          setOptions(ArrayNew(1));
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
      
      <cfset this.setList(this.get(endpoint="TrackingCategories"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="TrackingCategories",id=id)>

    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="TrackingCategories",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="TrackingCategories",body=this.toJSON(exclude="Options"),id=this.getTrackingCategoryID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="addOptions" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="TrackingCategories",body=this.getOptionsAsJSON(),id=this.getTrackingCategoryID(),child="Options")>
   
    <cfreturn this />
  </cffunction>

  <cffunction name="deleteOption" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="TrackingCategories",id=this.getTrackingCategoryID(),child="Options",childId=this.getOptionId())>
      <cfset tempArray = ArrayNew(1)>
      <cfloop from="1" to="#ArrayLen(this.getOptions())#" index="i">
        <cfif this.getOptions()[i]['TrackingOptionID'] EQ variables.result[1]['TrackingOptionID']>
          <cfset tempArray = this.getOptions()>
          <cfset var foo = ArrayDeleteAt(tempArray,i)>
          <cfset bar = this.setOptions(tempArray)>
          <cfbreak>          
        </cfif>
      </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset this.setStatus("ARCHIVED")>
    <cfset variables.result = Super.post(endpoint="TrackingCategories",body=this.toJSON(archive=true),id=this.getTrackingCategoryID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="TrackingCategories",body=this.toJSON(),id=this.getTrackingCategoryID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of TrackingCategories">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of TrackingCategories">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * The Xero identifier for a tracking categorye.g. 297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return TrackingCategoryID
  --->
  <cffunction name="getTrackingCategoryID" access="public" output="false" hint="I return the TrackingCategoryID">
    <cfreturn variables.instance.TrackingCategoryID />
  </cffunction>

  <cffunction name="setTrackingCategoryID" access="public"  output="false" hint="I set the TrackingCategoryID into the variables.instance scope.">
    <cfargument name="TrackingCategoryID" type="String" hint="I am the TrackingCategoryID." />
      <cfset variables.instance.TrackingCategoryID = arguments.TrackingCategoryID />
  </cffunction>

  <!---
   * The name of the tracking category e.g. Department, Region (max length = 100)
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
   * The status of a tracking category
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
   * See Tracking Options
   * @return Options
  --->
  <cffunction name="getOptions" access="public" output="false" hint="I return the Options">
    <cfset var lines = variables.instance.Options>
    <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(lines);i=i+1) {
              ArrayAppend(arr,lines[i].toStruct());
            }
    </cfscript>
    <cfreturn arr />
  </cffunction>

  <cffunction name="setOptions" access="public"  output="false" hint="I set the Options into the variables.instance scope.">
    <cfargument name="Options" type="array" hint="I am the Options." />
       <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(arguments.Options);i=i+1) {
              var item=createObject("component","TrackingOption").init(variables.xero).populate(arguments.Options[i]); 
              ArrayAppend(arr,item);
            }
      </cfscript>
      <cfset variables.instance.Options = arr />
  </cffunction>

   <cffunction name="getOptionsAsJSON" access="public" output="false" hint="I return the Options">
    <cfset var lines = variables.instance.Options>
    <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(lines);i=i+1) {
              ArrayAppend(arr,lines[i].toStruct(exclude="TrackingOptionID,Status,TrackingCategoryID"));
            }
    </cfscript>
    <cfreturn serializeJSON(arr)>
  </cffunction>

   <!---
   * The status of a tracking category
   * @return Status
  --->
  <cffunction name="getOptionId" access="public" output="false" hint="I return the Status">
    <cfreturn variables.instance.OptionId />
  </cffunction>

  <cffunction name="setOptionId" access="public"  output="false" hint="I set the Status into the variables.instance scope.">
    <cfargument name="OptionId" type="String" hint="I am the Status." />
      <cfset variables.instance.OptionId = arguments.OptionId />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


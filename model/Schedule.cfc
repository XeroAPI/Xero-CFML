<cfcomponent displayname="Schedule" output="false" extends="xeroclient"
  hint="I am the Schedule Class.">

<!--- PROPERTIES --->

  <cfproperty name="Period" type="Double" default="" />
  <cfproperty name="Unit" type="String" default="" />
  <cfproperty name="DueDate" type="Double" default="" />
  <cfproperty name="DueDateType" type="array" default="" />
  <cfproperty name="StartDate" type="String" default="" />
  <cfproperty name="NextScheduledDate" type="String" default="" />
  <cfproperty name="EndDate" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Schedule Class.">
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
            myStruct["ScheduleID"]=getScheduleID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Period")) {
              if (NOT listFindNoCase(arguments.exclude, "Period")) {
                myStruct["Period"]=getPeriod();
              }
            }
            if (structKeyExists(variables.instance,"Unit")) {
              if (NOT listFindNoCase(arguments.exclude, "Unit")) {
                myStruct["Unit"]=getUnit();
              }
            }
            if (structKeyExists(variables.instance,"DueDate")) {
              if (NOT listFindNoCase(arguments.exclude, "DueDate")) {
                myStruct["DueDate"]=getDueDate();
              }
            }
            if (structKeyExists(variables.instance,"DueDateType")) {
              if (NOT listFindNoCase(arguments.exclude, "DueDateType")) {
                myStruct["DueDateType"]=getDueDateType();
              }
            }
            if (structKeyExists(variables.instance,"StartDate")) {
              if (NOT listFindNoCase(arguments.exclude, "StartDate")) {
                myStruct["StartDate"]=getStartDate();
              }
            }
            if (structKeyExists(variables.instance,"NextScheduledDate")) {
              if (NOT listFindNoCase(arguments.exclude, "NextScheduledDate")) {
                myStruct["NextScheduledDate"]=getNextScheduledDate();
              }
            }
            if (structKeyExists(variables.instance,"EndDate")) {
              if (NOT listFindNoCase(arguments.exclude, "EndDate")) {
                myStruct["EndDate"]=getEndDate();
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

        if (structKeyExists(obj,"Period")) {
          setPeriod(obj.Period);
        } else {
          setPeriod("");
        }
        if (structKeyExists(obj,"Unit")) {
          setUnit(obj.Unit);
        } else {
          setUnit("");
        }
        if (structKeyExists(obj,"DueDate")) {
          setDueDate(obj.DueDate);
        } else {
          setDueDate("");
        }
        if (structKeyExists(obj,"DueDateType")) {
          setDueDateType(obj.DueDateType);
        } else {
          setDueDateType("");
        }
        if (structKeyExists(obj,"StartDate")) {
          setStartDate(obj.StartDate);
        } else {
          setStartDate("");
        }
        if (structKeyExists(obj,"NextScheduledDate")) {
          setNextScheduledDate(obj.NextScheduledDate);
        } else {
          setNextScheduledDate("");
        }
        if (structKeyExists(obj,"EndDate")) {
          setEndDate(obj.EndDate);
        } else {
          setEndDate("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="Schedules"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Schedules",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Schedules",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Schedules",body=this.toJSON(),id=this.getScheduleID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Schedules",body=this.toJSON(archive=true),id=this.getScheduleID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Schedules",body=this.toJSON(),id=this.getScheduleID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Schedules">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Schedules">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Integer used with the unit e.g. 1 (every 1 week), 2 (every 2 months)
   * @return Period
  --->
  <cffunction name="getPeriod" access="public" output="false" hint="I return the Period">
    <cfreturn variables.instance.Period />
  </cffunction>

  <cffunction name="setPeriod" access="public"  output="false" hint="I set the Period into the variables.instance scope.">
    <cfargument name="Period" type="Double" hint="I am the Period." />
      <cfset variables.instance.Period = arguments.Period />
  </cffunction>

  <!---
   * One of the following : WEEKLY or MONTHLY
   * @return Unit
  --->
  <cffunction name="getUnit" access="public" output="false" hint="I return the Unit">
    <cfreturn variables.instance.Unit />
  </cffunction>

  <cffunction name="setUnit" access="public"  output="false" hint="I set the Unit into the variables.instance scope.">
    <cfargument name="Unit" type="String" hint="I am the Unit." />
      <cfset variables.instance.Unit = arguments.Unit />
  </cffunction>

  <!---
   * Integer used with due date type e.g 20 (of following month), 31 (of current month)
   * @return DueDate
  --->
  <cffunction name="getDueDate" access="public" output="false" hint="I return the DueDate">
    <cfreturn variables.instance.DueDate />
  </cffunction>

  <cffunction name="setDueDate" access="public"  output="false" hint="I set the DueDate into the variables.instance scope.">
    <cfargument name="DueDate" type="Double" hint="I am the DueDate." />
      <cfset variables.instance.DueDate = arguments.DueDate />
  </cffunction>

  <!---
   * See DueDateType
   * @return DueDateType
  --->
  <cffunction name="getDueDateType" access="public" output="false" hint="I return the DueDateType">
    <cfreturn variables.instance.DueDateType />
  </cffunction>

  <cffunction name="setDueDateType" access="public"  output="false" hint="I set the DueDateType into the variables.instance scope.">
    <cfargument name="DueDateType" type="array" hint="I am the DueDateType." />
      <cfset variables.instance.DueDateType = arguments.DueDateType />
  </cffunction>

  <!---
   * Date the first invoice of the current version of the repeating schedule was generated (changes when repeating invoice is edited)
   * @return StartDate
  --->
  <cffunction name="getStartDate" access="public" output="false" hint="I return the StartDate">
    <cfreturn variables.instance.StartDate />
  </cffunction>

  <cffunction name="setStartDate" access="public"  output="false" hint="I set the StartDate into the variables.instance scope.">
    <cfargument name="StartDate" type="String" hint="I am the StartDate." />
      <cfset variables.instance.StartDate = arguments.StartDate />
  </cffunction>

  <!---
   * The calendar date of the next invoice in the schedule to be generated
   * @return NextScheduledDate
  --->
  <cffunction name="getNextScheduledDate" access="public" output="false" hint="I return the NextScheduledDate">
    <cfreturn variables.instance.NextScheduledDate />
  </cffunction>

  <cffunction name="setNextScheduledDate" access="public"  output="false" hint="I set the NextScheduledDate into the variables.instance scope.">
    <cfargument name="NextScheduledDate" type="String" hint="I am the NextScheduledDate." />
      <cfset variables.instance.NextScheduledDate = arguments.NextScheduledDate />
  </cffunction>

  <!---
   * Invoice end date – only returned if the template has an end date set
   * @return EndDate
  --->
  <cffunction name="getEndDate" access="public" output="false" hint="I return the EndDate">
    <cfreturn variables.instance.EndDate />
  </cffunction>

  <cffunction name="setEndDate" access="public"  output="false" hint="I set the EndDate into the variables.instance scope.">
    <cfargument name="EndDate" type="String" hint="I am the EndDate." />
      <cfset variables.instance.EndDate = arguments.EndDate />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


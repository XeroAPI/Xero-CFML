<cfcomponent displayname="BrandingTheme" output="false" extends="cfc.xeroclient"
  hint="I am the BrandingTheme Class.">

<!--- PROPERTIES --->

  <cfproperty name="ReportDate" type="String" default="" />
  <cfproperty name="ReportID" type="String" default="" />
  <cfproperty name="ReportName" type="String" default="" />
  <cfproperty name="ReportTitles" type="Array" default="" />
  <cfproperty name="ReportType" type="String" default="" />
  <cfproperty name="Rows" type="Array" default="" />

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
            myStruct.ReportID=getReportID();
            myStruct.Status=getStatus();
          } else {

            if (structKeyExists(variables.instance,"ReportID")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportID")) {
                myStruct.ReportID=getReportID();
              }
            }
            if (structKeyExists(variables.instance,"ReportName")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportName")) {
                myStruct.ReportName=getReportName();
              }
            }
            if (structKeyExists(variables.instance,"ReportDate")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportDate")) {
                myStruct.ReportDate=getReportDate();
              }
            }
            if (structKeyExists(variables.instance,"ReportType")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportType")) {
                myStruct.ReportType=getReportType();
              }
            }
            if (structKeyExists(variables.instance,"ReportTitles")) {
              if (NOT listFindNoCase(arguments.exclude, "ReportTitles")) {
                if (ArrayLen(variables.instance.ReportTitles) GT 0) {
                  myStruct.ReportTitles=getReportTitles();
                }
              }
            }
            if (structKeyExists(variables.instance,"Rows")) {
              if (NOT listFindNoCase(arguments.exclude, "Rows")) {
                if (ArrayLen(variables.instance.Rows) GT 0) {
                  myStruct.Rows=getRows();
                }
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

        if (structKeyExists(obj,"ReportID")) {
          setReportID(obj.ReportID);
        } else {
          setReportID("");
        }
        if (structKeyExists(obj,"ReportName")) {
          setReportName(obj.ReportName);
        } else {
          setReportName("");
        }
        if (structKeyExists(obj,"ReportDate")) {
          setReportDate(obj.ReportDate);
        } else {
          setReportDate("");
        }
        if (structKeyExists(obj,"ReportType")) {
          setReportType(obj.ReportType);
        } else {
          setReportType("");
        }
        if (structKeyExists(obj,"ReportTitles")) {
          setReportTitles(obj.ReportTitles);
        } else {
          setReportTitles(ArrayNew(1));
        }
        if (structKeyExists(obj,"Rows")) {
          setRows(obj.Rows);
        } else {
          setRows(ArrayNew(1));
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    <cfargument name="reportYear"  type="string" default="">
    <cfargument name="date"  type="string" default="">
    <cfargument name="fromDate"  type="string" default="">
    <cfargument name="toDate"  type="string" default="">
    <cfargument name="ContactID"  type="string" default="">
    <cfargument name="periods"  type="string" default="">
    <cfargument name="timeframe"  type="string" default="">
    <cfargument name="trackingOptionID1"  type="string" default="">
    <cfargument name="trackingOptionID2"  type="string" default="">
    <cfargument name="standardLayout"  type="string" default="">
    <cfargument name="paymentsOnly"  type="string" default="">
    <cfargument name="bankAccountID"  type="string" default="">

      <cfset stParam = StructNew()>
      <cfset stParam["reportYear"] = arguments.reportYear>
      <cfset stParam["date"] = arguments.date>
      <cfset stParam["fromDate"] = arguments.fromDate>
      <cfset stParam["toDate"] = arguments.toDate>
      <cfset stParam["ContactID"] = arguments.ContactID>
      <cfset stParam["periods"] = arguments.periods>
      <cfset stParam["timeframe"] = arguments.timeframe>
      <cfset stParam["trackingOptionID1"] = arguments.trackingOptionID1>
      <cfset stParam["trackingOptionID2"] = arguments.trackingOptionID2>
      <cfset stParam["standardLayout"] = arguments.standardLayout>
      <cfset stParam["paymentsOnly"] = arguments.paymentsOnly>
      <cfset stParam["bankAccountID"] = arguments.bankAccountID>
      
      <cfset this.setParameters(stParam)>    
     
      <cfset var result = this.get(endpoint="Reports",id=id)>

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
    <cfset variables.result = Super.post(endpoint="BrandingThemes",body=this.toJSON(),id=this.getReportID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="BrandingThemes",body=this.toJSON(),id=this.getReportID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="BrandingThemes",body=this.toJSON(),id=this.getReportID())>
    
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
   * @return ReportID
  --->
  <cffunction name="getReportID" access="public" output="false" hint="I return the ReportID">
    <cfreturn variables.instance.ReportID />
  </cffunction>

  <cffunction name="setReportID" access="public"  output="false" hint="I set the ReportID into the variables.instance scope.">
    <cfargument name="ReportID" type="String" hint="I am the ReportID." />
      <cfset variables.instance.ReportID = arguments.ReportID />
  </cffunction>

  <!---
   * ReportName of branding theme
   * @return ReportName
  --->
  <cffunction name="getReportName" access="public" output="false" hint="I return the ReportName">
    <cfreturn variables.instance.ReportName />
  </cffunction>

  <cffunction name="setReportName" access="public"  output="false" hint="I set the ReportName into the variables.instance scope.">
    <cfargument name="ReportName" type="String" hint="I am the ReportName." />
      <cfset variables.instance.ReportName = arguments.ReportName />
  </cffunction>

  <!---
   * Integer – ranked order of branding theme. The default branding theme has a value of 0
   * @return ReportDate
  --->
  <cffunction name="getReportDate" access="public" output="false" hint="I return the ReportDate">
    <cfreturn variables.instance.ReportDate />
  </cffunction>

  <cffunction name="setReportDate" access="public"  output="false" hint="I set the ReportDate into the variables.instance scope.">
    <cfargument name="ReportDate" type="String" hint="I am the ReportDate." />
      <cfset variables.instance.ReportDate = arguments.ReportDate />
  </cffunction>

  <!---
   * UTC timestamp of creation date of branding theme
   * @return ReportType
  --->
  <cffunction name="getReportType" access="public" output="false" hint="I return the ReportType">
    <cfreturn variables.instance.ReportType />
  </cffunction>

  <cffunction name="setReportType" access="public"  output="false" hint="I set the ReportType into the variables.instance scope.">
    <cfargument name="ReportType" type="String" hint="I am the ReportType." />
      <cfset variables.instance.ReportType = arguments.ReportType />
  </cffunction>

<!---
   * Store certain address types for a contact – see address types
   * @return ReportTitles
  --->
  <cffunction name="getReportTitles" access="public" output="false" hint="I return the ReportTitles">
    <cfreturn variables.instance.ReportTitles />
  </cffunction>

  <cffunction name="setReportTitles" access="public"  output="false" hint="I set the ReportTitles into the variables.instance scope.">
    <cfargument name="ReportTitles" type="array" hint="I am the ReportTitles." />

      <cfset variables.instance.ReportTitles = arguments.ReportTitles />
  </cffunction>


<!---
   * Store certain address types for a contact – see address types
   * @return Rows
  --->
  <cffunction name="getRows" access="public" output="false" hint="I return the Rows">
    <cfreturn variables.instance.Rows />
  </cffunction>

  <cffunction name="setRows" access="public"  output="false" hint="I set the Rows into the variables.instance scope.">
    <cfargument name="Rows" type="array" hint="I am the Rows." />

      <cfset variables.instance.Rows = arguments.Rows />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


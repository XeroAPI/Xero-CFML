<cfcomponent displayname="ManualJournal" output="false" extends="xeroclient"
  hint="I am the ManualJournal Class.">

<!--- PROPERTIES --->

  <cfproperty name="Narration" type="String" default="" />
  <cfproperty name="JournalLines" type="array" default="" />
  <cfproperty name="Date" type="String" default="" />
  <cfproperty name="LineAmountTypes" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="Url" type="String" default="" />
  <cfproperty name="ShowOnCashBasisReports" type="Boolean" default="" />
  <cfproperty name="HasAttachments" type="Boolean" default="" />
  <cfproperty name="UpdatedDateUTC" type="String" default="" />
  <cfproperty name="ManualJournalID" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the ManualJournal Class.">
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
            myStruct["ManualJournalID"]=getManualJournalID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"Narration")) {
              if (NOT listFindNoCase(arguments.exclude, "Narration")) {
                myStruct["Narration"]=getNarration();
              }
            }
            if (structKeyExists(variables.instance,"JournalLines")) {
              if (NOT listFindNoCase(arguments.exclude, "JournalLines")) {
                myStruct["JournalLines"]=getJournalLines();
              }
            }
            if (structKeyExists(variables.instance,"Date")) {
              if (NOT listFindNoCase(arguments.exclude, "Date")) {
                myStruct["Date"]=getDate();
              }
            }
            if (structKeyExists(variables.instance,"LineAmountTypes")) {
              if (NOT listFindNoCase(arguments.exclude, "LineAmountTypes")) {
                myStruct["LineAmountTypes"]=getLineAmountTypes();
              }
            }
            if (structKeyExists(variables.instance,"Status")) {
              if (NOT listFindNoCase(arguments.exclude, "Status")) {
                myStruct["Status"]=getStatus();
              }
            }
            if (structKeyExists(variables.instance,"Url")) {
              if (NOT listFindNoCase(arguments.exclude, "Url")) {
                if(len(getUrl()) GT 0) {
                  myStruct["Url"]=getUrl();
                }
              }
            }
            if (structKeyExists(variables.instance,"ShowOnCashBasisReports")) {
              if (NOT listFindNoCase(arguments.exclude, "ShowOnCashBasisReports")) {
                myStruct["ShowOnCashBasisReports"]=getShowOnCashBasisReports();
              }
            }
            if (structKeyExists(variables.instance,"HasAttachments")) {
              if (NOT listFindNoCase(arguments.exclude, "HasAttachments")) {
                myStruct["HasAttachments"]=getHasAttachments();
              }
            }
            if (structKeyExists(variables.instance,"UpdatedDateUTC")) {
              if (NOT listFindNoCase(arguments.exclude, "UpdatedDateUTC")) {
                myStruct["UpdatedDateUTC"]=getUpdatedDateUTC();
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

        if (structKeyExists(obj,"Narration")) {
          setNarration(obj.Narration);
        } else {
          setNarration("");
        }
        if (structKeyExists(obj,"JournalLines")) {
          setJournalLines(obj.JournalLines);
        } else {
          setJournalLines(ArrayNew(1));
        }
        if (structKeyExists(obj,"Date")) {
          setDate(obj.Date);
        } else {
          setDate("");
        }
        if (structKeyExists(obj,"LineAmountTypes")) {
          setLineAmountTypes(obj.LineAmountTypes);
        } else {
          setLineAmountTypes("");
        }
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"Url")) {
          setUrl(obj.Url);
        } else {
          setUrl("");
        }
        if (structKeyExists(obj,"ShowOnCashBasisReports")) {
          setShowOnCashBasisReports(obj.ShowOnCashBasisReports);
        } else {
          setShowOnCashBasisReports(false);
        }
        if (structKeyExists(obj,"HasAttachments")) {
          setHasAttachments(obj.HasAttachments);
        } else {
          setHasAttachments(false);
        }
        if (structKeyExists(obj,"UpdatedDateUTC")) {
          setUpdatedDateUTC(obj.UpdatedDateUTC);
        } else {
          setUpdatedDateUTC("");
        }
        if (structKeyExists(obj,"ManualJournalID")) {
          setManualJournalID(obj.ManualJournalID);
        } else {
          setManualJournalID("");
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
      
      <cfset this.setList(this.get(endpoint="ManualJournals"))>
      <cfset temp = this.populate(StructNew())>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="ManualJournals",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="ManualJournals",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ManualJournals",body=this.toJSON(),id=this.getManualJournalID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ManualJournals",body=this.toJSON(archive=true),id=this.getManualJournalID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="ManualJournals",body=this.toJSON(),id=this.getManualJournalID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of ManualJournals">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of ManualJournals">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Description of journal being posted
   * @return Narration
  --->
  <cffunction name="getNarration" access="public" output="false" hint="I return the Narration">
    <cfreturn variables.instance.Narration />
  </cffunction>

  <cffunction name="setNarration" access="public"  output="false" hint="I set the Narration into the variables.instance scope.">
    <cfargument name="Narration" type="String" hint="I am the Narration." />
      <cfset variables.instance.Narration = arguments.Narration />
  </cffunction>

  <!---
   * See JournalLines
   * @return JournalLines
  --->
  <cffunction name="getJournalLines" access="public" output="false" hint="I return the JournalLines">
    
    <cfset var lines = variables.instance.JournalLines>
    <cfscript>
        var arr = ArrayNew(1);
        for (var i=1;i LTE ArrayLen(lines);i=i+1) {
          ArrayAppend(arr,lines[i].toStruct());
        }
    </cfscript>
    <cfreturn arr />
  </cffunction>

  <cffunction name="setJournalLines" access="public"  output="false" hint="I set the JournalLines into the variables.instance scope.">
    <cfargument name="JournalLines" type="array" hint="I am the JournalLines." />
			
      <cfscript>
            var arr = ArrayNew(1);
		        for (var i=1;i LTE ArrayLen(arguments.JournalLines);i=i+1) {
		          var item=createObject("component","JournalLine").init(variables.xero).populate(arguments.JournalLines[i]); 
		          ArrayAppend(arr,item);
		        }
		  </cfscript>
		  <cfset variables.instance.JournalLines = arr />
  </cffunction>

  <!---
   * Date journal was posted – YYYY-MM-DD
   * @return Date
  --->
  <cffunction name="getDate" access="public" output="false" hint="I return the Date">
    <cfreturn variables.instance.Date />
  </cffunction>

  <cffunction name="setDate" access="public"  output="false" hint="I set the Date into the variables.instance scope.">
    <cfargument name="Date" type="String" hint="I am the Date." />
      <cfset variables.instance.Date = arguments.Date />
  </cffunction>

  <!---
   * NoTax by default if you don’t specify this element. See Line Amount Types
   * @return LineAmountTypes
  --->
  <cffunction name="getLineAmountTypes" access="public" output="false" hint="I return the LineAmountTypes">
    <cfreturn variables.instance.LineAmountTypes />
  </cffunction>

  <cffunction name="setLineAmountTypes" access="public"  output="false" hint="I set the LineAmountTypes into the variables.instance scope.">
    <cfargument name="LineAmountTypes" type="String" hint="I am the LineAmountTypes." />
      <cfset variables.instance.LineAmountTypes = arguments.LineAmountTypes />
  </cffunction>

  <!---
   * See Manual Journal Status Codes
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
   * Url link to a source document – shown as “Go to [appName]” in the Xero app
   * @return Url
  --->
  <cffunction name="getUrl" access="public" output="false" hint="I return the Url">
    <cfreturn variables.instance.Url />
  </cffunction>

  <cffunction name="setUrl" access="public"  output="false" hint="I set the Url into the variables.instance scope.">
    <cfargument name="Url" type="String" hint="I am the Url." />
      <cfset variables.instance.Url = arguments.Url />
  </cffunction>

  <!---
   * Boolean – default is true if not specified
   * @return ShowOnCashBasisReports
  --->
  <cffunction name="getShowOnCashBasisReports" access="public" output="false" hint="I return the ShowOnCashBasisReports">
    <cfreturn variables.instance.ShowOnCashBasisReports />
  </cffunction>

  <cffunction name="setShowOnCashBasisReports" access="public"  output="false" hint="I set the ShowOnCashBasisReports into the variables.instance scope.">
    <cfargument name="ShowOnCashBasisReports" type="Boolean" hint="I am the ShowOnCashBasisReports." />
      <cfset variables.instance.ShowOnCashBasisReports = arguments.ShowOnCashBasisReports />
  </cffunction>

  <!---
   * Boolean to indicate if a manual journal has an attachment
   * @return HasAttachments
  --->
  <cffunction name="getHasAttachments" access="public" output="false" hint="I return the HasAttachments">
    <cfreturn variables.instance.HasAttachments />
  </cffunction>

  <cffunction name="setHasAttachments" access="public"  output="false" hint="I set the HasAttachments into the variables.instance scope.">
    <cfargument name="HasAttachments" type="Boolean" hint="I am the HasAttachments." />
      <cfset variables.instance.HasAttachments = arguments.HasAttachments />
  </cffunction>

  <!---
   * Last modified date UTC format
   * @return UpdatedDateUTC
  --->
  <cffunction name="getUpdatedDateUTC" access="public" output="false" hint="I return the UpdatedDateUTC">
    <cfreturn variables.instance.UpdatedDateUTC />
  </cffunction>

  <cffunction name="setUpdatedDateUTC" access="public"  output="false" hint="I set the UpdatedDateUTC into the variables.instance scope.">
    <cfargument name="UpdatedDateUTC" type="String" hint="I am the UpdatedDateUTC." />
      <cfset variables.instance.UpdatedDateUTC = arguments.UpdatedDateUTC />
  </cffunction>

  <!---
   * The Xero identifier for a Manual Journal
   * @return JournalID
  --->
  <cffunction name="getManualJournalID" access="public" output="false" hint="I return the ManualJournalID">
    <cfreturn variables.instance.ManualJournalID />
  </cffunction>

  <cffunction name="setManualJournalID" access="public"  output="false" hint="I set the ManualJournalID into the variables.instance scope.">
    <cfargument name="ManualJournalID" type="String" hint="I am the ManualJournalID." />
      <cfset variables.instance.ManualJournalID = arguments.ManualJournalID />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


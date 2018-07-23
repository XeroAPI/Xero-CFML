<cfcomponent displayname="Journal" output="false" extends="xeroclient"
  hint="I am the Journal Class.">

<!--- PROPERTIES --->

  <cfproperty name="JournalID" type="String" default="" />
  <cfproperty name="JournalDate" type="String" default="" />
  <cfproperty name="JournalNumber" type="String" default="" />
  <cfproperty name="CreatedDateUTC" type="String" default="" />
  <cfproperty name="Reference" type="String" default="" />
  <cfproperty name="SourceID" type="String" default="" />
  <cfproperty name="SourceType" type="String" default="" />
  <cfproperty name="JournalLines" type="array" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the Journal Class.">
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

  <cffunction name="toJSON" access="public" output="false">
     <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON payload" />
    
     
        <cfscript>
          myStruct=StructNew();

          if (structKeyExists(variables.instance,"JournalID")) {
            if (NOT listFindNoCase(arguments.exclude, "JournalID")) {
              myStruct["JournalID"]=getJournalID();
            }
          }
          if (structKeyExists(variables.instance,"JournalDate")) {
            if (NOT listFindNoCase(arguments.exclude, "JournalDate")) {
              myStruct["JournalDate"]=getJournalDate();
            }
          }
          if (structKeyExists(variables.instance,"JournalNumber")) {
            if (NOT listFindNoCase(arguments.exclude, "JournalNumber")) {
              myStruct["JournalNumber"]=getJournalNumber();
            }
          }
          if (structKeyExists(variables.instance,"CreatedDateUTC")) {
            if (NOT listFindNoCase(arguments.exclude, "CreatedDateUTC")) {
              myStruct["CreatedDateUTC"]=getCreatedDateUTC();
            }
          }
          if (structKeyExists(variables.instance,"Reference")) {
            if (NOT listFindNoCase(arguments.exclude, "Reference")) {
              myStruct["Reference"]=getReference();
            }
          }
          if (structKeyExists(variables.instance,"SourceID")) {
            if (NOT listFindNoCase(arguments.exclude, "SourceID")) {
              myStruct["SourceID"]=getSourceID();
            }
          }
          if (structKeyExists(variables.instance,"SourceType")) {
            if (NOT listFindNoCase(arguments.exclude, "SourceType")) {
              myStruct["SourceType"]=getSourceType();
            }
          }
          if (structKeyExists(variables.instance,"JournalLines")) {
            if (NOT listFindNoCase(arguments.exclude, "JournalLines")) {
              myStruct["JournalLines"]=getJournalLines();
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

        if (structKeyExists(obj,"JournalID")) {
          setJournalID(obj.JournalID);
        } else {
          setJournalID("");
        }
        if (structKeyExists(obj,"JournalDate")) {
          setJournalDate(obj.JournalDate);
        } else {
          setJournalDate("");
        }
        if (structKeyExists(obj,"JournalNumber")) {
          setJournalNumber(obj.JournalNumber);
        } else {
          setJournalNumber("");
        }
        if (structKeyExists(obj,"CreatedDateUTC")) {
          setCreatedDateUTC(obj.CreatedDateUTC);
        } else {
          setCreatedDateUTC("");
        }
        if (structKeyExists(obj,"Reference")) {
          setReference(obj.Reference);
        } else {
          setReference("");
        }
        if (structKeyExists(obj,"SourceID")) {
          setSourceID(obj.SourceID);
        } else {
          setSourceID("");
        }
        if (structKeyExists(obj,"SourceType")) {
          setSourceType(obj.SourceType);
        } else {
          setSourceType("");
        }
        if (structKeyExists(obj,"JournalLines")) {
          setJournalLines(obj.JournalLines);
        } else {
          setJournalLines(ArrayNew(1));
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
      
      <cfset this.setList(this.get(endpoint="Journals"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="Journals",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="Journals",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Journals",body=this.toJSON(),id=this.getJournalID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="Journals",body=this.toJSON(),id=this.getJournalID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="Journals",body=this.toJSON(),id=this.getJournalID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of Journals">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of Journals">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * Xero identifier
   * @return JournalID
  --->
  <cffunction name="getJournalID" access="public" output="false" hint="I return the JournalID">
    <cfreturn variables.instance.JournalID />
  </cffunction>

  <cffunction name="setJournalID" access="public"  output="false" hint="I set the JournalID into the variables.instance scope.">
    <cfargument name="JournalID" type="String" hint="I am the JournalID." />
      <cfset variables.instance.JournalID = arguments.JournalID />
  </cffunction>

  <!---
   * Date the journal was posted
   * @return JournalDate
  --->
  <cffunction name="getJournalDate" access="public" output="false" hint="I return the JournalDate">
    <cfreturn variables.instance.JournalDate />
  </cffunction>

  <cffunction name="setJournalDate" access="public"  output="false" hint="I set the JournalDate into the variables.instance scope.">
    <cfargument name="JournalDate" type="String" hint="I am the JournalDate." />
      <cfset variables.instance.JournalDate = arguments.JournalDate />
  </cffunction>

  <!---
   * Xero generated journal number
   * @return JournalNumber
  --->
  <cffunction name="getJournalNumber" access="public" output="false" hint="I return the JournalNumber">
    <cfreturn variables.instance.JournalNumber />
  </cffunction>

  <cffunction name="setJournalNumber" access="public"  output="false" hint="I set the JournalNumber into the variables.instance scope.">
    <cfargument name="JournalNumber" type="String" hint="I am the JournalNumber." />
      <cfset variables.instance.JournalNumber = arguments.JournalNumber />
  </cffunction>

  <!---
   * Created date UTC format
   * @return CreatedDateUTC
  --->
  <cffunction name="getCreatedDateUTC" access="public" output="false" hint="I return the CreatedDateUTC">
    <cfreturn variables.instance.CreatedDateUTC />
  </cffunction>

  <cffunction name="setCreatedDateUTC" access="public"  output="false" hint="I set the CreatedDateUTC into the variables.instance scope.">
    <cfargument name="CreatedDateUTC" type="String" hint="I am the CreatedDateUTC." />
      <cfset variables.instance.CreatedDateUTC = arguments.CreatedDateUTC />
  </cffunction>

  <!---
   *  
   * @return Reference
  --->
  <cffunction name="getReference" access="public" output="false" hint="I return the Reference">
    <cfreturn variables.instance.Reference />
  </cffunction>

  <cffunction name="setReference" access="public"  output="false" hint="I set the Reference into the variables.instance scope.">
    <cfargument name="Reference" type="String" hint="I am the Reference." />
      <cfset variables.instance.Reference = arguments.Reference />
  </cffunction>

  <!---
   * The identifier for the source transaction (e.g. InvoiceID)
   * @return SourceID
  --->
  <cffunction name="getSourceID" access="public" output="false" hint="I return the SourceID">
    <cfreturn variables.instance.SourceID />
  </cffunction>

  <cffunction name="setSourceID" access="public"  output="false" hint="I set the SourceID into the variables.instance scope.">
    <cfargument name="SourceID" type="String" hint="I am the SourceID." />
      <cfset variables.instance.SourceID = arguments.SourceID />
  </cffunction>

  <!---
   * The journal source type. The type of transaction that created the journal
   * @return SourceType
  --->
  <cffunction name="getSourceType" access="public" output="false" hint="I return the SourceType">
    <cfreturn variables.instance.SourceType />
  </cffunction>

  <cffunction name="setSourceType" access="public"  output="false" hint="I set the SourceType into the variables.instance scope.">
    <cfargument name="SourceType" type="String" hint="I am the SourceType." />
      <cfset variables.instance.SourceType = arguments.SourceType />
  </cffunction>

  <!---
   * See JournalLines
   * @return JournalLines
  --->
  <cffunction name="getJournalLines" access="public" output="false" hint="I return the JournalLines">
    <cfreturn variables.instance.JournalLines />
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



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



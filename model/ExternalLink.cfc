<cfcomponent displayname="ExternalLink" output="false" extends="xeroclient"
  hint="I am the ExternalLink Class.">

<!--- PROPERTIES --->

  <cfproperty name="LinkType" type="String" default="" />
  <cfproperty name="Url" type="String" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the ExternalLink Class.">
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
        <cfscript>
          myStruct=StructNew();
          myStruct=this.toJSON(returnType="struct");
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
            myStruct["ExternalLinkID"]=getExternalLinkID();
            myStruct["Status"]=getStatus();
          } else {

            if (structKeyExists(variables.instance,"LinkType")) {
              if (NOT listFindNoCase(arguments.exclude, "LinkType")) {
                myStruct["LinkType"]=getLinkType();
              }
            }
            if (structKeyExists(variables.instance,"Url")) {
              if (NOT listFindNoCase(arguments.exclude, "Url")) {
                myStruct["Url"]=getUrl();
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

        if (structKeyExists(obj,"LinkType")) {
          setLinkType(obj.LinkType);
        } else {
          setLinkType("");
        }
        if (structKeyExists(obj,"Url")) {
          setUrl(obj.Url);
        } else {
          setUrl("");
        }
      </cfscript>
      
   <cfreturn this />
  </cffunction>

  <cffunction name="getAll" access="public" returntype="any">
    <cfargument name="ifModifiedSince"  type="string" default="">
      <cfset this.setList(this.get(endpoint="ExternalLinks"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="ExternalLinks",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="ExternalLinks",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ExternalLinks",body=this.toJSON(),id=this.getExternalLinkID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="archive" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ExternalLinks",body=this.toJSON(archive=true),id=this.getExternalLinkID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="ExternalLinks",body=this.toJSON(),id=this.getExternalLinkID())>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of ExternalLinks">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of ExternalLinks">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * See External link types
   * @return LinkType
  --->
  <cffunction name="getLinkType" access="public" output="false" hint="I return the LinkType">
    <cfreturn variables.instance.LinkType />
  </cffunction>

  <cffunction name="setLinkType" access="public"  output="false" hint="I set the LinkType into the variables.instance scope.">
    <cfargument name="LinkType" type="String" hint="I am the LinkType." />
      <cfset variables.instance.LinkType = arguments.LinkType />
  </cffunction>

  <!---
   * URL for service e.g. http://twitter.com/xeroapi
   * @return Url
  --->
  <cffunction name="getUrl" access="public" output="false" hint="I return the Url">
    <cfreturn variables.instance.Url />
  </cffunction>

  <cffunction name="setUrl" access="public"  output="false" hint="I set the Url into the variables.instance scope.">
    <cfargument name="Url" type="String" hint="I am the Url." />
      <cfset variables.instance.Url = arguments.Url />
  </cffunction>



<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   



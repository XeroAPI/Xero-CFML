<cfcomponent displayname="ContactGroup" output="false" extends="xeroclient"
  hint="I am the ContactGroup Class.">

<!--- PROPERTIES --->

  <cfproperty name="Name" type="String" default="" />
  <cfproperty name="Status" type="String" default="" />
  <cfproperty name="ContactGroupID" type="String" default="" />
  <cfproperty name="Contacts" type="array" default="" />

<!--- INIT --->
  <cffunction name="init" access="public" output="false"
    returntype="any" hint="I am the constructor method for the ContactGroup Class.">
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

  <cffunction name="getContactsAsJSON" access="public" output="false">
        
    <cfreturn this.toJSON(exclude="HasAttachments,Name,IsCustomer,IsSupplier,Status,ContactGroupID") />
  </cffunction>

  <cffunction name="toJSON" access="public" output="false">
     <cfargument name="exclude" type="String" default="" hint="I am a list of attributes to exclude from JSON payload" />
     <cfargument name="archive" type="boolean" default="false" hint="I flag to return only the req. fields as JSON payload for archiving an object" />
     <cfargument name="returnType" type="String" default="json" hint="I set how the data is returned" />
     
        <cfscript>
          myStruct=StructNew();
          if (archive) {
            myStruct["ContactGroupID"]=getContactGroupID();
            myStruct["Status"]=getStatus();
          } else {

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
            if (structKeyExists(variables.instance,"ContactGroupID")) {
              if (NOT listFindNoCase(arguments.exclude, "ContactGroupID")) {
                myStruct["ContactGroupID"]=getContactGroupID();
              }
            }
            if (structKeyExists(variables.instance,"Contacts")) {
              if (NOT listFindNoCase(arguments.exclude, "Contacts")) {
                myStruct["Contacts"]=getContacts();
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
        if (structKeyExists(obj,"Status")) {
          setStatus(obj.Status);
        } else {
          setStatus("");
        }
        if (structKeyExists(obj,"ContactGroupID")) {
          setContactGroupID(obj.ContactGroupID);
        } else {
          setContactGroupID("");
        }
        if (structKeyExists(obj,"Contacts")) {
          setContacts(obj.Contacts);
        } else {
          setContacts(ArrayNew(1));
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
      
      <cfset this.setList(this.get(endpoint="ContactGroups"))>
    <cfreturn this>
  </cffunction>

  <cffunction name="getById" access="public" returntype="any">
    <cfargument name="id"  type="string" default="">
    
    <cfset var ArrayResult = this.get(endpoint="ContactGroups",id=id)>
    <cfscript>
      this.populate(ArrayResult[1]);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="create" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="ContactGroups",body=this.toJSON())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="update" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ContactGroups",body=this.toJSON(),id=this.getContactGroupID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="addContacts" access="public" output="false">
    <cfset variables.result = Super.put(endpoint="ContactGroups",body=this.getContactsAsJSON(),id=this.getContactGroupID(),child="Contacts")>

    <cfreturn this />
  </cffunction>

  <cffunction name="removeContact" access="public" output="false">
    <cfargument name="id" required="true" type="String" default="" hint="I am a ID of the Contact to Remove from the Contact Group." />

    <cfset variables.result = Super.delete(endpoint="ContactGroups",body=this.getContactsAsJSON(),id=this.getContactGroupID(),child="Contacts",childId=arguments.id)>
<!---
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>
--->
    <cfreturn this />
  </cffunction>

  <cffunction name="delete" access="public" output="false">
    <cfset variables.result = Super.post(endpoint="ContactGroups",body=this.toJSON(archive=true),id=this.getContactGroupID())>
    
    <cfloop from="1" to="#ArrayLen(variables.result)#" index="i">
      <cfset temp = this.populate(variables.result[i])>
    </cfloop>

    <cfreturn this />
  </cffunction>

  <cffunction name="deleteContacts" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="ContactGroups",body=this.toJSON(),id=this.getContactGroupID(),child="Contacts")>

    <cfreturn this />
  </cffunction>

  <cffunction name="deleteContact" access="public" output="false">
    <cfset variables.result = Super.delete(endpoint="ContactGroups",body=this.toJSON(),id=this.getContactGroupID(),child="Contact",childId="123")>
    
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

  <cffunction name="setList" access="public"  output="false" hint="I set the array of ContactGroups">
    <cfargument name="list" type="Array" hint="I am the list." />
      <cfset this.list = arguments.list />
  </cffunction>

  <cffunction name="getList" access="public" output="false" hint="I return the array of ContactGroups">
    <cfreturn this.list />
  </cffunction>

<!--- GETTER / SETTER  --->

  <!---
   * The Name of the contact group. Required when creating a new contact group
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
   * The Status of a contact group. To delete a contact group update the status to DELETED. Only contact groups with a status of ACTIVE are returned on GETs.
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
   * The Xero identifier for an contact group – specified as a string following the endpoint name. e.g. /297c2dc5-cc47-4afd-8ec8-74990b8761e9
   * @return ContactGroupID
  --->
  <cffunction name="getContactGroupID" access="public" output="false" hint="I return the ContactGroupID">
    <cfreturn variables.instance.ContactGroupID />
  </cffunction>

  <cffunction name="setContactGroupID" access="public"  output="false" hint="I set the ContactGroupID into the variables.instance scope.">
    <cfargument name="ContactGroupID" type="String" hint="I am the ContactGroupID." />
      <cfset variables.instance.ContactGroupID = arguments.ContactGroupID />
  </cffunction>

  <!---
   * The ContactID and Name of Contacts in a contact group. Returned on GETs when the ContactGroupID is supplied in the URL.
   * @return Contacts
  --->
  <cffunction name="getContacts" access="public" output="false" hint="I return the Contacts">
    <!---
    <cfset var lines = variables.instance.Contacts>
    <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(lines);i=i+1) {
              ArrayAppend(arr,lines[i].toStruct());
            }
    </cfscript>
    <cfreturn arr />
  --->
    <cfreturn variables.instance.Contacts>
  </cffunction>

  <cffunction name="setContacts" access="public"  output="false" hint="I set the Contacts into the variables.instance scope.">
    <cfargument name="Contacts" type="array" hint="I am the Contacts." />
     <!---
     <cfscript>
            var arr = ArrayNew(1);
            for (var i=1;i LTE ArrayLen(arguments.Contacts);i=i+1) {
              var item=createObject("component","Contact").init().populate(arguments.Contacts[i]); 
              ArrayAppend(arr,item);
            }
      </cfscript>
      <cfset variables.instance.Contacts = arr />
		--->
      <cfset variables.instance.Contacts = arguments.Contacts />
    
  </cffunction>

<cffunction name="getMemento" access="public"
  output="false" hint="I return a dumped struct of the
  variables.instance scope.">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>   


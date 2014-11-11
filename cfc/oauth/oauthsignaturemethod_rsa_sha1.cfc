<!---
Description:
============
	OAuth signaturemethod "RSA SHA1"

License:
============
Copyright 2008 CONTENS Software GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

History:
============

--->

<cfcomponent extends="oauthsignaturemethod" displayname="oauthsignaturemethod_rsa_sha1" hint="signature method using RSA-SHA1">

	<!--- returns the signature name --->
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn "RSA-SHA1">
	</cffunction>

	<!--- builds a SHA-1 signature --->
	<cffunction name="buildSignature" access="public" returntype="string" output="false">
		<cfargument name="oRequest"		required="true" type="oauthrequest">
		<cfargument name="oConsumer"	required="true" type="oauthconsumer">
		<cfargument name="oToken"		required="true" type="oauthtoken">

		<cfset var aSignature = ArrayNew(1)>
		<cfset var sKey = "">
		<cfset var sResult = "">
		<cfset var sHashed = "">
		<cfset var digest = "">
		<cfset var encoder = CreateObject("component", "oauthutil").init()>

		<cfset ArrayAppend(	aSignature,
							encoder.encodePercent(arguments.oRequest.getNormalizedHttpMethod()) )>
		<cfset ArrayAppend(	aSignature,
							encoder.encodePercent(arguments.oRequest.getNormalizedHttpURL()) )>
		<cfset ArrayAppend(	aSignature,
							encoder.encodePercent(arguments.oRequest.getSignableParameters()) )>

		<!-- use PrivateKey generated with OpenSSL - public key uploaded to api.xero.com --->
		<cffile 
			    action = "readBinary" 
			    file = "#arguments.oConsumer.getPathToPrivateKey()#"
			    variable = "sKey">

		<cfset sResult = ArrayToList(aSignature, "&")>

		<cfset sHashed = rsa_sha1(
			signKey = sKey,
			signMessage = sResult)>

		<cfreturn sHashed>
	</cffunction>

<!---
	<cffunction name="hmac_sha1" returntype="string" access="public">
	   <cfargument name="signKey" type="string" required="true">
	   <cfargument name="signMessage" type="string" required="true">
	   <cfargument name="sFormat" type="string" required="false" default="iso-8859-1">

	   <cfset var jMsg = JavaCast("string", arguments.signMessage).getBytes(arguments.sFormat)>
	   <cfset var jKey = JavaCast("string", arguments.signKey).getBytes(arguments.sFormat)>

	   <cfset var key = createObject("java", "javax.crypto.spec.SecretKeySpec")>
	   <cfset var mac = createObject("java", "javax.crypto.Mac")>

	   <cfset key = key.init(jKey,"HmacSHA1")>

	   <cfset mac = mac.getInstance(key.getAlgorithm())>
	   <cfset mac.init(key)>
	   <cfset mac.update(jMsg)>

	   <cfreturn ToBase64(mac.doFinal())>
	</cffunction>
--->


<cffunction name="rsa_sha1" returntype="string" access="public" descrition="RSA-SHA1 computation based on supplied private key and supplied base signature string.">
    	<!---Written by Sharad Gupta sharadg@gmail.com (used with permission)--->
          <cfargument name="signKey"  required="true" hint="base64 formatted PKCS8 private key">
	      <cfargument name="signMessage" type="string" required="true" hint="msg to sign">
	      <cfargument name="sFormat" type="string" required="false" default="UTF-8">
	

	      <cfset var jMsg = JavaCast("string",arguments.signMessage).getBytes(arguments.sFormat)>
	
	      <cfset var key = createObject("java", "java.security.PrivateKey")>
	      <cfset var keySpec = createObject("java","java.security.spec.PKCS8EncodedKeySpec")><!--- PKCS8EncodedKeySpec --->
	      <cfset var keyFactory = createObject("java","java.security.KeyFactory")>
	      <cfset var b64dec = createObject("java", "sun.misc.BASE64Decoder")>
	
	      <cfset var sig = createObject("java", "java.security.Signature")>
	
	      <cfset var byteClass = createObject("java", "java.lang.Class")>
	      <cfset var byteArray = createObject("java","java.lang.reflect.Array")>
	
	      <cfset byteClass = byteClass.forName(JavaCast("string","java.lang.Byte"))>
	      <cfset keyBytes = byteArray.newInstance(byteClass, JavaCast("int","1024"))>
	

	      <cfset sig = sig.getInstance("SHA1withRSA", "SunJSSE")>
	      <cfset sig.initSign(keyFactory.getInstance("RSA").generatePrivate(keySpec.init(signKey)))>
	      <cfset sig.update(jMsg)>
	      <cfset signBytes = sig.sign()>
	
	      <cfreturn ToBase64(signBytes)>
     </cffunction>

     <cffunction name="urlEncoder" returntype="string" access="public" output="no" hint="ColdFusion default urlEncode does not 		encode in the required format.">
 
		<cfargument name="url" type="string" required="true" />
	 
		<cfset var rfc_3986_bad_chars = "%2D,%2E,%5F,%7E">
		<cfset var rfc_3986_good_chars = "-,.,_,~">
	 
		<cfset arguments.url = ReplaceList(URLEncodedFormat(trim(arguments.url)),rfc_3986_bad_chars,rfc_3986_good_chars)>
		
	   <cfreturn arguments.url />
 
	</cffunction>



</cfcomponent>
Xero-CFML
=========

CFML SDK for Xero API - use with CFML application servers.

* [Things to note](#things-to-note)
* [Select an Application Type](#select-an-application-type)
* [Getting Started](#getting-started)
* [To Do](#to-do)
* [Additional Reading](#additional-reading)
* [Acknowledgements](#acknowledgements)
* [License](#license)

## Things to note
* This SDK offers an Object Oriented approach using CFCs to model endpoints and methods you can invoke. You can still instantiate the xero.cfc and construct http calls for your own use and situation if you find the models don't meet your needs. 
* Not tested on Lucee, please submit issues if you encounter any.


## Select an application type
Xero's API supports [3 application types](http://developer.xero.com/documentation/getting-started/api-application-types/). All Xero Apps types supported by this SDK.  Please [review  each type](http://developer.xero.com/documentation/getting-started/api-application-types/) to determine the right one for your integration.

* [Public](http://developer.xero.com/documentation/auth-and-limits/public-applications/)
* [Private](http://developer.xero.com/documentation/auth-and-limits/private-applications/)
* [Partner](http://developer.xero.com/documentation/auth-and-limits/partner-applications/)


## Getting Started
### Create a Xero User Account
[Create a Xero user account](https://www.xero.com/signup) for free.  Xero does not have a designated "sandbox" for development.  Instead you'll use the free Demo company for development.  Learn how to get started with [Xero Development Accounts](http://developer.xero.com/documentation/getting-started/development-accounts/).

### Install Xero-CFML Library
Download this library and place it in your webroot. There are two directory maps in the Application.cfc file.

	<cfset this.mappings["/cfc"] = getDirectoryFromPath(getCurrentTemplatePath()) & "cfc/" /> 
    <cfset this.mappings["/common"] = getDirectoryFromPath(getCurrentTemplatePath()) & "common/" /> 

## Configuration of API Keys and Certificates
### Securing your resources directory
All configuration files and certificates are located in the resources directory.  In a production environment, you will move this directory outside the webroot for security reasons.  Remember to update the *pathToConfigJSON* variable in your Application.cfc.  

<cfset pathToConfigJSON = getDirectoryFromPath(getCurrentTemplatePath()) & "resources/config.json"> 

### Config.json
Inside the resources directory, you'll find 4 files.  *the ONLY file used is config.json*.  The other 3 files show required values based on the type of Xero Application.  For example, if you are building a Xero Public App, you can open *config-public.json* and save it as *config.json*, then follow the steps below to set the values for your App.

* config.json
* config-partner.json
* config-private.json
* config-public.json

### Public Application
#### Configure Xero Application
Create a [Xero Public application](https://app.xero.com/). Enter a callback domain i.e. localhost.

Open *config.json* file located in the resources directory.  Copy and paste your consumer key and secret.

	"ConsumerKey" : "__YOUR_CONSUMER_KEY__",
	"ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",

Customize your callback base URL and callback path to point to the location of example/callback.cfm. 

	"CallbackBaseUrl" : "http://localhost:8500",
	"CallbackPath" : "/Xero-CFML-master/example/callback.cfm"

Point your browser to example/index.cfm and click "Connect to Xero" to begin the authentication flow.  Public application access tokens expire after 30 minutes and require the user to authenticate again.

### Private Application
#### Generate Public/Private Key
A [public/private key pair](http://developer.xero.com/documentation/api-guides/create-publicprivate-key/) is required to sign your RSA-SHA1 oAuth requests.  Upload the public key when you create your Xero application.  Store the private key in the /resources/certs/ directory. 

The basic command line steps to generate a public and private key using OpenSSL are as follows:

	openssl genrsa -out privatekey.pem 1024
	openssl req -new -x509 -key privatekey.pem -out publickey.cer -days 1825
	openssl pkcs12 -export -out public_privatekey.pfx -inkey privatekey.pem -in publickey.cer

For this SDK, you will need to run one additional command to create a .pk8 formatted private key.

	openssl pkcs8 -topk8 -in privatekey.pem -outform DER -nocrypt -out privatekey.pk8

#### Configure Xero Application
Create a [Xero Private application](https://app.xero.com/Application). Select which Xero organization you are connecting to. Upload the *publickey.cer* created as part of the public/private key pair. 


Open *config-private.json* located in the *resources* directory and save it as *config.json*, Open *config.json* then copy and paste the consumer key.

	"ConsumerKey" : "__YOUR_CONSUMER_KEY__",

Point your browser to example/index.cfm and click "Connect to Xero" to begin accessing API resources. Note: private applications connect to a single Xero organzation and therefore do not require the 3-legged oAuth flow.

### Partner Application
Partner applications are only available to those joining [Xero's Add-on Partner Program](http://developer.xero.com/partner/).

After you've applied to join the Partner Program and validated your integration with Xero Developer Evangelist team, build your integration as a Public Application.  Public and Partner applications share all the same data endpoints. Public and Partner application access tokens both expire after 30 minutes, but Partner applications can refresh access tokens when they expire.

Once your integration is complete, contact Xero Developer Evangelist team to review your integration and upgrade from Public to Partner Application.

#### Generate Public/Private Key
A [public/private key pair](http://developer.xero.com/documentation/api-guides/create-publicprivate-key/) is required to sign your RSA-SHA1 oAuth requests.  Upload the public key when you upgrade to a Partner application.  Store the private key  in the /resources/certs directory.

The basic command line steps to generate a public and private key using OpenSSL are as follows:

	openssl genrsa -out privatekey.pem 1024
	openssl req -new -x509 -key privatekey.pem -out publickey.cer -days 1825
	openssl pkcs12 -export -out public_privatekey.pfx -inkey privatekey.pem -in publickey.cer

For this SDK, you will need to run one additional command to create a .pk8 formatted private key.

	openssl pkcs8 -topk8 -in privatekey.pem -outform DER -nocrypt -out privatekey.pk8

#### Configure Xero Application
Go to your upgraded [Xero Partner application](https://app.xero.com/). Enter a callback domain i.e. localhost.

Open *config-partner.json* located in the resources directory and save it as *config.json*, Open *config.json* then copy and paste the consumer key and secret.

	"ConsumerKey" : "__YOUR_CONSUMER_KEY__",
	"ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",

Customize your callback base URL and callback path to point to the location of example/callback.cfm. 

	"CallbackBaseUrl" : "http://localhost:8500",
	"CallbackPath" : "/Xero-CFML-master/example/callback.cfm"


Point your browser to example/index.cfm and click "Connect to Xero" to begin the authentication flow. 

## OAuth Flow

For Public & Parnter Aps you'll use 3 legged oAuth, which involves a RequestToken Call, then redirecting the user to Xero to select a Xero org, then callback to your server where you'll swap the request token for your 30 min access tokens.

### requesttoken.cfm

```java
<cfscript>

req=createObject("component","cfc.xero").init(); 

try {
  req.requestToken();
  location(req.getAuthorizeUrl());
}	

catch(any e){
  if(e.ErrorCode EQ "401") {
    location("index.cfm?" & e.message);
  } else {
    writeDump(e);
    abort;
  }
}
</cfscript>	
```


### callback.cfm

```java
<cfscript>

res=createObject("component","cfc.xero").init(); 

try {
  res.accessToken(aCallbackParams = cgi.query_string);
  location("get.cfm","false");
}	

catch(any e){
  if(e.ErrorCode EQ "401") {
    location("index.cfm?" & e.message);
  } else {
    writeDump(e);
    abort;
  }
}
</cfscript>
```


## Methods

Each endpoint supports different set of methods - refer to [Xero API Documentation](https://developer.xero.com/documentation/api/api-overview)

Below are examples of the types of methods you can call ....

Reading all objects from an endpoint

```java
<cfscript>
  account=createObject("component","cfc.model.Account").init();

  // Get all items 
  account.getAll();
	// After you getAll - you can loop over an Array of items (NOTE: Your object is not populated with the getAll method)
  account.getList();

  //After you getAll - Populate your object with the first item in the Array
  account.getObject(1);	

  //Get all using where clause
  account.getAll(where='Status=="ACTIVE"');

  //Get all using order param
  account.getAll(order='Name DESC');

  //Get all items modified since this date/time (i.e. 24 hours ago)
  dateTime24hoursAgo = DateAdd("d", -1, now());
  ifModifiedSince = DateConvert("local2utc", dateTime24hoursAgo);
  account.getAll(ifModifiedSince=ifModifiedSince);

 //Get an item by a specific ID (No need to getAll with this method)
  account.getById("XXXXXXXXXXXXXXXXX");
</cfscript>		
```


Reading a single object from an endpoint.

```java
<cfscript>  
  account=createObject("component","cfc.model.Account").init();

  //Get an item by a specific ID (No need to getAll with this method)
  account.getById("XXXXXXXXXXXXXXXXX");
</cfscript>   
```


Creating objects on an endpoint

```java
<cfscript>
  account=createObject("component","cfc.model.Account").init(); 

  account.setName("Dinner");
  account.setCode("4040");
  account.setType("CURRENT");
  account.create();
</cfscript>		
```


Update an object on an endpoint

```java
<cfscript>
  account=createObject("component","cfc.model.Account").init(); 

  // Get all objects and set the first one in the Array to update
  account.getAll().getObject(1);
  account.setName("Meals");
  account.update();
</cfscript>		
```


Delete an object on an endpoint

```java
<cfscript>
  account=createObject("component","cfc.model.Account").init(); 

  // Set the ID for the Account to Delete
  account.setAccountID("XXXXXXXXXXXXX");
  account.delete();
</cfscript>		
```


Archive an object on an endpoint

```java
<cfscript>
  account=createObject("component","cfc.model.Account").init(); 

  // Set the ID for the Account to Delete
  account.setAccountID("XXXXXXXXXXXXX");
  account.archive();
</cfscript>		
```

Void an object on an endpoint

```java
<cfscript>
  invoice=createObject("component","cfc.model.Invoice").init(); 

  // Set the ID for the Account to Delete
  invoice.setInvoiceID("XXXXXXXXXXXXX");
  invoice.void();
</cfscript>		
```


Add to an object on an endpoint

```java
<cfscript>
  trackingcategory=createObject("component","cfc.model.TrackingCategory").init(); 

  // Set the ID for the Tracking Category
  trackingcategory.setTrackingCategoryID("XXXXXXXXXXXXX");
 
  trackingoption=createObject("component","cfc.model.TrackingOption").init(); 
  trackingoption.setName("Foobar" &RandRange(1, 10000, "SHA1PRNG"));
  aTrackingOption = ArrayNew(1);
  aTrackingOption.append(trackingoption.toStruct());

  // Set the Array for Tracking Options
  trackingcategory.setOptions(aTrackingOption);
  trackingcategory.addOptions();
</cfscript>		
```


Remove from an object on an endpoint

```java
<cfscript>
  trackingcategory=createObject("component","cfc.model.TrackingCategory").init(); 	

  // Set the ID for the Tracking Category
  trackingcategory.setTrackingCategoryID("XXXXXXXXXXXXX");
 
  trackingoptionToDelete=createObject("component","cfc.model.TrackingOption").init().populate(trackingcategory.getOptions()[1]); 	
  trackingcategory.setOptionId(trackingoptionToDelete.getTrackingOptionId());	
  trackingcategory.deleteOption();				
</cfscript>		
```


## Make API calls without Models

If you find yourself limited by the models, you can always hack your own raw API call.

```java
  <cfset config = application.config.json>
  <cfset parameters = structNew()>
  <cfset body = "">
  <cfset ifModifiedSince = "">
  <cfset method = "GET">
  <cfset accept = "json/application">
  <cfset endpoint = "Organisation">

  <cfset sResourceEndpoint = "#config.ApiBaseUrl##config.ApiEndpointPath##endpoint#">
  
  <!--- Build and Call API, return new structure of XML results --->
  <cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
    sResourceEndpoint = sResourceEndpoint,
    sOAuthToken = sOAuthToken,
    sOAuthTokenSecret= sOAuthTokenSecret,
    stParameters = parameters,
    sAccept = accept,
    sMethod = method,
    sIfModifiedSince = ifModifiedSince,
    sBody = body)>

  <cfdump var="#oRequestResult#" >
```


## To Do
* Attachments Endpoint
* Get PDF of Invoices

## Additional Reading
* [oAuth Bibile](http://oauthbible.com/)

## Acknowledgements
Thanks to the following Developers and Open Source libraries for making the SDK and samples easier

* [ColdFusion oAuth Library](http://oauth.riaforge.org/) - OAuth 1.0
* [Sharad Gupta](http://www.jensbits.com/2010/05/16/generating-signatures-in-coldfusion-with-rsa-sha1-for-secure-authsub-in-google-analytics/) - RSA-SHA1 signature
* [Matthew Bryant](http://au.linkedin.com/in/mjbryant) - For his work on a Xero API wrapper for Private applications


## License

This software is published under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

	Copyright (c) 2014-2018 Xero Limited

	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.

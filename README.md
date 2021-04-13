# Warning: This SDK is no longer maintained.

## Looking for OAuth 2.0?
Please checkout this open soruce [OAuth 2 library](https://github.com/coldfumonkeh/oauth2)

Xero CFML SDK - connect to Xero API with CFML application servers.

* [Things to note](#things-to-note)
* [Getting Started](#getting-started)
* [OAuth Flow](#oauth-flow)
* [Methods](#methods)
* [To Do](#to-do)
* [Additional Reading](#additional-reading)
* [Acknowledgements](#acknowledgements)
* [License](#license)

## Things to note
* This SDK offers an Object Oriented approach using CFCs to model endpoints and methods you can invoke. You can still instantiate the xero.cfc and construct http calls for your own use and situation if you find the models don't meet your needs. 
* Not tested on Lucee, please submit issues if you encounter any.


## Getting Started
### Sample App
Install the sample app with [CommandBox]( https://www.ortussolutions.com/products/commandbox)

```javascript
  box install xero-cfml-sample-app
```

Alternatively, you can [clone or download the app](https://github.com/XeroAPI/xero-cfml-sample-app) into your wwwroot folder

### Install as a dependency with [CommandBox]( https://www.ortussolutions.com/products/commandbox)

```javascript
  box install xero-cfml
```

Alternatively, you can clone or download this repo and add to your application

Iniate the component by passing it the path to your configuration file. It can be used as a singleton, so that you only need to do this once.

```javascript
  <cfset pathToConfigJSON = getDirectoryFromPath(getCurrentTemplatePath()) & "resources/config.json"> 
  <cfset application.xero = CreateObject("component", "modules.xero-cfml.xero").init(pathToConfigJSON)>
```

### Create a Xero User Account
[Create a Xero user account](https://www.xero.com/signup) for free.  Xero does not have a designated "sandbox" for development.  Instead you'll use the free Demo company for development.  Learn how to get started with [Xero Development Accounts](http://developer.xero.com/documentation/getting-started/development-accounts/).

### Create a Xero a App
You'll need to decide which type of Xero app you'll be building.

* [Public](http://developer.xero.com/documentation/auth-and-limits/public-applications/)
* [Private](http://developer.xero.com/documentation/auth-and-limits/private-applications/)
* [Partner](http://developer.xero.com/documentation/auth-and-limits/partner-applications/)

Go to [http://app.xero.com](http://app.xero.com) and login with your Xero user account to create a Xero app.

### Update Config.json with Keys and Certificates

Refer to Xero Developer Center [Getting Started](http://developer.xero.com/documentation/getting-started/getting-started-guide/) if you haven't created your free Xero User account an a Xero App yet - this is where you'll find your config.json details. 

After you create a Xero App, look under the SDK Configuration heading and select "CFML" and copy the config.json information for your Xero App.

Create a file called config.json and paste your information.  Our sample app looks for config.json in the resources directory.

The min required attirbutes for each app type is show below.


Private and Partner apps require a [public/private key pair](http://developer.xero.com/documentation/api-guides/create-publicprivate-key/) created with OpenSSL.  The private key should be exported as a pk8 file and placed in the "resources/certs" folder.  Jump to Generate Public/Private Key below to see terminal commands.

**Public Application**
```javascript
{ 
  "AppType" : "PUBLIC",
  "UserAgent": "YourAppName",
  "ConsumerKey" : "__YOUR_CONSUMER_KEY__",
  "ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",
  "CallbackBaseUrl" : "http://localhost:8500",
  "CallbackPath" : "/xero-cfml-sample-app/callback.cfm"
}
```

**Private Application**
Note: private applications connect to a single Xero organzation and therefore do not require the 3-legged oAuth flow.
```javascript
{ 
  "AppType" : "PRIVATE",
  "UserAgent": "YourAppName",
  "ConsumerKey" : "__YOUR_CONSUMER_KEY__",
  "ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",
  "PrivateKeyCert" :  "certs/public_privatekey.pfx",
  "PrivateKeyPassword" :  "1234"
}
```
**Partner Application**
```javascript
{ 
  "AppType" : "PARTNER",
  "UserAgent": "YourAppName",
  "ConsumerKey" : "__YOUR_CONSUMER_KEY__",
  "ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",
  "CallbackBaseUrl" : "http://localhost:8500",
  "CallbackPath" : "/xero-cfml-sample-app/callback.cfm",
  "PrivateKeyCert" :  "certs/public_privatekey.pfx",
  "PrivateKeyPassword" :  "1234"
}
```

**Optionals Attributes**

* Accept: format of data returned from API  (application/xml, application/json, application/pdf) *default is application/json*
* ApiBaseUrl: base URL for API calls      *default is https://api.xero.com*
* ApiEndpointPath: path for API Calls      *default is /api.xro/2.0/*
* RequestTokenPath: path for Request Token      *default it /oauth/RequestToken*
* AuthenticateUrl: path for redirect to authorize      *default is /oauth/RequestToken*
* AccessTokenPath: path for Access Token         *default is https://api.xero.com/oauth/Authorize*


### Secure your Keys and Certificates
All configuration files and certificates are located in the resources directory.  In a production environment, you will move this directory outside the webroot for security reasons.  Remember to update the *pathToConfigJSON* variable in your Application.cfc.  

```javascript
<cfset pathToConfigJSON = getDirectoryFromPath(getCurrentTemplatePath()) & "resources/config.json"> 
```

### Generate Public-Private Key
A [public/private key pair](http://developer.xero.com/documentation/api-guides/create-publicprivate-key/) is required to sign your RSA-SHA1 oAuth requests.  Upload the public key for Private and Partner apps at http://app.xero.com.  Store the private key  in the /resources/certs directory.

The basic command line steps to generate a public and private key using OpenSSL are as follows:
```javascript
  openssl genrsa -out privatekey.pem 1024
  openssl req -new -x509 -key privatekey.pem -out publickey.cer -days 1825
  openssl pkcs12 -export -out public_privatekey.pfx -inkey privatekey.pem -in publickey.cer
```
For this SDK, you will need to run one additional command to create a .pk8 formatted private key.
```javascript
  openssl pkcs8 -topk8 -in privatekey.pem -outform DER -nocrypt -out privatekey.pk8
```
## OAuth Flow

For Public & Partner Apps you'll use 3 legged oAuth, which involves a RequestToken Call, then redirecting the user to Xero to select a Xero org, then callback to your server where you'll swap the request token for your 30 min access tokens.  Partner Apps will check if a token is expired an refresh for you.

Note: Tokens are managed in the session scope through the storage.cfc file.  You'll want to extend storage.cfc to persist individual tokens in a database.

### requesttoken.cfm

```java
<cfscript>

try {
  application.xero.requestToken();
  location(application.xero.getAuthorizeUrl());
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


try {
  application.xero.accessToken(aCallbackParams = cgi.query_string);
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
  account=application.xero.getModel("Account"); 
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
</cfscript>		
```


Reading a single object from an endpoint.

```java
<cfscript>  
  account=application.xero.getModel("Account");

  //Get an item by a specific ID (No need to getAll with this method)
  account.getById("XXXXXXXXXXXXXXXXX");
</cfscript>   
```


Creating objects on an endpoint

```java
<cfscript>
  account=application.xero.getModel("Account");  

  account.setName("Dinner");
  account.setCode("4040");
  account.setType("CURRENT");
  account.create();
</cfscript>		
```


Update an object on an endpoint

```java
<cfscript>
  account=application.xero.getModel("Account");  

  // Get all objects and set the first one in the Array to update
  account.getAll().getObject(1);
  account.setName("Meals");
  account.update();
</cfscript>		
```


Delete an object on an endpoint

```java
<cfscript>
  account=application.xero.getModel("Account");  

  // Set the ID for the Account to Delete
  account.setAccountID("XXXXXXXXXXXXX");
  account.delete();
</cfscript>		
```


Archive an object on an endpoint

```java
<cfscript>
  account=application.xero.getModel("Account"); 

  // Set the ID for the Account to Delete
  account.setAccountID("XXXXXXXXXXXXX");
  account.archive();
</cfscript>		
```

Void an object on an endpoint

```java
<cfscript>
  invoice=application.xero.getModel("Invoice"); 

  // Set the ID for the Invoice to Void
  invoice.setInvoiceID("XXXXXXXXXXXXX");
  invoice.void();
</cfscript>		
```


Add to an object on an endpoint

```java
<cfscript>
  trackingcategory=application.xero.getModel("TrackingCategory");

  // Set the ID for the Tracking Category
  trackingcategory.setTrackingCategoryID("XXXXXXXXXXXXX");
 
  trackingoption=application.xero.getModel("TrackingOption");
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
  trackingcategory=application.xero.getModel("TrackingCategory");

  // Set the ID for the Tracking Category
  trackingcategory.setTrackingCategoryID("XXXXXXXXXXXXX");
 
  trackingoptionToDelete=application.xero.getModel("TrackingOption").populate(trackingcategory.getOptions()[1]);  

  trackingcategory.setOptionId(trackingoptionToDelete.getTrackingOptionId());	
  trackingcategory.deleteOption();				
</cfscript>		
```


## Make API calls without Models

If you find yourself limited by the models, you can always hack your own raw API call.

```java
  <cfset parameters = structNew()>
  <cfset body = "">
  <cfset ifModifiedSince = "">
  <cfset method = "GET">
  <cfset accept = "json/application">
  <cfset endpoint = "Organisation">

  <cfset sResourceEndpoint = "#application.xero.config.ApiBaseUrl##application.xero.config.ApiEndpointPath##endpoint#">
  
  <!--- Build and Call API, return new structure of XML results --->
  <cfset oRequestResult = application.xero.requestData(
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

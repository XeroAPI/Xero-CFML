Xero-CFML
=========

##Config.json
The only .json file used by this library is config.json.  Depending on the type of Xero Application you are building, you should open the corresponding one and save it as config.json - and overwrite the file.  For example, if you are building a private Xero app, open config-private.json and save it as config.json.  Then update the appropriate values.  

Go to app.xero.com to create your Xero app and get your Consumer Key and Secret.

Looking to generate a private key - review these docs - http://developer.xero.com/documentation/api-guides/create-publicprivate-key/

You'll upload the public key at app.xero.com

###Private Xero Applications

```json
{ 
	"AppType" : "PRIVATE",
	"UserAgent" : "Xero-CFML-Private",
	"Accept" : "application/json", 
	"ConsumerKey" : "__YOUR_CONSUMER_KEY__",
	"ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",
	"ApiBaseUrl" : "https://api.xero.com",
	"ApiEndpointPath" : "/api.xro/2.0/",
	"PrivateKeyCert" :  "certs/privatekey.pk8"
}
```

###Public Xero Applications

```json
{ 
	"AppType" : "PUBLIC",
	"UserAgent" : "Xero-CFML-Public",
	"Accept" : "application/json", 
	"ConsumerKey" : "__YOUR_CONSUMER_KEY__",
	"ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",
	"ApiBaseUrl" : "https://api.xero.com",
	"ApiEndpointPath" : "/api.xro/2.0/",
	"RequestTokenPath": "/oauth/RequestToken",
	"AuthenticateUrl" : "https://api.xero.com/oauth/Authorize",
	"AccessTokenPath"  : "/oauth/AccessToken",
	"CallbackBaseUrl" : "http://localhost:8500",
	"CallbackPath" : "/Xero-CFML-master/example/callback.cfm"
}
```

###Partner Xero Applications

```json
{ 
	"AppType" : "PARTNER",
	"UserAgent" : "Xero-CFML-Partner",
	"Accept" : "application/json", 
	"ConsumerKey" : "__YOUR_CONSUMER_KEY__",
	"ConsumerSecret" : "__YOUR_CONSUMER_KEY_SECRET__",
	"ApiBaseUrl" : "https://api.xero.com",
	"ApiEndpointPath" : "/api.xro/2.0/",
	"RequestTokenPath": "/oauth/RequestToken",
	"AuthenticateUrl" : "https://api.xero.com/oauth/Authorize",
	"AccessTokenPath"  : "/oauth/AccessToken",
	"CallbackBaseUrl" : "http://localhost:8500",
	"CallbackPath" : "/Xero-CFML-master/example/callback.cfm",
	"PrivateKeyCert" :  "certs/privatekey.pk8"
}
```
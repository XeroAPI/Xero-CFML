Xero-CFML
=========

CFML wrapper for Xero API - use with ColdFusion and Railo application servers.

* [Things to note] (#things-to-note)
* [Selecting an Application Type] (#select-an-application-type)
* [Getting Started] (#getting-started)
* [To Do] (#to-do)
* [Additional Reading] (#additional-reading)
* [Acknowledgements] (#acknowledgements)
* [License] (#license)

## Things to note
* The library focuses on the authentication for Xero's API and provides a basis to be extended. There are examples of how to authenticate the different application types. These examples provide enough to get you going, but are not a complete solution to all your needs. You will need to adapt them for your own use and situation. 

## Select an application type
Xero's API supports [3 application types] (http://developer.xero.com/documentation/getting-started/api-application-types/).  The three types are public, private and partner.  Each application type is supported by this library.  Please [review  each type] (http://developer.xero.com/documentation/getting-started/api-application-types/) to determine the right one for your integration.

* [Public] (http://developer.xero.com/documentation/getting-started/public-applications/)
* [Private] (http://developer.xero.com/documentation/getting-started/private-applications/)
* [Partner] (http://developer.xero.com/documentation/getting-started/partner-applications/)


## Getting Started
### Create a Xero User Account
You can [create a Xero user account](https://www.xero.com/signup) for free.  Xero does not have a designated "sandbox" for development.  Instead you'll use the demo company for development.  Learn how to get started with [Xero Development Accounts](http://developer.xero.com/documentation/getting-started/development-accounts/).

### Install Xero-CFML Library
Simply download this library and place it in your ColdFusion or Railo webroot. There is a single mapping of the cfc directory in the Application.cfc file.

	<cfset this.mappings["/cfc"] = getDirectoryFromPath(getCurrentTemplatePath()) & "cfc/" />

Next, follow the configuration steps based on your type of Xero application.

### Public Application
#### Configure Xero Application
Create a [Xero Public application](https://api.xero.com/Application). Enter a callback domain i.e. localhost.

Open *config.cfm* file located in example/public directory.  Copy and paste the consumer key and secret.

	<cfset sConsumerKey = "__PASTE_YOUR_CONSUMER_KEY__"> 
	<cfset sConsumerSecret = "__PASTE_YOUR_CONSUMER_SECRET__">

Customize your callback URL to point to the location of example/public/callback.cfm in your webroot.

	<cfset sCallbackURL = "http://localhost:8500/Xero-CFML/example/public/callback.cfm"> 

Point your browser to example/public/index.cfm and click "Connect to Xero" to begin the authentication flow.  Public application access tokens expire after 30 minutes and require the user to authenticate again.

### Private Application
#### Generate Public/Private Key
A [public/private key pair](http://developer.xero.com/documentation/advanced-docs/public-private-keypair/) is required to sign your RSA-SHA1 oAuth requests.  Upload the public key when you create your Xero application.  Store the private key on your server.  To keep things simple, place the private key in the /example/private/cert directory.  In a production environment, you will store this key outside the webroot for security reasons.

The basic command line steps to generate a public and private key using OpenSSL are as follows:

	openssl genrsa -out privatekey.pem 1024
	openssl req -new -x509 -key privatekey.pem -out publickey.cer -days 1825
	openssl pkcs12 -export -out public_privatekey.pfx -inkey privatekey.pem -in publickey.cer

For this wrapper, you will need to run one additional command to create a .pk8 formatted private key.

	openssl pkcs8 -topk8 -in privatekey.pem -outform DER -nocrypt -out privatekey.pk8

#### Configure Xero Application
Create a [Xero Private application](https://api.xero.com/Application). Select which Xero organization you are connecting to. Upload the *publickey.cer* created as part of the public/private key pair. 

Open *config.cfm* file located in example/private directory.  Copy and paste the consumer key.

	<cfset sConsumerKey = "__PASTE_YOUR_CONSUMER_KEY__"> 

Point your browser to example/private/index.cfm and click "Connect to Xero" to begin accessing API resources. Note: private applications connect to a single Xero organzation and therefore do not require the 3-legged oAuth flow.

### Partner Application
Partner applications are only available to those joining [Xero's Add-on Partner Program](http://developer.xero.com/partner/).

After you've applied to join the Partner Program and validated your integration with Xero Developer Relations, build your integration as a Public Application.  Public and Partner applications share all the same data endpoints. Public and Partner application access tokens both expire after 30 minutes, but Partner applications can refresh access tokens when they expire.

Once your integration is complete, schedule a time with Xero Developer Relations to review your integration and upgrade your Public application to a Partner Application.

#### Generate Public/Private Key
A [public/private key pair](http://developer.xero.com/documentation/advanced-docs/public-private-keypair/) is required to sign your RSA-SHA1 oAuth requests.  Upload the public key when you upgrade to a Partner application.  Store the private key on your server.  To keep things simple, place the private key in the /example/partner/cert directory.  In a production environment, you will store this key outside the webroot for security reasons.

The basic command line steps to generate a public and private key using OpenSSL are as follows:

	openssl genrsa -out privatekey.pem 1024
	openssl req -new -x509 -key privatekey.pem -out publickey.cer -days 1825
	openssl pkcs12 -export -out public_privatekey.pfx -inkey privatekey.pem -in publickey.cer

For this wrapper, you will need to run one additional command to create a .pk8 formatted private key.

	openssl pkcs8 -topk8 -in privatekey.pem -outform DER -nocrypt -out privatekey.pk8

#### Configure Xero Application
Go to your upgraded [Xero Partner application](https://api.xero.com/Application). Enter a callback domain i.e. localhost.

Open *config.cfm* file located in example/partner directory.  Copy and paste the consumer key and secret.

	<cfset sConsumerKey = "__PASTE_YOUR_CONSUMER_KEY__"> 
	<cfset sConsumerSecret = "__PASTE_YOUR_CONSUMER_SECRET__">

Customize your callback URL to point to the location of example/partner/callback.cfm in your webroot.

	<cfset sCallbackURL = "http://localhost:8500/Xero-CFML/example/partner/callback.cfm"> 

#### Entrust SSL Certificate
Xero will issue you SSL certificates for accessing the Partner API.  Download and store the SSL certificate on your server.  To keep things simple, place the .p12 file in the /example/partner/cert directory.  In a production environment, you will store this key outside the webroot for security reasons.

	<cfset pathToSSLCert = GetDirectoryFromPath( GetCurrentTemplatePath()) & "certs/your-entrust-cert.p12" />   
	<cfset passwordToSSLCert = "your-entrust-password" /> 

Point your browser to example/partner/index.cfm and click "Connect to Xero" to begin the authentication flow. 

## To Do
* Refresh Token method for partner applications

## Additional Reading
* [oAuth Bibile](http://oauthbible.com/)

##Acknowledgements
Thanks to the following Developers and Open Source libraries for making the wrapper and samples easier

* [ColdFusion oAuth Library](http://oauth.riaforge.org/) - OAuth 1.0
* [Sharad Gupta](http://www.jensbits.com/2010/05/16/generating-signatures-in-coldfusion-with-rsa-sha1-for-secure-authsub-in-google-analytics/) - RSA-SHA1 signature
* [Matthew Bryant](http://au.linkedin.com/in/mjbryant) - For his work on a Xero API wrapper for Private applications


##License

This software is published under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

	Copyright (c) 2014 Xero Limited

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
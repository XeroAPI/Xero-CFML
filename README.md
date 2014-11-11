Xero-CFML
=========

CFML wrapper for Xero API - use with ColdFusion and Railo application servers.

* [Things to note] (#things-to-note)
* [Selecting an Application Type] (#selecting-an-application-type)
* [Getting Started] (#getting-started)
* [To Do] (#to-do)
* [Acknowledgements] (#acknowledgements)
* [License] (#license)

## Things to note
* The library focuses on the authentication for Xero's API and provides a basis to be extended. There are examples of how to authenticate the different application types. These examples provide enough to get you going, but are not a complete solution to all your needs. You will need to adapt them for your own use and situation. 

## Selecting an Application Type
Xero's API supports [3 application types] (http://developer.xero.com/documentation/getting-started/api-application-types/).  The three types are public, private and partner.  Each application type is supported by this library.  Please [review  each type] (http://developer.xero.com/documentation/getting-started/api-application-types/) to determine the right one for your integration.

* [Public] (http://developer.xero.com/documentation/getting-started/public-applications/)
* [Private] (http://developer.xero.com/documentation/getting-started/private-applications/)
* [Partner] (http://developer.xero.com/documentation/getting-started/partner-applications/)


## Getting Started
### Public Applications
coming soon

### Private Applications
coming soon

### Partner Applications
coming soon

## To Do
* Refresh Token method for partner applications

##Acknowledgements
Thanks for the following Developers and Open Source libraries for making the wrapper and samples easier

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
---
title: v2 Endpoint and Implicit Grant
subtitle: Building on my previous v2 Endpoint Primer, here we discuss using the Implicit Grant.
excerpt: Building on my previous v2 Endpoint Primer, here we discuss using the Implicit Grant.
tags:
  - Azure
  - Azure Active Directory
  - Microsoft Graph
  - node.js
  - OAUTH
  - Office
  - v2 Endpoint
Image: /assets/azure-office-768x154.png
---

_This is a continuation of my [Microsoft v2 Endpoint Primer][primer]. If you haven't read this article yet, I highly recommend doing so. I will be glossing over several bits of configuration we previously covered (application registration for example)._

First, a disclaimer. I am not a fan of the [Implicit Grant][implicit-flow]. It has some severe limitations and is [less][section-10.3] [secure][section-10.16] than the [Authentication Code Grant][authcode-flow]. There are absolutely cases where an Implicit Grant is required but in most cases it should be avoided whenever possible.

## What is the Implicit Grant workflow

The [Implicit Grant][implicit-flow] is a simplified version of the [Authentication Code Grant][authcode-flow]. It eliminates some steps from the process that would be impossible to support in certain scenarios. In particular, it eliminates the exchanging of an authentication code for a bearer token. Instead it returns the bearer token directly to the client but adding it as a [fragment identifier][fragment-id] to the Redirect URI.

> The term fragment identifier may be unfamiliar to a lot folks (I counted myself among them). Changes are they are you know what they're for, most of us just didn't know what they were called. Fragment IDs are similar to query params in that they are data appended the URI. Instead of using a question mark (`http://url.com?query-param`) they use a hash (`http://url.com#fragment-id`). So there you are fearless reader, your useless URI trivia for the day.

To understand why this workflow is needed, it is helpful to consider the actors involved in the Authentication Code Grant workflow. As I covered in my [previous article][primer], we have three actors (the User, the Service and the Provider). Another way to describe these actors might be as the Browser, the Website and the Provider.

This Browser/Website/Provider accurately describes the actors within the context of a Web App. It doesn't however align very well to other scenarios such a local/native application or a single-page application written entirely in JavaScript. Normally the Service holds the "Secret" that is used to convert the authentication code to a bearer token. In this scenario the secret is rather pointless since it is easily discoverable by the end-user. If the User knows the Application ID and the Secret why bother having the Secret in the first place? Enter the Implicit Grant workflow.

## Supporting Implicit Grant
In order to support Implicit Grants, you must have a Platform in your Application Registration configured to support it. Assuming you followed the registration process in the [Primer][primer] this is simply a matter of checking off the "Allow Implicit Flow" option in the Web Platform Properties:

  ![App Registration - Web Platform Properties](/assets/images/apps-dev-web-platform.png)

Once this option is selected and saved, the v2 Endpoint will begin supporting Implicit Grants for your Application ID. From here we need to make a couple of adjustments to the token request method we used in the previous article.

## Requesting a Token
The Implicit workflow has only two stages. The first is a redirect to the Provider which is where the user will enter their credentials. This process will return an Bearer Token back to the Client as a [fragment identifier][fragment-id] . The Client must then parse the token out of the URL and included with any API calls back to Microsoft.

The first call into the v2 Endpoint is a simple GET request (typically just a link the user clicks) to `https://login.microsoftonline.com/common/oauth2/v2.0/authorize` along with several query parameters:

* client_id - This is your Application ID from above
* response_type - For this example it should always be "**token**"
* redirect_uri - This must be the same URI you entered earlier in the Platform configuration.
* scope - This tells the Provider what permissions you need for the APIs (more on this in a moment)

The prototype for this call looks like this:

```
https://login.microsoftonline.com/common/oauth2/v2.0/authorize?
client_id=[APPLICATION ID]&amp;response_type=token&amp;
redirect_uri=[REDIRECT URI]&amp;scope=[SCOPE]
```

>  **Scopes**:  Because the Implicit Flow does not do a token exchange, scopes that depend on them such as offline_access and openid will simply be ignored by the Endpoint.

Once the user has completed signing in, the Provider will redirect back to your Redirect URI. The Provider will add a [fragment identifier][fragment-id] this URI. You will need to extract these values from the URI to retrieve the Bearer Token.

The prototype of the Implicit Grant's fragment ID is as follows:

```
[REDIRECT URI]#access_token=[ACCESS TOKEN]&amp;token_type=Bearer
&amp;expires_in=[EXPIRES]&amp;scope=[SCOPE]
```

* access_token - This is the actual token.
* expires_in - Number of seconds until this token expires and can no longer be used.
* token_type - This tells you what type of token you have. It should always be "bearer".
* scope - This is the list of scopes you have been granted access too.

In you're using JavaScript in a browser, you can grab this data from the URI using window.location.hash. If you're using [jQuery](http://jquery.org) then I would hightly recommend looking into [jQuery BBQ](http://benalman.com/projects/jquery-bbq-plugin/).

## Further Reading
- [The OAuth 2.0 Authorization Framework (RFC-6749)](http://tools.ietf.org/html/rfc6749)
- [Access Token Security with Implicit Grants][section-10.3]
- [Misuse of Access Token to Impersonate Resource Owner in Implicit Flow][section-10.16]

[primer]: http://massivescale.com/microsoft-v2-endpoint-primer
[fragment-id]: https://en.wikipedia.org/wiki/Fragment_identifier
[implicit-flow]: http://tools.ietf.org/html/rfc6749#section-1.3.2
[authcode-flow]: http://tools.ietf.org/html/rfc6749#section-1.3.1
[section-10.3]: http://tools.ietf.org/html/rfc6749#section-10.3
[section-10.16]: http://tools.ietf.org/html/rfc6749#section-10.16
---
title: v2 Endpoint & Consent
subtitle: Understanding the difference between User and Admin Consent 
tags:
  - Azure Active Directory
  - Microsoft Graph
  - OAuth
  - v2 Endpoint
background: '/img/train.jpg'
updated: 2018-3-28
image: https://pbs.twimg.com/media/B-DS4_aCIAAUoF0.jpg
categories: 
  - Azure AD
  - OAuth 2.0
  - v2 Endpoint
  - Microsoft Graph
---

_This is a continuation of my [Microsoft v2 Endpoint Series](#microsoft-v2-endpoint-series). If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._

When it comes to selecting the scopes your application will be requesting from an API such as Microsoft Graph, it is worth considering how those scopes will impact your initial deployment and user experiences.

With Azure AD, the act of authorizing a set of scopes for an application is referred to as "providing consent". There are two distinct types of consent involved; User and Admin.

## User Consent

User Consent is likely something you've run across multiple times; you log in to an application for the first time and get presented with a list of permissions to accept:

![user consent](/assets/images/user-consent.png)

In the screenshot above, Azure AD is asking the User to consent to a list of permissions that were requested by the Application. When the user clicks "Accept" they are providing their consent and the Application will be granted those permissions on the user's behalf.

Of course, not all permission scopes are created equal. While some scopes such as the ability to read any user's basic profile from the tenant are pretty innocuous, other such as the ability to _write_ to those profiles represent a potential risk to data integrity. In order to mitigate this risk, certain permissions require an additional level of consent. This is where Admin Consent comes in.

## Admin Consent

Admin Consent is quite different than User Consent. Namely, in that, it is authorizing the application itself rather than the end user. It doesn't replace User Consent, it is simply an additional layer on top of it. One type of consent does not remove the need for the other.

One way to think about Admin Consent is in terms of "Parental Consent". So, if my son wants to invite someone over to the house they first need _my_ permission. Only after I give the thumbs up can they go ahead and invite their friend to come over.

In this example, my "son" is the "Application". The permission I granted was "Admin Consent". The invitation is my son's invitation is a request for "User Consent".

You can determine if you need to receive Admin Consent by checking the "Admin Consent Required" column in the [documentation for Scopes][scopes].

> If you're using the Client Credentials (`client_credentials`) Grant then you will need Admin Consent regardless of the scopes you've selected. This is due to Client Credentials not authenticating a user and therefore not having a User Consent component whatsoever. For this grant, Admin Consent is the only consent you will receive.
{:.tip}

## Microsoft v2 Endpoint Series

* [Microsoft v2 Endpoint Primer]({{ 'microsoft-v2-endpoint-primer' | relative_url }})
* [v2 Endpoint & Implicit Grant]({{ 'microsoft-v2-endpoint-implicit-grant' | relative_url }})
* [v2 Endpoint & Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})
* [v2 Endpoint & Admin Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})

## Further Reading

* [Azure AD v2 and MSAL from a developer's point of view](https://joonasw.net/view/azure-ad-v2-and-msal-from-dev-pov) by Joonas Westlin

[scopes]: https://developer.microsoft.com/graph/docs/concepts/permissions_reference#calendars-permissions

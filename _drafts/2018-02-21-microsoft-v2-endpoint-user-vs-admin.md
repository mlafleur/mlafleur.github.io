---
title: v2 Endpoint & Consent
subtitle: Understanding the difference between User and Admin Consent 
tags:
  - Azure Active Directory
  - Microsoft Graph
  - OAuth
  - v2 Endpoint
background: '/img/train.jpg'
---

_This is a continuation of my [Microsoft v2 Endpoint Primer][primer]. If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._

When it comes to selecting the scopes your application will be requesting from an API such as Microsoft Graph, it is worth considering how those scopes will impact your initial deployment and user experiences.

With Azure AD, the act of authorizing a set of scopes for an application is refereed to as "providing consent". There are two distinct types of consent involved; User and Admin.

## User Consent

User Consent is likely something you've run across multiple times; you login to an application for the first time and get presented with a list of permissions to accept:

![user consent](/assets/images/user-consent.png)

In the screenshot above, Azure AD is asking the User to consent to a list of permissions that were requested by the Application. When the user clicks "Accept" they are providing their consent and the Application will be granted those permission on the user's behalf.

Of course, not all permission scopes are created equal. While some scopes such as the ability to read any user's basic profile from the tenant are pretty innocuous, other such as the ability to _write_ to those profiles represent a potential risk to data integrity. In order to mitigate this risk, certain permissions require an additional level of consent. This is where Admin Consent comes in.

## Admin Consent

Admin Consent is quite different than User Consent. Namely in that it is authorizing the application itself rather than the end user. It doesn't replace User Consent, it is simply an additional layer on top of it. One type of consent does not remove the need for the other.

> One way to think about Admin Consent is in terms of "Parental Consent". So, if my son wants to invite someone over to the house they first need _my_ permission. Only after I give the thumbs up can they go ahead and invite their friend to come over.
>
> In this example, my "son" is the "Application". The permission I granted was "Admin Consent". The invitation is my son's invitation is a request for "User Consent".

You can determine if you need to receive Admin Consent by checking the "Admin Consent Required" column in the [documentation for Scopes][scopes].

> If you're using the Client Credentials (`client_credentials`) Grant then you will need Admin Consent regardless of the scopes you've selected. This is due to Client Credentials not authenticating a user and therefore not having a User Consent component whatsoever. For this grant, Admin Consent is the only consent you will receive.

## Changing Scopes

One common issue that folks run into, particularly early on in development and testing, are errors being raised after changing the application's scopes. It is important to remember that Consent is granted for a fixed set of scopes. If those scopes should change, _additional consent is required_.

For User Consent this typically isn't an issue since the user is simply presented with an updated Consent page the next time they authenticate. For Admin Consent however, you will need to repeat the Admin Consent process in order to cover those new scopes.

[primer]: {{ 'microsoft-v2-endpoint-primer' | relative_url }}
[implicit]: {{ 'microsoft-v2-endpoint-implicit-grant' | relative_url }}

[scopes]: https://developer.microsoft.com/graph/docs/concepts/permissions_reference#calendars-permissions
[graph]: https://graph.microsoft.io
[admin_consent]: https://docs.microsoft.com/azure/active-directory/active-directory-assign-admin-roles
[app-reg]: https://apps.dev.microsoft.com

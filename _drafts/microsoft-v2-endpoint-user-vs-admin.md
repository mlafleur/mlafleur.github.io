---
title: v2 Endpoint - User vs Admin Consent
subtitle: Digging into the differences between User and Admin Consent 
tags:
  - Azure Active Directory
  - Microsoft Graph
  - OAuth
  - v2 Endpoint
background: '/img/train.jpg'
category: aadv2
---
_This is a continuation of my [Microsoft v2 Endpoint Primer][primer]. If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._

When it comes to the scopes your application will be requesting from an API such as Microsoft Graph, it is important to consider how those scopes will get authorized and the impact it may have your app deployment and adoption story. In Azure AD, the authorizing of scopes is refereed to as "providing consent". There are two types of consent to consider; User Consent and Admin Consent.

## User Consent

User Consent is likely something you've run across multiple times; you login to an application for the first time and get presented with a list of permissions to accept:

![user consent](/assets/images/user-consent.png)

In the screenshot above, Azure AD is asking the User to consent to a list of permissions that were requested by the Application. When the user clicks "Accept" they are providing their consent and the Application will be granted those permission on the user's behalf.

Of course, not all permission scopes are created equal. While some scopes such as the ability to read any user's basic profile from the tenant are pretty innocuous, other such as the ability to _write_ to those profiles represent a potential risk to data integrity. In order to mitigate this risk, certain permissions require an additional level of consent. This is where Admin Consent comes in.

## Admin Consent

Admin Consent is quite different than User Consent. Namely in that it is authorizing the application itself rather than the end user. It doesn't replace User Consent, it is simply an additional layer on top of it. One type of consent does not remove the need for the other.

 >One way to think about Admin Consent is in terms of "Parental Consent". For example, if my son wants to invite someone over to the house they first need _my_ permission. Only after I give the thumbs up can they go ahead and invite their friend to come over. In this scenario, my son is the "Application". The permission I granted was "Admin Consent". The invitation is my son's request for "User Consent".

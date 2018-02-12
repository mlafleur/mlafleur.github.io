---
title: v2 Endpoint & Admin Consent
subtitle: Mother may I? Obtaining Administrative Consent for your application
tags:
  - Azure Active Directory
  - Microsoft Graph
  - OAuth
  - v2 Endpoint
background: '/img/train.jpg'
redirect_from: /aadv2/microsoft-v2-endpoint-admin-consent/
---

_This is a continuation of my [Microsoft v2 Endpoint Primer][primer]. If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._

As developers dig into [Microsoft Graph][graph], they inevitably find themselves needing permission scopes that require "[Admin Consent][admin_consent]". These are scopes that have deemed worthy of requiring an Administrator to sign off before allowing lowly "normals" to authorize your application.

## User vs Admin Consent

When it comes to the scopes your application will be requesting from an API such as Microsoft Graph, it is important to consider how those scopes will get authorized and the impact it may have your app deployment and adoption story. In Azure AD, the authorizing of scopes is refereed to as "providing consent". There are two types of consent to consider; User Consent and Admin Consent.

User Consent is likely something you've run across multiple times; you login to an application for the first time and get presented with a list of permissions to accept:

![user consent](/assets/images/user-consent.png)

In the screenshot above, Azure AD is asking the User to consent to a list of permissions that were requested by the Application. When the user clicks "Accept" they are providing their consent and the Application will be granted those permission on the user's behalf.

Of course, not all permission scopes are created equal. While some scopes such as the ability to read any user's basic profile from the tenant are pretty innocuous, other such as the ability to _write_ to those profiles represent a potential risk to data integrity. In order to mitigate this risk, certain permissions require an additional level of consent. This is where Admin Consent comes in.

Admin Consent is quite different than User Consent. Namely in that it is authorizing the application itself rather than the end user. It doesn't replace User Consent, it is simply an additional layer on top of it. One type of consent does not remove the need for the other.

> One way to think about Admin Consent is in terms of "Parental Consent". For example, if my son wants to invite someone over to the house they first need _my_ permission. Only after I give the thumbs up can they go ahead and invite their friend to come over. In this scenario, my son is the "Application". The permission I granted was "Admin Consent". The invitation is my son's request for "User Consent".

## Delegated vs Application Scopes Scopes

Graph has two categories of permission scopes; Application & Delegated. These serve two distinct purposes:

* **Delegated:** If your application acts on "behalf" of a single user, you're looking for delegated permissions. Many Delegated permissions can be consented to by normal users. Other higher-privileged permissions require administrator consent however.

* **Application:** If your application runs without a user context such as a background service or daemon, you're looking for Application permissions. Unlike Delegated permission, Application permissions _always require_ administrator consent.

> Which scopes get applied to your token depends on which type of OAuth Grant you used to request that token. When you're using [`Authorization Code`][primer] or [`Implicit`][implicit] grants then you'll be using Delegated scopes. If you're using `Client Credentials` then you're using Application scopes.

For the moment, I'm going to assume the application in question here is a traditional web app that happens to require access to higher-privileged scopes. This scenario is also used for daemon apps but there are a enough nuances around daemons to deserve it's own article.

## Scope Differences

When using the v2 Endpoint, you can dynamic request scopes during authorization. This allows you to only request the minimum access required for a given user. For example, if you're application supports syncing both Calendars and Contacts but your user only wants to leverage the Calendar integration, you can forgo requesting access to Contacts. This provides some additional assurance to the user that your application is behaving as expected.

Things operate a bit differently when Admin Consent is required. These scopes must be defined with your [application registration][app-reg]. This ensures administrators that there is some stability around the permissions you're requesting. It is important to note that this doesn't change how dynamic scopes operate; _you can still dynamically choose to not request these admin scopes_.

Defining these scopes is done within your [application registration][app-reg]. You can define both Delegated and Application permissions here:

![permissions](/assets/images/app-reg-graph-permissions.png)

Clicking add will display a list of available permissions:

![permissions](/assets/images/app-reg-graph-permissions-dialog.png)

At a minimum you need to declare any scopes that require administrative consent. While you're certainly able to define other scopes, this isn't a requirement.

## Obtaining Consent

Before any normal (non-admin) users can an application that requires higher-privileged scopes, an admin must first provide consent. This is a one time event. Once an admin provides the "thumbs up", every user within that organization will be able to authorize your application.

Admin Consent is kicked off with a simple GET request (typically just a link the admin clicks) to `https://login.microsoftonline.com/common/adminconsent` along with the following query parameters:

* `client_id` - This is your Application ID (see [Microsoft v2 Endpoint Primer][primer] for more information)
* `redirect_uri` - This is the URI you want to redirect them too after consent (more in a moment)

The prototype for this call looks like this:

```none
https://login.microsoftonline.com/common/adminconsent?
client_id=[APPLICATION ID]&redirect_uri=[REDIRECT URI]
```

When the admin logs in they will be presented with the list of permission you selected during registration. Once they accept the scopes, they will be returned to the redirect_uri you specified.

During redirection, you will receive some additional data in for form of query parameters:

`GET http://localhost:3000/consentReturn/?tenant=[tenant id]&admin_consent=[True/False]`

* `tenant` - This is the GUID for the tenant that was authorized. This allows you to capture which tenant consent was granted for.
* `admin_consent` - This returns true if they consented and false if they declined

## Post Consent

Once the tenant has consented to your permissions, you can begin authenticating users using the traditional OAUTH workflow. Features such as dynamic scopes and refresh tokens continue to operate in the same way as well.

[primer]: //massivescale.com/microsoft-v2-endpoint-primer
[implicit]: //massivescale.com/microsoft-v2-endpoint-implicit-grant.md
[graph]: //graph.microsoft.io
[admin_consent]: https://docs.microsoft.com/en-us/azure/active-directory/active-directory-assign-admin-roles
[app-reg]: https://apps.dev.microsoft.com

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
updated: 2018-3-28
image: /assets/aad-768x154.png
categories: 
  - Azure AD
  - OAuth 2.0
  - v2 Endpoint
  - Microsoft Graph
---

_This is a continuation of my [Microsoft v2 Endpoint Series](#microsoft-v2-endpoint-series). If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._

As developers dig into [Microsoft Graph][graph], they inevitably find themselves needing permission scopes that require "[Admin Consent][admin_consent]". These are scopes that have deemed worthy of requiring an Administrator to sign off before allowing lowly "normals" to authorize your application.

## User vs Admin Consent

While this article is focused on obtaining Admin Consent flow, it is also important to understand the Consent process and the differences between User and Admin Consent.

For a more detailed explanation, see [v2 Endpoint & Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})

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

| Property       | Description                                                                                   |
| :------------- | :-------------------------------------------------------------------------------------------- |
| `client_id`    | This is your Application ID (see [Microsoft v2 Endpoint Primer][primer] for more information) |
| `redirect_uri` | This is the URI you want to redirect them too after consent (more in a moment)                |

The prototype for this call looks like this:

```none
https://login.microsoftonline.com/common/adminconsent?
client_id=[APPLICATION ID]&redirect_uri=[REDIRECT URI]
```

When the admin logs in they will be presented with the list of permission you selected during registration. Once they accept the scopes, they will be returned to the redirect_uri you specified.

During redirection, you will receive some additional data in for form of query parameters:

```none
http://localhost:3000/consentReturn/?tenant=[tenant id]&admin_consent=[True/False]
```

* `tenant` - This is the GUID for the tenant that was authorized. This allows you to capture which tenant consent was granted for.
* `admin_consent` - This returns true if they consented and false if they declined

## Post Consent

Once the tenant has consented to your permissions, you can begin authenticating users using the traditional OAUTH workflow. Features such as dynamic scopes and refresh tokens continue to operate in the same way as well.

> One common issue that folks run into, particularly early on in development and testing, are errors being raised after changing the application's scopes. It is important to remember that Consent is granted for a fixed set of scopes. If those scopes should change, _additional consent is required_.
>
> For User Consent this typically isn't an issue since the user is simply presented with an updated Consent page the next time they authenticate. For Admin Consent however, you will need to repeat the Admin Consent process in order to cover those new scopes.
{:.warning}

## Microsoft v2 Endpoint Series

* [Microsoft v2 Endpoint Primer]({{ 'microsoft-v2-endpoint-primer' | relative_url }})
* [v2 Endpoint & Implicit Grant]({{ 'microsoft-v2-endpoint-implicit-grant' | relative_url }})
* [v2 Endpoint & Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})
* [v2 Endpoint & Admin Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})

## Further Reading

* [Azure AD v2 and MSAL from a developer's point of view](https://joonasw.net/view/azure-ad-v2-and-msal-from-dev-pov) by Joonas Westlin

[primer]: {{ 'microsoft-v2-endpoint-primer' | relative_url }}
[implicit]: {{ 'microsoft-v2-endpoint-implicit-grant' | relative_url }}
[scopes]: https://developer.microsoft.com/graph/docs/concepts/permissions_reference#calendars-permissions
[graph]: https://graph.microsoft.io
[admin_consent]: https://docs.microsoft.com/azure/active-directory/active-directory-assign-admin-roles
[app-reg]: https://apps.dev.microsoft.com

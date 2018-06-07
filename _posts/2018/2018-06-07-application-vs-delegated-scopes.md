---
title: Application vs Delegated Scopes
subtitle: Microsoft Graph has two parallel sets of permission scopes; Delegated & Application. Here I will attempt to shed some light on the when, where and how to use each.
categories:
  - Microsoft Graph
  - v2 Endpoint
---

[Microsoft Graph][graph] has two parallel sets of [permission scopes][scopes]; Delegated & Application. Understanding the difference between the two, and when to use them, is important when it comes to optimizing your integration with Microsoft Graph and mitigating against unintentionally requesting more access than you really need (or that an IT department would wish to grant).

## Delegated Permissions

To understand Delegated Permissions, its helpful to start with the dictionary definition for the word "Delegate":

> **del·e·gate** (verb) - To entrust a task or responsibility to another

This is precisely what Microsoft Graph means by "Delegated", a user has delegated a given task to your application. When you application subsequently makes a call to the API, it is executing that function _on behalf_ of the authenticated user.

The simplest illustration of Delegated Permissions in action is `/me`. Behind the scenes the Graph is automatically mapping `/me` to the user that delegated permission to your application. Because all activities executed within a delegated scope are made on behalf of a single user, Graph is able to determine who "me" is referring to.

>**Activities executed using Delegated scopes are *always* executed on behalf of an authenticated User.**
{:.key}

## Application Permissions

Unlike Delegated scopes, Application scopes do *not* have a "user" in context. When your application is operating under Application scopes, your permissions are not provided by a given User but by the Azure AD instance itself. 

In general, Application scopes are global. So where requesting the Delegated `Mail.Read` scope provides access to any mailbox the current user has permission to access, it's Application equivalent provides access to *every* user's mailbox. For this reason, you should use extreme caution before deciding to use Application scopes.

>**Activities executed using Application scopes are executed on behalf of your Application.**
{:.key}

Because Application permission scopes are so broad, all Application scopes require Admin Consent before your application can access a given tenant. For this reason, they are generally not a great fit for commercial/packaged applications.

## Determining Which Permissions Get Applied

Which scopes are applied to your application is determined by the OAuth Grant your use to obtain an access token. OAuth Grants that authenticate an individual receive Delegated permissions, while those that do not will receive Application permissions. 

| Oauth Grant Type                                                                | Permission Type |
| ------------------------------------------------------------------------------- | --------------- |
| [Authorization Code Grant](https://oauth.net/2/grant-types/authorization-code/) | Delegated       |
| [Implicit Grant](https://oauth.net/2/grant-types/implicit/)                     | Delegated       |
| [Client Credentials](https://oauth.net/2/grant-types/client-credentials/)       | Application     |

> A single Access Token can only contain one type of scopes (Application or Delegated).  So if your particular scenario requires both Application _and_ Delegated scopes, your application will need to obtain two separate tokens. The first will represent the User and be obtained using an Authorization Cord or Implicit grant, the second will represent the application itself and be obtained using a Client Credentials grant.
{:.tip}

## Best Practices

- **Principal of Least Privileged Permissions** - An application should only request permissions that are absolutely necessary to complete the required task(s). For example: If your needs to read a user's mailbox, you should select `Mail.Read` rather than `Mail.ReadWrite`. 
- **Avoid Application scopes in interactive applications** - Using application permissions for interactive scenarios represents a significant compliance and security risk. They can inadvertently elevate a user's privileges and circumvent policies configured by the tenants administrators. A good rule of thumb is that Application scopes should only be used for headless/daemon scenarios.

## Further Reading

* [Microsoft v2 Endpoint Primer]({{ 'microsoft-v2-endpoint-primer' | relative_url }})
* [v2 Endpoint & Implicit Grant]({{ 'microsoft-v2-endpoint-implicit-grant' | relative_url }})
* [v2 Endpoint & Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})
* [v2 Endpoint & Admin Consent]({{ 'microsoft-v2-endpoint-admin-consent' | relative_url }})

[scopes]: https://developer.microsoft.com/graph/docs/concepts/permissions_reference
[graph]: https://graph.microsoft.io
[admin_consent]: https://docs.microsoft.com/azure/active-directory/active-directory-assign-admin-roles
[app-reg]: https://apps.dev.microsoft.com
[primer]: {{ 'microsoft-v2-endpoint-primer' | relative_url }}
[implicit]: {{ 'microsoft-v2-endpoint-implicit-grant' | relative_url }}
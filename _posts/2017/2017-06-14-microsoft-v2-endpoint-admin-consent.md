---
title: v2 Endpoint & Admin Consent
subtitle: Mother may I? Obtaining Administrative Consent for your application
tags:
  - Azure Active Directory
  - Microsoft Graph
  - OAuth
  - v2 Endpoint
background: '/img/train.jpg'
category: aadv2
---
_This is a continuation of my [Microsoft v2 Endpoint Primer][primer]. If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._

As developers dig into [Microsoft Graph][graph], they inevitably find themselves needing permission scopes that require "[Admin Consent][admin_consent]". These are scopes that have deemed worth of receiving an administrators sign off before allowing your application to continue. 

Graph has two categories of permission scopes; Application & Delegated. These serve two distinct purposes:

* **Delegated:** If your application acts on "behalf" of a single user, you're looking for delegated permissions. Many Delegated permissions can be consented to by normal users. Other higher-privileged permissions require administrator consent however. 

* **Application:** If your application runs without a user context such as a background service or daemon, you're looking for Application permissions. Unlike Delegated permission, Application permissions _always require_ administrator consent. 

For the moment, I'm going to assume the application in question here is a traditional web app that happens to require access to higher-privileged scopes. This scenario is also used for daemon apps but there are a enough nuances around daemons to deserve it's own article. 

## Scope Differences

When using the v2 Endpoint, you can dynamic request scopes during authorization. This allows you to only request the minimum access required for a given user. For example, if you're application supports syncing both Calendars and Contacts but your user only wants to leverage the Calendar integration, you can forgo requesting access to Contacts. This provides some additional assurance to the user that your application is behaving as expected. 

Things operate a bit differently when Admin Consent is required. These scopes must be defined with your [application registration][app-reg]. This ensures administrators that there is some stability around the permissions you're requesting. It is important to note that this doesn't change how dynamic scopes operate; _you can still dynamically choose to not request these admin scopes_. 

Defining these scopes is done within your [application registration][app-reg]. You can define both Delegated and Application permissions here:

![](/assets/images/app-reg-graph-permissions.png)

Clicking add will display a list of available permissions:

![](/assets/images/app-reg-graph-permissions-dialog.png)

At a minimum you need to declare any scopes that require administrative consent. While you're certainly able to define other scopes, this isn't a requirement. 

## Obtaining Consent

Before any normal (non-admin) users can an application that requires higher-privileged scopes, an admin must first provide consent. This is a one time event. Once an admin provides the "thumbs up", every user within that organization will be able to authorize your application. 

Admin Consent is kicked off with a simple GET request (typically just a link the admin clicks) to `https://login.microsoftonline.com/common/adminconsent` along with the following query parameters:

* client_id - This is your Application ID (see [Microsoft v2 Endpoint Primer][primer] for more information)
* redirect_uri - This is the URI you want to redirect them too after consent (more in a moment)

The prototype for this call looks like this:

```
https://login.microsoftonline.com/common/adminconsent?
client_id=[APPLICATION ID]&redirect_uri=[REDIRECT URI]
```
When the admin logs in they will be presented with the list of permission you selected during registration. Once they accept the scopes, they will be returned to the redirect_uri you specified. 

During redirection, you will receive some additional data in for form of query parameters:

`GET http://localhost:3000/consentReturn/?tenant=[tenant id]&admin_consent=[True/False]`

* tenant - This is the GUID for the tenant that was authorized. This allows you to capture which tenant consent was granted for. 
* admin_consent - This returns true if they consented and false if they declined

## Post Consent

Once the tenant has consented to your permissions, you can begin authenticating users using the traditional OAUTH workflow. Features such as dynamic scopes and refresh tokens continue to operate in the same way as well. 


[primer]: //massivescale.com/microsoft-v2-endpoint-primer
[graph]: //graph.microsoft.io
[admin_consent]: https://docs.microsoft.com/en-us/azure/active-directory/active-directory-assign-admin-roles
[app-reg]: https://apps.dev.microsoft.com
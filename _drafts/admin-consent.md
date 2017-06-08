---
title: Mother May I?
subtitle: Using Administrative Consent with the v2 Endpoint 
tags:
  - Azure
  - Azure Active Directory
  - Microsoft Graph
  - OAUTH
  - Office
  - v2 Endpoint
---
_This is a continuation of my [Microsoft v2 Endpoint Primer][primer]. If you haven't read this article yet, I highly recommend starting there. I will be glossing over several bits of configuration we previously covered._


As developers dig into [Microsoft Graph][graph], they inevitably find themselves needing permission scopes that require "[Admin Consent][admin_consent]". These are scopes that have deemed worth of receiving an administrators sign off before allowing your application to continue. 

Graph has two categories of permission scopes; Application & Delegated. These serve two distinct purposes:

* **Delegated:** If your application acts on "behalf" of a single user, you're looking for delegated permissions. Many Delegated permissions can be consented to by normal users. Other higher-privileged permissions require administrator consent however. 

* **Application:** If your application runs without a user context such as a background service or daemon, you're looking for Application permissions. Unlike Delegated permission, Application permissions _always require_ administrator consent. 




[primer]: //massivescale.com/microsoft-v2-endpoint-primer
[graph]: //graph.microsoft.io
[admin_consent]: https://docs.microsoft.com/en-us/azure/active-directory/active-directory-assign-admin-roles
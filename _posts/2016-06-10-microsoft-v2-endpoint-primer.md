---
Title: Microsoft v2 Endpoint Primer
Published: 2016-06-10 11:15:01
Excerpt: 'For some time now, Microsoft has had two distinct systems for authenticating users; Microsoft Account (or MSA) and Azure Active Directory (or Azure AD); MSA for consumer services and Azure AD for enterprise services. The v2 Endpoint allow applications to authenticate both Microsoft Accounts and Azure AD accounts using a single OAUTH 2 endpoint. This allows developers to build applications that are entirely  account-agnostic. This article covers the basics of using the v2 Endpoint and OAUTH2 to authenticate users. '
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4900044170";}'
author:
  - Marc LaFleur
post_date:
  - 2016-06-10 11:15:01
post_excerpt:
  - 'For some time now, Microsoft has had two distinct systems for authenticating users; Microsoft Account (or MSA) and Azure Active Directory (or Azure AD); MSA for consumer services and Azure AD for enterprise services. The v2 Endpoint allow applications to authenticate both Microsoft Accounts and Azure AD accounts using a single OAUTH 2 endpoint. This allows developers to build applications that are entirely  account-agnostic. This article covers the basics of using the v2 Endpoint and OAUTH2 to authenticate users. '
permalink:
  - /microsoft-v2-endpoint-primer/
---
Until recently Microsoft had two very distinct systems for authenticating users; <a href="https://en.wikipedia.org/wiki/Microsoft_account">Microsoft Account</a> (or MSA) and <a href="https://azure.microsoft.com/en-us/documentation/articles/active-directory-whatis/">Azure Active Directory</a> (or Azure AD). Both served the same purpose but for very different audiences; MSA for consumer services and Azure AD for enterprise services. For a while this separation worked reasonably well. While application required different integrations, most applications tended to sit squarely in one market or the other.

Over time however, the distinction between "Enterprise" and "Consumer" applications has eroded. Today we it is extremely common to find publishers targeting both markets with the same solution and users with multiple accounts for work and personal use. Having to support distinct authentication integrations quickly became a pain point. The solution to this pain is the <a href="https://azure.microsoft.com/en-us/documentation/articles/?product=active-directory&amp;term=app+model+v2.0">Microsoft v2 Endpoint</a> (previously known as "Converged Authentication").

<h2>What is v2 Endpoint</h2>

The v2 Endpoint allows applications to authenticate both Microsoft Accounts and Azure AD accounts using a single <a href="https://en.wikipedia.org/wiki/OAuth">OAUTH2</a> endpoint. This allows developers to build applications that are entirely  account-agnostic. You no longer need to know which type of account the user owns. More importantly, you no longer need to ask to user to tell you what type of account they have (which to be honest, 90% of users likely have no idea how to answer).

Obviously there are some APIs may have different data sets depending on the account type. <a href="https://graph.microsoft.io/en-us/docs/overview/overview">Microsoft Graph</a> for example provides access to a number of APIs common to MSA and Azure AD accounts (Outlook, OneDrive, etc.) but some APIs only apply to enterprise accounts (Delve, SharePoint, etc.). To support these scenarios your application can determine the account type at run-time. The key difference here being that your application can pragmatically find the account type than relying on the user to tell your code.

<h2>OAUTH &amp; Grant Types</h2>

The v2 Endpoint uses OAUTH2 for authorization and supports the two most common Grant Types; Authorization Code and Implicit. If you're not familiar with OAUTH (and OAUTH2 specifically), a Grant Types defines the workflow used for a particular OAUTH transaction. They all provide the same output, a token representing the authenticated user. Where they differ is how that token is obtained. In an effort to avoid going down a rabbit hole, I won't go into the details of OAUTH and the various grant flows. I will instead point you to an <a href="https://aaronparecki.com/2012/07/29/2/oauth2-simplified">excellent article on the topic</a>.

OAUTH is based on verifiable trusts. The User trusts the OAUTH Provider (they opened an account there), the Service trusts the OAUTH Provider (they redirect the user there to authenticate) and the Provider trusts both the User and the Service. This is where Application Registration comes into play. Just as the Provider trusts the User because the User has an account on their system, the Service must do the same. Think of Application Registration as an account record for your application and just as the user has a "User ID", your application will receive an "Application ID".

In essence, we have a triangle with assumed trusts between the User and the Provider (the user's account) and the Service and the Provider (the app registration).

<img class="size-full wp-image-7561 aligncenter" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/oauth-triangle-broken1.png" alt="oauth-triangle-broken" width="350" height="238" />

In order to complete the triangle and receive an authorization token we need to verify  trust between the User and the Service.

<img class="size-full wp-image-7551 aligncenter" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/oauth-triangle-complete.png" alt="oauth-triangle-complete" width="350" height="238" />

That third leg of trust is represented by an authorization token passed between the User and the Service with each call.

<h2>Application Registration</h2>

Microsoft provides a portal for registering your application at <a href="https://apps.dev.microsoft.com">https://apps.dev.microsoft.com</a>. After opening this page and logging in with your <a href="https://account.microsoft.com/">Microsoft Account</a> you are presented with a list of registered application and a button labeled "Add an app".

[caption id="attachment_7611" align="aligncenter" width="400"]<img class="wp-image-7611 size-full" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-landing-page.png" alt="apps-dev-landing-page" width="400" height="120" /> App Registration - Initial Page[/caption]

Clicking this button will prompt you for the name of your application:

[caption id="attachment_7641" align="aligncenter" width="400"]<img class="size-full wp-image-7641" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-new-app-dialog.png" alt="App Registration – New App Dialog" width="400" height="147" /> App Registration – New App Dialog[/caption]

Once you've named your application and clicked "Create application" you are redirected to your application's profile page.

<blockquote>
  <strong>v2 Registration vs. Azure AD Registration</strong> 
  If you've worked with Azure AD in the past you will notice some similarities here. The general architecture is the same, the user experience however is far more straightforward. If you've not worked with Azure AD in the past then you'll have to trust me, this <em>is</em> a simplified experience.
</blockquote>

The first item to take note of is the Application ID. This is one of the elements required for the OAUTH workflow.  You will also see options for generating Client Secrets (aka Passwords). A single applications can have multiple Client Secrets assigned. This allows you to use the same registration for both traditional web sites, single-page apps and native clients.

[caption id="attachment_7661" align="aligncenter" width="400"]<a href="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-appid.png"><img class="wp-image-7661 size-full" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-appid.png" alt="App Registration - Application ID" width="400" height="274" /></a> App Registration - Application ID[/caption]

For this example I'm going to focus on the traditional web scenario. We will need two components for this workflow, a Password (aka Client Secret) and a Platform record. To get started we will need to click "Generate New Password".  This will open a dialog with your new Password. Save this in a safe place because once you close this dialog <em>you will never see this password again</em>.

[caption id="attachment_7721" align="aligncenter" width="400"]<img class="size-full wp-image-7721" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-new-password.png" alt="App Registration - New Password" width="400" height="246" /> App Registration - New Password[/caption]

Next we will need to click "Add Platform". This presents a dialog with two options. We'll select "Web" for this example.

[caption id="attachment_7671" align="aligncenter" width="400"]<a href="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-new-platform.png"><img class="wp-image-7671 size-full" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-new-platform.png" alt="App Registration - New Platform Dialog" width="400" height="206" /></a> App Registration - New Platform Dialog[/caption]

This will add a new Web platform card to your registration page. This card has two properties, Allow Implicit Flow and Redirect URI. We will not be implementing the Implicit workflow in our example so you can uncheck that option. The Redirect URI is where the user will be redirected back to once they have authenticated. The value will depend on your implementation and if you're using a framework (such as <a href="https://github.com/simov/grant">Grant</a>) you will need to check with the framework documentation. For my simple example here I am using redirecting to a local server at <code>http://localhost:3000/returned</code>.

[caption id="attachment_7681" align="aligncenter" width="400"]<img class="wp-image-7681 size-full" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-web-platform.png" alt="App Registration - Web Platform Properties" width="400" height="176" /> App Registration - Web Platform Properties[/caption]

<blockquote>
  <strong>Implicit Grant Workflow</strong>
  If you want to play around with the Implicit Grant workflow, you can leave Allow Implicit Flow checked. It doesn't impact the Authorization Code Grant workflow and I've only disabled it for the sake of completeness. Leaving it enabled won't cause problem here. In production it should only be enabled if you truly need it since it does allow for a less secure workflow.
</blockquote>

<h2>Requesting a Token</h2>

In this example I'm going to focus on using the Authorization Code Grant workflow with a traditional web app/site. This is the most common of the grant type and is a bit more secure Implicit Grant workflow. If your application can support Authorization Code Grant than you app should use it. It is also the most complex of the workflows which makes it a great place to start. Once you understand how the Authorization workflows functions it is relatively easy to transition to the Implicit workflow.

The Authorization workflow has four components. The first is a redirect to the Provider which is where the user will enter their credentials. This process will return an Authorization Code back to the Service. The Service will then send an HTTP POST back to the Provider where that Authorization Code is converted into a Bearer Token. This Token is returned to the Service and will be included with any API calls back to Microsoft.

<img class="size-full wp-image-7701 aligncenter" src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/oauth-steps.png" alt="oauth-steps" width="856" height="148" />

The first call into the v2 Endpoint is a simple GET request (typically just a link the user clicks) to <code>https://login.microsoftonline.com/common/oauth2/v2.0/authorize</code> along with several query parameters:

<ul>
<li>client_id - This is your Application ID from above</li>
<li>response_type - For this example it should always be "code"</li>
<li>redirect_uri - This must be the same URI you entered earlier in the Platform configuration.</li>
<li>scope - This tells the Provider what permissions you need for the APIs (more on this in a moment)</li>
</ul>

The prototype for this call looks like this:

<pre>https://login.microsoftonline.com/common/oauth2/v2.0/authorize?
client_id=[APPLICATION ID]&amp;response_type=code&amp;
redirect_uri=[REDIRECT URI]&amp;scope=[SCOPE]</pre>

<blockquote>
  <strong>Scopes</strong>
  The scope parameter holds the list of permission scopes you application requires. This is a simple string of space delimited scope parameters. Most scopes in the v2 Endpoint are full URIs rather than just the scope name itself. For example, if you need to access the user's profile you need to request permission for User.Read. The full URI for this is https://graph.microsoft.com/User.Read.  If you also need permissions for Mail.Read your scope string would be: https://graph.microsoft.com/User.Read https://graph.microsoft.com/Mail.Read. For more information on scopes and what access they provide, please see <a href="https://graph.microsoft.io/en-us/docs/authorization/permission_scopes">Microsoft Graph permission scopes</a>.
</blockquote>

Once the user has completed signing in, the Provider will redirect back to your Redirect URI. The Provider will add a "code" query parameter to this URI. The value of this parameter is your authorization code. You will need to extract this value from the URI so you can use it in the next stage, requesting the Bearer Token.

Once you have the Authorization Code you will need to make an HTTP POST back to the provider. The POST's body must be encoded as "application/x-www-form-urlencoded" and contain the following parameters:

<ul>
<li>grant_type - Should be authorization_code</li>
<li>code - The auth code you received from the Provider</li>
<li>client_id - This is your Application ID from above</li>
<li>client_secret - This is the Password we generated previously</li>
<li>scope - This should match the same set of scopes you initial requested</li>
<li>redirect_uri - This is the redirect URI defined in your application registration</li>
</ul>

This body will be POSTed up to https://login.microsoftonline.com/common/oauth2/v2.0/token. The prototype for this call should look like:

<pre>POST URL: https://login.microsoftonline.com/common/oauth2/v2.0/token
POST HEADER: Content-Type: application/x-www-form-urlencoded
POST BODY: grant_type=authorization_code&amp;code=[AUTHORIZATION CODE]&amp;
           client_id=[APPLICATION ID]&amp;client_secret=[PASSWORD]
           &amp;scope=[SCOPE]&amp;redirect_uri=[REDIRECT URI]</pre>

Once the Provider has processed this request, it will return a JSON object containing the following properties:

<ul>
<li>access_token - This is the actual token.</li>
<li>expires_in - Number of seconds until this token expires and can no longer be used.</li>
<li>token_type - This tells you what type of token you have. It should always be "bearer".</li>
<li>scope - This is the list of scopes you have been granted access too.</li>
</ul>

<strong>Example</strong>

https://gist.github.com/mlafleur/b4914cf06dbffd5a67524e36210de686

<h2>Refreshing a Token</h2>

By default, Access/Bearer tokens have a lifetime of 1 hour. After this time they are no longer valid. There are two options at this point, you can ask the user to re-authenticate (less than ideal) or you can use a Refresh Token to get an updated token.

Refresh Tokens are only returned when you include offline_access in your first scopes list. This is a special scope that does not need a full URI. Adding this scope will result in an additional property called refresh_token being returned by the provider. This refresh_token can be used to repeat the previous POST process to retrieve a newly minted bearer token.

<blockquote>
  Refresh Tokens are also only available in the Authorization Code workflow. If you are using the Implicit workflow you are limited to the initial lifetime of the token. Refresh Tokens operation similarly to the initial Authorization Code, they are exchanged with the Provider for an updated bearer token. Given that the Implicit Grant was designed to skip the Authorization Code exchange, they also cannot participate in the Refresh Token exchange.
</blockquote>

To exorcise your Refresh Token, we need to make another HTTP POST back to the provider. The POST's body must be encoded as <a href="https://en.wikipedia.org/wiki/Percent-encoding#The_application.2Fx-www-form-urlencoded_type">application/x-www-form-urlencoded</a>" and contain the following parameters:

<ul>
<li>grant_type - Must be refresh_token</li>
<li>refresh_token - The refresh token value you received from the Provider</li>
<li>client_id - This is your Application ID from above</li>
<li>client_secret - This is the Password we generated before</li>
<li>scope - This should match the same set of scopes you first requested</li>
<li>redirect_uri - This is the redirect URI defined in your application registration</li>
</ul>

This body will be POSTed up to <a href="https://login.microsoftonline.com/common/oauth2/v2.0/token">https://login.microsoftonline.com/common/oauth2/v2.0/token</a>. The prototype for this call should look like:

<pre>POST URL: https://login.microsoftonline.com/common/oauth2/v2.0/token
POST HEADER: Content-Type: application/x-www-form-urlencoded
POST BODY: grant_type=refresh_token&amp;refresh_token=[REFRESH TOKEN]
           &amp;client_id=[APPLICATION ID]&amp;client_secret=[PASSWORD]
           &amp;scope=[SCOPE]&amp;redirect_uri=[REDIRECT URI]</pre>

Once the Provider has processed this request, it will return a JSON object containing the following properties:

<ul>
<li>access_token - This is the actual token.</li>
<li>expires_in - Number of seconds until this token expires and can no longer be used.</li>
<li>token_type - This tells you what type of token you have. It should always be "bearer".</li>
<li>scope - This is the list of scopes you have been granted access too.</li>
<li>refresh_token - A new refresh token to be used for the next round</li>
</ul>

<strong>Example</strong>

https://gist.github.com/mlafleur/cb955f376cd4528546a998e881ba2f84

<h2>Token Lifetime</h2>

Each of the tokens described above (auth_code, access_token, refresh_token) have a defined lifetime. Once they have expired they can no longer be used. This is important to understand when architecting your authorization workflow. You need to have a strategy for handling initial authorization, invalid tokens, refreshing of tokens, etc. With refresh tokens in particular, you may need a background process automatically handling token renewal prior to them expiring.

<strong>Microsoft Account (MSA) Tokens:</strong>

<ul>
<li>Authorization Codes - 5 minutes</li>
<li>Access Tokens - 1 hour</li>
<li>Refresh Tokens - up to 1 year</li>
</ul>

<strong>Azure Active Directory (AAD) Tokens:</strong>

<ul>
<li>Authorization Codes - 10 minutes</li>
<li>Access Tokens - 1 hour</li>
<li>Refresh Tokens - up to 14 days</li>
</ul>

<h2>Example Application</h2>

I've created a very simple Node.js application using Express and Request that walks you through the entire workflow (including refreshing the token).  The entire application is available on GitHub at <a href="https://github.com/mlafleur/node-v2endpoint-example">https://github.com/mlafleur/node-v2endpoint-example</a>.

In order to use this sample you will need to complete the Application Registration process outlined above. Once completed, you will need to add you Application ID and Password to the variables defined at the top of <a href="https://github.com/mlafleur/node-v2endpoint-example/blob/master/index.js">index.js</a>. Running the sample will spin up a local web server at <a href="http://localhost:3000">http://localhost:3000</a>. Browsing to this page will present a page with a single link. This link represents the first stage (redirection to the Provider) of the process. Once the token is obtained it is rendered in the browser (along with a link to trigger a token refresh).
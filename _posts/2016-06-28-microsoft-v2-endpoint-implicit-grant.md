---
Title: Microsoft v2 Endpoint and Implicit Grant
Published: 2016-06-28 17:32:26
Excerpt: >
  Building on my previous v2 Endpoint
  Primer, here we discuss using the
  Implicit Grant.
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4946406903";}'
author:
  - Marc LaFleur
post_date:
  - 2016-06-28 17:32:26
post_excerpt:
  - >
    Building on my previous v2 Endpoint
    Primer, here we discuss using the
    Implicit Grant.
permalink:
  - /microsoft-v2-endpoint-implicit-grant/
---
<em>This is a continuation of my <a href="http://massivescale.com/microsoft-v2-endpoint-primer">Microsoft v2 Endpoint Primer</a>. If you haven't read this article yet, I highly recommend doing so. I will be glossing over several bits of configuration we previously covered (application registration for example).</em>

First, a disclaimer. I am not a fan of the <a href="http://tools.ietf.org/html/rfc6749#section-1.3.2">Implicit Grant</a>. It has some severe limitations and is <a href="http://tools.ietf.org/html/rfc6749#section-10.3">less</a> <a href="http://tools.ietf.org/html/rfc6749#section-10.16">secure</a> than the <a href="http://tools.ietf.org/html/rfc6749#section-1.3.1">Authentication Code Grant</a>. There are absolutly cases where an Implicit Grant is required but in most cases it should be avoided whenever possible.

<h2>What is the Implicit Grant workflow</h2>

The <a href="http://tools.ietf.org/html/rfc6749#section-1.3.2">Implicit Grant</a> is a simplified version of the <a href="http://tools.ietf.org/html/rfc6749#section-1.3.1">Authentication Code Grant</a>. It eliminates some steps from the process that would be impossible to support in certain scenarios. In particular, it eliminates the exchanging of an authentication code for a bearer token. Instead it returns the bearer token directly to the client but adding it as a [fragment identifier][fragment-id] to the Redirect URI.

<blockquote>
  The term fragment identifier may be unfamiliar to a lot folks (I counted myself among them). Changes are they are you know what they're for,  most of us just didn't know what they were called. Fragment IDs are similar to query params in that they are data appended the URI. Instead of using a question mark (http://url.com?query-param) they use a hash (http://url.com#fragment-id). So there you are fearless reader, your useless URI trivia for the day.
</blockquote>

To understand why this workflow is needed, it is helpful to consider the actors involved in the Authentication Code Grant workflow. As I covered in my <a href="http://massivescale.com/microsoft-v2-endpoint-primer">previous article</a>, we have three actors (the User, the Service and the Provider). Another way to describe these actors might be as the Browser, the Website and the Provider.

This Browser/Website/Provider accurately describes the actors within the context of a Web App. It doesn't however align very well to other scenarios such a local/native application or a single-page application written entirely in JavaScript. Normally the Service holds the "Secret" that is used to convert the authentication code to a bearer token. In this scenario the secret is rather pointless since it is easily discoverable by the end-user. If the User knows the Application ID and the Secret why bother having the Secret in the first place? Enter the Implicit Grant workflow.

<h2>Supporting Implicit Grant</h2>

In order to support Implicit Grants, you must have a Platform in your Application Registration configured to support it. Assuming you followed the registration process in the <a href="http://massivescale.com/microsoft-v2-endpoint-primer">Primer</a> this is simply a matter of checking off the "Allow Implicit Flow" option in the Web Platform Properties:

[caption id="attachment_7681" align="alignnone" width="400"]<img src="https://massivescale.blob.core.windows.net/blogmedia/2016/06/apps-dev-web-platform.png" alt="App Registration - Web Platform Properties" width="400" height="176" class="size-full wp-image-7681" /> App Registration - Web Platform Properties[/caption]

Once this option is selected and saved, the v2 Endpoint will begin supporting Implicit Grants for your Application ID. From here we need to make a couple of adjustments to the token request method we used in the previous article.

<h2>Requesting a Token</h2>

The Implicit workflow has only two stages. The first is a redirect to the Provider which is where the user will enter their credentials. This process will return an Bearer Token  back to the Client as a [fragment identifier][fragment-id] . The Client must then parse the token out of the URL and included with any API calls back to Microsoft.

The first call into the v2 Endpoint is a simple GET request (typically just a link the user clicks) to <code>https://login.microsoftonline.com/common/oauth2/v2.0/authorize</code> along with several query parameters:

<ul>
<li>client_id - This is your Application ID from above</li>
<li>response_type - For this example it should always be "<strong>token</strong>" </li>
<li>redirect_uri - This must be the same URI you entered earlier in the Platform configuration.</li>
<li>scope - This tells the Provider what permissions you need for the APIs (more on this in a moment)</li>
</ul>

The prototype for this call looks like this:

<pre>https://login.microsoftonline.com/common/oauth2/v2.0/authorize?
client_id=[APPLICATION ID]&amp;response_type=token&amp;
redirect_uri=[REDIRECT URI]&amp;scope=[SCOPE]</pre>

<blockquote>
  <strong>Scopes</strong>
  Because the Implicit Flow does not do a token exhange, scopes that depend on them such as offline_access and openid will simply be ignored by the Endpoint.
</blockquote>

Once the user has completed signing in, the Provider will redirect back to your Redirect URI. The Provider will add a [fragment identifier][fragment-id]   this URI.  You will need to extract these values from the URI to retrieve the Bearer Token.

The protype of the Implicit Grant's fragment ID is as follows:

<pre>[REDIRECT URI]#access_token=[ACCESS TOKEN]&token_type=Bearer
&expires_in=[EXPIRES]&scope=[SCOPE]</pre>

<ul>
<li>access_token - This is the actual token.</li>
<li>expires_in - Number of seconds until this token expires and can no longer be used.</li>
<li>token_type - This tells you what type of token you have. It should always be "bearer".</li>
<li>scope - This is the list of scopes you have been granted access too.</li>
</ul>

In you're using JavaScript in a browser, you can grab this data from the URI using window.location.hash. If you're using <a href="http://jquery.org">jQuery</a> then I would hightly recommend looking into <a href="http://benalman.com/projects/jquery-bbq-plugin/">jQuery BBQ</a>.

<h2>Further Reading</h2>

<ul>
<li><a href="http://tools.ietf.org/html/rfc6749">The OAuth 2.0 Authorization Framework (RFC-6749)</a></li>
<li><a href="http://tools.ietf.org/html/rfc6749#section-10.3">Access Token Security with Implicit Grants</a></li>
<li><a href="http://tools.ietf.org/html/rfc6749#section-10.16">Misuse of Access Token to Impersonate Resource Owner in Implicit Flow</a></li>
</ul>
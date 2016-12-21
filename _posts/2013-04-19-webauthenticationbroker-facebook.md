---
Title: 'WebAuthenticationBroker &#038; Facebook'
Published: 2013-04-19 08:42:01
Excerpt: "I needed to use Facebook authentication in a Windows Store app the other day. The Windows Runtime makes this trivially easy with it's WebAuthenticationBroker class. The web authentication broker allows apps to use Internet authentication and authorization protocols like OAuth and OpenID with minimal effort."
Tags: null
views:
  - 'a:1:{i:0;s:3:"585";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3541860397";}'
author:
  - Marc LaFleur
post_date:
  - 2013-04-19 08:42:01
post_excerpt:
  - "I needed to use Facebook authentication in a Windows Store app the other day. The Windows Runtime makes this trivially easy with it's WebAuthenticationBroker class. The web authentication broker allows apps to use Internet authentication and authorization protocols like OAuth and OpenID with minimal effort."
permalink:
  - /webauthenticationbroker-facebook/
---
I needed to use Facebook authentication in a Windows Store app the other day. The Windows Runtime makes this trivially easy with it's <a href="http://msdn.microsoft.com/en-us/library/windows/apps/br227044.aspx" target="_blank">WebAuthenticationBroker </a>class. The web authentication broker allows apps to use Internet authentication and authorization protocols like <a href="http://oauth.net/2/" target="_blank">OAuth </a>and <a href="http://openid.net/" target="_blank">OpenID</a> with minimal effort. Unfortunately the samples I found on the interwebs for Facebook were buggy/incomplete or assumed the I had a deep understanding of Facebook authentication. After a bit of work I was able to get it working and figured I'd share to save someone else some time. <span style="font-size: 12pt;">
</span>
<h1>AppID</h1>
Before you can authenticate against Facebook you need an AppID for your app. For obvious reasons, all of the documentation assumed you're building a Web App but it is the same process.
<ol>
	<li>Head over to <a href="https://developers.facebook.com/apps">https://developers.facebook.com/apps</a> and "Create a New App"
<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/04/041913_1331_WebAuthenti1.png" /></li>
	<li>Once it completes creating you app, copy your AppID from the next screen
<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/04/041913_1331_WebAuthenti2.png" /></li>
</ol>
<h1>Authentication Method</h1>
Next I created a new async method that authenticates the user and returns the Authentication Token from Facebook.
https://gist.github.com/mlafleur/6074087
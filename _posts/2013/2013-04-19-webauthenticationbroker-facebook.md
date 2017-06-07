---
title: 'WebAuthenticationBroker &#038; Facebook'
excerpt: "I needed to use Facebook authentication in a Windows Store app the other day. The Windows Runtime makes this trivially easy with it's WebAuthenticationBroker class. The web authentication broker allows apps to use Internet authentication and authorization protocols like OAuth and OpenID with minimal effort."
tags:
  - OpenAuth
  - OpenID
  - WebAuthenticationBroker
  - Windows
---
I needed to use Facebook authentication in a Windows Store app the other day. The Windows Runtime makes this trivially easy with it's <a href="http://msdn.microsoft.com/en-us/library/windows/apps/br227044.aspx" target="_blank">WebAuthenticationBroker </a>class. The web authentication broker allows apps to use Internet authentication and authorization protocols like <a href="http://oauth.net/2/" target="_blank">OAuth </a>and <a href="http://openid.net/" target="_blank">OpenID</a> with minimal effort. Unfortunately the samples I found on the interwebs for Facebook were buggy/incomplete or assumed the I had a deep understanding of Facebook authentication. After a bit of work I was able to get it working and figured I'd share to save someone else some time. <span style="font-size: 12pt;">
</span>

# AppID
Before you can authenticate against Facebook you need an AppID for your app. For obvious reasons, all of the documentation assumed you're building a Web App but it is the same process.
<ol>
	<li>Head over to <a href="https://developers.facebook.com/apps">https://developers.facebook.com/apps</a> and "Create a New App"
<img alt="" src="/assets/wp/2013/04/041913_1331_WebAuthenti1.png" /></li>
	<li>Once it completes creating you app, copy your AppID from the next screen
<img alt="" src="/assets/wp/2013/04/041913_1331_WebAuthenti2.png" /></li>
</ol>
# Authentication Method
Next I created a new async method that authenticates the user and returns the Authentication Token from Facebook.
{% gist 5dc184b0b0ba91a06035  %}
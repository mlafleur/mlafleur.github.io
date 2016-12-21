---
Title: Basic HTTP Authentication in WinRT
Published: 2012-07-29 22:45:18
Excerpt: "I'm working with a REST API that requires Basic HTTP Authentication. This is pretty commonplace and something I've done it many times in the past in web and Silverlight applications. WinRT was very similar but (as with everything in WinRT) has its own nuances."
Tags: null
views:
  - 'a:1:{i:0;s:4:"7730";}'
panels_data:
  - 'a:1:{i:0;s:6:"a:0:{}";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538706604";}'
author:
  - Marc LaFleur
post_date:
  - 2012-07-29 22:45:18
post_excerpt:
  - "I'm working with a REST API that requires Basic HTTP Authentication. This is pretty commonplace and something I've done it many times in the past in web and Silverlight applications. WinRT was very similar but (as with everything in WinRT) has its own nuances."
permalink:
  - /basic-http-authentication-in-winrt/
---
I'm on vacation right now, getting some much needed time with the family and preparing for my wedding at the end of the week. So what does a geek do in the midst of 6 kids and the chaos of wedding planning? Why build a Metro style app of course. Duh!

For my little application I'm working with a REST API that requires Basic HTTP Authentication. This is pretty commonplace and something I've done it many times in the past in web and Silverlight applications. WinRT was very similar but (as with everything in WinRT) has its own nuances.

If you're using WinRT to call REST APIs (and honestly, who isn't?) you will quickly become familiar the <a href="http://msdn.microsoft.com/en-us/library/system.net.http.httpclient(v=vs.110).aspx" target="_blank">HttpClient</a> class. It is very similar to the older WebClient and it pretty straightforward to use (and very clean thanks to the absolutely awesome await keyboard in .NET 4.5).

https://gist.github.com/mlafleur/3d8413879e02a8c9dacb

In order to pass along the authentication we'll need to add a <a href="http://msdn.microsoft.com/en-us/library/hh193878(v=vs.110)" target="_blank">AuthenticationHeaderValue</a>. This took a little noodling to figure out so hopefully this saves you a bit of time. Basic HTTP authentication is handled by passing "username:password" in the header. In order to do this I needed to create a new AuthenticationHeaderValue with "basic" for the scheme and "username:password" for the value. This gets added to my HttpClient so that every call includes the Authentication information. To do that I created a method called CreateBasicHeader that generates what I need and then call that from inside my original method.

https://gist.github.com/mlafleur/13d1f1353e916e4472a9

As it happens, the particular API I'm calling wants the password in an MD5 Hash rather than plain text. Luckily there was a <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.security.cryptography.core.hashalgorithmprovider.openalgorithm.aspx" target="_blank">great sample</a> that showed how to do this. The only change I made was to use EncodeToHexString rather than EncodeToBase64String.

Here is the full sample:

https://gist.github.com/mlafleur/04f93e78d1834e010c4d
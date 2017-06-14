---
title: Custom Headers with HttpClient
subtitle: Adding additional custom headers to your HttpClient calls
tags:
  - REST
  - Web Services
  - Windows
  - HttpClient
  - WinRT
---
I while back I talked about [Basic Authentication with HttpClient][basic-http-authentication-in-winrt]. Kaysha posted an excellent question about custom headers for things like User-Agent and Content-Type. Here is how you handle those headers.

[HttpClient][HttpClient] is extremely simple to use out of the box. Most of the plumbing is automatically handled for you. In some cases however you need to change some of that plumbing. As with most abstractions however, you often need to take a few steps back when you need to change the assumptions the abstraction made for you.

One of the things HttpClient does for you is to construct the Request Message automatically when you execute GetAsync. To add or change an HTTP header (such as [User-Agent][userAgent") however, you will need to construct the Request Message yourself.  Luckily this is rather simple to carry out.

The first thing you need to do is instantiate a new [HttpRequestMessage[HttpRequestMessage] object. You'll need to supply the [HttpMethod][HttpMethod] (PUT, GET, etc.) and the URI of the site you'll be sending it to.

{% gist 5dc184b0b0ba91a06035  %}

Next we need to populate the headers with our data. For User-Agent we add it to the HTTP headers. For Content-Type we need to add it to the Content Headers.

{% gist 5dc184b0b0ba91a06035  %}

Now we have a HttpRequestMessage with our custom User-Agent and Content-Type ready to roll. The only thing left to do is send it off to the server and await the response. This is a slightly different call than GetAsync since we are not using the default HttpRequestMessage. Instead we'll use [SendAsyn][SendAsyn] to tell HttpClient to send our custom HttpRequestMessage to the server.

{% gist 5dc184b0b0ba91a06035  %}

Here is the complete sample:

{% gist 5dc184b0b0ba91a06035  %}

[basic-http-authentication-in-winrt]: //massivescale.com/basic-http-authentication-in-winrt
[HttpClient]: https://msdn.microsoft.com/en-us/library/system.net.http.httpclient(v=vs.118).aspx
[userAgent]: http://en.wikipedia.org/wiki/User_agent
[HttpRequestMessage]: https://msdn.microsoft.com/en-us/library/system.net.http.httprequestmessage(v=vs.118).aspx
[HttpMethod]: https://msdn.microsoft.com/en-us/library/system.net.http.httpmethod(v=vs.118).aspx
[SendAsyn]: https://msdn.microsoft.com/en-us/library/system.net.http.httpclient.sendasync(v=vs.118).aspx
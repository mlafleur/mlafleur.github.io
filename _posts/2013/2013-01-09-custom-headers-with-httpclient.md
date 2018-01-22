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
I while back I talked about [Basic Authentication with HttpClient][basic-http-authentication-in-winrt]. Kaysha posted an excellent question about custom headers for things like [User-Agent][] and Content-Type. Here is how you handle those headers.

[HttpClient][] is extremely simple to use out of the box. Most of the plumbing is automatically handled for you. In some cases however you need to change some of that plumbing. As with most abstractions however, you often need to take a few steps back when you need to change the assumptions the abstraction made for you.

One of the things [HttpClient][] does for you is to construct the Request Message automatically when you execute GetAsync. To add or change an HTTP header (such as [User-Agent] however, you will need to construct the Request Message yourself.  Luckily this is rather simple to carry out.

The first thing you need to do is instantiate a new [HttpRequestMessage][] object. You'll need to supply the [HttpMethod][] (PUT, GET, etc.) and the URI of the site you'll be sending it to.

{% gist ea9f434db959c29be2f3  %}

Next we need to populate the headers with our data. For [User-Agent][] we add it to the HTTP headers. For Content-Type we need to add it to the Content Headers.

{% gist ddc5346314d845b82c63  %}

Now we have a [HttpRequestMessage][] with our custom [User-Agent][] and Content-Type ready to roll. The only thing left to do is send it off to the server and await the response. This is a slightly different call than [GetAsync][] since we are not using the default [HttpRequestMessage][]. Instead we'll use [SendAsyn][] to tell [HttpClient][] to send our custom [HttpRequestMessage][] to the server.

{% gist 4af34080327d87ae2cbf  %}

Here is the complete sample:

{% gist 2fb459b91fe7cd08e1b7  %}

[basic-http-authentication-in-winrt]: //massivescale.com/basic-http-authentication-in-winrt
[User-Agent]:         http://en.wikipedia.org/wiki/User_agent

[HttpRequestMessage]: https://msdn.microsoft.com/library/system.net.http.httprequestmessage.aspx
[HttpClient]:         https://msdn.microsoft.com/library/system.net.http.httpclient.aspx
[HttpMethod]:         https://msdn.microsoft.com/library/system.net.http.httpmethod.aspx
[GetAsync]:           https://msdn.microsoft.com/library/hh158944.aspx
[SendAsyn]:           https://msdn.microsoft.com/library/system.net.http.httpclient.sendasync.aspx
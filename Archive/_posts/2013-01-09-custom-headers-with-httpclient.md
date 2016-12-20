---
ID: 1169
post_title: Custom Headers with HttpClient
author: Marc LaFleur
post_date: 2013-01-09 09:11:48
post_excerpt: 'One of the things HttpClient does for you is to construct the Request Message automatically when you execute GetAsync. To add or change an HTTP header (such as "User-Agent") however, you will need to construct the Request Message yourself.  Luckily this is rather simple to carry out.'
layout: post
permalink: >
  http://massivescale.com/custom-headers-with-httpclient/
published: true
views:
  - "3872"
panels_data:
  - 'a:0:{}'
dsq_thread_id:
  - "3538599527"
---
I while back I talked about <a title="Basic HTTP Authentication in WinRT" href="http://massivescale.azurewebsites.net/basic-http-authentication-in-winrt/" target="_blank">Basic Authentication with HttpClient</a>. Kaysha posted an excellent question about custom headers for things like User-Agent and Content-Type. Here is how you handle those headers.

<a href="http://msdn.microsoft.com/query/dev11.query?appId=Dev11IDEF1&amp;l=EN-US&amp;k=k(System.Net.Http.HttpClient);k(TargetFrameworkMoniker-.NETCore,Version%3Dv4.5);k(DevLang-csharp)&amp;rd=true" target="_blank">HttpClient </a>is extremely simple to use out of the box. Most of the plumbing is automatically handled for you. In some cases however you need to change some of that plumbing. As with most abstractions however, you often need to take a few steps back when you need to change the assumptions the abstraction made for you.

One of the things HttpClient does for you is to construct the Request Message automatically when you execute GetAsync. To add or change an HTTP header (such as "<a href="http://en.wikipedia.org/wiki/User_agent" target="_blank">User-Agent</a>") however, you will need to construct the Request Message yourself.  Luckily this is rather simple to carry out.

The first thing you need to do is instantiate a new <a href="http://msdn.microsoft.com/query/dev11.query?appId=Dev11IDEF1&amp;l=EN-US&amp;k=k(System.Net.Http.HttpRequestMessage);k(HttpRequestMessage);k(TargetFrameworkMoniker-.NETCore,Version%3Dv4.5);k(DevLang-csharp)&amp;rd=true" target="_blank">HttpRequestMessage </a>object. You'll need to supply the <a href="http://msdn.microsoft.com/query/dev11.query?appId=Dev11IDEF1&amp;l=EN-US&amp;k=k(System.Net.Http.HttpMethod);k(TargetFrameworkMoniker-.NETCore,Version%3Dv4.5);k(DevLang-csharp)&amp;rd=true" target="_blank">HttpMethod </a>(PUT/GET/etc) and the URI of the site you'll be sending it to.

https://gist.github.com/mlafleur/ea9f434db959c29be2f3

Next we need to populate the headers with our data. For User-Agent we add it to the HTTP headers. For Content-Type we need to add it to the Content Headers.

https://gist.github.com/mlafleur/ddc5346314d845b82c63

Now we have a HttpRequestMessage with our custom User-Agent and Content-Type ready to roll. The only thing left to do is send it off to the server and await the response. This is a slightly different call than GetAsync since we are not using the default HttpRequestMessage. Instead we'll use <a href="http://msdn.microsoft.com/query/dev11.query?appId=Dev11IDEF1&amp;l=EN-US&amp;k=k(System.Net.Http.HttpClient.SendAsync);k(TargetFrameworkMoniker-.NETCore,Version%3Dv4.5);k(DevLang-csharp)&amp;rd=true" target="_blank">SendAsyn </a>to tell HttpClient to send our custom HttpRequestMessage to the server.

https://gist.github.com/mlafleur/4af34080327d87ae2cbf

Here is the complete sample:

https://gist.github.com/mlafleur/2fb459b91fe7cd08e1b7

<span style="color: #ff0000;">Update: Fixed an error in my sample code for the custom Content-Type</span>
<span style="color: #ff0000;">Update: Fixed an issue with the code formatting</span>
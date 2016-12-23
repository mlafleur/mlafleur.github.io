---
Title: Web API Routing by Content-Type
Excerpt: >
  Implementing a custom Route Attribute
  for Web API that considers Content-Type.
  This allows for routing based on the
  data encoding being supplied by the HTTP
  Request, not just the path and
  parameters it was sent to.
Tags:
  - .NET
  - ASP.NET
  - REST
  - WebApi
  - Windows
---
<a href="http://www.asp.net/web-api" target="_blank">ASP.NET Web API </a>has a really slick routing engine that pretty much "just works" right out of the box. It can automatically configure routing using your method name (i.e. GetStuff = GET, PostStuff = POST, DeleteStuff = PUT, etc.) and when this is insufficient you can easily override the behavior by decorating your methods with <a href="http://msdn.microsoft.com/en-us/library/system.web.http.routeattribute(v=vs.118).aspx" target="_blank">Route</a> and <a href="http://msdn.microsoft.com/en-us/library/system.web.http.acceptverbsattribute(v=vs.118).aspx" target="_blank">AcceptVerbs</a> attributes.

I ran into a situation recently where I wanted even finer-grain control over the routing mechanics. I had a method for updating an object that and I wanted clients to be able to pass it either <a href="http://en.wikipedia.org/wiki/JSON" target="_blank">JSON </a>or <a href="http://en.wikipedia.org/wiki/Percent-encoding#The_application.2Fx-www-form-urlencoded_type" target="_blank">X-WWW-FORM-URLENCODED</a> content. Regardless of the input format, the functionality was the same - update the object in the DB and return a JSON representation of the updated object. The challenge here is that Web API's routing has now way to routing based solely on the type of content in the request.

In the past I've solved this problem by switching my function prototype to use <a href="http://msdn.microsoft.com/en-us/library/system.net.http.httprequestmessage(v=vs.118).aspx" target="_blank">HttpRequestMessage </a> as the input parameter. Within the method I would evaluate the <a href="http://en.wikipedia.org/wiki/MIME#Content-Type" target="_blank">Content-Type</a> header and then process it accordingly. In this particular case I had quite a number of methods with this issue, creating a rather gnarly looking set of methods. This method also requires that you handle processing the data manually, bypassing a lot of the built-in features (e.g. <a href="http://blogs.msdn.com/b/jmstall/archive/2012/04/16/how-webapi-does-parameter-binding.aspx" target="_blank">parameter binding</a>) that makes Web API such a joy to work with.

https://gist.github.com/mlafleur/98529f7c4c2d2cd393e7

For a cleaner solution I decided to implement my own version of the Route attribute. It adds a Content-Type parameter that gets evaluated when a request is being routed.  If the request doesn't contain a Content-Type in it's header we default to X-WWW-FORM-URLENCODED . Now I can have a single path (e.g. api/controler/method) that accepts both JSON and X-WWW-FORM-URLENCODED input.

https://gist.github.com/mlafleur/f5ed0f50a36ce11de945

Building a customized Route attribute is extremely easy. It essentially consists of 2 classes, one that inherits from RouteFactoryAttribute and one that implements the IHttpRouteConstraint interface. Both classes are quite small and for the sake of simplicity I stuck them into a single file:

https://gist.github.com/mlafleur/887bdae885ae2427646f

What we are doing here is adding a Constraint to the standard Route attribute. This evaluates the request's Content-Type and compares it to the method's Content-Type constraint. If they're the same we return True, if they are not we return False. The rest of the magic is handled by Web API for us.

This pattern can be reused to evaluate any parameter in the request, including non-standard headers. A common example of this would be an API-Version header that routes based on the API version the client expects. If can also be used to evaluate multiple parameters (routing based on both API-Version and Content-Type for example).
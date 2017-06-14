---
title: Web API Routing by Content-Type
subtitle: Implementing a custom Route Attribute
  for Web API that considers Content-Type
tags:
  - .NET
  - ASP.NET
  - REST
  - WebApi
  - Windows
---
[ASP.NET Web API][WebApi] has a really slick routing engine that pretty much "just works" right out of the box. It can automatically configure routing using your method name (i.e. GetStuff = GET, PostStuff = POST, DeleteStuff = PUT, etc.) and when this is insufficient you can easily override the behavior by decorating your methods with [Route][] and [AcceptVerbs][] attributes.

I ran into a situation recently where I wanted even finer-grain control over the routing mechanics. I had a method for updating an object that and I wanted clients to be able to pass it either [JSON][] or [X-WWW-FORM-URLENCODED][] content. Regardless of the input format, the functionality was the same - update the object in the DB and return a JSON representation of the updated object. The challenge here is that Web API's routing has now way to routing based solely on the type of content in the request.

In the past I've solved this problem by switching my function prototype to use [HttpRequestMessage][] as the input parameter. Within the method I would evaluate the [Content-Type][] header and then process it accordingly. In this particular case I had quite a number of methods with this issue, creating a rather gnarly looking set of methods. This method also requires that you handle processing the data manually, bypassing a lot of the built-in features (e.g. [parameter binding][parameter-binding]) that makes Web API such a joy to work with.

{% gist 5dc184b0b0ba91a06035  %}

For a cleaner solution I decided to implement my own version of the Route attribute. It adds a Content-Type parameter that gets evaluated when a request is being routed.  If the request doesn't contain a Content-Type in it's header we default to X-WWW-FORM-URLENCODED . Now I can have a single path (e.g. api/controler/method) that accepts both JSON and X-WWW-FORM-URLENCODED input.

{% gist 5dc184b0b0ba91a06035  %}

Building a customized Route attribute is extremely easy. It essentially consists of 2 classes, one that inherits from RouteFactoryAttribute and one that implements the IHttpRouteConstraint interface. Both classes are quite small and for the sake of simplicity I stuck them into a single file:

{% gist 5dc184b0b0ba91a06035  %}

What we are doing here is adding a Constraint to the standard Route attribute. This evaluates the request's Content-Type and compares it to the method's Content-Type constraint. If they're the same we return True, if they are not we return False. The rest of the magic is handled by Web API for us.

This pattern can be reused to evaluate any parameter in the request, including non-standard headers. A common example of this would be an API-Version header that routes based on the API version the client expects. If can also be used to evaluate multiple parameters (routing based on both API-Version and Content-Type for example).

[Route]: https://msdn.microsoft.com/en-us/library/system.web.mvc.routeattribute(v=vs.118).aspx
[AcceptVerbs]: https://msdn.microsoft.com/en-us/library/system.web.mvc.acceptverbsattribute(v=vs.118).aspx
[HttpRequestMessage]: http://msdn.microsoft.com/en-us/library/system.net.http.httprequestmessage(v=vs.118).aspx
[WebApi]: http://www.asp.net/web-api
[JSON]: http://en.wikipedia.org/wiki/JSON
[X-WWW-FORM-URLENCODED]: http://en.wikipedia.org/wiki/Percent-encoding#The_application.2Fx-www-form-urlencoded_type
[Content-Type]: http://en.wikipedia.org/wiki/MIME#Content-Type
[parameter-binding]: http://blogs.msdn.com/b/jmstall/archive/2012/04/16/how-webapi-does-parameter-binding.aspx
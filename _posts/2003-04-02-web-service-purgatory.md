---
title: Web Service Purgatory
excerpt: ""
tags:
  - SOAP
  - Web Services
  - WebDev
---
Well, I'm out of <a href="http://massivescale.azurewebsites.net/?p=383">Web Service Hell</a>.<a href="http://dotnetweblogs.com/cweyer/">Christian Weyer</a> pointed me in the right direction and I had my first Web Service working pretty quickly.





It turns out that the dataset is only included in the WSDL if it is actually being returned by a function. Simply including it in the project, even if it is used in the code(as mine was), does not mean it will be made visible to the outside world.





This does make some sense as you wouldn't typically want to see a bunch of internal components of the web service unless those components could be used by the client application. Now that I understand this little rule, things are much clearer now. Of course, it would be nice to have had this documented someplace. But hey, where would the adventure be in that?


<p class="MsoNormal" style="margin: 0in 0in 0pt;">
I'm still working though some issues in my head (data collisions and exception handling for example) so I'm not quite in Heaven yet, but I am comfortable in purgatory. :)</p>
<p class="MsoNormal" style="margin: 0in 0in 0pt;">
Thanks again Christian.</p>
---
title: VoiceXML on Speech Server
excerpt: ""
tags:
  - Skype
---
Yesterday I posted about an issue with Speech Server and Vista. One reader named Bill asked a question in the comments. My response was a bit long for a comment so I decided to turn it into a separate post instead. 

<blockquote>
Hey Marc, are you using Microsoft Speech Server with VXML?  If so, what hardware are you using on it?  Also, does MSS support CCXML? <br /><a href="http://weblogs.asp.net/mlafleur/archive/2008/05/20/reinstalling-microsoft-speech-server-on-windows-vista.aspx#6205444" target=_blank mce_href="http://weblogs.asp.net/mlafleur/archive/2008/05/20/reinstalling-microsoft-speech-server-on-windows-vista.aspx#6205444">-Bill</a>
</blockquote>
Yes, I'm using quite a bit of <a href="http://en.wikipedia.org/wiki/VXML" target=_blank mce_href="http://en.wikipedia.org/wiki/VXML">VoiceXML</a>. Most of the applications I work on are written to run against the <a href="http://www.nuance.com/voiceplatform/" target=_blank mce_href="http://www.nuance.com/voiceplatform/">Nuance Voice Platform</a>. I've been using VXML so that I could run them against either platform (or any other platform for that matter). 

There are some issues that I ran into where I was using Nuance specific properties (<a href="http://www.vxml.org/frame.jsp?page=mot_nuanceprops.htm" target=_blank mce_href="http://www.vxml.org/frame.jsp?page=mot_nuanceprops.htm">example</a>) that Microsoft doesn't have VXML equivalents for. In those cases I needed to write them using the Speech Server managed model. 

The key thing to keep in mind is that Microsoft has implemented the VXML spec pretty much verbatim. So as long as your application is pure VXML you should be fine. 

I haven't put Speech Server through any sizing tests so I'm not sure what the hardware requirements will be in the end. That said, my development machine is a DELL D830 with 4GB of RAM running Vista Ultimate. In the lab I'm using a DELL 1950 with 4GB of RAM running Windows Server 2003. In both cases I'm using a <a href="http://www.dialogic.com/products/gateways/DMG2000.htm" target=_blank mce_href="http://www.dialogic.com/products/gateways/DMG2000.htm">Dialogic DMG2000</a> gateway. 

As for <a href="http://en.wikipedia.org/wiki/Call_Control_eXtensible_Markup_Language" target=_blank mce_href="http://en.wikipedia.org/wiki/Call_Control_eXtensible_Markup_Language">CCXML</a>, they don't support it and I don't see that changing. I actually think CCXML is going to go the way of SALT. With only <a href="http://www.voxeo.com/" target=_blank mce_href="http://www.voxeo.com/">Voxeo</a> supporting a real CCXML implementation I don't think there is going to be a lot of call for it. Also, everything you would want to do with CCXML can be done using Speech Server's Managed API. This is just a guess on my part, I don't have any inside knowledge as to what Microsoft's roadmap looks like. 

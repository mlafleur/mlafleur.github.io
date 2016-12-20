---
ID: 383
post_title: Web Service Hell
author: Marc LaFleur
post_date: 2003-04-01 13:38:00
post_excerpt: ""
layout: post
permalink: >
  http://massivescale.com/web-service-hell/
published: true
views:
  - "591"
dsq_thread_id:
  - "3538636566"
---
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>Let me warn you that this posting may be a little incoherent and I apologies for that. You see, my brain is currently lying on the floor next to me. It seems that in a fit of frustration it jumped for it.</FONT></P><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>This week I decided to join the rest of the .<?xml:namespace prefix = st2 ns = "urn:schemas-microsoft-com:office:smarttags" /><st2:stockticker>NET</st2:stockticker> world and try my luck at Web Services. They seemed simply enough. Heck, they even include the world "Simple" in the protocol name! So how much trouble could this cause me anyway? Ugâ€¦.</FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>I installed the TaskVision sample and opened it up. Everything was extremely easy to understand. In fact, I was blown away by how seamless it all fit together. There seemed to be very few "hoop jumps" in their code. </FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>After gaining some confidence from TaskVision, I started a new project. </FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>I added an ASP.<st2:stockticker>NET</st2:stockticker> Web Service and a Windows Application to consume it. I quickly went about adding a Dataset to the Web Service project and added some code to return that dataset to the client. There was nothing special about it, just a "SELECT * FROM customer" against Northwind. I tested the Web Services via the integrated test web page thingy (very nice btw) and got back all my Northwind customers. </FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>Soon after this, my brain took the suicidal leap.</FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>Now that I have this lovely Web Service, I made a Web Reference to it from my client application. But something strange happened. While the class that returns the dataset was there, the dataset itself was not. I took another look at TaskVision and found that they were available in their Web Service. So what was going on here? Why can't I access the dataset?</FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>I've now been Googleing for 3 days and have found nothing on this. So either I'm an idiot (very possible, even probable) or I'm trying to do something abnormal here (also very possible). </FONT></P><o:p><FONT face=Arial>&nbsp;</FONT></o:p> 
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face=Arial>Anyone want to help me get my brain back into my head?</FONT></P>
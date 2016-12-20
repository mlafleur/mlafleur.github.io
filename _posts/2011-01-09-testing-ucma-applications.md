---
Title: Testing UCMA Applications
Published: 2011-01-09 14:46:37
Excerpt: ""
sbg_selected_sidebar:
  - 'a:1:{i:0;s:66:"a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}";}'
sbg_selected_sidebar_replacement:
  - 'a:1:{i:0;s:66:"a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}";}'
views:
  - 'a:1:{i:0;s:3:"510";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3827500663";}'
author:
  - Marc LaFleur
post_date:
  - 2011-01-09 14:46:37
post_excerpt:
  - ""
permalink:
  - /testing-ucma-applications/
---
One of the first things you notice when you start developing UCMA is the lack of an integrated SIP Phone for testing your applications. Speech Server made it trivial to test out your application, simply press F5 and everything was ready to go. UCMA lacks the integrated environment so you'll need a software phone of some kind to try out your app.

I have been using one called PhonerLite for years. It is freely downloadable from <a title="http://www.phonerlite.de/index_en.htm" href="http://www.phonerlite.de/index_en.htm">http://www.phonerlite.de/index_en.htm</a> and works like a charm. The key reasons I like it is that it supports UDP/TCP/TLS is extremely simply to use and has a build-in debugger that shows you the SIP messaging (something that is extremely useful when your application simply doesn't answer your call).

I would recommend going with the beta version (currently 1.85) at <a title="http://www.phoner.de/PhonerLiteBeta.zip" href="http://www.phoner.de/PhonerLiteBeta.zip">http://www.phoner.de/PhonerLiteBeta.zip</a>. Unzip it someplace and run the PhonerLite executable.

<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_4F134C1B.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_41CCC308.png" border="0" alt="image" width="244" height="227" /></a>
Select "manual configuration"

<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_603703F1.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_69AFC267.png" border="0" alt="image" width="244" height="227" /></a>
Give yourself a user name (I always use "1234")

<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_56FAC8B0.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_54DDC9E7.png" border="0" alt="image" width="244" height="227" /></a>
<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_4C79F490.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_5C398994.png" border="0" alt="image" width="244" height="227" /></a>
Take the defaults for the next two screens

<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_2F4426B9.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_2D2727F0.png" border="0" alt="image" width="244" height="226" /></a>
Select the "Configuration" tab and then the "Network" sub-tab

<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_64210629.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_372BA34E.png" border="0" alt="image" width="244" height="226" /></a>
Change your Port to something unused and your connection type to TCP

<a href="http://gotspeech.net/blogs/speakingfromtheedge/image_47C39E3C.png"><img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image" src="http://gotspeech.net/blogs/speakingfromtheedge/image_thumb_78E2D8DC.png" border="0" alt="image" width="244" height="226" /></a>
Enter the SIP address for your app in the "Destination name" field and click the green phone icon and you're off.

<img src="http://gotspeech.net/aggbug.aspx?PostID=11182" alt="" width="1" height="1" />
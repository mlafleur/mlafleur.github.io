---
Title: Bing Maps SDK
Published: 2013-01-03 12:45:54
Excerpt: "I've been playing around with the Bing Maps SDK over the holidays and ran into a gotcha with x64 compatibility. "
Tags:
  - Bing Maps
  - Windows
views:
  - 'a:1:{i:0;s:3:"478";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3539804843";}'
author:
  - Marc LaFleur
post_date:
  - 2013-01-03 12:45:54
post_excerpt:
  - "I've been playing around with the Bing Maps SDK over the holidays and ran into a gotcha with x64 compatibility. "
permalink:
  - /bing-maps-sdk/
---
I've been playing around with the<a href="http://msdn.microsoft.com/en-us/library/hh846481.aspx" target="_blank"> Bing Maps SDK</a> over the holidays. The documentation includes a step-by-step guide for <a href="http://msdn.microsoft.com/en-us/library/hh855146.aspx" target="_blank">adding Bing Maps to my app </a>that got me up and running. I had to make some small changes like targeting specific CPU and not the default 'Any CPU' target and (since this app is written in C#) I had to add a reference to the Microsoft Visual C++ Runtime Package in addition to the Bing Maps SDK.

Once I had the project configured I dropped the Map control on to my page, wired up the location data I wanted to display and smashed the F5 key. Up popped my app and my fancy-pants little map.

<img class="alignright  wp-image-1141" alt="App Shot" src="http://massivescale.azurewebsites.net/wp-content/uploads/2012/12/screenshot_11162012_005635-768x432.png" width="461" height="259" />

I tested my app on a couple of Windows 8 machines I have here as well as a Microsoft Surface. Everywhere I looked, fancy-pants maps appeared.  After some functional testing (and annoying everyone in the house with "hey look, a map! Isn't that cool?!?!") I declared success and submitted my app to the Windows Store.

With my store validation testing in process I sat back for a cup of eggnog and cookies in preparation of my anal New Years resolution to no longer consume eggnog and cookies. Life was good, life was easy and look, I've got mail!

Since I'm bothering to write this up you can safely assume my email was not congratulatory. Nope, it was a failure. My app it seemed crashed at start-up. Odd, wonder what would have caused that. So putting down the eggnog and cookies I started sorting of what could have went wrong (okay, I had already finished the eggnog and I took the cookies with me).

The only thing I could see as a potential problem was some error handling around some REST calls I was making. My app is really simple, it pulls a feed from the Massachusetts Department of Transportation and shows the wait times of the various Registry of Motor Vehicles (I know, you've been waiting for such an app!). I didn't have a "catch-all" around this code so it was possible that the feed returned something unexpected and the app errored out. I slapped myself for sloppy error handling and resubmitted the app.

With my store validation testing in process again I sat back for another cup of eggnog and a few more cookies (if I'm being honest, it may have been my 3rd cup...). Life was good again, life was easy again -- and look - I've got more mail!

With my latest failure in hand I decided it was time to do some more in-depth testing. I tried the app without an internet connection, I tested with incorrect URIs, I even set up my own server that returned various HTTP errors... everything seemed to be working fine. Then I tried debug builds, release builds and even some subtle variations of those build types. Still, everything seemed to be working fine.

Then I each CPU target and found the source of my problem. When I targeted x64 in the debugger I got "Cannot create instance of type 'Bing.Maps.Map'". When I tried it outside of the debugger I got the insta-crash that the validation had returned.

So a word of caution, if you're going to leverage Bing Maps make sure you target only x86 and ARM CPUs at this time. This shouldn't be a major concern for most apps but it is something to keep in mind while enjoying your 4th glass of eggnog.
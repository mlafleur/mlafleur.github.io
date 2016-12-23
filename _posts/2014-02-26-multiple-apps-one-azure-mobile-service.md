---
Title: Multiple Apps, One Azure Mobile Service
Excerpt: |
  Multiple Windows 8 apps, can they share the same Azure Mobile Services backend? This was the question I was looking to answer this week. I did the prerequisite search of the interwebs and found that this question has been floating around for a while now. What I didn’t find was a definitive answer. Let’s start off by solving that problem.
Tags:
  - Azure
  - Azure Mobile Services
  - Windows
---
“Multiple Windows 8 apps, can they share the same Azure Mobile Services backend?”

This was the question I was looking to answer this week. I did the prerequisite search of the interwebs and found that this question has been floating around for a while now. What I didn’t find was a definitive answer. Let’s start off by solving that problem:
<p style="text-align: center;font-size: 36px"><strong>YES</strong></p>
Okay, with that out of the way I need to add a bit of a caveat:
<p style="text-align: center;font-size: 36px"><strong>MOSTLY</strong></p>
<p style="text-align: left">Let me explain</p>

<h1>Yes…Mostly?</h1>
There are multiple scenarios that someone might use Azure Mobile Services. In almost every scenario the answer is yes. For few cases however the answer is “mostly yes”. And even then, only if you have more than one Windows Store App trying to access the same backend service.

The “mostly” has to do with <strong>Push Notifications</strong> to Windows Store Apps. The reason Windows Store Apps are problematic has to do with the App Package Security Identifier (SID) .  Every Windows Store App has a unique SID which ensures that one app cannot masquerade as someone else.   The problem is that Azure Mobile Services only accepts a single SID. Therefore we need multiple services to speak to multiple SIDs. Although to be fair, we only need a basic service that holds the SID and a Client Secret but more on this in a minute.

And again - cannot reiterate this enough – this only applies to scenarios where you have multiple Windows Store Apps sharing the same Azure Mobile Service. This does not apply if you have 1 Windows Store App and 450,122 apps on WP8, iOS and Android. If the later is you then you, then you only need 1 service to rule them all.
<h2>Assumption / Disclaimer</h2>
There is a second “mostly” scenario  with Single Sign-on. This is a feature that is only supported by Windows Store Apps using the Microsoft Account Provider. Since most users have already provided their Microsoft Account to Windows 8, this feature allows you to leverage that identity to automatically sign them on.

Working around this issue gets into dealing with multiple authentication services and joining them together behind the scenes. This gets into some snarly stuff around virtual tables and scripting.  I am not going to cover that here since it is worthy of it's own post (it is complex, it could be multiple posts). Surface to say, I’m going to assume here that you don’t need single sign-on in this article. If you’re really interested I suggest starting with <a href="http://blogs.msdn.com/b/jpsanders/" target="_blank">Jeff Sanders’ blog</a>. In particular I’d look at <a href="http://blogs.msdn.com/b/jpsanders/archive/2013/06/12/using-virtual-tables-for-different-views-windows-azure-mobile-services.aspx" target="_blank">Using Virtual Tables for Different Views</a>.
<h2>I Get It, But I Still Need It, So How</h2>
Okay, so you actually have multiple Windows Store Apps that need to use a common backend store and need Push Notifications? Perfect, we can do that.

The trick here is to understand that all you need to send a notification is an App, an Azure Mobile Service with said Apps SID and a Channel ID to the Device. Typically this is all self contained in a single Azure Mobile Service, but that isn’t a requirement.  Let’s take a look at a typical registration for a Windows Store App:

https://gist.github.com/mlafleur/bd034f3ff5e011b027d1

There isn’t anything too complex here. You generate a Channel ID and Install ID and stick them into a table in Azure.

For sending a notification I recommend taking a look at <a href="http://msdn.microsoft.com/en-us/library/windows/apps/hh868252.aspx" target="_blank">Quickstart: Sending a push notification</a> since there is a lot of plumbing code involved. For our purposes right now we don’t care about the plumbing, only how we call into it. Assuming you implemented PostToWns from the Quickstart, you call into it like this:

https://gist.github.com/mlafleur/2d3e8edd25bbb167a736

Again, nothing to complete here. You pass in the Client Secret from the Azure Mobile Service, the Security Identified from the Windows Store App and the Channel ID you registered for the Device. Two of those you know before hand, Channel ID you pull from the table.

This is the architecture for the typical self-contained solution:

<img style="float: none;margin-left: auto;margin-right: auto;border-width: 0px" title="aaaasd" src="http://massivescale.blob.core.windows.net/blogmedia/2014/02/aaaasd.jpg" alt="aaaasd" width="424" height="116" border="0" />

For our implementation however we’re going to change things up. We’re going to have a “parent” Azure Mobile Service and multiple “child” azure Mobile Services. This children will have only a Client Secret and SID for the associated app. They will not have a channels table, that will instead be stored centrally in the parent service. This architecture will look like this:

<img style="float: none;margin-left: auto;margin-right: auto;border-width: 0px" title="image" src="http://massivescale.blob.core.windows.net/blogmedia/2014/02/image.png" alt="image" width="391" height="348" border="0" />

Notice that we have a 1:1 relationship between each App and a Child Service but still maintain the 1:n relationship between the Apps and our parent service. We can not share data between platforms using a single Azure Mobile Service while still supporting Push Notifications.

To create this you create a standard Azure Mobile Service and add a channels table to hold the channel registrations. Each app will call into this parent service (per the code above) and insert their channel registration.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/02/channelstabel.jpg"><img style="float: none;margin-left: auto;margin-right: auto;border: 0px" title="channels-tabel" src="http://massivescale.blob.core.windows.net/blogmedia/2014/02/channelstabel_thumb.jpg" alt="channels-tabel" width="640" height="309" border="0" /></a>

You then create a <em>separate</em> Azure Mobile Service but you add nothing to it. Instead you simply select the Push section from the configuration page and manually enter the Client Secret and SID from Live Connect (just as explained in the Quickstart).

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/02/pushconfig.jpg"><img style="float: none;margin-left: auto;margin-right: auto;border: 0px" title="push-config" src="http://massivescale.blob.core.windows.net/blogmedia/2014/02/pushconfig_thumb.jpg" alt="push-config" width="640" height="449" border="0" /></a>

In a future post I’ll cover implementing this architecture with <a href="http://massivescale.azurewebsites.net/tag/rmv-awesome/" target="_blank">RMV Awesome</a> for those who would like to see it in action.

Special thanks to <a href="http://social.msdn.microsoft.com/profile/jeff%20%20sanders/" target="_blank">Jeff Sanders</a> who let me interrupt his morning and bounce my architecture off him.
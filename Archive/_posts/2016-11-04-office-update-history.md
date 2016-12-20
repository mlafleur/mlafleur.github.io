---
ID: 8731
post_title: Office Update History
author: Marc LaFleur
post_date: 2016-11-04 11:16:25
post_excerpt: |
  With Office's monthly release cadence, there are a log of versions floating out in the field. Understanding how "old" a given buid is can be extremely helpful in tracking down unexpected add-in behavior. Thankfully there are some resources available.
layout: post
permalink: >
  http://massivescale.com/office-update-history/
published: true
dsq_thread_id:
  - "5306472858"
---
I had an issue come up recently with a developer reporting that their Office Add-in wasn't working properly in Outlook 2013. They had defined a number of <a href="https://dev.office.com/docs/add-ins/outlook/add-in-commands-for-outlook">Add-in Commands</a> but one user was reporting that they weren't showing up in their ribbon. After a little bit of digging, we uncovered the root cause was an unpatched version of Outlook. This feature was introduced in the December 2015 patch but the customer was still running the original GA build from 2012. The fix was simply to update Office 2013 to the most recent build.

With Office's monthly release cadence, there are a number of versions potentially running in the field. Understanding how "old" a given build is can be extremely helpful in tracking down unexpected add-in behavior. Thankfully there are some resources available:
<ul>
 	<li><a href="https://technet.microsoft.com/en-us/office/mt465751">Office 2016 Releases</a></li>
 	<li><a href="https://support.office.com/en-us/article/Update-history-for-Office-2013-19214f38-85b7-4734-b2f8-a6a598bb0117?ui=en-US&amp;rs=en-US&amp;ad=US&amp;fromAR=1">Update history for Office 2013</a></li>
</ul>
You'll note that Office 2016 versioning is a bit more complex than 2013. This is due to the different <a href="https://technet.microsoft.com/library/mt455210.aspx">release channels</a> that a given account may be getting updates from.
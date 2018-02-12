---
title: Office Update History
excerpt: >
  With Office's monthly release cadence, there are a log of versions floating out in the field. Understanding how "old" a given build is can be extremely helpful in tracking down unexpected add-in behavior. Thankfully there are some resources available.
subtitle: Some resources to help you sort out which Office builds are current
tags:
  - Office
---

I had an issue come up recently with a developer reporting that their Office Add-in wasn't working properly in Outlook 2013. They had defined a number of Add-in Commands but one user was reporting that they weren't showing up in their ribbon. After a little bit of digging, we uncovered the root cause was an unpatched version of Outlook. This feature was introduced in the December 2015 patch but the customer was still running the original GA build from 2012. The fix was simply to update Office 2013 to the most recent build.

With Office's monthly release cadence, there are a log of versions floating out in the field. Understanding how "old" a given build is can be extremely helpful in tracking down unexpected add-in behavior. Thankfully there are some resources available:

* [Office 2016 Releases](https://technet.microsoft.com/en-us/office/mt465751)
* [Update history for Office 2013](https://support.office.com/en-us/article/Update-history-for-Office-2013-19214f38-85b7-4734-b2f8-a6a598bb0117?ui=en-US&rs=en-US&ad=US&fromAR=1)

You'll notice that Office 2016 is a bit more complicated than 2013. This stems from the various "release channels" that a user may be pulling from. These work similar to Windows 10's "rings" used by Windows Insider: Current (mainstream), First (slow ring), Insider (fast ring).

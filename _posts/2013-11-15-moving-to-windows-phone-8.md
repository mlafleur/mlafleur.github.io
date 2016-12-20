---
Title: Moving to Windows Phone 8
Published: 2013-11-15 09:43:16
Excerpt: >
  Part of a series covering Windows Client
  development, we continue to work on RMV
  Awesome – an ironically named Modern
  UI application for keeping tabs on the
  Massachusetts Registry of Motor
  Vehicles. In this article we’ll bring
  our awesomeness to Windows Phone 8
panels_data:
  - 'a:1:{i:0;s:6:"a:0:{}";}'
views:
  - 'a:1:{i:0;s:3:"258";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3565610959";}'
author:
  - Marc LaFleur
post_date:
  - 2013-11-15 09:43:16
post_excerpt:
  - >
    Part of a series covering Windows Client
    development, we continue to work on RMV
    Awesome – an ironically named Modern
    UI application for keeping tabs on the
    Massachusetts Registry of Motor
    Vehicles. In this article we’ll bring
    our awesomeness to Windows Phone 8
permalink:
  - /moving-to-windows-phone-8/
---
<span style="font-size: 8pt;">NOTE: This is part of a series covering Windows Client development. Our sample application is RMV Awesome, an awesomely named Modern UI application for keeping tabs on the Massachusetts Registry of Motor Vehicles wait times. In this article we'll bring our sample application to Windows Phone 8.
</span>

<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/12/120513_0509_MovingtoWin1.png" align="right" />Although both Windows and Windows Phone share a large number of concepts and components, they are still <a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj681690(v=vs.105).aspx">distinct platforms</a>. There are a number of subtle (and sometimes not-so-subtle) differences in how each platform implements and exposes these concepts. With this in mind, we leverage PCL as a way to share code between both platforms.

In essence the underlying data and communications models for our application will be shared between Windows 8.1 and Windows Phone 8 while the rendering of the user experience will be platform specific. All of this isn't to suggest that we can't reuse some of the same XAML in both implementations, we're just limited to more of a <a href="http://sourcemaking.com/antipatterns/cut-and-paste-programming">cut-and-paste reuse</a> model.

<strong>Separate Solutions, Shared Projects
</strong>

I initially thought it would be great to have everything in a single solution so that I could easily switch between projects. This turned out to be a real pain in the back side to manage since by default it caused both the Windows 8 and Windows Phone 8 emulators to launch at debug (a somewhat slow process and a bit overwhelming for my 1st gen Surface Pro with only 4GB RAM). I was able to solve this by customizing the build configurations but once I tried to document the process for this post it became clear it was unreasonably complex. You can certainly do it and it does work fine but I don't think it is worth the effort.

<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/12/121213_1612_MovingtoWin1.png" />

What I decided to do instead was use two solutions, both containing a reference to the PCL project. In the past this wasn't possible due to each project being tied to a single solution. Recent versions of Visual Studio no longer have this limitation however and it makes it extremely easy to share my library between my projects.

I created a new Windows Phone 8 project in the same source tree as my existing solution. I then added my existing PCL project and referenced it exactly the same way as I had in my original Windows 8.1 app.

<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/12/120513_0509_MovingtoWin4.png" />

<strong>Building It Out
</strong>

With my core library ready to roll, I turned my attention to the user experience. RMV Awesome is a master-detail application with two pages, one list the available branches and the child page that gives a bit more detail about an individual branch. In the phone app I created two pages; MainPage (the list of branches and our opening page) and BranchPage (I'll let you guess that this displays). In both case the XAML is bound to the same ViewModel we used for Windows 8. Of course the usage pattern on Windows Phone is different than Windows 8 (vertical vs horizontal layout for example) but the workflow and data sets are exactly the same providing for 100% reuse of the ViewModel. In more a complex app we'd likely use inheritance to share common ViewModel aspect while allowing for differences in implementation but since this is such a simple application we can use them as is.

MainPage consists of a single ListBox showing each branch:

https://gist.github.com/mlafleur/b4d96ff38f776d39bcd5

For the branch page we show some details about the branch:

https://gist.github.com/mlafleur/b7f779307cf4ded0a6b4

With these pages complete we have a working application which I then submitted to the store.
[appbox windowsphone 1168fc23-9fa2-4604-b5f1-808157df5cd6]

The code is available on GitHub at <a href="https://github.com/mlafleur/RMVAwsome/releases/tag/T3">https://github.com/mlafleur/RMVAwsome/releases/tag/T3</a> or follow the live development at <a href="https://github.com/mlafleur/RMVAwsome" target="_blank">https://github.com/mlafleur/RMVAwsome</a>
---
title: Settings Charm
excerpt: ""
tags:
  - Charms
  - Settings
  - Windows
---
One of the nice things about Windows 8 for developers adoption of some clearly defined (and long needed) <a href="http://msdn.microsoft.com/en-us/library/windows/apps/hh779072.aspx" target="_blank">user experience standards</a>. While in the past we relied on conventions (Help -&gt; About for example) those conventions were not always followed and often didn't make a lot of sense (Help -&gt; About for example). A great example of these UX standards are the Charms. Here we'll take a look at the Charm you're most likely to encounter; the <a href="http://msdn.microsoft.com/en-us/library/windows/apps/Hh770544.aspx" target="_blank">Settings Charm</a>.

Why is the Settings Charm the most likely you'll encounter? The simple answer is your "Privacy Policy"; a required component for adding an app to the Windows Store. You can read about the requirements <a href="http://msdn.microsoft.com/en-us/library/windows/apps/hh694083.aspx" target="_blank">here</a>. One common method for adding a Privacy Policy to your app is to simply open a link to one on your web site. You can of course embedded it in your application but that requires a bit more work than is necessary for most apps.

Before we get into the code, a caveat. There are a number of ways to use the Settings Charm and you'll see some rather complex examples out there. I'm not going to attempt to go that deep here. My assumption here is that you're looking to add some simple commands (such as the aforementioned Privacy Policy) that are scoped to the entire app. I may go into more complex examples in another post but not this time.

The first time I worked with the Settings Charm it took a minute to figure out what was going on. Unlike the App Bar which you add to your app, you register against a Settings Charm event.  It can seem a bit backwards until you realize that the Settings Charm being an part of Windows itself and therefore exists outside your application. Rather than creating the Settings Pane in your app you instead inject your commands into the existing Settings Pane.

The first step of this process is to register against the CommandsRequested event of the current Settings Pane like this:

{% gist 5dc184b0b0ba91a06035  %}

Dissecting that line of code shows that we first grab the existing Settings Pane for our application that Windows created for us and register the SettingsPane_CommandsRequested method to the CommandsRequested event. One thing we need to be careful of however is registering against this event more than once.

To solve that we'll use a simple Boolean to determine if we've registered this already:

{% gist 5dc184b0b0ba91a06035  %}

Because we want to show these commands on every page of our application we’ll add this even to the OnLaunched event of our App.xaml.cs file.

Next we need to add our commands when the application requests them:

{% gist 5dc184b0b0ba91a06035  %}

Finally we act on those commands being selected:

{% gist 5dc184b0b0ba91a06035  %}

As you can see, it is pretty simple to wire this up. In an upcoming post I'll cover adding more complex UI elements such as toggle boxes to the Settings Charm.

<a href="/assets/wp/2012/11/SettingsPaneExample_2012-11-19-00-27-49Z1.zip">Settings Pane Example</a>
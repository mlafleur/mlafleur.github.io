---
Title: Seting Up Settings
Excerpt: "Windows 8.1 introduces a new control for XAML, the SettingsFlyout. Most examples on using this new control assume you're defining your Settings at the page level. Here we outline a model for doing this scoped to the Application leveraging SettingsFlyout , User Controls in C# /XAML. It is incredibly easy to implement. "
Tags:
  - Controls
  - Windows
---
Last fall I wrote about the <a title="Settings Charm" href="http://massivescale.azurewebsites.net/settings-charm/" target="_blank">Settings Charm</a> and how to leverage it for Privacy Policy. That post is still completely relevant today but I want to update the examples to leverage the new Settings Flyout control in Windows 8.1.

<strong>SettingsFlyout</strong>

Windows 8.1 introduces a new control for XAML, the <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.settingsflyout.aspx" target="_blank">SettingsFlyout</a>. Previously this control had only been available for <a href="http://msdn.microsoft.com/en-us/library/windows/apps/Hh701253.aspx" target="_blank">JavaScript </a>apps or as a 3rd party component. It provides a convenient way for creating app settings flyouts in your app that comply with the proper design guidelines and behaviors of Windows 8.1.

A SettingsFlyout has both a header section and a content section. The header contains the back button, title, and an optional <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.settingsflyout.iconsource.aspx" target="_blank">icon</a>. You can set the header's <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.settingsflyout.headerbackground.aspx" target="_blank">background </a>and <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.settingsflyout.headerforeground.aspx" target="_blank">foreground</a> to match the color scheme of your app. The flyout will always be full height but you can control the <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.frameworkelement.width.aspx" target="_blank">width </a>when displayed.

<strong>Using SettingsFlyout</strong>

There is an <a href="http://msdn.microsoft.com/en-us/library/windows/apps/bg182878.aspx#SettingsFlyout" target="_blank">example </a>for using the flyout control that were published with it's introduction at //Build but this example assumes you're defining the settings pane at the page level. While there are a number of reasons why you might want to scope your settings to the page, the vast majority of developers want them scoped to the application. I'm going to outline a model for doing just this that leverages User Controls to define the UX and functionality.

User Controls give you a clean separation of concerns when it comes to your settings. When you are working within the scope of the page your flyout's code and bindings get intermingled with your page's code which, depending on the complexity of the page, can be a bear to keep straight. Extracting the flyout to a user control allows you to define it's functionality in isolation.

<strong>Building the User Control</strong>

First things first, we need a User Control to display our content. To do this I simply went to <strong>Project -&gt; Add</strong> <strong>Item</strong> and selected <strong>User Control</strong> from the menu. In my example I'm calling this control FlyoutSample. Within this control I used the following XAML:

{% gist 5dc184b0b0ba91a06035  %}

Because this is a standard user control, you can layer in as much functionality as you wish including bindings and other controls. In a couple of cases I've even gone so far as to build complete view models for a flyout because there was both data binding and business logic that needed to be applied.

<strong></strong><strong>Connecting the Dots</strong>

Once we have our controls build, we need to wire them up to the SettingsPane. This is done within App.xaml.cs during the OnLaunched event by declaring a handler for CommandsRequested. Within that handler I'll wire up each of the Commands I want to display on the SettingsPane as well as the code to handle it being selected. In my <a title="Settings Charm" href="http://massivescale.azurewebsites.net/settings-charm/" target="_blank">previous post</a> I used multiple handlers to achieve this, but I find the inline handling of the events makes for a cleaner implementation.

In my example I'm adding both our new UserControl as well as a URI to a website (a very common way to handle the privacy policy requirement).

{% gist 5dc184b0b0ba91a06035  %}

<a href="/assets/wp/2013/10/SettingsFlyoutExample_2013-10-17-08-36-18Z.zip">Download Sample Code</a>
---
Title: Awesome Android with Xamarin
Published: 2014-03-26 00:35:34
Excerpt: "I've been publicly developing an application I call RMV Awesome on this blog over the last few months. Since the initial release of the Windows 8.1 app we've migrated code to a Portable Class Library, ported to Windows Phone 8, added monetization, integrated Azure Mobile Services and tackled geo-location. Today we’ll take a look at bringing this awesomeness over Android using Xamarin."
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3540575642";}'
author:
  - Marc LaFleur
post_date:
  - 2014-03-26 00:35:34
post_excerpt:
  - "I've been publicly developing an application I call RMV Awesome on this blog over the last few months. Since the initial release of the Windows 8.1 app we've migrated code to a Portable Class Library, ported to Windows Phone 8, added monetization, integrated Azure Mobile Services and tackled geo-location. Today we’ll take a look at bringing this awesomeness over Android using Xamarin."
permalink:
  - /awesome-android-with-xamarin/
---
I’ve been publicly developing an application I call RMV Awesome on this blog over the last few months. Since the <a href="http://massivescale.azurewebsites.net/rmv-awesome/" target="_blank">initial release</a> of the Windows 8.1 app we’ve <a href="http://massivescale.azurewebsites.net/leveraging-portable-class-libraries/" target="_blank">migrated code to a Portable Class Library</a>, <a href="http://massivescale.azurewebsites.net/moving-to-windows-phone-8/" target="_blank">ported to Windows Phone 8</a>, <a href="http://massivescale.azurewebsites.net/monetizing-rmv-awesome/" target="_blank">added monetization</a>, <a title="Awesome Azure Mobile Services" href="http://massivescale.azurewebsites.net/awesome-azure-mobile-services/" target="_blank">integrated Azure Mobile Services</a> and <a href="http://massivescale.azurewebsites.net/?p=1711" target="_blank">tackled geo-location</a>. Today we’ll take a look at bringing this awesomeness over Android using <a href="http://xamarin.com/" target="_blank">Xamarin</a>.

<strong>The Worlds Most Simplistic Xamarin Overview</strong>

Xamarin has deep roots within the C# and .NET community. They are the same folks behind Mono, the Linux implementation of C# and .NET. Over the years they have established themselves as… Look, I could come up with some flowery language here but I’d rather skip all that that.  Just know that these these guys are brilliant; as in brilliant enough to risk one’s eyesight if you stare too long. They were founded by <a href="http://en.wikipedia.org/wiki/Nat_Friedman" target="_blank">Nat Friedman</a> and <a href="http://en.wikipedia.org/wiki/Miguel_de_Icaza" target="_blank">Miguel de Icaza</a>. These are the same guys who founded GNOME. Heck, <a href="http://www.eweek.com/c/a/Windows/The-Microsoft-Channel/" target="_blank">Miguel was once serenaded</a> by <a href="http://en.wikipedia.org/wiki/Don_Box" target="_blank">Don Box</a> for goodness sake. They rock, end of story.

Xamarin provides a C# implementation for Android and iOS. It fully integrates with Visual Studio (although they do have an excellent cross-platform IDE as well).  Through this integration you can do some wonderful things such as have a single solution that targets Windows, Windows Phone, Android and iOS (note that iOS does require a Mac on the network to handle compilation due to Apple’s restrictions).

One should not confuse Xamarin with most of the other cross-platform solutions out there. Xamarin is unique in that it produces a truly native app using fully native UI. It does this by separating the UX implementations while sharing the remaining layers via Portable Class Libraries. One way to think about this is in terms of an MVC architecture; the Model and Controller live within a PCL and are shared across your apps while the View is implemented using native UI. This takes a little more effort than the “Build Once, Run Everywhere” model  but the gains are almost always worth the effort. This model results in native applications that perform, look and function exactly as the user would expect for that platform.

<strong>Spinning Up Our Project</strong>

First things first, you need to head over to Xamarin and download an <a href="http://xamarin.com/download" target="_blank">30-day evaluation copy</a>. If you’ve got an MSDN subscription then you’re extra lucky, <a href="http://xamarin.com/msdn" target="_blank">you get 90 days and a massive discount</a> (30-50%, depending on edition).  Once you’ve downloaded and installed Xamarin you’ll find new project types available within Visual Studio.

I’m going to add am Android Application called RMV.Awesome.Droid to my solution. Please note that I’m <em>not </em>calling it <em>“</em>Android”. Please don’t make the mistake I made the first time and do so, it conflicts with the default Android namespace and all sorts of oddities ensure.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/03/xamarin_android_create.png"><img style="float: none; margin-left: auto; display: block; margin-right: auto; border-width: 0px;" title="xamarin_android_create" src="http://massivescale.blob.core.windows.net/blogmedia/2014/03/xamarin_android_create_thumb.png" alt="xamarin_android_create" width="640" height="445" border="0" /></a>

As you can see, we now have an Android application in Visual Studio living right along side our existing Windows 8 app, Windows Phone 8 app and our Portable Class Library.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/03/xamarin_android_project.png"><img style="float: none; margin-left: auto; display: block; margin-right: auto; border-width: 0px;" title="xamarin_android_project" src="http://massivescale.blob.core.windows.net/blogmedia/2014/03/xamarin_android_project_thumb.png" alt="xamarin_android_project" width="398" height="334" border="0" /></a>

<strong>Building Our App </strong>

Thanks to our previous work <a href="http://massivescale.azurewebsites.net/leveraging-portable-class-libraries/" target="_blank">migrating the meat of our app to a PCL</a>, all of the heavy lifting of our data is already done.  Even the work we did leveraging <a href="http://massivescale.azurewebsites.net/?p=1687" target="_blank">Azure Mobile Services</a> comes along for the ride. This leaves us with adding only some references and the user interface.

The first thing we need to do is add a Project Reference to our existing PCL. This gives us our view models, object models and utility functions.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot6.png"><img style="float: none; margin-left: auto; display: block; margin-right: auto; border-width: 0px;" title="Screenshot (6)" src="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot6_thumb.png" alt="Screenshot (6)" width="640" height="425" border="0" /></a>

Next we need to add the Azure Mobile Services component. Components are add-ins for Xamarin, very similar to Nuget. To add the Azure Mobile Services component, we expand the Android project and right click on the Components folder. From here we select “Get New Components” and add the “Azure Mobile Services” component.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot7.png"><img style="float: none; margin-left: auto; display: block; margin-right: auto; border-width: 0px;" title="Screenshot (7)" src="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot7_thumb.png" alt="Screenshot (7)" width="640" height="408" border="0" /></a>

Now we have all of the foundational pieces in place and can begin building our UI. This experience is eerily similar to XAML development and yet frustratingly different. Android uses XML to declare it’s UI layout and if you’ve spent time with XAML you’ll feel right at home. That said, you’ll likely also find it frustrating how incomplete it feels compared to XAML, especially when it comes to data binding (or the complete lack there of).

<strong>Resources &amp; Activities</strong>

The development experience is a lot more bare-bones than XAML. Unlike XAML there is no data binding or code-behind. Instead, everything is broken out into Resources and Activities (among others). Activities are your execution code, Resources are your layouts, templates, strings, etc.

For our application we’re going to have 2 Activities (MainActivity and BranchDetail). These align with the MainPage and BranchPage from our WP8 app. Each of these Activities will have an associated Layout. We’re also going to add two classes for binding our list of branches (BranchListAdapter) and for downloading the images (Images).

<strong>Main Layout</strong>

We’ll start off with our layout for the MainActivity. This will consist of a TextView to hold our page title, a ProgressBar to <del>alter</del> alert the user that we’re fetching information and a GridView that displays a list of branches.

<strong><a href="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot9.png"><img style="float: none; margin-left: auto; display: block; margin-right: auto; border-width: 0px;" title="Screenshot (9)" src="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot9_thumb.png" alt="Screenshot (9)" width="161" height="240" border="0" /></a></strong>

You’ll notice that the screen shot here doesn’t include of any sample data. As I mentioned previously, data binding isn’t included here. Layouts are just XML documents and there is little to no design time functionality. To understand what you’re going to see it is sometimes easier to simply look at the raw XML:

https://gist.github.com/mlafleur/f25a6e983f33e5ebdb67

Notice that there is not item template associated with the GridView. Instead of declaring this in-line, the template will be applied by our custom adapter (more on that in a minute).  We’ll define that template in a separate layout called BranchItem.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot10.png"><img style="float: none; margin-left: auto; display: block; margin-right: auto; border-width: 0px;" title="Screenshot (10)" src="http://massivescale.blob.core.windows.net/blogmedia/2014/03/Screenshot10_thumb.png" alt="Screenshot (10)" width="240" height="78" border="0" /></a>

https://gist.github.com/mlafleur/edc059c40548236b1fb9

<strong>Main Activity</strong>

Now that we have the layouts we need, it is time to write some actual code. Opening MainActivity.cs you’ll find some friendly C# code. Thanks to our PCL (and the fact that our app isn’t exactly complicated) we’re going to have a pretty simple implementation here. I’m going to reference our ViewModel from the PCL for most of the work. The only difference here is that we need to handle the binding and updating ourselves.

First we’ll  reference our ViewModel and stub out what we need in OnCreate:

https://gist.github.com/mlafleur/3263a93e5a3995475cc3

<strong>List Adapter</strong>

In order to populate our GridView we need to create a custom List Adapter. This is a class that inherits from the BaseAdapter class and overrides some select methods. We will then instantiate this adapter in our Main Activity and assign it to the GridView in our layout.

https://gist.github.com/mlafleur/3dcf11dd5c6fa9a12390

With this in place we can flesh out our Main Activity a bit more:

https://gist.github.com/mlafleur/18bf870134dc03b9aa63

If we run the application now you’ll find that we’ve got a functional list of branches with one exception, there are no branch images. This is because, unlike XAML, you cannot reference an external URI from your layout. We need to download them into local storage first and then update the List Adapter.

<strong>Images</strong>

To download the images, I created a static method. It takes in the external URI, downloads the image and updates the ImagePath to point at the local file.

https://gist.github.com/mlafleur/72189a854b4d03560f2f

I then kick off a separate thread within our Main Activity to download these images in the background. Once complete it notifies the List Adapter that the items have updated.

https://gist.github.com/mlafleur/21d0334527ba3b3e244b

<strong>Branch Details</strong>

For the detail page, I added a new Activity and Layout for BranchDetail. Just like MainActivity, it references the ViewModel in our PCL. Since this ViewModel is static we simply pass in the index of the branch and display the details:

https://gist.github.com/mlafleur/2fff4f973503fd2494dd

We then add a Click event to our Main Activity that handles the navigation:

https://gist.github.com/mlafleur/9c47806ae6817274549d

This gives us our final MainActivity class:

https://gist.github.com/mlafleur/586efced551ed3bf1778

<strong>Going Forward</strong>

There is still quite a bit to do with this app (improved UI layout, location/GPS support, etc). For the time being I wanted to start with a simple implementation that shows both the ease and power of Xamarin for cross-platform development. It may not be polished yet but I think it is a good start.

<hr />

As always, the version here has been submitted and validated for the Store. The code is available on GitHub at <a href="https://github.com/mlafleur/RMVAwsome/releases/tag/T7" target="_blank">https://github.com/mlafleur/RMVAwsome/releases/tag/T7</a>  or follow the live development of the entire project at <a href="https://github.com/mlafleur/RMVAwsome" target="_blank">https://github.com/mlafleur/RMVAwsome</a>. If you have a feature you would like to see done, please let me know and I’ll happy add it to the list.
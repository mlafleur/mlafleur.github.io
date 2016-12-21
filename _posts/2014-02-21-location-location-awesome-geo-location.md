---
Title: Location, Location, Awesome Geo-Location
Published: 2014-02-21 01:52:47
Excerpt: 'I’ve been publicly building an application called RMV Awesome for the last several months on this blog. Since the initial release of the Windows 8.1 app we’ve migrated code to a Portable Class Library, ported to Windows Phone 8, added monetization and integrated Azure Mobile Services.  Next we’ll tackle geo-location.'
Tags:
  - GeoLocation
  - Mobile
  - RMV Awesome
  - Windows
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3540967376";}'
author:
  - Marc LaFleur
post_date:
  - 2014-02-21 01:52:47
post_excerpt:
  - 'I’ve been publicly building an application called RMV Awesome for the last several months on this blog. Since the initial release of the Windows 8.1 app we’ve migrated code to a Portable Class Library, ported to Windows Phone 8, added monetization and integrated Azure Mobile Services.  Next we’ll tackle geo-location.'
permalink:
  - /location-location-awesome-geo-location/
---
I’ve been publicly building an application called RMV Awesome for the last several months on this blog. Since the <a href="http://massivescale.azurewebsites.net/rmv-awesome/" target="_blank">initial release</a> of the Windows 8.1 app we’ve <a href="http://massivescale.azurewebsites.net/leveraging-portable-class-libraries/" target="_blank">migrated code to a Portable Class Library</a>, <a href="http://massivescale.azurewebsites.net/moving-to-windows-phone-8/" target="_blank">ported to Windows Phone 8</a>, <a href="http://massivescale.azurewebsites.net/monetizing-rmv-awesome/" target="_blank">added monetization</a> and <a title="Awesome Azure Mobile Services" href="http://massivescale.azurewebsites.net/awesome-azure-mobile-services/" target="_blank">integrated Azure Mobile Services</a>.  Next we’ll tackle geo-location.

Since RMV Awesome is all about wait-times at various branches around Massachusetts, location is a logical feature. It makes a lot more sense to order the branch list based on distance rather than alphabetically. After all, knowing it is a 10 minute wait at a branch 2 hours away isn’t very valuable.

If you look carefully at the data set we’re storing in Azure, you’ll notice that it includes a Longitude and Latitude for each branch location.  We’ll use this data to determine the sort order by sampling the user’s current location and populating the distance property of each Branch record. We’ll then use that distance to sort the branches as we populate the ViewModel.

There is one complication however, we cannot sample the user’s location from the PCL since there isn’t a common API across every platform. This means we’ll have to sample the location in the app and pass it into the PCL. We’ll do this by providing static Log and Lat properties in the PCL.  When the app samples the location, we’ll update these properties. This will allow us to do the rest of the work in the PCL.

Along with sampling the location, we’re going to need a method of calculating the distance between two geo-locations. For this I’ll leverage an excellent bit of code by <a href="http://www.codeproject.com/script/Membership/View.aspx?mid=541560" target="_blank">Gary Dryden</a> that he posted to <a href="http://www.codeproject.com/Articles/12269/Distance-between-locations-using-latitude-and-long" target="_blank">CodeProject</a> back in 2005. I’ve used this C# implementation of the <a href="http://en.wikipedia.org/wiki/Haversine_formula" target="_blank">Haversine formula</a> for years and it has served me well.

To store our user’s geo-location and provide a home for our distance calculation method, I’ve added a new class called Location (RMV.Awesome.PCL.Utilities.Location). This class will provide static properties and methods. I’ve also changed Gary’s example since we no longer need to pass in the starting geo-location, it can simply use the existing properties.

https://gist.github.com/mlafleur/7ed7c57d5a21049f3669

<h2>Windows 8</h2>

With our Location class in place, we can move on to the client code. I’ll begin with the Windows 8.1 implementation. WinRT includes GeoLocation API at <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.devices.geolocation.aspx" target="_blank">Windows.Devices.GeoLocation</a>. This is a very clever API that has the ability to source a location in a number of ways, depending on what information is available. If the device has a GPS it is very specific but without one it can still get pretty darn by estimating position from Wifi signals, cell towers or even the IP address.

The first step in this process is updating our manifest to declare our intention to use GeoLocation. This will tell the end user that we’re going to use their location and provide the options to disable this feature if they wish.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/02/LocationManafest.jpg"><img style="display: inline; border-width: 0px;" title="LocationManafest" alt="LocationManafest" src="http://massivescale.blob.core.windows.net/blogmedia/2014/02/LocationManafest_thumb.jpg" width="640" height="308" border="0" /></a>

One of the rules with GeoLocation is that we must prompt the user first. This is handled by WinRT but as it is a UI function, the first call to GeoLocation must be made from the UI thread. To accomplish this, we’ll do our check in BranchListPage (the first page we bring the user to) when we load it’s state.

https://gist.github.com/mlafleur/87cd87d809717538e9c5

I also added the following to the XAML item template so that the user can see the actual distance

https://gist.github.com/mlafleur/f440c699c70688468fbb

<h2>Windows Phone</h2>

Just as with WinRT, we need to declare the location capability in the manifest.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/02/PhoneManafest.jpg"><img style="display: inline; border-width: 0px;" title="PhoneManafest" alt="PhoneManafest" src="http://massivescale.blob.core.windows.net/blogmedia/2014/02/PhoneManafest_thumb.jpg" width="591" height="384" border="0" /></a>

We will then add the location code to the MainPage’s loading method. You’ll notice the code is <em>almost</em> identical to WinRT. The major difference is the check of application settings. This is because Windows Phone, unlike WinRT, does not have a built-in mechanism for enabling and disabling location. The validation requirements state that we need to provide this setting to the user within the app.

https://gist.github.com/mlafleur/1e55e4036819d0d68ecf

To deal with the settings issue I added a menu item to MainPage labeled “location settings”. Selecting it presents the user with the option to turn location on or off.

https://gist.github.com/mlafleur/1aad831fc4957932757f

And as with WinRT, I updated MainPage’s XAML so that it too shows the distance to the user.

<h2>Portable Class Library</h2>

Now what we’ve complete the client side code we can focus on the PCL portion.  We’ll make a small change to our FetchXML feed and use some LINQ magic to sort  branches by distance.

https://gist.github.com/mlafleur/2c464f1c89b0df9c711d

As an aside, whenever someone asks why I love C# and LINQ so much I always point to an example like this. The first time I did something like this I was <em>sure</em> it wouldn’t work. LINQ rocks.

<hr />

As always, the version here has been submitted and validated for the Store. The code is available on GitHub at <a href="https://github.com/mlafleur/RMVAwsome/releases/tag/T6">https://github.com/mlafleur/RMVAwsome/releases/tag/T6</a> or follow the live development of the entire project at <a href="https://github.com/mlafleur/RMVAwsome">https://github.com/mlafleur/RMVAwsome</a>. If you have a feature you would like to see done, please let me know and I’ll happy add it to the list.
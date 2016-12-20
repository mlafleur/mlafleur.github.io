---
Title: Leveraging Portable Class Libraries
Published: 2013-10-30 11:52:17
Excerpt: "Part of a series covering Windows Client development, we continue to work on RMV Awesome - an ironically named Modern UI application for keeping tabs on the Massachusetts Registry of Motor Vehicles. In this article we'll take a step towards cross-platform by introducing Portable Class Libraries."
panels_data:
  - 'a:1:{i:0;s:6:"a:0:{}";}'
views:
  - 'a:1:{i:0;s:3:"761";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3546619736";}'
author:
  - Marc LaFleur
post_date:
  - 2013-10-30 11:52:17
post_excerpt:
  - "Part of a series covering Windows Client development, we continue to work on RMV Awesome - an ironically named Modern UI application for keeping tabs on the Massachusetts Registry of Motor Vehicles. In this article we'll take a step towards cross-platform by introducing Portable Class Libraries."
permalink:
  - /leveraging-portable-class-libraries/
---
<span style="color: black; font-size: 8pt;">NOTE: This is part of a series covering Windows Client development. Our sample application is RMV Awesome, an ironically named Modern UI application for keeping tabs on the Massachusetts Registry of Motor Vehicles. In this article we'll take a step towards Windows Phone by introducing Portable Class Libraries.
</span>

<span style="color: black;">On the path towards Windows Phone we must first stop off in the land of <a href="http://msdn.microsoft.com/en-us/library/gg597391.aspx">Portable Class Libraries</a> or PCLs. In many was a PCL is just like any other Library, it holds classes with methods and properties and can be consumed by applications. The key difference however is that a PCL can be consumed by applications targeting a number of different platforms. PCLs support a subset of assemblies from the .NET Framework, Silverlight, .NET for Windows Store apps, Windows Phone, and Xbox 360, and provides a Visual Studio template that you can use to build assemblies that run without modification on these platforms. If wish you can add 3rd parties like <a href="http://xamarin.com/">Xamarin</a> into the mix and bring these libraries to Android and iOS applications.
</span>
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/10/103013_1704_LeveragingP1.png" /><span style="color: black;">
</span></p>
<span style="color: black;">Architecturally this gives you both separations of concerns and efficient code reuse across a number of platforms. Cross-platform reuse such as this as meaningful impact on the cost of building and maintain an application. Today we find most developers in siloes with applications independently ported to each platform. For most consumer/prosumer apps this typical consists of separate teams for iOS, Android and Windows with overlay teams handling backend architecture and user experience. This model allows you to keep the overlay teams while combining the app platform teams into one app team.
</span>

<span style="color: black;">Creating a PCL is extremely straightforward. From Visual Studio 2013, select File -&gt; New Project and pick "Portable Class Library from the list. This will present you with a dialog where you select the projects you wish to support. In our case I'm selecting "Windows Store apps (Windows 8.1)" and "Windows Phone 8" (note: .NET Framework 4.5.1 is automatically selected based on the previous two selections).
</span>
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/10/103013_1704_LeveragingP2.png" /><span style="color: black;">
</span></p>
<span style="color: black;">For RMV Awesome I added a PCL named RMV Awesome PCL (using RMV.Awesome.PCL for the namespace). This gave me a central library to store any common code. In RMV's case moved the entire Model folder from RMV Awesome to my new library. I then changed the namespace to RMV.Awesome.PCL, referenced my new library from RMV Awesome and updated any namespace references to client code base.
</span>

<span style="color: black;">There was one additional component I added to the PCL. Out of the box PCL doesn't support HTTP Client which our ViewModel makes extensive use of. Thanks to Nuget and the <a href="https://www.nuget.org/packages/Microsoft.Net.Http">Microsoft.Net.Http</a> package this is easily rectified. Installing this package adds a common HTTP client to any PCL. This is such a common addition that I fully expect we'll see this become part of the core PCL at some point. Until then it is very easy to install using Nuget.
</span>
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/10/103013_1704_LeveragingP3.png" /><span style="color: black;">
</span></p>
<span style="color: black;">After compiling and testing the app we have a Windows 8.1 application with a ViewModel we can easily reuse in our next platform target, Windows Phone 8. We'll cover that in the next article.
</span>

The code is available on GitHub at <a href="https://github.com/mlafleur/RMVAwsome/releases/tag/T2">https://github.com/mlafleur/RMVAwsome/releases/tag/T2</a> or follow the live development at <a href="https://github.com/mlafleur/RMVAwsome" target="_blank">https://github.com/mlafleur/RMVAwsome</a>
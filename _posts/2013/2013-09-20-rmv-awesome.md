---
title: RMV Awesome!
excerpt: |
  "The Most Awesome App for the Massachusetts Registry of Motor Vehicles" ~ No One
  This article is the beginning of a series on developing apps for Windows and Windows Phone. This version of the app referred to in this article will act as a foundation for future articles. As the series progresses I will be adding additional features and documenting them in greater detail than I have here.
tags:
  - RMV Awesome
  - Visual Studio
  - Windows
  - XAML
---
A few years ago I found myself in a legendary convergence, a kismet of epic proportion, a "big bang" that shook me to the core. This wasn't something trivial like singularity. This was bigger, much bigger.

I needed to build app for Windows 8 that demonstrated some fundamental principles of WinRT and Modern UI development. It also so happened that I needed to renew my vehicle registration and I was dreading the idea of waiting in line for hours. Out of this came &lt;insert drum roll&gt; RMV Awesome - "The Most Awesome App for the Massachusetts Registry of Motor Vehicles".

I know! It is huge! Feel free to take a moment if you need to absorb the enormity of this awesomeness.

Reader's Note: For those who failed to detect the hyperbole in the proceeding paragraphs you may want to stop reading my blog forthwith. It won't get better, I promise.
## Sourcing the Data
To begin with I needed to determine if the Massachusetts Registry of Motor Vehicles (RMV) even provided the data I needed. I knew they had a web site that included the wait times for each branch, but I wasn't excited about the idea of screen scraping the data I wanted. Luckily <a href="http://www.massdot.state.ma.us/DevelopersData.aspx">Massachusetts provides developers</a> with a broad collection of data from the Dept of Transportation (including the RMV). In particular I found the <a href="http://www.massdot.state.ma.us/feeds/qmaticxml/qmaticXML.aspx">Branch Wait Time Feed</a> which lists the wait times for registration and licensing at each branch location.

The Branch Wait Time Feed looks like this:

{% gist 5dc184b0b0ba91a06035  %}

To use this feed I will fetch it using the HttpClient and convert it to an XDocument. I can then use LINQ to iterate over the feed and update the data within my app.

{% gist 5dc184b0b0ba91a06035  %}

Unfortunately I don't get all of the data I need from this feed. While it gives me the branch and the times, it doesn't include anything beyond a name. In order to keep things simple, I decided to code in some static that I'm sure won't change any time soon. Obviously this is - to put it mildly - less than idea and I cannot state strongly enough that you should not do this. This is a demo so I'm cutting this corner but in a real app this data belongs out of band from the app itself. In a later demo I'll show how you can use Azure to accomplish this but for the time being I'll be doing the wrong thing.
## Design
My overall design for v1 here is simple master-detail model. I need a page that lists the branches that the user can pick from and a details page that covers a single branch.

<img alt="" src="/assets/wp/2013/09/092013_2053_RMVAwesome1.png" />

I started with a location list. This is a grid displaying each branch with the city, a summary status and a city image (an image I'm pulling from Wikipedia). Clicking a location will open up the details page.

<img alt="" src="/assets/wp/2013/09/092013_2053_RMVAwesome2.png" />

The details page shows a larger version of the city image, the address and the wait times for Licensing and Registration separately.
## Technology
In the version I'm posting here was built for Windows 8.1 using C#/XML and Visual Studio 2013 RC. The original version was built for Windows 8 using Visual Studio 2012 and all of the code here would work with that version as well. All of the controls used come out-of-the-box with Visual Studio.

The code is available on GitHub at <a href="https://github.com/mlafleur/RMVAwsome/releases/tag/v1" target="_blank">https://github.com/mlafleur/RMVAwsome/releases/tag/v1</a> or follow the live development at <a href="https://github.com/mlafleur/RMVAwsome" target="_blank">https://github.com/mlafleur/RMVAwsome</a>
## Next Steps
This article is the beginning of a series on developing apps for Windows and Windows Phone. This version of the app referred to in this article will act as a foundation for future articles. As the series progresses I will be adding additional features and documenting them in greater detail than I have here. Here is a list of some of the features ideas I've been toying with:

Using Portable Client Libraries to share code with Windows Phone (i.e. WP8 version of this app)
<ul>
	<li>Geo-Location support</li>
	<li>Integration of Bing Maps SDK</li>
	<li>Monetization using the Advertising SDK</li>
	<li>Replacing hella-bad "static data" with an Azure service</li>
	<li>Azure Mobile Services for Push Notifications</li>
	<li>Dynamically pulling images from Bing using ODATA</li>
	<li>Supplementing city details with Wikipedia and other such sites (Facebook, FourSquare, etc)</li>
</ul>
If you have any ideas, please drop a note. I'm happy to focus on any area.
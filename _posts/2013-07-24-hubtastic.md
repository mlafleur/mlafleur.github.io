---
Title: Hubtastic
Excerpt: |
  There are two universal truths about the Bing News app on Windows 8. The first is that it represents the best of Windows 8 app design with dynamic content, gorgeous images and intuitive navigation. The second is that it is nearly impossible for the average developer (maybe even many above average developers) to reproduce. The fact is, it isn't just one of the best Windows 8 apps, it was written by some of the best Windows 8 developers. Thankfully Windows 8.1 has greatly simplified building this kind of app.
Tags:
  - Microsoft
  - Visual Studio
  - Windows
---
There are two universal truths about the <a href="http://apps.microsoft.com/windows/en-US/app/news/eaaf2ce3-d5a3-4a59-ae31-276fbc44a7cd">Bing News app on Windows 8</a>. The first is that it represents the best of Windows 8 app design with dynamic content, gorgeous images and intuitive navigation. The second is that it is nearly impossible for the average developer (maybe even many above average developers) to reproduce. The fact is, it isn't just one of the best Windows 8 apps, it was written by some of the best Windows 8 developers. Thankfully Windows 8.1 has greatly simplified building this kind of app.
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/07/072413_1933_Hubtastic1.png" /><span style="color: black;">
</span></p>
<span style="color: black;">Previously we accomplished this style of app by constructing purpose-build data collections and used template selectors to display the different items. This was all wrapped up in a GridView using the grouping functionality to create the overall user experience. The result was never quite right and could be a nightmare to make any major changes too. Even if a developer was able to pull it off (and there were several great apps that did), I promise they would have preferred to focus on more important elements of their app.</span>

<span style="color: black;">Windows 8.1 introduces the new Hub control and an associated design pattern called the Hub Page. In most cases this becomes the entry point for your Store app; providing an application hub from which the user navigates to other areas of your app. The user is given a scrollable view of disparate content broken up into distinct sections. Typically each section would show a small subset of data related to that function area that the user can then drill into. That said, there is nothing preventing you from putting anything you want into these sections. One of the common sections found within the Bing apps for example is a stacked array of buttons for common tasks. This allows you to expose common functionality to the end-user while still allowing more esoteric features to be tucked away in app bars.
</span>
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/07/072413_1933_Hubtastic2.png" /><span style="color: black;">
</span></p>
<span style="color: black;">The Hub control holds a collection of Hub Sections. Each of these sections have Header and Data areas however only the Header is directly accessible as a property. You would with the Data area via the Section's DataTemplate (there is also a HeaderTemplate for cases were you need a more complex header than simply a title). This can be a little confusing the first time you look at a Section implementation but it is really quite simple to work with. You can either bind the DataTemplate or define the template inside your XAML.
</span>

https://gist.github.com/mlafleur/bf5296132b0cde7a0d97
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/07/072413_1933_Hubtastic3.jpg" /><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/07/072413_1933_Hubtastic4.png" /><span style="color: black;">
</span></p>
<span style="color: black;">Visual Studio 2013 includes a template for getting started with the Hub design. If you've tried to great a News-style app in the past it will be somewhat startling to see a perfect representation of one show up in just a few clicks. There is also a <a href="http://code.msdn.microsoft.com/windowsapps/XAML-Hub-control-sample-5d116fa9?fileId=72255&amp;pathId=1661474377&amp;lineno=17">full sample available</a> from MSDN.
</span>
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/07/072413_1933_Hubtastic5.png" /><span style="color: black;">
</span></p>
---
Title: Style In The Round
Published: 2013-03-13 10:46:07
Excerpt: "Think about your actual user's actual experience, not some generalized design guidelines. If you wedge your user's experience into a design that doesn't fit, you are serving neither your customer nor the platform. Do something amazing that will wow your customer's and make their experience something they'll talk about. Make something ROUND!"
Tags: Windows
views:
  - 'a:1:{i:0;s:3:"825";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3976257139";}'
author:
  - Marc LaFleur
post_date:
  - 2013-03-13 10:46:07
post_excerpt:
  - "Think about your actual user's actual experience, not some generalized design guidelines. If you wedge your user's experience into a design that doesn't fit, you are serving neither your customer nor the platform. Do something amazing that will wow your customer's and make their experience something they'll talk about. Make something ROUND!"
permalink:
  - /style-in-the-round/
---
As part of my <a href="http://massivescale.azurewebsites.net/about/" target="_blank">job </a>I get to talk with a lot of developers, designers and product managers. When the subject of User Experience comes up (and it always does), I always emphasize the importance of thinking "outside the box".

<em>Yes, I know. It is a horrible cliché, a vestigial remnant of bad management consulting that should have gone the way of <a href="http://siliconangle.com/files/2011/03/pets-dot-com1-300x300.jpg" target="_blank">sock puppets</a>. But stick with me for a second, it isn't what you assume it is.
</em>

When I say this, I tell them, I mean it literally. Think about your actual user's actual experience, not some generalized design guidelines. If you wedge your user's experience into a design that doesn't fit, you are serving neither your customer nor the platform. Do something amazing that will wow your customer's and make their experience something they'll talk about. "Don't feel constrained by rectangle tiles, make them round if you want" I tell them.

Honestly, it is a bit of a joke. Obviously making your Modern UI titles round isn't going to "wow" anyone. That said, one of my favorite UX examples happens to be <a href="http://apps.microsoft.com/windows/en-us/app/naturespace-relax-meditate/5705b6e7-6912-42b3-9267-e79243931ee1/m/ROW" target="_blank">Nature Space</a> which…wait for it…uses round titles.

Having made this pitch dozens of times someone finally called me on it recently. "Okay, how can I do that?" they asked. Uh… Truth be told, I hadn't given it much thought. So I sat down this past weekend to give it a shot.

Today I give you &lt;insert drum roll&gt; <strong>ROUND TITLE STYLE</strong> &lt;insert cheering crowd&gt;.

<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/031313_1546_OutsidetheB1.png" />

<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/031313_1546_OutsidetheB2.png" />

In all seriousness, it was kind of fun to do. And it turned out to be a decent example of how to extend the default Windows Store App styles.

To accomplish the effect I took the default Item templates for GridVIew and ListView from Standard Titles and used ellipses to create the affect. It was actually quite simple. I also made some changes to the Grid View's Item Container template so that interactivity (i.e. mouse over) respects the round format a bit better. Turning it on is a matter of adding the Resource Dictionary to the app.xaml file and apply the style to the control.

If you want to try it yourself, I've <a href="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/RoundItemStyles.zip" target="_blank">packaged up the Resource Dictionary</a> with the styles. They will work out of the box with the standard XAML/C# Grid and Split templates. I've also <a href="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/RoundItemsProject.zip" target="_blank">packaged up a sample project </a>that implements the styles.
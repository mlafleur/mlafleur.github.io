---
ID: 1198
post_title: Do It With Style
author: Marc LaFleur
post_date: 2013-03-04 22:26:05
post_excerpt: >
  The truth is that equating "design
  guidelines" with "every app looks the
  same" is akin equating "code standards"
  with "every app does this same thing".
  Guidelines serve to reduce the number of
  decisions we are forced to make, they do
  not limit the decisions you want to
  make. To paraphrase an old American
  phrase, they are guidelines not a
  suicide pact.
layout: post
permalink: >
  http://massivescale.com/do-it-with-style/
published: true
views:
  - "334"
dsq_thread_id:
  - "3701465947"
---
Along with the introduction of Windows 8 came the induction of formalized user experience <a href="http://msdn.microsoft.com/en-us/library/windows/apps/hh465424.aspx" target="_blank">design guidelines</a>. This was a pretty revolutionary step in Windows development. The historic lack of any formal UX guidelines for previous versions of Windows had been bemoaned by for years. Developers were left to their own devices with predictable results; including <a href="http://www.interfacehallofshame.eu/www.iarchitect.com/shame.htm" target="_blank">entire web sites</a> devoted to shaming some of the more horrendous examples.

<img class="alignleft" alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/030513_0315_DoItWithSty1.png" width="328" height="184" align="left" />While some members of the community did an excellent job of <a href="http://www.amazon.com/gp/product/1893115941?ie=UTF8&amp;tag=joelonsoftware&amp;linkCode=as2&amp;camp=1789&amp;creative=9325&amp;creativeASIN=1893115941" target="_blank">attempting to educate to developers</a>, the reality was UX design remained an arcane art. And to be fair, developers were part of the problem. Design in the early days was something graphic designers did for marketing departments and magazines, not software. Okay, that is a complete exaggeration but looking at through the aforementioned "Interface Hall of Shame" tells me is isn't much of one.

So is UX a dark art? Well, to be honest great experiences often are. But "good" UX? Not so much. This is where the design guidelines come into play. Following some basic guidelines, anyone can produce solid user experiences (no, it won't bring you to <a href="http://www.jnd.org/" target="_blank">Don Norman's</a> level of expertise but then not much will). And even with artistic skill only slightly beyond Crayola level (i.e. kid level, <a href="http://pinterest.com/txterrisweeps/crayon-art/" target="_blank">not this level</a>) you can create something worth looking at.

Along with the guidelines comes a number of comprehensive application templates inside Visual Studio 2012. They include all of the basic control and navigation elements you need as well as a complete selection of
"standard styles". If you are looking to get a "good enough" UX up and running with minimal work so you can focus on the code, these provide an excellent starting point. One of my standard demos is building a working application in an hour using these templates.<em>
</em>
<h2>Monoculture Fear</h2>
<img class="alignright" alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/030513_0315_DoItWithSty2.jpg" width="265" height="199" align="right" />One thing that I have found interesting are the reactions I've heard to publishing formal guidelines and providing standard templates. The gist of which is that they result in a heard of monoculture of cookie-cutter apps where every app looks the same.

The truth is that equating "design guidelines" with "every app looks the same" is akin equating "code standards" with "every app does this same thing". Guidelines serve to reduce the number of decisions we are <em>forced</em> to make, they do not limit the decisions you <em>want</em> to make. To paraphrase an old American phrase, they are guidelines not a suicide pact.

It is true that if you do nothing but leverage the standard templates you will end up with apps that look like nothing more than the standard templates. For a wide range of apps (think of all those internal applications that live within an enterprise) that may exactly what is needed. Remember, the guidelines are about establishing a conventional baseline here. And if every enterprise app starts looking like those templates, we've made substantial progress (don't make me point you to the Hall of Shame again).
<h2>Applying Guidelines</h2>
As developers we are accustomed to how guidelines apply to coding. We use patterns such as MVC to ensure a separation of concerns. It is invaluable for both maintainability and testability of the apps we build. We teach our junior developers to embrace it, even when slapping some code closer to the View would be easier because we know from experience that it isn't worth it. Does that mean there is never a valid reason to step out of the pattern? Of course not! There are any number of good reasons to violate the model. When the value of the violation outweighs the value of compliance, break the convention.

<img class="alignright" alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/030513_0315_DoItWithSty3.jpg" width="261" height="194" align="right" />Designers have worked with guidelines like these for equally as long. Every major company and brand has a definitive style guide outlining logos, fonts, colors, etc. This is where the entire concept of "style sheets" came from. And just as with coding standards, there can be justifiable exceptions to the published style guide. When presented with an idea that breaks convention, they evaluate the value of breaking it.

This of course doesn't mean there are no rules. There are several rules that every Windows 8 app has to adhere to. You cannot design your app to swipe from the left or right edges for example since Windows owns those gestures for the Charms and switching apps. Another is that any app that connects to the internet requires a Privacy Police. You can review the <a href="http://msdn.microsoft.com/en-us/library/windows/apps/hh694083.aspx" target="_blank">entire list on MSDN</a>. In general however, these rules are designed to protect the end-user, not limit innovative ideas.

So please feel break free from the mold. The Visual Studio Templates are there to help not to hinder so don't be afraid to remake them in your own image. The guidelines are there to give you a starting point, not a conclusion. Make your tiles round, add some interesting animations, change the world if you wish.

<span style="font-size: 9pt;"><em>Oh, and read <a href="http://www.amazon.com/gp/product/1893115941?ie=UTF8&amp;tag=joelonsoftware&amp;linkCode=as2&amp;camp=1789&amp;creative=9325&amp;creativeASIN=1893115941" target="_blank">Joel Spolsky's book</a>. It is still amazingly valuable even a decade after it was published. </em></span>
---
title: Ink Enable The ISV
excerpt: ""
tags:
  - Tablet PC
---
<a href="http://weblogs.asp.net/jlerman/posts/32396.aspx" target=_blank>Julia</a> talked about it, so has <a href="http://kstati.com/tabula/posts/775.aspx" target=_blank>Peter</a>, and recently <a href="http://blog.monstuff.com/archives/000105.html" target=_blank>Dumkey</a> chimed in as well. What we're all talking about of course is developing applications that target the Tablet PC platform. More specifically, the surprisingly sparse resources available to those of us who want to do so. While the hardware has made quite a splash, the software community is still struggling to find a footing.

There are a number of obvious reasons why the Tablet PC is so tempting to develop for. They <i>are</i> cool, but it is more that just the "new toy" factor at work here. There are any number of solid business reasons to target the platform as well:

<b>Low Learning Curve</b>. I, and a number of others, have found that almost anyone can learn to use the Tablet is a matter of minutes. For folks who use a computer every day, this isn't surprising; they are very similar in operation after all. But what <i>is</i> socking was how well the computer-illiterate and technology-adverse are able to operate it (and even love doing so). One of the important things to remember is that for all of our technological advances in the last 30 years, the bottleneck for the average user still remains the keyboard. By removing the keyboard Microsoft has removed a substantial bottleneck. 

<b>Fast User Acceptance. </b>A few months ago I took a tablet home to test our. My wife, who has a completely irrational hate all modern technology, started using it and fell in love with it. Rather than the usual  "when will this thing be out of my house" I got "do you <i>really</i> have to give this back". I've told this story to many developers and almost everyone one of them have had received similar reactions.

<b>Extreme Portability. </b>Portability has been somewhat of a holy grail in the computer industry for a while now. The Tablet PC represents a significant step closer to grabbing that grail. While laptops help bring our desktop with us, it still requires (despite to it's name) a desk to sit at. The Pocket PC made the leap to working while standing, but the small screen and limited input options has pretty much limited its use to isolated tasks. The Tablet PC however gives the user all of the power of a laptop with the portability of the palmtop. No, it isn't perfect; but it is a great improvement.

<b>High "Buzz" Value.</b> When it comes to financing or selling technology solutions, nothing is more important than "buzz". And no, I'm not talking about hype. Hype is the ugly beast that invades the executive offices at Large Company X and suddenly forces development to being integrating Product Y for no legitimate reason. Buzz on the other hand is quite different. Buzz is what happens when a new product seems to build a massive audience without anyone noticing it is happening (the Blackberry is a good example). Buzz is the sound of synapses firing as someone thinks of every conceivable use for a product.

I've experienced Buzz first hand when I demonstrated the Tablet PC to some of my customers. They simply lit up at the sight of me using it and you could feel the "Buzz" in the air. At this particular demonstration I showed a Pocket PC with a Barcode scanner, a PC with three 20" LCD screens, an HP laptop with a 17" screen, and previewed the next major release of our software. I answered questions for an hour and only 2 of them were <i>not </i>about the Tablet PC. That my friends is Buzz at its finest.

So there is a lot interest in these devices. People that own them, love them. And yet, even after a full year of availability, there is very little development support for them. And without a solid developer support system in place there will be very little ISV support. We simply cannot afford to put in the R&D necessary on our own. 

It is somewhat confusing that 2 years prior to release we have an MSDN Development Center for Longhorn. But we still don't have one for the Tablet PC. Sure, they have <a href="http://www.tabletpcdeveloper.com./" target=_top>Tablet PC Developer</a>. But I'm pretty sure there are Y2K bug sites out there less devoid of life than that place. So all we are left with is the SDK (albeit a decent one).

To be fair, I have only minor issues with the current SDK. The current SDK ships with 2 controls for developers to use; InkPaint & InkEdit. They work, but only in the most limited scope imaginable. InkEdit in particular is cute but completely impractical. When entering information in ink it either converts it to text or it leaves it as ink. Most of our users express the desire to keep the ink as ink. The only issue is that it immediately shrinks that ink to the same size as the current font. When you ink a smiley face, it is a smiley face. But when you shrink it to 8.75pt font it is unrecognizable scribble. And it just isn't what the end-user expects to have happen.

What I need, and most users want, it to be able to insert ink just like they do in Microsoft Word today. And by that I mean the ability to draw on my RTF control and have it display that ink exactly as it was originally entered. If I could have an RTF editor that gave me real support for ink, I would be replacing every single RTF editor in my application today.

So if anyone out there knows of some solid 3rd party controls for Ink, please send them my way. I'm going to try and get an comprehensive list of Tablet PC options together to post on this site. 

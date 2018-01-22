---
title: Moved My Blog (again)
subtitle: Trying out GitHub Pages 
tags:
  - Thoughts
---
I've switched blogging platforms quite a few times over the years. I've tried everything from [LiveJournal](http://www.livejournal.com/) to [Orchard](http://www.orchardproject.net/) and, for the last several years, [WordPress](https://wordpress.org/). And for the most part, WordPress has severed me extremely well. It has a huge community with more [plugins](https://wordpress.org/plugins/) than you can through a stick at. It does however have it's drawbacks; particularly it's rather sizable footprint and [bloat](https://premium.wpmudev.org/blog/wordpress-bloat/).

For a while now I've been eyeing a move to a static page model. My site doesn't require a lot of dynamic content and given that I've been [writing in Markdown](https://github.com/OfficeDev/office-js-docs) for several years already, my workflow wouldn't have to change too much. 

Switching also allows me to dramatic reduce my costs. By leveraging [GitHub Pages](https://pages.github.com/) I'm able to turn off the web and database severs required by WordPress. While not excessively expensive, it certainly isn't free.

Behind the scenes GitHub is using [Jekyll](http://jekyllrb.com/) which is a very popular static site generator. Jekyll handles most of the heavy lifting for me. I pass in my templates, my posts and some settings and it spits out an entire site almost instantly. It is remarkably robust. 

> As an aside, Jekyll was actually what held me back for so long. It is [notoriously tricky](http://jekyllrb.com/docs/windows/#installation) to get running on Windows and I wanted the ability to stage my site locally. So what changed? [Bash baby, Bash!](https://msdn.microsoft.com/en-us/commandline/wsl/about) Jekyll is running happily on Windows 10 thanks to Windows Subsystem for Linux. 

GitHub provides a number of [built-in themes](https://github.com/pages-themes/) but none of them caught my eye. Jekyll has a number of themes available as gem packages but these are unfortunately not supported by GitHub.

Thankfully I found Start Bootstrap's [Clean Blog template](https://github.com/BlackrockDigital/startbootstrap-clean-blog-jekyll) that provided exactly what I needed; a minimalist foundation using Bootstrap that I could easily extend. After a few tweaks I was up and running in now time. 

The most notable difference? My page load times are improved by orders of magnitude!
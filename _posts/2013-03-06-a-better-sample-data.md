---
Title: A Better Sample Data
Published: 2013-03-06 11:36:10
Excerpt: "Visual Studio's templates provide a great jump start but there they are tab visually boring out of the box. Here we spice them up a bit with placeholder images. "
Tags:
  - Visual Studio
  - Windows
views:
  - 'a:1:{i:0;s:3:"721";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4094711490";}'
author:
  - Marc LaFleur
post_date:
  - 2013-03-06 11:36:10
post_excerpt:
  - "Visual Studio's templates provide a great jump start but there they are tab visually boring out of the box. Here we spice them up a bit with placeholder images. "
permalink:
  - /a-better-sample-data/
---
<a href="http://www.hanselman.com" target="_blank">Scott Hanselman</a> recently wrote about some <a href="http://www.hanselman.com/blog/TheInternetsBestPlaceholderImageSitesForWebDevelopment.aspx" target="_blank">placeholder images sites for web development</a>. As is typical for one of his posts, it pointed me towards something I was completely unaware of. It also inspired me to solve a personally annoyance of mine.

<img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/030613_1640_ABetterSamp1.jpg" align="right" />As a Technical Evangelist I spend a good deal of presenting Windows 8 development techniques. In most cases these presentations consist of my coding up an application in front of the audience. I almost always start with one of the C#/XAML templates that ship with Visual Studio 2012. They are a lot of fun to do and the templates provide a great jump start but there is one thing that has always annoyed, they are visually a little boring. For obvious reasons they use various gray placeholder images (light, medium and dark). For additionally obvious reasons, that isn't very exciting to look at.

In an effort to inject some life into my demos, I took Scott's post one step further and replaced the gray placeholder images in the template's sample data with random placeholder images from <a href="http://lorempixel.com/">lorempixel</a>. I used lorempixel because it offered images by category (keep in spirit with the grouping already in the sample data) and I could specify which images from a given series were used (allowing me to work around the inherent URI caching that resulted in the same image showing up repeatedly).

It was a rather simple process, I simply replaced all of the "asset/&lt;shade&gt;gray.png" references with the lorempixel URI. Since image sources can be local or remote it "just works". I also renamed each Group Titles to a category from lorempixel and set each item to grab the next consecutive image in the series. By  replacing the standard sample data with my new one, I get a much nicer looking demo template.
<p style="text-align: center;"><img alt="" src="http://massivescale.azurewebsites.net/wp-content/uploads/2013/03/030613_1640_ABetterSamp2.jpg" /></p>
Here is the complete replacement method. Simple copy and paste over the existing SampelDataSrouce() method in the DataModelSampleDataSource.cs file.

https://gist.github.com/mlafleur/77fd21b834852acdc8b2
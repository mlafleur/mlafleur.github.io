---
Title: Source Selector Utility
Published: 2003-06-17 15:58:00
Excerpt: ""
Tags:
  - Source Control
  - Visual Studio
views:
  - 'a:1:{i:0;s:4:"9977";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538636931";}'
author:
  - Marc LaFleur
post_date:
  - 2003-06-17 15:58:00
post_excerpt:
  - ""
permalink:
  - /source-selector-utility/
---
<font face="Arial" size="2"><span class="375394215-17062003">Many people are forced 
to use multiple source code control systems on a single PC. For example, I do a 
lot of side projects that are stored in <a href="http://massivescale.blob.core.windows.net/blogmedia/2003/06/www.cvshome.org">CVS</a>. I have another project that has some VB 
code stored in <a href="http://massivescale.blob.core.windows.net/blogmedia/2003/06/www.perforce.com">PerForce</a>. And I'm working 
on a new project that will likely be using <a href="http://massivescale.blob.core.windows.net/blogmedia/2003/06/www.sourcegear.com">SourceGear's</a> <a href="http://massivescale.blob.core.windows.net/blogmedia/2003/06/vault">Vault</a> product. </span></font>

<font face="Arial" size="2"><span class="375394215-17062003">On top of those three 
systems, I'm a zealot on Source Control and try just about every product that 
comes out. This means that I often have 5-10 different systems installed at the 
same time. </span></font>

<font face="Arial" size="2"><span class="375394215-17062003">For some reason, 
Visual Studio only supports a single SCC provider called the "default" provider. 
This always struck me asÂ odd because it implies that there can be 
"non-default" providers. Well, there can, you just can't use them.Â :--) 
</span></font>

<font face="Arial" size="2"><span class="375394215-17062003"></span></font><font face="Arial" size="2"><span class="375394215-17062003">The fix has always been to edit 
the registry. Or if you are like me you would create a bunch of .reg files to 
make the edits a bit quicker. This works but is a real pain in the 
butt.</span></font>

<font face="Arial" size="2"><span class="375394215-17062003">But thanks to Tor over 
at <a href="http://nidaros.homedns.org/subway/">Subway</a>Â (an SCC 
connection to <a href="http://massivescale.blob.core.windows.net/blogmedia/2003/06/subversion.tigris.org">Subversion</a>), I now 
have a neat utility called <a href="http://nidaros.homedns.org/subway/binaries/SourceSelector.exe">SourceSelect.exe</a> 
that allows me to switch the provider. This just made my life a lot 
easier.</span></font>

<p align="center"><font face="Arial" size="2"><span class="375394215-17062003"><img src="cid:375394215@17062003-185B" /></span></font></p>
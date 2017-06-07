---
title: >
  Outlook 2003 Add-in with Visual Studio
  2005?
excerpt: ""
tags:
  - Office
  - Visual Studio
  - VSTO
---
Thinking of building an add-in for Outlook 2003 with Visual Studio 2005? Don't do it. Really, don't do it. What? Ok, if you must...
  I've just spend the last three days building an add-in and installing on on a single PC. This totaled about 3 hours of development time and the rest was getting the darn thing to load! Honestly, it was the single most frustrating thing I've ever encountered in years. 
  The problem was that the setup program that Visual Studio 2005 automatically generates when you create an add-in project doesn't include everything you need. 
  Here is how I fixed the problem:
  Before you can load your add-in you need to make sure the following is installed:
  <ul>   <li>Visual Studio 2005 Tools for Office Second Edition Runtime (found at <a title="http://shrinkster.com/mnh" href="http://shrinkster.com/mnh" target="_blank">http://shrinkster.com/mnh</a>) </li>    <li>Office 2003 Update: Redistributable Primary Interop Assemblies (found at <a title="http://shrinkster.com/mni" href="http://shrinkster.com/mni" target="_blank">http://shrinkster.com/mni</a>)</li> </ul>  After that you'll need to "fully trust" your assemblies. This can only be done with signed assemblies. I remember being a pain with VS 2003 but turns out is a breeze with VS 2005. Just open up the Properties for the project and select the Signing tab. From there is was fairly self explanatory. 
  Now comes the part that gave me problems. After you have everything installed (including your nice newly signed assemblies) you need to give permission to those assemblies. This is done using a tool called CASPOL.EXE. Here is the command line for registering your file:
  <blockquote>   caspol -u -ag All_Code -url "&lt;full path to your file&gt;" FullTrust -n "&lt;assembly name&gt;"
 </blockquote>  If you have more than one file (or the above didn't work) you can also do this for a directory. 
  <blockquote>   caspol -u -ag All_Code -url "&lt;directory path&gt;*" FullTrust
 </blockquote>  I hope this helps save someone from the pain I experienced over the last few days. Hopefully this will get easier with the next release of Visual Studio...
  <em>Updated to reference Outlook 2003. I wasn't clear about that in the original post. </em>

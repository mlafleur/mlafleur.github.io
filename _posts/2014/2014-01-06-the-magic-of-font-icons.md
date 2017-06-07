---
title: The Magic of Font Icons
excerpt: |
  Okay, it isn't magic but it is "one of those things" that I've wished I could easily do for years that finally came together. Anyone who has tried to mess around with creating custom paths for glyphs in their apps will truly appreciate how easy things have become.
tags:
  - FontIcon
  - Windows
  - XAML
---
With the release of Windows 8.1 came a little noticed addition to XAML called <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.fonticon.aspx" target="_blank">FontIcon</a>. It is a rather simple XAML tag designed to show a glyph from a specified font. At the same time came two other tags in a similar vain (<a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.symbolicon.aspx" target="_blank">SymbolIcon </a>which shows a glyph from Segoe UI and <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.controls.pathicon.aspx">PathIcon</a> which displays a <a href="http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.xaml.shapes.path.aspx">path</a>).

On it's own, FontIcon isn't extremely useful. Most of the basic glyphs are already part of Segoe UI and most of the other symbol fonts are somewhat dated looking (yes, I'm looking at you Windings). But what if you had a way to quickly design your <em>own</em> symbol font? And what if you could use any SVG graphic such as those available from <a href="http://thenounproject.com/">The Noun Project</a>? And what then if you could just drop that font into Visual Studio without requiring the end-user to install it?

Enter the glorious folks at <a href="http://fontastic.me/" target="_blank">Fontastic</a>. These guys have an amazing tool that allows you to instantly build symbol fonts using either public collections on their site (which there are many and most are quite good), premium collections that sell (which I assume is how they make their income) or any SVG file you want to upload (include SVGs from <a href="http://thenounproject.com/">The Noun Project</a>). Once you design your font on their site you are supplied with a .zip containing  .ttf, .eot, .svg, and .woff versions of your font (include the .css file) giving you the ability to use this same symbol set on iOS, Android, Windows and the Web.

Once you have your .ttf, drop it into your Windows 8.1 XAML project. You can then reference it directly from your FontIcon tag (your FontFamily is <em>fontfile#fontname</em> and your glyph will be which ever letter you've mapped in Fontastic). You can also use FontIcon in your AppBar and CommandBar buttons.

{% gist 5dc184b0b0ba91a06035  %}

Okay, it isn't magic but it is "one of those things" that I've wished I could easily do for years that finally came together. Anyone who has tried to mess around with creating custom paths for glyphs in their apps will truly appreciate how easy this is now.

NOTE: There does seem to be some caching issues in the designer. I've run into where the XAML designer shows the letter rather than the actual glyph but once rebuilt it seems to right itself and it always works as expected when executing.
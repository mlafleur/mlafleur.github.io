---
Title: SQL Denali Makes Even Fast Look Slow
Published: 2011-08-09 16:20:30
Excerpt: ""
Tags: ""
views:
  - 'a:1:{i:0;s:3:"852";}'
author:
  - Marc LaFleur
post_date:
  - 2011-08-09 16:20:30
post_excerpt:
  - ""
permalink:
  - /sql-denali-makes-fast-look-slow/
---
I've seen a lot of performance testing over the years, every so often I'm even impressed a bit by the results. Here is one however that will melt the mind of anyone working against large SQL databases: SQL Denali + 1.4 billion with a b rows = 455x increase from 2008 R2. No, I didn't fat finger an extra 5 there. It was that big.

How? By using a new feature called a <a href="http://msdn.microsoft.com/en-us/library/gg492088(v=SQL.110).aspx" target="_blank">Column Store Index</a> (aka Column Indexing). For those wanting the details on how it works and how they tested it you can find the PDF <a href="http://download.microsoft.com/download/8/C/1/8C1CE06B-DE2F-40D1-9C5C-3EE521C25CE9/Columnstore%20Indexes%20for%20Fast%20DW%20QP%20SQL%20Server%2011.pdf" target="_blank">here</a>. Not interested? You sure? I promise, its really short.

One major caveat however is that not all data types are supported within it. Most wouldn't make sense for this type of use anyway but one in particular was a pain â€“&gt; uniqueidentifier. I've long used uniqueidentifier as my ID for tables (makes n-tier, replication and merging databases a lot easier). The other gotcha types are the (max) text columns. If you thought you could get away with just setting everything to (max) then you can mark today as when you found out that was a bad idea. You can find the other limitations and restrictions <a href="http://msdn.microsoft.com/en-us/library/gg492088(v=SQL.110).aspx#Restrictions" target="_blank">here</a>.

Looking at the performance I really could have used this feature more than once in the past.
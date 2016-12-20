---
ID: 500
post_title: Primal Scream
author: Marc LaFleur
post_date: 2004-08-10 22:38:00
post_excerpt: ""
layout: post
permalink: http://massivescale.com/primal-scream/
published: true
views:
  - "273"
dsq_thread_id:
  - "3538634220"
---
<DIV>Every have one of those days were it seems like the world is secretly trying to scramble your brains? I'm having one today.</DIV>
<DIV>For some reason this statement compiles just fine:</DIV><PRE><FONT size=2><P></FONT><FONT color=#0000ff size=2>if</FONT><FONT size=2>(anyYearCheck.Checked = </FONT><FONT color=#0000ff size=2>false</FONT><FONT size=2> &amp;&amp; (1 &gt; 2))</P><P>{</P><P>}</P></FONT></PRE>
<DIV>Did you notice the problem? Yeah? Well I didn't.</DIV>
<DIV>&nbsp;</DIV>
<DIV>For those like me who didn't catch it, here is the deal; "Checked = false" doesn't check the value of Checked, it <EM>sets</EM> the value of Checked. So rather than checking for false I was <EM>setting it to false</EM>.&nbsp;This caused some rather&nbsp;intricate four-letter-word sentences to be expunged by yours truly.</DIV>
<DIV>&nbsp;</DIV>
<DIV>What I find odd is that I'm positive that statements like this have cause compiler errors in the past. So like I said, the world must be secretly out to get me.</DIV>
<DIV>&nbsp;</DIV>
<DIV>UPDATED: My code sample was wrong. This error requires the &amp;&amp; to be included in the if statement.</DIV>
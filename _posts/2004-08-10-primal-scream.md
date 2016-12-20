---
Title: Primal Scream
Published: 2004-08-10 22:38:00
Excerpt: ""
Tags: false
views:
  - 'a:1:{i:0;s:3:"273";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538634220";}'
author:
  - Marc LaFleur
post_date:
  - 2004-08-10 22:38:00
post_excerpt:
  - ""
permalink:
  - /primal-scream/
---
<div>Every have one of those days were it seems like the world is secretly trying to scramble your brains? I'm having one today.</div>
<div>For some reason this statement compiles just fine:</div><pre><font size=2><p></p></font><font color=#0000ff size=2>if</font><font size=2>(anyYearCheck.Checked = </font><font color=#0000ff size=2>false</font><font size=2> &amp;&amp; (1 &gt; 2))<p>{</p><p>}</p></font></pre>
<div>Did you notice the problem? Yeah? Well I didn't.</div>
<div>&nbsp;</div>
<div>For those like me who didn't catch it, here is the deal; "Checked = false" doesn't check the value of Checked, it <em>sets</em> the value of Checked. So rather than checking for false I was <em>setting it to false</em>.&nbsp;This caused some rather&nbsp;intricate four-letter-word sentences to be expunged by yours truly.</div>
<div>&nbsp;</div>
<div>What I find odd is that I'm positive that statements like this have cause compiler errors in the past. So like I said, the world must be secretly out to get me.</div>
<div>&nbsp;</div>
<div>UPDATED: My code sample was wrong. This error requires the &amp;&amp; to be included in the if statement.</div>
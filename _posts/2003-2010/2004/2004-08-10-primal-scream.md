---
title: Primal Scream
excerpt: ""
tags: null
---
<div>Every have one of those days were it seems like the world is secretly trying to scramble your brains? I'm having one today.</div>
<div>For some reason this statement compiles just fine:</div><pre>
if(anyYearCheck.Checked = false &amp;&amp; (1 &gt; 2)){
}
</pre>
<div>Did you notice the problem? Yeah? Well I didn't.</div>
<div> </div>
<div>For those like me who didn't catch it, here is the deal; "Checked = false" doesn't check the value of Checked, it <em>sets</em> the value of Checked. So rather than checking for false I was <em>setting it to false</em>. This caused some rather intricate four-letter-word sentences to be expunged by yours truly.</div>
<div> </div>
<div>What I find odd is that I'm positive that statements like this have cause compiler errors in the past. So like I said, the world must be secretly out to get me.</div>
<div> </div>
<div>UPDATED: My code sample was wrong. This error requires the &amp;&amp; to be included in the if statement.</div>
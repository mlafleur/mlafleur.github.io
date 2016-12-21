---
Title: VoiceXML with Visual Studio
Published: 2007-02-22 06:06:00
Excerpt: ""
Tags: Skype, Visual Studio
views:
  - 'a:1:{i:0;s:4:"2445";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538635266";}'
author:
  - Marc LaFleur
post_date:
  - 2007-02-22 06:06:00
post_excerpt:
  - ""
  - ""
permalink:
  - /voicexml-with-visual-studio/
  - /voicexml-with-visual-studio/
---
<p>Every so often I'm surprised by the incredible flexibility built into Visual Studio 2005. </p>  <p>I've been writing a lot of VoiceXML lately and I was really missing the intellisense that I've become so used to. On a whim I tried opening a VoiceXML document in Visual Studio and much to my surprise it worked!</p>  <p>It turns out that Visual Studio is capable of understanding the syntax of a document based on it's DOCTYPE. In my case it saw &lt;!DOCTYPE vxml PUBLIC &quot;-//W3C//DTD VOICEXML 2.1//EN&quot; &quot;<a href="http://www.w3.org/TR/voicexml21/vxml.dtd"">http://www.w3.org/TR/voicexml21/vxml.dtd&quot;</a>&gt; and was able to automatically give me basic intellisense and syntax checking for VoiceXML version 2.1.</p>  <p>As an example, create a new XML document and insert the following:</p>  <blockquote>   <p>&lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt; </p>    <p>&lt;!DOCTYPE vxml PUBLIC &quot;-//W3C//DTD VOICEXML 2.1//EN&quot; &quot;<a href="http://www.w3.org/TR/voicexml21/vxml.dtd"">http://www.w3.org/TR/voicexml21/vxml.dtd&quot;</a>&gt; </p>    <p>&lt;vxml version=&quot;2.1&quot;&gt;     <br />&lt;/vxml&gt;</p> </blockquote>  <p>You'll notice that the last element (&lt;/vxml&gt;) gives you a warning. Hovering over it tells you not only that your missing an element but what the valid elements might be! </p>  <p>This is all very cool if you ask me...</p>
---
Title: VoiceXML with Visual Studio
Excerpt: ""
Tags:
  - Skype
  - Visual Studio
---
Every so often I'm surprised by the incredible flexibility built into Visual Studio 2005. 
  I've been writing a lot of VoiceXML lately and I was really missing the intellisense that I've become so used to. On a whim I tried opening a VoiceXML document in Visual Studio and much to my surprise it worked!
  It turns out that Visual Studio is capable of understanding the syntax of a document based on it's DOCTYPE. In my case it saw &lt;!DOCTYPE vxml PUBLIC "-//W3C//DTD VOICEXML 2.1//EN" "<a href="http://www.w3.org/TR/voicexml21/vxml.dtd"">http://www.w3.org/TR/voicexml21/vxml.dtd"</a>&gt; and was able to automatically give me basic intellisense and syntax checking for VoiceXML version 2.1.
  As an example, create a new XML document and insert the following:
  <blockquote>   &lt;?xml version="1.0" encoding="utf-8" ?&gt; 
    &lt;!DOCTYPE vxml PUBLIC "-//W3C//DTD VOICEXML 2.1//EN" "<a href="http://www.w3.org/TR/voicexml21/vxml.dtd"">http://www.w3.org/TR/voicexml21/vxml.dtd"</a>&gt; 
    &lt;vxml version="2.1"&gt;     <br />&lt;/vxml&gt;
 </blockquote>  You'll notice that the last element (&lt;/vxml&gt;) gives you a warning. Hovering over it tells you not only that your missing an element but what the valid elements might be! 
  This is all very cool if you ask me...

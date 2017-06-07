---
title: Communicating Between Workflow and VXML
excerpt: ""
tags:
  - Skype
---
When working with the VoiceXML Interpreter Activity the simple act of passing data between your Workflow and your VXML applications can be tricky to figure out. Hopefully this post will save someone the time I spent scratching my head the first time around.
  <strong>Passing Data In</strong>
  Lets say I want to pass "The dog is brown" to my VXML application so that is can in turn relay this very vital information to the caller. 
  Prior to VXML activity I'll drop a Code activity with the following in its ExecuteCode method:
  <pre style="border-bottom:#cecece 1px solid;border-left:#cecece 1px solid;padding-bottom:5px;background-color:#fbfbfb;min-height:40px;padding-left:5px;width:650px;padding-right:5px;overflow:auto;border-top:#cecece 1px solid;border-right:#cecece 1px solid;padding-top:5px;"></pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">VXML.ApplicationData.Add("PassedInVar", "The dog is brown");</pre>

To access this data from within my VXML application I'll need to reference both my variable name and the ApplicationData collection itself. For example:


<pre style="border-bottom:#cecece 1px solid;border-left:#cecece 1px solid;padding-bottom:5px;background-color:#fbfbfb;min-height:40px;padding-left:5px;width:650px;padding-right:5px;overflow:auto;border-top:#cecece 1px solid;border-right:#cecece 1px solid;padding-top:5px;"></pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">&lt;block&gt;
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">  &lt;prompt&gt;
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    &lt;value expr="ApplicationData['PassedInVar']" /&gt;                
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">  &lt;/prompt&gt;            
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">&lt;/block&gt;</pre>
<strong>Passing Data Out</strong> 

VoiceXML has a standard method of passing data out of an application using the <a href="http://www.vxml.org/frame.jsp?page=exit.htm" target="_blank">&lt;exit&gt;</a> tag (&lt;exit namelist="SomeVar"/&gt;).&#160; Variables passed back via the "namelist" are stored as a Dictionary object in the ApplicationData collection. 


Inside my VoiceXML application I'll declare a Var and return it in my &lt;exit&gt; tag. 


<pre style="border-bottom:#cecece 1px solid;border-left:#cecece 1px solid;padding-bottom:5px;background-color:#fbfbfb;min-height:40px;padding-left:5px;width:650px;padding-right:5px;overflow:auto;border-top:#cecece 1px solid;border-right:#cecece 1px solid;padding-top:5px;"></pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">&lt;block&gt; 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    &lt;prompt&gt; 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">        &lt;value expr="ApplicationData['PassedInVar']" /&gt;                
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    &lt;/prompt&gt; 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    &lt;var name="ReturnedVar" expr="'The cat is black'" /&gt;        
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    &lt;exit namelist="ReturnedVar"/&gt; 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">&lt;/block&gt;</pre>

Once back in the Workflow I'll extract the data from the ApplicationData collection's $_exit_ element. I'll drop a Code activity after the VXML activity with following in its ExecuteCode method:


<div style="padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;display:inline;float:none;padding-top:0px;" id="scid:8eb9d37f-1541-4f29-b6f4-1eea890d4876:e9c0c0d7-7513-49c9-b479-baad3c02d8a7" class="wlWriterEditableSmartContent"><div><a href="http://www.massivescale.com/blog_files/CommunicatingVariablestoVoiceXML_14D56/VXMLVariableSample.zip" target="_self">Download Sample Project</a></div>
</div><img src="http://gotspeech.net/aggbug.aspx?PostID=10282" width="1" height="1"/>
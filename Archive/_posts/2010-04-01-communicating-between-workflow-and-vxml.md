---
ID: 65
post_title: Communicating Between Workflow and VXML
author: Marc LaFleur
post_date: 2010-04-01 11:08:00
post_excerpt: ""
layout: post
permalink: >
  http://massivescale.com/communicating-between-workflow-and-vxml/
published: true
views:
  - "322"
---
<p>When working with the VoiceXML Interpreter Activity the simple act of passing data between your Workflow and your VXML applications can be tricky to figure out. Hopefully this post will save someone the time I spent scratching my head the first time around.</p>  <p><strong>Passing Data In</strong></p>  <p>Lets say I want to pass "The dog is brown" to my VXML application so that is can in turn relay this very vital information to the caller. </p>  <p>Prior to VXML activity I'll drop a Code activity with the following in its ExecuteCode method:</p>  <pre style="border-bottom:#cecece 1px solid;border-left:#cecece 1px solid;padding-bottom:5px;background-color:#fbfbfb;min-height:40px;padding-left:5px;width:650px;padding-right:5px;overflow:auto;border-top:#cecece 1px solid;border-right:#cecece 1px solid;padding-top:5px;"><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">VXML.ApplicationData.Add(&quot;<span style="color:#8b0000;">PassedInVar</span>&quot;, &quot;<span style="color:#8b0000;">The dog is brown</span>&quot;);</pre></pre>

<p>To access this data from within my VXML application I'll need to reference both my variable name and the ApplicationData collection itself. For example:</p>

<pre style="border-bottom:#cecece 1px solid;border-left:#cecece 1px solid;padding-bottom:5px;background-color:#fbfbfb;min-height:40px;padding-left:5px;width:650px;padding-right:5px;overflow:auto;border-top:#cecece 1px solid;border-right:#cecece 1px solid;padding-top:5px;"><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;"><span style="color:#0000ff;">&lt;</span><span style="color:#800000;">block</span><span style="color:#0000ff;">&gt;</span>
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">  <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">prompt</span><span style="color:#0000ff;">&gt;</span>
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">value</span> <span style="color:#ff0000;">expr</span>=<span style="color:#0000ff;">&quot;ApplicationData['PassedInVar']&quot;</span> <span style="color:#0000ff;">/&gt;</span>                
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">  <span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">prompt</span><span style="color:#0000ff;">&gt;</span>            
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;"><span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">block</span><span style="color:#0000ff;">&gt;</span></pre></pre>
<strong>Passing Data Out</strong> 

<p>VoiceXML has a standard method of passing data out of an application using the <a href="http://www.vxml.org/frame.jsp?page=exit.htm" target="_blank">&lt;exit&gt;</a> tag (&lt;exit namelist=&quot;SomeVar&quot;/&gt;).&#160; Variables passed back via the "namelist" are stored as a Dictionary object in the ApplicationData collection. </p>

<p>Inside my VoiceXML application I'll declare a Var and return it in my &lt;exit&gt; tag. </p>

<pre style="border-bottom:#cecece 1px solid;border-left:#cecece 1px solid;padding-bottom:5px;background-color:#fbfbfb;min-height:40px;padding-left:5px;width:650px;padding-right:5px;overflow:auto;border-top:#cecece 1px solid;border-right:#cecece 1px solid;padding-top:5px;"><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;"><span style="color:#0000ff;">&lt;</span><span style="color:#800000;">block</span><span style="color:#0000ff;">&gt;</span> 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">prompt</span><span style="color:#0000ff;">&gt;</span> 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">        <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">value</span> <span style="color:#ff0000;">expr</span>=<span style="color:#0000ff;">&quot;ApplicationData['PassedInVar']&quot;</span> <span style="color:#0000ff;">/&gt;</span>                
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    <span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">prompt</span><span style="color:#0000ff;">&gt;</span> 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">var</span> <span style="color:#ff0000;">name</span>=<span style="color:#0000ff;">&quot;ReturnedVar&quot;</span> <span style="color:#ff0000;">expr</span>=<span style="color:#0000ff;">&quot;'The cat is black'&quot;</span> <span style="color:#0000ff;">/&gt;</span>        
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;">    <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">exit</span> <span style="color:#ff0000;">namelist</span>=<span style="color:#0000ff;">&quot;ReturnedVar&quot;</span><span style="color:#0000ff;">/&gt;</span> 
</pre><pre style="background-color:#fbfbfb;margin:0em;width:100%;font-family:consolas,'Courier New',courier,monospace;font-size:12px;"><span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">block</span><span style="color:#0000ff;">&gt;</span></pre></pre>

<p>Once back in the Workflow I'll extract the data from the ApplicationData collection's $_exit_ element. I'll drop a Code activity after the VXML activity with following in its ExecuteCode method:</p>

<div style="padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;display:inline;float:none;padding-top:0px;" id="scid:8eb9d37f-1541-4f29-b6f4-1eea890d4876:e9c0c0d7-7513-49c9-b479-baad3c02d8a7" class="wlWriterEditableSmartContent"><p><div><a href="http://www.massivescale.com/blog_files/CommunicatingVariablestoVoiceXML_14D56/VXMLVariableSample.zip" target="_self">Download Sample Project</a></div></p></div><img src="http://gotspeech.net/aggbug.aspx?PostID=10282" width="1" height="1">
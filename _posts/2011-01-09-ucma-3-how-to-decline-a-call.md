---
ID: 58
post_title: 'UCMA 3 How-To: Decline A Call'
author: Marc LaFleur
post_date: 2011-01-09 15:12:22
post_excerpt: |
  In Speech Server we had an activity for declining a call. Typically this was used when you wanted to pull your application "off-line" for some reason. UCMA 3.0 doesn't have this activity, but the Core API still has support for it.
layout: post
permalink: >
  http://massivescale.com/ucma-3-how-to-decline-a-call/
published: true
Image:
  - >
    http://gotspeech.net/aggbug.aspx?PostID=11183
sbg_selected_sidebar:
  - 'a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}'
sbg_selected_sidebar_replacement:
  - 'a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}'
views:
  - "1490"
dsq_thread_id:
  - "3562663115"
---
In Speech Server we had an activity for declining a call. Typically this was used when you wanted to pull your application "off-line" for some reason. UCMA 3.0 doesn't have this activity, but the Core API still has support for it.

Rather than declining the call within the Workflow, we'll be declining the call prior to the Workflow starting. I'll show how to do this using the out-of-the-box code you get when creating a new CommunicationWorkflow.

If you look inside Program.cs you'll find the StartWorkflow() method. When we reach this point in the application we already have a "call" object which makes it trivial to Decline the call.

The default code looks like this:
<div id="codeSnippetWrapper" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 20px 0px 10px; width: 97.5%; font-family: 'Courier New', courier, monospace; direction: ltr; max-height: 200px; font-size: 8pt; overflow: auto; cursor: text; border: silver 1px solid; padding: 4px;">
<div id="codeSnippet" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;">
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">private</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">void</span> StartWorkflow(Call call, SipRequestData requestData)</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span> {</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>   Debug.Assert(call != <span style="color: #0000ff;">null</span>, <span style="color: #006080;">"call != null"</span>);</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>   Debug.Assert(call <span style="color: #0000ff;">is</span> AudioVideoCall || call <span style="color: #0000ff;">is</span> InstantMessagingCall,</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span>       <span style="color: #006080;">"Only AudioVideoCall and InstantMessagingCall are subscribed to above."</span>);</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span></pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span>   WorkflowInstance workflowInstance = _workflowRuntime.CreateWorkflow(<span style="color: #0000ff;">typeof</span>(Workflow1));</pre>
</div>
</div>
We'll insert our code starting at line 6, we'll also add some intelligence so that it allows me to call from my developer line while rejecting everyone else.
<div id="codeSnippetWrapper" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 20px 0px 10px; width: 97.5%; font-family: 'Courier New', courier, monospace; direction: ltr; max-height: 200px; font-size: 8pt; overflow: auto; cursor: text; border: silver 1px solid; padding: 4px;">
<div id="codeSnippet" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;">
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">private</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">void</span> StartWorkflow(Call call, SipRequestData requestData)</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span> {</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>     Debug.Assert(call != <span style="color: #0000ff;">null</span>, <span style="color: #006080;">"call != null"</span>);</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>     Debug.Assert(call <span style="color: #0000ff;">is</span> AudioVideoCall || call <span style="color: #0000ff;">is</span> InstantMessagingCall,</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span>      <span style="color: #006080;">"Only AudioVideoCall and InstantMessagingCall are subscribed to above."</span>);</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span></pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span>     <span style="color: #0000ff;">if</span> (!call.RemoteEndpoint.Participant.UserAtHost.StartsWith(<span style="color: #006080;">"1234@"</span>))</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum8" style="color: #606060;">   8:</span>     {</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum9" style="color: #606060;">   9:</span>      call.Decline(<span style="color: #0000ff;">new</span> CallDeclineOptions(503));</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum10" style="color: #606060;">  10:</span>      <span style="color: #0000ff;">return</span>;</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum11" style="color: #606060;">  11:</span>     }</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum12" style="color: #606060;">  12:</span></pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum13" style="color: #606060;">  13:</span>     WorkflowInstance workflowInstance = _workflowRuntime.CreateWorkflow(<span style="color: #0000ff;">typeof</span>(Workflow1));</pre>
<pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum14" style="color: #606060;">  14:</span> ...</pre>
</div>
</div>
A couple of tips:
<ol>
	<li>Take a look at the call object. It has a lot of interesting properties that let you make intelligent decisions about the call before your workflow has started.</li>
	<li>Make sure you use a SIP code (CallDeclineOptions) that your gateways understand and make sense. You don't want to toss a BUSY HERE if it isn't in fact BUSY.</li>
</ol>
<img src="http://gotspeech.net/aggbug.aspx?PostID=11183" alt="" width="1" height="1" />
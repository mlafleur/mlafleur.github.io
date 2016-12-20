---
Title: >
  Avoiding Call Throttling on Outbound
  Calls
Published: 2009-07-23 09:06:36
Excerpt: ""
Tags:
  - 
    term_id: 110
    name: Skype
    slug: skype
    term_group: 0
    term_taxonomy_id: 114
    taxonomy: post_tag
    description: ""
    parent: 0
    count: 27
    filter: raw
    avhec_term_order: "0"
views:
  - 'a:1:{i:0;s:3:"427";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4633420889";}'
author:
  - Marc LaFleur
post_date:
  - 2009-07-23 09:06:36
post_excerpt:
  - ""
permalink:
  - >
    /avoiding-call-throttling-on-outbound-calls/
---
<p><a href="http://www.massivescale.com/blog_files/AvoidingCallThrottlingonOutboundCalls_8E27/image.png"><img style="border-right-width:0px;margin:0px 5px 15px 15px;display:inline;border-top-width:0px;border-bottom-width:0px;border-left-width:0px;" title="image" border="0" alt="image" align="right" src="http://www.massivescale.com/blog_files/AvoidingCallThrottlingonOutboundCalls_8E27/image_thumb.png" width="151" height="152" /></a>One of the most common ways of queuing outbound calls with Speech Server is by using the built in MSMQ support. For the most part, using a message queue is extremely straightforward and easy to implement. But there is one gotcha â€“ call throttling. </p>  <p>When an outbound call fails to connect, Speech Server will start throttling down the number of messages it pulls from the queue. The assumption is that failures are the result of your system having insufficient capacity to handle the load. The more failures your have, the more it will throttle the load. This would be acceptable if it were not for two issues: </p>  <ul>   <li>Almost any failure, even acceptable ones,&#160; can result in throttling </li>    <li>It will happy throttle you all the way down to 0, effectively shutting down your application </li> </ul>  <p>Disabling call throttling needs to be done on a per-call bases by binding to the TelephonySession.OpenCompleted event prior to the MakeCall Activity. Typically I do this in a Code Activity at the very top of my workflow. </p>  <p>Inside my initWorkflow Activity I bind to the OpenCompleted like so:</p>  <p>&#160;<font color="#0000ff" face="Courier New">TelephonySession.OpenCompleted += new EventHandler&lt;Microsoft.SpeechServer.AsyncCompletedEventArgs&gt;(TelephonySession_OpenCompleted);</font></p>  <p>Then I use the following to disable throttling on any failure:</p>  <blockquote>   <p><font color="#0000ff" face="Courier New">void TelephonySession_OpenCompleted(object sender, Microsoft.SpeechServer.AsyncCompletedEventArgs e)        <br />{         <br />&#160;&#160;&#160; if (e.Error != null &amp;&amp; e.Error is SipPeerException)         <br />&#160;&#160;&#160; {         <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; SipPeerException sipEx = e.Error as SipPeerException;         <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; sipEx.ShouldThrottleMsmqCalls = false;         <br />&#160;&#160;&#160; }         <br />}</font></p></blockquote><img src="http://gotspeech.net/aggbug.aspx?PostID=9209" width="1" height="1"/>
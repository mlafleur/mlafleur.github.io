---
Title: >
  Avoiding Call Throttling on Outbound
  Calls
Excerpt: ""
Tags:
  - Skype
---
<a href="http://www.massivescale.com/blog_files/AvoidingCallThrottlingonOutboundCalls_8E27/image.png"><img style="border-right-width:0px;margin:0px 5px 15px 15px;display:inline;border-top-width:0px;border-bottom-width:0px;border-left-width:0px;" title="image" border="0" alt="image" align="right" src="http://www.massivescale.com/blog_files/AvoidingCallThrottlingonOutboundCalls_8E27/image_thumb.png" width="151" height="152" /></a>One of the most common ways of queuing outbound calls with Speech Server is by using the built in MSMQ support. For the most part, using a message queue is extremely straightforward and easy to implement. But there is one gotcha €“ call throttling. 
  When an outbound call fails to connect, Speech Server will start throttling down the number of messages it pulls from the queue. The assumption is that failures are the result of your system having insufficient capacity to handle the load. The more failures your have, the more it will throttle the load. This would be acceptable if it were not for two issues: 
  <ul>   <li>Almost any failure, even acceptable ones,&#160; can result in throttling </li>    <li>It will happy throttle you all the way down to 0, effectively shutting down your application </li> </ul>  Disabling call throttling needs to be done on a per-call bases by binding to the TelephonySession.OpenCompleted event prior to the MakeCall Activity. Typically I do this in a Code Activity at the very top of my workflow. 
  Inside my initWorkflow Activity I bind to the OpenCompleted like so:
  &#160;TelephonySession.OpenCompleted += new EventHandler&lt;Microsoft.SpeechServer.AsyncCompletedEventArgs&gt;(TelephonySession_OpenCompleted);
  Then I use the following to disable throttling on any failure:
  <blockquote>   void TelephonySession_OpenCompleted(object sender, Microsoft.SpeechServer.AsyncCompletedEventArgs e)        <br />{         <br />&#160;&#160;&#160; if (e.Error != null &amp;&amp; e.Error is SipPeerException)         <br />&#160;&#160;&#160; {         <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; SipPeerException sipEx = e.Error as SipPeerException;         <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; sipEx.ShouldThrottleMsmqCalls = false;         <br />&#160;&#160;&#160; }         <br />}
</blockquote><img src="http://gotspeech.net/aggbug.aspx?PostID=9209" width="1" height="1"/>
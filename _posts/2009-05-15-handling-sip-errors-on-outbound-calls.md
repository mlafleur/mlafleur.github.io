---
Title: Handling SIP Errors on Outbound Calls
Published: 2009-05-15 12:31:21
Excerpt: ""
Tags: null
views:
  - 'a:1:{i:0;s:3:"414";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3593460826";}'
author:
  - Marc LaFleur
post_date:
  - 2009-05-15 12:31:21
post_excerpt:
  - ""
permalink:
  - /handling-sip-errors-on-outbound-calls/
---
<p>&#160;</p>  <p><a href="http://www.massivescale.com/blog_files/HandlingTelephonyErrorsonOutboundCalls_B83B/image.png" target="_blank"><img style="border-right-width:0px;margin:5px 0px 10px;display:inline;border-top-width:0px;border-bottom-width:0px;border-left-width:0px;" title="image" border="0" alt="image" align="right" src="http://www.massivescale.com/blog_files/HandlingTelephonyErrorsonOutboundCalls_B83B/image_thumb.png" width="157" height="204" /></a>When placing outbound calls there are a number of scenarios that you will want to apply business logic too. When your application reaches a BUSY number for example, you will need to make an appropriate decision as to how to process this result (should you redial, wait some amount of time and then redial, stop calling, etc). </p>  <p>In order to handle these events you will first need to catch them using the Fault Handler page. From here you define the workflows for processing each fault type.</p>  <p>The default project template for speech workflows includes two fault handlers. The first handles call disconnections (normally this happens when a caller hangs up) and a general fault handler for catching everything else.</p>  <p>We're going to add another one for trapping SIP results. This will fire off a code block where we will make decisions on how to handle the results we care about.&#160; </p>  <ol>   <li>From the toolbox, drag a new FaultHandler object into the fault handler's list. </li>    <li>On the Properties tab for the FaultHandler, open the details dialog for the FaultType property. </li>    <li>In the Type Name text box enter "Microsoft.SpeechServer.SipPeerException" and click ok. </li>    <li>Drop a Code activity into the workflow area of the new FaultHandler instance </li>    <li>Double-click the new Code activity to open the code view for the ExectuteCode event. </li> </ol>  <p>Now you can process the SipPeerException based on the ResponseCode you've received. For example:</p>  <div style="border-bottom:gray 1px solid;border-left:gray 1px solid;padding-bottom:4px;line-height:12pt;background-color:#f4f4f4;margin:20px 0px 10px;padding-left:4px;width:97.5%;padding-right:4px;font-family:consolas, 'Courier New', courier, monospace;max-height:200px;font-size:8pt;overflow:auto;border-top:gray 1px solid;cursor:text;border-right:gray 1px solid;padding-top:4px;">   <div style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">     <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">if (sipPeerFaultHandler.Fault is Microsoft.SpeechServer.SipPeerException)</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;"> {</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">     Microsoft.SpeechServer.SipPeerException ex = (Microsoft.SpeechServer.SipPeerException)sipPeerFaultHandler.Fault;</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">     switch (sipException.ResponseCode)</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">     {</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 486: // Decline with Busy Here</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 600: // Decline with Busy everywhere</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">             /*</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">              * </pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">              *  Handle your busy case here</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">              * </pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">              */</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">             break;</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">&#160;</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 480: // Temporarily unavailable</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 503: // Service Unavailable</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 603: // Decline</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 408: // Request Timeout</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 504: // Gateway Timeout</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 404: // Not Found</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 484: // Address Incomplete                 </pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 604: // Does Not Exist Anywhere</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 485: // Ambiguous</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         case 410: // Gone</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">         default:</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">             break;</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:white;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;">     }</pre>

    <pre style="border-bottom-style:none;padding-bottom:0px;line-height:12pt;border-right-style:none;background-color:#f4f4f4;margin:0em;padding-left:0px;width:100%;padding-right:0px;font-family:consolas, 'Courier New', courier, monospace;border-top-style:none;color:black;font-size:8pt;border-left-style:none;overflow:visible;padding-top:0px;"> }</pre>
  </div>
</div><img src="http://gotspeech.net/aggbug.aspx?PostID=8799" width="1" height="1"/>
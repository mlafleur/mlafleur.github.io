---
title: 'UCMA 3 How-To: Inbound Call Throttling'
excerpt: "Speech Server included a setting in the Administrator Console for inbound call throttling, simply set it and forget it. Here we'll discus how we can accomplish graceful inbound call throttling with UCMA 3.0."
tags:
  - Skype
---
Speech Server included a setting in the Administrator Console for inbound call throttling, simply set it and forget it. Here we'll discus how we can accomplish graceful inbound call throttling with UCMA 3.0.

The basis for what we're discussing here is covered in the prior article <a href="//massivescale.com/?p=58" target="_blank">"Decline A Call"</a>. We'll extend this code such that it checks for the number of calls currently connected to the application and gracefully declines calls with a busy signal we've reached capacity.

One thing to understand about UCMA applications is that there are two objects in play here. The first is the Conversation object, the second is the Call object. Each Conversation instance can have one or more Calls associated with it. This is because (unlike Speech Server) UCMA supports conferencing. A conference is a single Conversation involving multiple Calls. For most IVR style applications however you'll have only a single Call per Conversation. For this reason (and because frankly its easier to understand) our sample here will be counting the number of "Conversations" rather than the number of "Calls".

The ApplicationEndpoint class has a method called GetConverstations() which returns a generic collection of Conversation objects. When you create a new UCMA Workflow the default name for our ApplicationEnpoint is _endpoint.  By executing _endpoint.GetConverstaions().Count we get an integer representing the number of Conversations active on this endpoint. Because we're making some assumptions with our application (a. there is a 1:1 ration or Conversations to Calls and b. we've got a single endpoint) we can test this value against our maximum threshold.

For example, lets assume we have a maximum load of 50 calls:
<div id="codeSnippetWrapper" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 20px 0px 10px; width: 97.5%; font-family: 'Courier New', courier, monospace; direction: ltr; max-height: 200px; font-size: 8pt; overflow: auto; cursor: text; border: silver 1px solid; padding: 4px;">
<pre id="codeSnippet" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;">if (_endpoint.GetConversations().Count &gt; 50){

}</pre>
</div>
One note here, the call we are going decline here is included in GetConverstations().Count. We're not counting how many callers are within the Workflow, we counting the number of connections hitting the endpoint. This means there is a potential race condition here, if 50 people tried to call us at the exact same moment in time it would decline them all even though none of them had made it into the Workflow. Given how fast we reach this point it is unlikely, but it is something to keep in mind you are expecting that kind "instant load". In other words, American Idol needs a more nuanced method here.

Now that we've got our count, we can simply Decline the call and return the status 486 (BUSY HERE) trigger a busy signal to the caller:
<div id="codeSnippetWrapper" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 20px 0px 10px; width: 97.5%; font-family: 'Courier New', courier, monospace; direction: ltr; max-height: 200px; font-size: 8pt; overflow: auto; cursor: text; border: silver 1px solid; padding: 4px;">
<pre id="codeSnippet" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;">if (_endpoint.GetConversations().Count &gt; 50)
{    
     call.Decline(new CallDeclineOptions(486));
     return;
}</pre>
</div>
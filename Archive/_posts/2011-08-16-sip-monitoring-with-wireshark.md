---
ID: 749
post_title: SIP Monitoring with Wireshark
author: Marc LaFleur
post_date: 2011-08-16 21:34:00
post_excerpt: ""
layout: post
permalink: >
  http://massivescale.com/sip-monitoring-with-wireshark/
published: true
views:
  - "1641"
dsq_thread_id:
  - "3544912646"
---
<em>This topic comes up pretty often and while this article was originally written for Wireshark v1.05 in 2009, it still applies today. All of the instructions are accurate for Wireshark v1.6.1. </em>

Wireshark is a free tool for capturing network traffic. It is an invaluable resource for troubleshooting problems with VOIP calls. It is available for download from <a href="http://www.wireshark.org">www.wireshark.org</a> (current version for Windows as of this post is 1.05).

I'm going to walk through the steps required for setting up a basic trace with Wireshark. This will give you a view of the underlying SIP traffic between your speech platform and your SIP gateway.Â  Please note that this information isn't specific to Lync or UCMA so if you're using something else simply replace these references with your platform.

1) Download and install Wireshark from <a href="http://www.wireshark.org">www.wireshark.org</a> on the machine where Speech Server is installed.
<div style="width: 100%; padding-top: 15px;">

<a href="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkCaptureInterfaces.jpg" target="_blank"><img style="margin: 0px 0px 10px 15px; display: inline; border-width: 0px;" title="Wireshark- Capture Interfaces" src="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkCaptureInterfaces_thumb.jpg" alt="Wireshark- Capture Interfaces" width="244" height="80" align="right" border="0" /></a> 2) Now launch Wireshark and open up the "Capture" menu. Select "Interfaces" (the first item in the menu). This will open a window listing each of your network adapters, their current IP address and the number of packets currently travailing down the wire.

</div>
<div style="width: 100%; padding-top: 15px;">

3) Click the "Start" button for the interface that UCMA is using (sometimes it helps to run a call and see which interface has traffic).

</div>
<div style="width: 100%; padding-top: 15px;">

<a href="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkRawCaptureData.jpg" target="_blank"><img style="margin: 0px 0px 10px 15px; display: inline; border-width: 0px;" title="Wireshark- Raw Capture Data" src="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkRawCaptureData_thumb.jpg" alt="Wireshark- Raw Capture Data" width="244" height="171" align="right" border="0" /></a> 4) Now you should be seeing a flood of traffic in the Wireshark window. This is a real-time view of the data traveling up and down you're network connection (it is a bit scary how much traffic you see on a typical network). Of course as it stands right now there is far too much information being shown to parse through. To narrow our focus we'll apply a "Filter" for the traffic we want.

</div>
<div style="width: 100%; padding-top: 15px;">

<a href="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkSIPCaptureData.jpg" target="_blank"><img style="margin: 0px 0px 10px 15px; display: inline; border-width: 0px;" title="Wireshark - SIP Capture Data" src="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkSIPCaptureData_thumb.jpg" alt="Wireshark - SIP Capture Data" width="244" height="171" align="right" border="0" /></a> 5) In the Wireshark filter's box enter the value "sip" (all lowercase) and hit enter. This will filter out everything that isn't SIP traffic. In this screenshot you can see the traffic for a single call.

</div>
<div style="width: 100%; padding-top: 15px;">

<a href="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkSIPINVITE.jpg" target="_blank"><img style="margin: 7px 0px 10px 15px; display: inline; border-width: 0px;" title="Wireshark - SIP INVITE" src="http://www.massivescale.com/blog_files/BasicSIPTroubleshootingwithWireshark_B0A1/WiresharkSIPINVITE_thumb.jpg" alt="Wireshark - SIP INVITE" width="244" height="171" align="right" border="0" /></a>6) The top section shows a summary of each packet including the time, source and destination. The lower section shows the contents of the selected packet from above. It is this lower area where you can see the actual SIP traffic details. By expanding the "Session Initial Protocol" section for the first packet we can see the INVITE header that was sent to the gateway.

</div>
This is just a starting point. There are a lot of valuable functionality in Wireshark such as decoding the audio from the call, viewing ladder diagrams of the conversation, complex filtering rulesâ€¦ There is a lot in there. But every one of them starts with this simple collection process.

There is quite a bit of information in a typical SIP conversation and often times troubleshooting involves figuring out obscure differences between the server and the gateway SIP implementation. As an example, I once found a problem between the Nuance Voice Platform and an Acme Packet SBC involving the format of the ALLOW property of the SIP INVITE (turns out Nuance wants them all delimited on one line and Acme Packet put them out as separate elements). Without Wireshark I would have been trying to diagnose this blind.

The only downside is that you can only monitor conversations between two endpoints. For developers this means you can't easily view the conversations using the Visual Studio debugging tools. You need a gateway or remote SIP phone in order to see what information is being transmitted.
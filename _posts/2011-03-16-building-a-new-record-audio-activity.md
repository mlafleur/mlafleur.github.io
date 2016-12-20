---
Title: Building a New Record Audio Activity
Published: 2011-03-16 12:19:09
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
  - 'a:1:{i:0;s:4:"4156";}'
sbg_selected_sidebar:
  - 'a:1:{i:0;s:66:"a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}";}'
sbg_selected_sidebar_replacement:
  - 'a:1:{i:0;s:66:"a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538636414";}'
author:
  - Marc LaFleur
post_date:
  - 2011-03-16 12:19:09
post_excerpt:
  - ""
permalink:
  - /building-a-new-record-audio-activity/
---
One of the key activities missing from UCMA that we used in Speech Sever 2007 is the Record Audio Activity. This was one of my "go to" tools in the Speech Server arsenal, so I've been hurting without. So to eliminate my pain, and hopefully some other's, I've started building a replacement.Â  While what I've built so far isn't nearly feature-complete, it will hopefully provide a suitable starting point for those looking to simply record some audio. Trust me, starting from scratch wasn't much fun. It may seem simple (and it really is) but it was extremely unclear when I started. A special thanks to <a href="http://gotspeech.net/blogs/marshallharrison/default.aspx" target="_blank">Marshall Harrison</a> who helped me put this together.

<strong>What's Included</strong>
<ul>
	<li>InitialSilenceTimeout â€“ How long should we record silence before we decide the calling isn't going to start talking</li>
	<li>EndingSilenceTimeout â€“ How long should we record silence before we decided the caller has stopped talking</li>
	<li>FilePath â€“ Full path where we should save the file (this is new, it wasn't definable in Speech Server)</li>
	<li>AudioEncoding â€“ Format to encode the saved file as (Wma16Kbps,Wma48Kbps, Pcm16Khz or Pcm8Khz)</li>
	<li>RecordedLength - The length of the recorded made</li>
</ul>
<strong>What's Not Included</strong>
<ul>
	<li>LeadingSilenceTrimmedLength â€“ We're just saving the raw audio, there is no post-processing of the file</li>
	<li>TrailingSilenceTrimmedLength â€“ See above</li>
	<li>PlayBeep â€“ This object simply records audio, it doesn't play any prompts or tones</li>
	<li>PromptsÂ  - See above</li>
	<li>TerminationDigitsÂ  - The only method used for stopping recording at this point is silence from the caller</li>
	<li>CanBargeIn â€“ Given the lack of prompts, there was nothing to "barge in" on</li>
</ul>
I've included the full project (and the compiled Debug and Release versions) here:Â  <a rel="attachment wp-att-358" href="http://massivescale.azurewebsites.net/?attachment_id=358">AudioRecordingActivity1.2</a>

<del><strong>UPDATE: </strong>I've fixed a few issues and updated the download to v1.1.</del>

<strong><span style="color: #ff0000;">Update: </span></strong><span style="color: #ff0000;">We're now at v1.2. This version solves some problems with Properties when multiple copies of the activity are in the same workflow</span><span style="color: #ff0000;"> </span>
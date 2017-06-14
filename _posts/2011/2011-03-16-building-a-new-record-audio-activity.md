---
title: Building a New Record Audio Activity
excerpt: ""
tags:
  - Skype
---
One of the key activities missing from UCMA that we used in Speech Sever 2007 is the Record Audio Activity. This was one of my "go to" tools in the Speech Server arsenal, so I've been hurting without. So to eliminate my pain, and hopefully some other's, I've started building a replacement.  While what I've built so far isn't nearly feature-complete, it will hopefully provide a suitable starting point for those looking to simply record some audio. Trust me, starting from scratch wasn't much fun. It may seem simple (and it really is) but it was extremely unclear when I started. A special thanks to <a href="http://gotspeech.net/blogs/marshallharrison/default.aspx" target="_blank">Marshall Harrison</a> who helped me put this together.

## What's Included*
*   InitialSilenceTimeout €“ How long should we record silence before we decide the calling isn't going to start talking
*   EndingSilenceTimeout €“ How long should we record silence before we decided the caller has stopped talking
*   FilePath €“ Full path where we should save the file (this is new, it wasn't definable in Speech Server)
*   AudioEncoding €“ Format to encode the saved file as (Wma16Kbps,Wma48Kbps, Pcm16Khz or Pcm8Khz)
*   RecordedLength - The length of the recorded made

**What's Not Included**

*   LeadingSilenceTrimmedLength €“ We're just saving the raw audio, there is no post-processing of the file
*   TrailingSilenceTrimmedLength €“ See above
*   PlayBeep €“ This object simply records audio, it doesn't play any prompts or tones
*   Prompts  - See above
*   TerminationDigits  - The only method used for stopping recording at this point is silence from the caller
*   CanBargeIn €“ Given the lack of prompts, there was nothing to "barge in" on

I've included the full project (and the compiled Debug and Release versions) here:  <a rel="attachment wp-att-358" href="//massivescale.com/?attachment_id=358">AudioRecordingActivity1.2</a>

<del><strong>UPDATE: </strong>I've fixed a few issues and updated the download to v1.1.</del>

<strong>Update: </strong>We're now at v1.2. This version solves some problems with Properties when multiple copies of the activity are in the same workflow 
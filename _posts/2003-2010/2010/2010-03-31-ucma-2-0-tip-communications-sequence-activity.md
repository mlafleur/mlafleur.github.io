---
title: 'UCMA 2.0 Tip: Communications Sequence Activity'
excerpt: ""
tags:
  - Skype
---
I've been playing around with the UCMA 2.0 SDK for the last few weeks, mainly in preparation for the upcoming v.next release of Communication Server. For those interested in what comes after Speech Server it is a worthy endeavor to dig into the UCMA. Going forward the UCMA will be the tool we use.&#160; 
  When I first started playing I made one simple mistake that left me scratching my head for longer that I'd like to admit. In an effort to help others avoid my mistake (and to remind me should I forget again):
  <blockquote>   <strong>With the UCMA, all of your activities must live within a Communications Sequence Activity.</strong>
 </blockquote>  With Speech Server the tools automatically provide you with a "parent sequence" in which all your activities live. With the UCMA this isn't the case; you need to include it in your workflow. When you create a new project it provides this for you, just don't be like me and think its ok to just delete it€¦.
  FTR, the exception I received was:
  <blockquote>   System.InvalidOperationException: 'Workflow1' does not have a value for Call property. Please specify a name that corresponds to a call in the CommunicationsWorkflowRuntime service
</blockquote><img src="http://gotspeech.net/aggbug.aspx?PostID=10283" width="1" height="1"/>
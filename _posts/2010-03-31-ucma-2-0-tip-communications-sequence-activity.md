---
Title: 'UCMA 2.0 Tip: Communications Sequence Activity'
Published: 2010-03-31 11:34:19
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
  - 'a:1:{i:0;s:4:"1211";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538636369";}'
author:
  - Marc LaFleur
post_date:
  - 2010-03-31 11:34:19
post_excerpt:
  - ""
permalink:
  - >
    /ucma-2-0-tip-communications-sequence-activity/
---
<p>I've been playing around with the UCMA 2.0 SDK for the last few weeks, mainly in preparation for the upcoming v.next release of Communication Server. For those interested in what comes after Speech Server it is a worthy endeavor to dig into the UCMA. Going forward the UCMA will be the tool we use.&#160; </p>  <p>When I first started playing I made one simple mistake that left me scratching my head for longer that I'd like to admit. In an effort to help others avoid my mistake (and to remind me should I forget again):</p>  <blockquote>   <p><strong>With the UCMA, all of your activities must live within a Communications Sequence Activity.</strong></p> </blockquote>  <p>With Speech Server the tools automatically provide you with a "parent sequence" in which all your activities live. With the UCMA this isn't the case; you need to include it in your workflow. When you create a new project it provides this for you, just don't be like me and think its ok to just delete itâ€¦.</p>  <p>FTR, the exception I received was:</p>  <blockquote>   <p>System.InvalidOperationException: 'Workflow1' does not have a value for Call property. Please specify a name that corresponds to a call in the CommunicationsWorkflowRuntime service</p></blockquote><img src="http://gotspeech.net/aggbug.aspx?PostID=10283" width="1" height="1"/>
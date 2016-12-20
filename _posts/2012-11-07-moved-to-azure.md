---
Title: Moved to Azure
Published: 2012-11-07 00:25:09
Excerpt: "Well now I've gone and done it, I've moved this site over to Azure. Overall the experience was pretty painless."
views:
  - 'a:1:{i:0;s:3:"405";}'
networkpub_postmessage:
  - 'a:1:{i:0;s:0:"";}'
networkpub_twitterhandle:
  - 'a:1:{i:0;s:0:"";}'
networkpub_twitterhash:
  - 'a:1:{i:0;s:0:"";}'
networkpub_ogtype_facebook:
  - 'a:1:{i:0;s:0:"";}'
networkpub_post_image_video:
  - 'a:1:{i:0;s:0:"";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538706432";}'
author:
  - Marc LaFleur
post_date:
  - 2012-11-07 00:25:09
post_excerpt:
  - "Well now I've gone and done it, I've moved this site over to Azure. Overall the experience was pretty painless."
permalink:
  - /moved-to-azure/
---
Well now I've gone and done it, I've moved this site over to Azure. Overall the experience was pretty painless.

Created a new <a href="http://www.windowsazure.com/en-us/home/scenarios/virtual-machines/">Windows Server 2012 VM</a> instance

<ol>
    <li>Installed WordPress and MySQL via the <a href="http://www.microsoft.com/web/downloads/platform.aspx">Web Platform Installer</a></li>
    <li>Imported my old MySQL Database</li>
</ol>

I have run into a few issues around MySQL. I exported my old data from MySQL using the only tool at my disposal, an automated backup from my old hosting provider. The problem with this method is that my character set information seemed to have gone sideways in the process. You'll see a number of jumbled quotations and apostrophes in some of the posts; something I unfortunately will need to manually fix at this point.

The entire VM creation and installation however was as flawless as installing on a local server; which of course is the entire point.
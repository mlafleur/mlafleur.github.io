---
Title: Moved to Azure
Excerpt: "Well now I've gone and done it, I've moved this site over to Azure. Overall the experience was pretty painless."
Tags:
  - Azure
  - Blogging
---
Well now I've gone and done it, I've moved this site over to Azure. Overall the experience was pretty painless.

Created a new <a href="http://www.windowsazure.com/en-us/home/scenarios/virtual-machines/">Windows Server 2012 VM</a> instance
<ol>
	<li>Installed WordPress and MySQL via the <a href="http://www.microsoft.com/web/downloads/platform.aspx">Web Platform Installer</a></li>
	<li>Imported my old MySQL Database</li>
</ol>
I have run into a few issues around MySQL. I exported my old data from MySQL using the only tool at my disposal, an automated backup from my old hosting provider. The problem with this method is that my character set information seemed to have gone sideways in the process. You'll see a number of jumbled quotations and apostrophes in some of the posts; something I unfortunately will need to manually fix at this point.

The entire VM creation and installation however was as flawless as installing on a local server; which of course is the entire point.
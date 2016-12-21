---
Title: Updating My PHP for WordPress
Published: 2014-10-17 12:12:49
Excerpt: "A few years ago I moved my blog to an Azure VM and it has been running flawlessly ever since. Thanks to WordPress' update process and automatic Windows Updates, there really wasn't much for me to manage. I have zero complaints."
Tags:
  - Azure
  - PHP
  - WordPress
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3565437765";}'
author:
  - Marc LaFleur
  - Marc LaFleur
post_date:
  - 2014-10-17 12:12:49
  - 2014-10-17 12:12:49
post_excerpt:
  - "A few years ago I moved my blog to an Azure VM and it has been running flawlessly ever since. Thanks to WordPress' update process and automatic Windows Updates, there really wasn't much for me to manage. I have zero complaints."
permalink:
  - /upgrading-php-on-azure/
  - /upgrading-php-on-azure/
---
A few years ago I moved my blog to an Azure VM and it has been running flawlessly ever since. Thanks to WordPress' update process and automatic Windows Updates, there really wasn't much for me to manage. I have zero complaints.

&nbsp;

Recently WordPress released version 4.0 and I decided to that that opportunity to take a assess the VM's state as well.  The first thing I noticed that that I was using <a href="http://php.net/ChangeLog-5.php#5.3.2" target="_blank">PHP 5.3</a> while PHP has since matured to <a href="http://php.net/ChangeLog-5.php#5.6.2" target="_blank">5.6</a>. Now WordPress had been running on PHP 5.3 without a hitch since day one so this wasn't something I needed to change but since when has that ever stopped me? I called the CEO (me) who referred me to the CTO (me) who told the Admin (me) to update PHP. I should state the the VP of Platform Stability (me) filed a formal objection to this but who listens to that luddite?

&nbsp;

Upgrading PHP is thankfully pretty trivial. I opened up the <a href="http://www.microsoft.com/web/downloads/platform.aspx" target="_blank">Web Platform Installer</a> and searched for PHP. The located four results, two for the IIS server and two for IIS Express. The two for IIS are the one's I was interested in.

&nbsp;

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image.png"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image_thumb.png" alt="image" width="644" height="441" border="0" /></a>

&nbsp;

<a href="http://windows.php.net/" target="_blank">PHP 5.6</a> is the full PHP platform plus the add-in <a href="http://phpmanager.codeplex.com/" target="_blank">PHP Manager for IIS</a>. Before installing it is important that first shut down IIS of the installation of PHP Manager will likely fail (requiring you to manually install it later because you will want it).

&nbsp;

<a href="http://www.iis.net/downloads/microsoft/wincache-extension" target="_blank">Windows Cache Extension 1.3 for PHP 5.6</a> is a PHP accelerator that caches compiled PHP content and code in memory. This has a dramatic affect on the performance of WordPress (the term "night and day" comes to mind). You absolutely want this.

&nbsp;

One I installed the bits I then needed to restart IIS and reconfigure the PHP version it was pointing at. This is done at the root IIS level using the PHP Manager we installed a moment ago.

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image1.png"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image_thumb1.png" alt="image" width="644" height="484" border="0" /></a>

&nbsp;

Opening up the manager presents you with the current PHP settings. Clicking on the "Change PHP Version" link opens up a simple dialog to select the version you want. It doesn't get much easier than this.

&nbsp;

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image2.png"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image_thumb2.png" alt="image" width="445" height="207" border="0" /></a>

&nbsp;

In most cases this is likely all anyone needs to do. In my case I had a couple of specific configuration changes to make. Because I upload large images and files, the default 2MB upload limit was always a problem for me so I'll change that to 200MB instead. I also use a specific temp directory for uploaded files. I use this because I have multiple PHP applications that live under the same IIS site and I was always running into odd permissions issues with file uploads. There are other ways to handle it but this was my solution.

&nbsp;

To make this changes I selected "Manage All Settings" from the PHP Manager and filtered on the word Upload. This gave me the settings I wanted to tweak.

&nbsp;

<a href="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image3.png"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="http://massivescale.blob.core.windows.net/blogmedia/2014/10/image_thumb3.png" alt="image" width="644" height="484" border="0" /></a>

&nbsp;

Once they were saved I restarted my app pools and went on my way. I can't say enough good things about the Web Platform Installer and the work that goes into make sure those packages install seamlessly.
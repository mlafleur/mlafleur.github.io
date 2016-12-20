---
ID: 1593
post_title: Status Update on Image Importer
author: Marc LaFleur
post_date: 2014-02-12 13:35:53
post_excerpt: "Back in October I wrote about a little app I built for Windows 8.1 called Image Importer. It is a rather simple app designed to replace two features previously available in Windows Essentials Live Gallery - the ability to import files into folders by Date Taken and remove files from the source media when completed. Since then I've made a few updates and learned a few lessons."
layout: post
permalink: >
  http://massivescale.com/status-update-on-image-importer/
published: true
dsq_thread_id:
  - "3546631268"
---
Back in October I wrote about a little app I built for Windows 8.1 called <a title="Image Importer" href="http://massivescale.azurewebsites.net/image-importer/">Image Importer</a>. It is a rather simple app designed to replace two features previously available in Windows Essentials Live Gallery - the ability to import files into folders by Date Taken and remove files from the source media when completed. Since then I've made a few updates and learned a few lessons.

One of the unexpected but should have expected I ran into had to do with how I filtered devices. In most cases the only devices someone would want to see are those with photos available to import. On my Surface Pro for example I use a 64GB SD card to store most of my personal files. I mapped Documents, Pictures, etc. here as well as my entire SkyDrive. Technically this SD Card is a "media device" and Image Importer dutifully listed it as an import location. Obviously this was a problem since I'm importing my photos to this device and importing to the device I'm importing from would violate the space time continuum. To solve this I wrote some code that filtered out devices that didn't use <a href="http://en.wikipedia.org/wiki/Design_rule_for_Camera_File_system" target="_blank">DCIM</a> storage structure that cameras use to store images. It was cleaver code but unfortunately sometimes a bit to clever since it turns out there are a number of low-end cameras that don't store images in a <a href="http://en.wikipedia.org/wiki/Design_rule_for_Camera_File_system" target="_blank">DCIM</a> structure. To solve this I added a "Show All Devices" option which turns off my clever little filter.

I've also added the ability to selected the destination folder. In the first version I used the default Pictures library and while that is where most users likely want them, there are a number of folks (myself included) that want to store them elsewhere. In my case I want to store them in the Skydrive folder so they automatically sync up to the cloud. I used the Pictures library because it is extremely simple to implement (select Pictures Library in the app's manifest and you have access to a known location) and to save somewhere else we need to ask the end user first.  This initially seemed annoying but thankfully Modern Apps have a nifty little feature for saving the user's selection called the AccessCache. By storing a token for the user's selection I only have to ask once. So by default I use Pictures Library but if someone wants to select a new location then they only have to do so once from Import Settings.

Along with selecting a custom destination folder I also enhanced the organization options. Previously it was limited to either Date Taken or Date Imported. Today there are a Imaged Importer supports seven different organization scenarios:
<ol>
	<li>[YEAR]\[DATE] (destination_folder\year\date\picture.jpg)</li>
	<li>[YEAR]\[DATE]\[EXT] (destination_folder\year\date\ext\picture.jpg)</li>
	<li>[DATE] (destination_folder\date\picture.jpg)</li>
	<li>[IMPORT_YEAR]\[IMPORT_DATE] (destination_folder\year\date\picture.jpg)</li>
	<li>[IMPORT_YEAR]\[IMPORT_DATE]\[EXT] (destination_folder\year\date\ext\picture.jpg)</li>
	<li>[IMPORT_DATE] (destination_folder\date\picture.jpg)</li>
	<li>[NONE] (destination_folder\picture.ext)</li>
</ol>
One of the joys in writing software is the ability to write some code and solve your own petty little problems; in this case replacing a missing a feature I used a lot. Guessing from the response I've received it seems that several others have found this little app useful which is really nice; another joy of writing software is the ability to share your solutions with others. Interested in doing something similar? Taking it in a different direction? <a href="https://github.com/mlafleur/ImageImport" target="_blank">Go for it, fork my code</a>.
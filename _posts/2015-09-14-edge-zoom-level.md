---
Title: Edge Zoom Level
Excerpt: "I recently ran into a odd problem where the Edge browser's default zoom level got stuck at 80%. This is how I fixed it. Full disclosure, this happened on an Insider build. As I signed up to eat this dog food, I can't really complain when it tastes like.... well, dog food. "
Tags:
  - Dog Food
  - Edge
  - Windows
---
I recently ran into a odd problem where the Edge browser's default zoom level got stuck at 80%. The frustrating bit was that changing it only effected the current page, clicking any link to a new page resulted that page displaying at 80%.  In my search for a fix I found a <a href="http://answers.microsoft.com/en-us/windows/forum/apps_windows_10-msedge/microsoft-edge-keep-changing-page-zoom/a6ea0236-cfd6-471e-b050-4f8776d257da" target="_blank">few others </a>with the<a href="http://forums.windowscentral.com/windows-10/381291-edge-default-page-zoom-windows-10-a.html" target="_blank"> same issue</a> (although everyone seems to have a different percentage, and most seemed to be &gt; 100%).

Before I explain how I resolved the problem there are a couple of vital caveats:
<ol>
	<li>I'm running an <a href="https://insider.windows.com/" target="_blank">Insider Build</a> so issues like this, while admittedly frustrating, are not expected. I signed up to eat the dog food, I can't really complain when it tastes like.... well, dog food.</li>
	<li>Fixing this requires editing the registry. <strong>If you are not sure you should do this then you shouldn't</strong>. Period. End of story. Got that? Going to ignore my warning anyway? No worries. I've got kids, I'm used to having my warnings ignored.</li>
</ol>
At the moment I'm unclear exactly how I got into a broken zoom state, but the fix seems to have held. I've been trying for a while to reproduce the problem but at the moment it seems to be holding steady.

Edge is a UWP application. As such, it's registry settings are a bit buried; they live under HKEY_CLASSES_ROOT rather than CURRENT_USER or LOCAL_MACHINE. In particular they can be found at <span style="font-family: Courier New">HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge</span>. <img class="alignnone size-full wp-image-6281" src="https://massivescale.blob.core.windows.net/blogmedia/2016/04/image1.png" alt="image1" width="711" height="537" />

From there you will find several subkeys, including one named Zoom. Zoom has a single DWORD value named ZoomFactor.

<img class="alignnone size-full wp-image-6291" src="https://massivescale.blob.core.windows.net/blogmedia/2016/04/image2.png" alt="image2.png" width="711" height="537" />

The value directly relates to the zoom percentage (which in my case was 80,000). Setting this value to 100,000 results in a 100% zoom.

<img class="alignnone size-full wp-image-6301" src="https://massivescale.blob.core.windows.net/blogmedia/2016/04/image3.png" alt="image3.png" width="331" height="199" />

Once I changes this to 100000, Edge began giving me the default I expected. For those looking for the “quick fix”, here is a Gist of the regex export:

https://gist.github.com/mlafleur/fc183f36e4ac85e926d5
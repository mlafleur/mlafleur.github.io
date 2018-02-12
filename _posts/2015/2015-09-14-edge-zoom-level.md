---
title: Edge Zoom Level
excerpt: >  
  I recently ran into a odd problem where the Edge browser's default zoom level got stuck at 80%. This is how I fixed it. Full disclosure, this happened on an Insider build. As I signed up to eat this dog food, I can't really complain when it tastes like... well, dog food.
tags:
  - Dog Food
  - Edge
  - Windows
Image: /assets/Edge-768x154.png
---

I recently ran into a odd problem where the Edge browser's default zoom level got stuck at 80%. The frustrating bit was that changing it only effected the current page, clicking any link to a new page resulted that page displaying at 80%.  In my search for a fix I found a [few others](http://answers.microsoft.com/en-us/windows/forum/apps_windows_10-msedge/microsoft-edge-keep-changing-page-zoom/a6ea0236-cfd6-471e-b050-4f8776d257da) with the [same issue](http://forums.windowscentral.com/windows-10/381291-edge-default-page-zoom-windows-10-a.html) (although everyone seems to have a different percentage, and most seemed to be > 100%).

Before I explain how I resolved the problem there are a couple of vital caveats:

* I'm running an [Insider Build](https://insider.windows.com/) so issues like this, while admittedly frustrating, are not expected. I signed up to eat the dog food, I can't really complain when it tastes like.... well, dog food.

* Fixing this requires editing the registry. **If you are not sure you should do this then you shouldn't**. Period. End of story. Got that? Going to ignore my warning anyway? No worries. I've got kids, I'm used to having my warnings ignored.

At the moment I'm unclear exactly how I got into a broken zoom state, but the fix seems to have held. I've been trying for a while to reproduce the problem but at the moment it seems to be holding steady.

Edge is a UWP application. As such, it's registry settings are a bit buried; they live under HKEY_CLASSES_ROOT rather than CURRENT_USER or LOCAL_MACHINE. In particular they can be found at `HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge`.

![registry-edge-1](/assets/images/registry-edge-1.png)

From there you will find several subkeys, including one named Zoom. Zoom has a single DWORD value named ZoomFactor.

![registry-edge-2](/assets/images/registry-edge-2.png)

The value directly relates to the zoom percentage (which in my case was 80,000). Setting this value to 100,000 results in a 100% zoom.

![registry-edge-3](/assets/images/registry-edge-3.png)

Once I changes this to 100000, Edge began giving me the default I expected. For those looking for the “quick fix”, here is a Gist of the regex export:

{% gist fc183f36e4ac85e926d5 %}

---
Title: 'Live Writer [Mostly] Lives On'
Excerpt: >
  I include myself in a long list of
  Windows Live Writer lovers. I’ve tried
  switching to other editors on multiple
  occasions but always end up returning.
  To be perfectly clear, all of
  alternatives I’ve tied worked as
  advertised. And in many cases I
  seriously considered switching. In the
  end however, they all failed to match
  the ease and simplicity of Live Writer.
Tags:
  - Blogging
  - Windows
Image: /assets/WLW-768x154.png
---
I include myself in a long list of [Windows](http://blogs.technet.com/b/stefan_stranger) [Live](http://weblogs.asp.net/ricardoperes) [Writer](http://www.hanselman.com/) [lovers](http://panicdatabase.blogspot.com/2015/05/using-windows-live-writer-for-blogger.html). I’ve tried switching to [other](/hello-world-its-onenote/) [editors](/word-as-blog-editor/) on multiple occasions but always end up returning. To be perfectly clear, all of alternatives I’ve tied worked as advertised. And in many cases I seriously considered switching. In the end however, they all failed to match the ease and simplicity of Live Writer.

This isn’t so say Live Writer is perfect. To call it long in the tooth would be substantially understating the current state of things. It is woefully outdated which in many ways stands testament to how good an editor it is, even today it’s the best option I’ve found.

I recently repaved a machine with Windows 10 and ran into a problem when I went to install Live Writer. While it the app has been outdated for years, this was the first time it simply wouldn’t install for me. Thankfully I wasn’t the only one who ran into this issue. [Stefan Stranger](http://blogs.technet.com/b/stefan_stranger/) was kind enough to [publish a solution](http://blogs.technet.com/b/stefan_stranger/archive/2015/07/24/installing-windows-live-writer-on-windows-10.aspx):

 1. Download [Windows Live Writer](http://wl.dlservice.microsoft.com/download/C/1/B/C1BA42D6-6A50-4A4A-90E5-FA9347E9360C/en/wlsetup-all.exe)
 2. Open a Command Prompt and navigate to the directory you downloaded the installer to.
 3. Execute the following command: `wlsetup-all.exe /AppSelect:Writer /q /log:C:\temp\Writer.Log /noMU /noHomepage /noSearch`

_One note, this method executes a silent install so give it a couple of minutes to finish. Once completed you will see Windows Live Writer show up in the Recently Added section of your Start menu._

Now that we have it installed, [Ricardo Peres](http://weblogs.asp.net/ricardoperes/) put together an [extensive list of WLF tricks.](http://weblogs.asp.net/ricardoperes/windows-live-writer-tricks) I pulled out the two I always use myself here:

#### Update the Default Templates
Windows Live Writer used to be able to import your blogs styles automatically. Unfortunately this feature doesn’t play well with the modern web. Thankfully you can customize the default styles yourself. The default HTML and CSS templates are located in the %ProgramFiles(x86)%\Windows Live\Writer\template directory. In my case simply copy and paste my site’s CSS into default.css and add the relevant class tags to the default.html.

#### Change the Rendering Engine
Windows Live Writer uses an embedded version of Internet Explorer for rendering your HTML. Unfortunately the version it uses predates HTML5. You can solve this by forcing IE to use a more recent version of the rendering engine.

1. From the Run Dialog enter `regedit`
2. Using the Tree control, navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION`
3. From the Edit menu, select New and DWORD (32-bit) Value
4. Enter WindowsLiveWriter.exe as the key name
5. Double-click your new key to open the editor dialog.
6. Select Decimal as your base and enter 11000 as the Vazlue (11000 is IE11, 10000 is IE10) 

Hopefully we will see some progress on <a href="http://www.winbeta.org/news/open-source-windows-live-writer-coming-soon">open sourcing Live Writer</a>. Until then however at least I can continue to use my favorite - albeit outdated - blog editor.
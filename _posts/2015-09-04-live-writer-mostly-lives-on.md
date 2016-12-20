---
Title: 'Live Writer [Mostly] Lives On'
Published: 2015-09-04 14:04:11
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
  - 
    term_id: 63
    name: Blogging
    slug: blogging
    term_group: 0
    term_taxonomy_id: 66
    taxonomy: post_tag
    description: ""
    parent: 0
    count: 4
    filter: raw
    avhec_term_order: "0"
  - 
    term_id: 96
    name: Windows
    slug: windows
    term_group: 0
    term_taxonomy_id: 100
    taxonomy: post_tag
    description: ""
    parent: 0
    count: 27
    filter: raw
    avhec_term_order: "0"
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4098053285";}'
author:
  - Marc LaFleur
post_date:
  - 2015-09-04 14:04:11
post_excerpt:
  - >
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
permalink:
  - /live-writer-mostly-lives-on/
---
I include myself in a long list of <a href="http://blogs.technet.com/b/stefan_stranger">Windows</a> <a href="http://weblogs.asp.net/ricardoperes">Live</a> <a href="http://www.hanselman.com/">Writer</a> <a href="http://panicdatabase.blogspot.com/2015/05/using-windows-live-writer-for-blogger.html">lovers</a>. I’ve tried switching to <a href="http://massivescale.com/hello-world-its-onenote/">other</a> <a href="http://massivescale.com/word-as-blog-editor/">editors</a> on multiple occasions but always end up returning. To be perfectly clear, all of alternatives I’ve tied worked as advertised. And in many cases I seriously considered switching. In the end however, they all failed to match the ease and simplicity of Live Writer.

This isn’t so say Live Writer is perfect. To call it long in the tooth would be substantially understating the current state of things. It is woefully outdated which in many ways stands testament to how good an editor it is, even today it’s the best option I’ve found.

I recently repaved a machine with Windows 10 and ran into a problem when I went to install Live Writer. While it the app has been outdated for years, this was the first time it simply wouldn’t install for me. Thankfully I wasn’t the only one who ran into this issue. <a href="http://blogs.technet.com/b/stefan_stranger/">Stefan Stranger</a> was kind enough to <a href="http://blogs.technet.com/b/stefan_stranger/archive/2015/07/24/installing-windows-live-writer-on-windows-10.aspx">publish a solution</a>:

<ol>
    <li>Download <a href="http://wl.dlservice.microsoft.com/download/C/1/B/C1BA42D6-6A50-4A4A-90E5-FA9347E9360C/en/wlsetup-all.exe">Windows Live Writer</a></li>
    <li>Open a Command Prompt and navigate to the directory you downloaded the installer to.</li>
    <li>Execute the following command:
<span style="font-family: courier new;">wlsetup-all.exe /AppSelect:Writer /q /log:C:tempWriter.Log /noMU /noHomepage /noSearch</span></li>
</ol>

<em>One note, this method executes a silent install so give it a couple of minutes to finish. Once completed you will see Windows Live Writer show up in the Recently Added section of your Start menu. </em>

Now that we have it installed, <a href="http://weblogs.asp.net/ricardoperes/">Ricardo Peres</a> put together an <a href="http://weblogs.asp.net/ricardoperes/windows-live-writer-tricks">extensive list of WLF tricks. </a>I pulled out the two I always use myself here:

<h4>Update the Default Templates</h4>

Windows Live Writer used to be able to import your blogs styles automatically. Unfortunately this feature doesn’t play well with the modern web. Thankfully you can customize the default styles yourself. The default HTML and CSS templates are located in the %ProgramFiles(x86)%Windows LiveWritertemplate directory. In my case simply copy and paste my site’s CSS into default.css and add the relevant class tags to the default.html.

<h4>Change the Rendering Engine</h4>

Windows Live Writer uses an embedded version of Internet Explorer for rendering your HTML. Unfortunately the version it uses predates HTML5. You can solve this by forcing IE to use a more recent version of the rendering engine.

<ol>
    <li>From the Run Dialog enter “regedit”</li>
    <li>Using the Tree control, navigate to HKEY_LOCAL_MACHINESOFTWAREWow6432NodeMicrosoftInternet ExplorerMainFeatureControlFEATURE_BROWSER_EMULATION</li>
    <li>From the Edit menu, select New and DWORD (32-bit) Value</li>
    <li>Enter WindowsLiveWriter.exe as the key name</li>
    <li>Double-click your new key to open the editor dialog.</li>
    <li>Select Decimal as your base and enter 11000 as the Vazlue (11000 is IE11, 10000 is IE10)
<a href="https://massivescale.blob.core.windows.net/blogmedia//2015/09/image.png"><img style="border: 0px currentcolor; display: inline; background-image: none;" title="image" src="https://massivescale.blob.core.windows.net/blogmedia//2015/09/image_thumb.png" alt="image" width="337" height="199" border="0" /></a></li>
</ol>

Hopefully we will see some progress on <a href="http://www.winbeta.org/news/open-source-windows-live-writer-coming-soon">open sourcing Live Writer</a>. Until then however at least I can continue to use my favorite - albeit outdated - blog editor.
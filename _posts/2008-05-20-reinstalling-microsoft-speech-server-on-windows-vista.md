---
Title: >
  Reinstalling Microsoft Speech Server on
  Windows Vista
Published: 2008-05-20 13:51:07
Excerpt: ""
Tags: Skype
views:
  - 'a:1:{i:0;s:3:"369";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538635110";}'
author:
  - Marc LaFleur
post_date:
  - 2008-05-20 13:51:07
post_excerpt:
  - ""
permalink:
  - >
    /reinstalling-microsoft-speech-server-on-windows-vista/
---
<p>If you're thinking of uninstalling/reinstalling Microsoft Speech Server on Windows Vista then this post might prove helpful. </p>  <p>It seems that Speech Server Setup doesn't do such a good job uninstalling itself from Vista. And when you reinstall the server it fails to properly configure IIS. Namely it has a number of problems dealing with the *.speax exemption. This results it 404.2 and 500 errors being returned by IIS when you attempt to launch a Speech Server application.</p>  <p>The workaround I've found for this issue requires manually mapping the handler for *.speax in your application's web.config. Adding the following to the &lt;system.webServer&gt; section will map IIS to the correct handler:</p>  <blockquote>   <p>&lt;system.webServer&gt;      <br />&lt;handlers&gt;       <br />&lt;remove name=&quot;MSSCustomMap&quot; /&gt;       <br />&lt;add name=&quot;MSSCustomMap&quot; path=&quot;*.speax&quot; verb=&quot;*&quot; modules=&quot;IsapiModule&quot; scriptProcessor=&quot;C:WindowsMicrosoft.NETFrameworkv2.0.50727aspnet_isapi.dll&quot; resourceType=&quot;Unspecified&quot; requireAccess=&quot;Script&quot; responseBufferLimit=&quot;0&quot; /&gt;       <br />&lt;/handlers&gt;       <br />&lt;/system.webServer&gt; </p></blockquote>
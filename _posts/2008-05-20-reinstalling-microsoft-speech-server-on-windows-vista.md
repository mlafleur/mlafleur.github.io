---
Title: >
  Reinstalling Microsoft Speech Server on
  Windows Vista
Excerpt: ""
Tags:
  - Skype
---
<p>If you're thinking of uninstalling/reinstalling Microsoft Speech Server on Windows Vista then this post might prove helpful. </p>  <p>It seems that Speech Server Setup doesn't do such a good job uninstalling itself from Vista. And when you reinstall the server it fails to properly configure IIS. Namely it has a number of problems dealing with the *.speax exemption. This results it 404.2 and 500 errors being returned by IIS when you attempt to launch a Speech Server application.</p>  <p>The workaround I've found for this issue requires manually mapping the handler for *.speax in your application's web.config. Adding the following to the &lt;system.webServer&gt; section will map IIS to the correct handler:</p>  <blockquote>   <p>&lt;system.webServer&gt;      <br />&lt;handlers&gt;       <br />&lt;remove name=&quot;MSSCustomMap&quot; /&gt;       <br />&lt;add name=&quot;MSSCustomMap&quot; path=&quot;*.speax&quot; verb=&quot;*&quot; modules=&quot;IsapiModule&quot; scriptProcessor=&quot;C:WindowsMicrosoft.NETFrameworkv2.0.50727aspnet_isapi.dll&quot; resourceType=&quot;Unspecified&quot; requireAccess=&quot;Script&quot; responseBufferLimit=&quot;0&quot; /&gt;       <br />&lt;/handlers&gt;       <br />&lt;/system.webServer&gt; </p></blockquote>
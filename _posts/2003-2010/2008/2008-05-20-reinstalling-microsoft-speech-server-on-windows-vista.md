---
title: >
  Reinstalling Microsoft Speech Server on
  Windows Vista
excerpt: ""
tags:
  - Skype
---
If you're thinking of uninstalling/reinstalling Microsoft Speech Server on Windows Vista then this post might prove helpful. 
  It seems that Speech Server Setup doesn't do such a good job uninstalling itself from Vista. And when you reinstall the server it fails to properly configure IIS. Namely it has a number of problems dealing with the *.speax exemption. This results it 404.2 and 500 errors being returned by IIS when you attempt to launch a Speech Server application.
  The workaround I've found for this issue requires manually mapping the handler for *.speax in your application's web.config. Adding the following to the &lt;system.webServer&gt; section will map IIS to the correct handler:
  <blockquote>   &lt;system.webServer&gt;      <br />&lt;handlers&gt;       <br />&lt;remove name="MSSCustomMap" /&gt;       <br />&lt;add name="MSSCustomMap" path="*.speax" verb="*" modules="IsapiModule" scriptProcessor="C:WindowsMicrosoft.NETFrameworkv2.0.50727aspnet_isapi.dll" resourceType="Unspecified" requireAccess="Script" responseBufferLimit="0" /&gt;       <br />&lt;/handlers&gt;       <br />&lt;/system.webServer&gt; 
</blockquote>
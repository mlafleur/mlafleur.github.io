---
Title: >
  Solving an Outlook.com and Outlook
  Authentication Problem
Excerpt: >
  I’ve been trying off and on for some
  time now to add my Outlook.com account
  to Outlook 2013. I’ve used this setup
  for years but recently it stopped
  working. Every time I tried to add it
  Outlook would return an error. In one of
  those face-palm moments I realized what
  changed.
Tags:
  - Office
  - Outlook
  - Outlook.com
---
I’ve been trying off and on for some time now to add my Outlook.com account which I use for personal email to Outlook 2013 so that I can see both my personal and professional calendars side-by-side in Outlook. I’ve used this set up for years but recently it stopped working. Every time I tried to add it Outlook would return an error.
<blockquote>Log onto Exchange ActiveSync mail server (EAS): The username or password you entered isn't working. Please try typing them again.</blockquote>
Now I know this worked before and for the life of me I could figure out what changed. I did some searching and often found <a href="http://answers.microsoft.com/en-us/office/forum/office_2013_release-outlook/which-outlookcom-accountalias-to-add-to-outlook/15dd69d0-d627-4d2c-b9b1-89f26723a9bf" target="_blank">others with the same problem</a>. What I couldn’t find was a solution. Until now.

In one of those face-palm moments I realized what changed. I had enabled Two-step verification to my Microsoft ID a while back. Anyone who has done this (and everyone should) will know that some apps don’t work with two-step and require a special “<a href="http://windows.microsoft.com/en-us/windows/app-passwords-two-step-verification" target="_blank">App Password</a>” (Your Xbox Live account on the Xbox 360 is a common example). Sure enough, I generated an App Password and used that instead of my actual password and it just worked.

In detail, here is how to configure user when using Two-Step verification:

With EAS you can get your email immediately, as well as see all your folders, calendar and contacts in one place. If your email app supports Exchange ActiveSync and you need to configure it manually, use the following settings.
<ul>
	<li>Server address: s.outlook.com</li>
	<li>Domain: &lt;leave empty&gt;</li>
	<li>User name: Your email address</li>
	<li>Password: <em>Your app password crated using <a href="http://windows.microsoft.com/en-us/windows/app-passwords-two-step-verification" target="_blank">this process</a></em></li>
	<li>TLS/SSL encryption required: Yes</li>
</ul>
Hopefully this post will show up in enough search results that others can avoid this problem in the future.
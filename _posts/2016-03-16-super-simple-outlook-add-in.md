---
Title: Super Simple Outlook Add-in
Published: 2016-03-16 13:24:20
Excerpt: >
  Building a very simple add-in using just
  a single HTML page, a couple of images
  assets and an XML manifest file that
  tells Outlook what to do. All stored on
  GitHub and hosted on Azure for free.
Tags: >
  Add-ins, JavaScript, Office, Outlook,
  Outlook.com
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4668288312";}'
author:
  - Marc LaFleur
post_date:
  - 2016-03-16 13:24:20
post_excerpt:
  - >
    Building a very simple add-in using just
    a single HTML page, a couple of images
    assets and an XML manifest file that
    tells Outlook what to do. All stored on
    GitHub and hosted on Azure for free.
permalink:
  - /super-simple-outlook-add-in/
---
I spend the bulk of my life working on <a href="http://dev.office.com">Office Extensibility</a> projects.  These come in two flavors, <a href="https://msdn.microsoft.com/en-us/library/office/jj220060.aspx">Office Add-ins</a> and <a href="http://dev.office.com/chooseapiendpoint">Office API</a> integration. They both serve the same purpose, allowing developers to interact with Office in some way; Add-Ins by adding functionality to the Office client (Word, PowerPoint, Excel, Outlook, etc.)  and Office APIs by allowing Office functionality to existing apps (both native and web)

Of all of the Office extensibility stories, my personal favorite is <a href="http://dev.outlook.com">Outlook</a>. As much as I love all of the new communication tools that have cropped up in recent years, Outlook is still where I spend the bulk of my time. It remains the system of record for the torrent of emails, appointments and contacts I have to manage each day.

The best part about building these add-ins, they are incredibly simple to build. They are stripped down web apps. If you have an API and some basic HTML/JS chops, then you're well on your way.

In fact, I'm going to show you just how easy this is. I'm going to build a very simple add-in using a single HTML page, a couple of images assets and an XML manifest file that tells Outlook what to do.

To start, we need to put together the list of libraries we need. Some are required, others we're using to make life a little easier. In each case however we are leveraging someone else's CDN to host them.

<ul>
<li><a href="http://jquery.com/">JQuery</a> - jquery is so common it may as well be baked into browsers at this point (required).</li>
<li><a href="https://msdn.microsoft.com/en-us/library/office/fp142185.aspx">Office.js</a>  - this is the core Office lib and provides the API and object model we need for interacting with Outlook (required).</li>
<li><a href="https://github.com/janl/mustache.js">Mustache.js</a> - mustache is a stripped down HTML/JS templating engine that makes rendering list of objects a heck of a lot easier (optional).</li>
<li><a href="http://dev.office.com/fabric">Office UI Fabric</a> - a UX framework designed for Office add-ins. I'm using this to handle rendering my Persona Cards (optional).</li>
</ul>

My add-in here will be very simple. I'm going to inspect an email or appointment and render anyone on the from, to or cc line as a <a href="http://dev.office.com/fabric/components/personacard">Persona Card</a> using the Office UI Fabric.  All of this will be done in a single HTML page. It will support the bare-bones API ensuring this add-in will work across platforms (Outlook for Windows, Outlook for Mac, Outlook.com, OWA, etc.).

To start, we'll build out the basic page framework:

https://gist.github.com/mlafleur/0e112756cb85f0bb550e

Next we'll add a

<div> to hold our Persona Cards. We'll use the ms-Grid class to manage rendering the cards in a responsive grid.

https://gist.github.com/mlafleur/0db5eedef0fa0c1a76d8

We also need to add a template for rendering each persona card. This is where we'll leverage mustache.

https://gist.github.com/mlafleur/ffe1b7efa95a0d9e87a9

Finally, we will execute some javascript during initialization that will parse the recipients. This is done by making calls to the Office.js API asking for specific metadata from the current mail item.

__Note that we first determine if this is an email or an appointment. This is because emails us from, to and cc fields while appointments use originator, required attendees and optional attendees. In the end we will render them identically.__

After building up an array of recipients, we use mustache to render our template and append this to the ms-Grid row we defined earlier.

https://gist.github.com/mlafleur/5dc184b0b0ba91a06035

We then define a manifest file that tells Outlook the who, what, where and when of rendering this add-in. This is pretty self-explanatory and mostly boilerplate so I won't go into detail here. For reference however, you can see the finished manifest on [GitHub](https://github.com/mlafleur/super-simple-outlook-add-in/blob/master/manifest.xml).


This entire project lives is available at [https://github.com/mlafleur/super-simple-outlook-add-in.](https://github.com/mlafleur/super-simple-outlook-add-in.) Aside from providing a great place to store my code, GitHub also makes it trivial for me to host the add-in using Azure. I created a free Azure Web App and simply pointed it at my repo. Within moments I had a fully working add-in ready to go.


If your interested in trying this out for yourself, you can see it in action. You can [manage add-ins from your O365 mailbox settings](https://outlook.office.com/owa/?path=/options/manageapps). From here, select "Add from URL" and past in [https://officekiss.azurewebsites.net/manifest.xml](https://officekiss.azurewebsites.net/manifest.xml). You will then see Persona Cards show up in all of your Outlook clients.</div>
---
title: Super Simple Outlook Add-in
subtitle: Building an add-in using nothing more than a static HTML page and a Manifest
excerpt: >
  Building a very simple add-in using just
  a single HTML page, a couple of images
  assets and an XML manifest file that
  tells Outlook what to do. All stored on
  GitHub and hosted on Azure for free.
tags:
  - Add-ins
  - JavaScript
  - Office
  - Outlook
  - Outlook.com
image: /assets/Office-768x154.png
---

I spend the bulk of my life working on [Office Extensibility](http://dev.office.com) projects, otherwise known as [Office Add-ins](https://docs.microsoft.com/office/dev/add-ins/). Add-Ins allow developers to extend the functionality of Office clients (Word, PowerPoint, Excel, Outlook, etc.).

Of all of the Office extensibility stories, my personal favorite is [Outlook](https://dev.office.com/docs/add-ins/outlook/overview). As much as I love all of the new communication tools that have cropped up in recent years, Outlook is still where I spend the bulk of my time. It remains the system of record for the torrent of emails, appointments and contacts I have to manage each day.

The best part about building these add-ins, they are incredibly simple to build. They are stripped down web apps. If you have an API and some basic HTML/JS chops, then you're well on your way.

In fact, I'm going to show you just how easy this is. I'm going to build a very simple add-in using a single HTML page, a couple of images assets and an XML manifest file that tells Outlook what to do.

To start, we need to put together the list of libraries we need. Some are required, others we're using to make life a little easier. In each case however we are leveraging a 3rd party's CDN to host them.

* [JQuery](http://jquery.com/) - jquery is so common it may as well be baked into browsers at this point (required).

* [Office.js](https://dev.office.com/reference/add-ins/javascript-api-for-office)  - this is the core Office lib and provides the API and object model we need for interacting with Outlook (required).

* [Mustache.js](https://github.com/janl/mustache.js) - mustache is a stripped down HTML/JS template engine that makes rendering list of objects a heck of a lot easier (optional).

* [Office UI Fabric](http://dev.office.com/fabric) - a UX framework designed for Office add-ins. I'm using this to handle rendering my Persona Cards (optional).

My add-in here will be very simple. I'm going to inspect an email or appointment and render anyone on the from, to or cc line as a [Persona Card](http://dev.office.com/fabric/components/personacard) using the Office UI Fabric.  All of this will be done in a single HTML page. It will support the bare-bones API ensuring this add-in will work across platforms (Outlook for Windows, Outlook for Mac, Outlook.com, OWA, etc.).

To start, we'll build out the basic page framework:

```html
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8" />
    
    <!-- Office UX Frabic -->
    <link rel="stylesheet" href="//appsforoffice.microsoft.com/fabric/2.0.1/fabric.min.css">
    <link rel="stylesheet" href="//appsforoffice.microsoft.com/fabric/2.0.1/fabric.components.min.css">
</head>
<body class="ms-font-m">
    
    <div>
    <!-- Page Content -->
    </div>

    <!-- JQuery v2.2.0 (via ASP.NET's' CDN) -->
    <script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.0.min.js"></script>
    
    <!-- Office.js v1 (via Office's' CDN) -->
    <script src="//appsforoffice.microsoft.com/lib/1/hosted/office.js" type="text/javascript"></script>
    
    <!-- Mustache.js v2.2.1 (via CouldFlare's' CDN) -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/mustache.js/2.2.1/mustache.min.js"></script>

    <script type="text/javascript">
       // Office.initialize fires as soon as our add-in is wired up and ready to execute
        Office.initialize = function (reason) {
            $(document).ready(function () {

            });
        };
    </script>
</body>
</html>
```

Next we'll add a `<div>` to hold our Persona Cards. We'll use the ms-Grid class to manage rendering the cards in a responsive grid.

```html
<div class="ms-Grid">
    <div class="ms-Grid-row" id="persona-cards">
    </div>
</div>
```

We also need to add a template for rendering each persona card. This is where we'll leverage mustache.

```
{% raw %}
<!-- Mustache template we'll use for rendering each Persona Cards -->
<script id="template" type="x-tmpl-mustache">
    <div class="ms-Grid-col" style="padding:5px">
        <div class="ms-PersonaCard">
            <div class="ms-PersonaCard-persona">
                <div class="ms-Persona ms-Persona--xl">
                    <div class="ms-Persona-imageArea">
                        <div class="ms-Persona-initials ms-Persona-initials--blue">{{initials}}</div>
                    </div>
                    <div class="ms-Persona-details">
                        <div class="ms-Persona-primaryText">{{name}}</div>
                        <div class="ms-Persona-secondaryText">{{address}}</div>
                        <div class="ms-Persona-tertiaryText">{{subject}}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>
{% endraw %}
```

Finally, we will execute some javascript during initialization that will parse the recipients. This is done by making calls to the Office.js API asking for specific metadata from the current mail item.

> **Note**: We need determine if the `itemType` is a `Office.MailboxEnums.ItemType.Message` or `Office.MailboxEnums.ItemType.Appointment` since they have uniquire property sets. Where Messages contain  `from`, `to` and `cc` properties, Appointments contain  `organizer`, `requiredAttendees` and `optionalAttendees`. In the ene, we render them using the same template, we simply populate the template fields with the approtiate property set. 

After building up an array of recipients, we use mustache to render our template and append this to the ms-Grid row we defined earlier.

```html
<script type="text/javascript">
    // Compile the mustache template 
    var template = $('#template').html();
    // Office.initialize fires as soon as our add-in is wired up and ready to execute
    Office.initialize = function (reason) {
        $(document).ready(function () {
            
            // Parse the Mustache template (optional but speeds things up)
            Mustache.parse(template);   
            var from;
            var to = [];
            var cc = [];
            
            // Recast the item to make things easier to work with                
            var item = Office.cast.item.toItemRead(Office.context.mailbox.item);
           
            // If this is an Email Maessage 
            if (item.itemType === Office.MailboxEnums.ItemType.Message) {
                from = Office.cast.item.toMessageRead(item).from;
                to = Office.cast.item.toMessageRead(item).to;
                cc = Office.cast.item.toMessageRead(item).cc;
            }
            
            // Else of this is an Appointment
            else if (item.itemType === Office.MailboxEnums.ItemType.Appointment) {
                from = Office.cast.item.toAppointmentRead(item).organizer;
                to = Office.cast.item.toAppointmentRead(item).requiredAttendees;
                cc = Office.cast.item.toAppointmentRead(item).optionalAttendees;
            }
            // Render the Persona Cards for everyone involved
            renderPersona(from);
            for (var i in to) { renderPersona(to[i]); };
            for (var i in cc) { renderPersona(cc[i]); };
        });
        // This function handles rendering of the persona card
        // including generation of the recipient's initials 
        function renderPersona(persona) {
            var initials = persona.displayName.match(/\b\w/g);
            initials = (initials.shift() + initials.pop()).toUpperCase();
            var rendered = Mustache.render(template, {
                initials: initials,
                name: persona.displayName,
                address: persona.emailAddress,
            });
            $('#persona-cards').append(rendered);
        }
    };
</script>
```

We then define a manifest file that tells Outlook the who, what, where and when of rendering this add-in. This is pretty self-explanatory and mostly boilerplate so I won't go into detail here. For reference however, you can see the finished manifest on [GitHub](https://github.com/mlafleur/super-simple-outlook-add-in/blob/master/manifest.xml).

This entire project lives is available at [https://github.com/mlafleur/super-simple-outlook-add-in.](https://github.com/mlafleur/super-simple-outlook-add-in.) 

If your interested in trying this out for yourself, you can see it in action. You can [manage add-ins from your O365 mailbox settings](https://outlook.office.com/owa/?path=/options/manageapps). From here, select "Add from URL" and paste in [`https://officekiss.azurewebsites.net/manifest.xml`](https://officekiss.azurewebsites.net/manifest.xml). You will then see Persona Cards show up in all of your Outlook clients.

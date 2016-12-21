---
Title: The Magical Little Photon
Published: 2015-07-01 15:25:42
Excerpt: "I've been playing around with the latest goody from the folks over at Particle and it just became my go-to microcontroller. "
Tags: >
  Core, IoT, Maker, Particle, Photon,
  Spark
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3984269923";}'
author:
  - Marc LaFleur
post_date:
  - 2015-07-01 15:25:42
  - 2015-07-01 15:25:42
post_excerpt:
  - "I've been playing around with the latest goody from the folks over at Particle and it just became my go-to microcontroller. "
  - "I've been playing around with the latest goody from the folks over at Particle and it just became my go-to microcontroller. "
permalink:
  - /the-magical-little-photon-4/
  - /the-magical-little-photon-4/
---
<p style="text-align: justify;">I've been playing around with the latest goody from the folks over at <a href="http://www.particle.io">Particle</a> (formally Spark.io). It's called <a href="http://www.particle.io/prototype#photon">Photon</a> and it represents a nice evolutionary step forward from the original <a href="http://www.particle.io/prototype#spark-core">Spark Core</a>.</p>

The Photon shares a lot with its sibling Core. They use the same development language and APIs (a variant of Arduino C). Both devices leverage Particle's web-based IDE for building and publishing firmware. They also both come with built-in support for Particle's Cloud API so you can start putting the I in IoT right out of the box.

Where things get interesting is where they differ. For all of the similarities, they've made several very smart improvements to the Photon:

<h3 style="margin-top: inherit; margin-bottom: inherit;">Size</h3>

Okay, so no one ever saw the Core and thought "gee that thing is big". The Core was surprisingly small considering what it was.

This time they went smaller. Honestly, when you unbox the Photon you will almost assuredly think they forgot to send you everything. It is that small. We're talking guitar pick small here.

<img class=" aligncenter" src="http://massivescale.azurewebsites.net/wp-content/uploads/imported-onenote-images/onenote-556b689479d059.58650877.jpeg" alt="" width="273.5" height="154" data-src-type="image/jpeg" data-fullres-src="https://www.onenote.com/api/v1.0/resources/0-5de5296c86124e249a7f6f70a87ff4bd!1-9038EB8999860402!1315501/$value" data-fullres-src-type="image/jpeg" />

<h3 style="margin-top: inherit; margin-bottom: inherit;">WiFi</h3>

While I really loved the Core, I had more than my fair share of frustration getting it onto WiFi. It required a serial connection to configure and was often finicky about the router. Whenever I took a Core on the road I always made sure I configured it to use my MiFi beforehand. If you think you hate Hotel WiFi now, try getting your Core to connect…

With the Photon they completely changed the WiFi chip set. The Core used a Texas Instruments CC3000, the Photon uses a Broadcom BCM43362. This makes a huge difference when it comes to both the provisioning and performance of the connection. It will also help with compatibility give that most of the routers on the planet are Broadcom based as well.

This change also enables a simpler onboarding process. Broadcom has a feature known as Soft-AP which allows the chip to act as either WiFi client or as a Router (access pointer). When you first unbox a Photon it is in Soft-AP mode (they call it "Listening Mode"). This allows you to configure the Photon completely wireless (either with a mobile app or using the Node.js based Photon CLI). If you've every setup a Chromecast then you have seen this workflow in action.

<h3 style="margin-top: inherit; margin-bottom: inherit;">Prototype to Production</h3>

Particle has made several design choices geared toward making it easier to get from prototype to production. This is aimed at answering one of the longest-standing dilemmas faced by Markers, how to take your breadboard project beyond the basement.

With this in mind, Particle has started a sited dedicated to this topic (<a href="http://www.proto2prod.com/">http://www.proto2prod.com/</a>). They have also made manufacturing <a href="https://www.particle.io/prototype#p0-and-p1">friendly versions available</a>. If you have been curious about what it takes to move into production, this site is a fascinating read.

With this in mind, Particle offers the Photon in manufacturing friendly form factors that help simplfy the process. They've also started to design the entire design to manufacturing process for the community. They have started a separate site at <a href="http://www.proto2prod.com/">http://www.proto2prod.com/</a> that covers this topic in surprisingly easy to digest

<h3 style="margin-top: inherit; margin-bottom: inherit;">Still Some Issues</h3>

There are still a few issues with the Core that carry over to the Photon. It still has a finicky sleep state for example (it wakes like a teenager, somewhat unreliably). The documentation is excellent but the format and organization make it challenging to find what you are looking for. And while onboarding is easier, it could be improved by embedding a webserver to handle configuration (something I understand they are working on).

Overall however, the Photon will be my go-to microcontroller for the time being. It's small, effective and inexpensive enough to get pretty excited about.

&nbsp;

Particle Core Hardware Specs - <a href="http://docs.particle.io/core/hardware/">http://docs.particle.io/core/hardware/
</a>Particle Photon Hardware Specs - <a href="http://docs.particle.io/photon/hardware/">http://docs.particle.io/photon/hardware/
</a>Particle Store - <a href="https://store.particle.io/">https://store.particle.io/</a>
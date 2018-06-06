---
title: The Magical Little Photon
excerpt: "I've been playing around with the latest goody from the folks over at Particle and it just became my go-to microcontroller. "
tags:
  - Core
  - IoT
  - Maker
  - Particle
  - Photon
  - Spark
categories: 
  - IoT
  - Particle
  - Makers
---
I've been playing around with the latest goody from the folks over at [Particle](http://www.particle.io) (formally Spark.io). It's called [Photon](http://www.particle.io/prototype#photon) and it represents a nice evolutionary step forward from the original [Spark Core](http://www.particle.io/prototype#spark-core).

The Photon shares a lot with its sibling Core. They use the same development language and APIs (a variant of Arduino C). Both devices leverage Particle's web-based IDE for building and publishing firmware. They also both come with built-in support for Particle's Cloud API so you can start putting the I in IoT right out of the box. Where things get interesting is where they differ. For all of the similarities, they've made several very smart improvements to the Photon:

### Size

Okay, so no one ever saw the Core and thought "gee that thing is big". The Core was surprisingly small considering what it was. This time they went smaller. Honestly, when you unbox the Photon you will almost assuredly think they forgot to send you everything. It is that small. We're talking guitar pick small here. ![](/assets/images/onenote-556b689479d059.58650877.jpg)

### WiFi

While I really loved the Core, I had more than my fair share of frustration getting it onto WiFi. It required a serial connection to configure and was often finicky about the router. Whenever I took a Core on the road I always made sure I configured it to use my MiFi beforehand. If you think you hate Hotel WiFi now, try getting your Core to connect… With the Photon they completely changed the WiFi chip set. The Core used a Texas Instruments CC3000, the Photon uses a Broadcom BCM43362\. This makes a huge difference when it comes to both the provisioning and performance of the connection. It will also help with compatibility give that most of the routers on the planet are Broadcom based as well. This change also enables a simpler onboarding process. Broadcom has a feature known as Soft-AP which allows the chip to act as either WiFi client or as a Router (access pointer). When you first unbox a Photon it is in Soft-AP mode (they call it "Listening Mode"). This allows you to configure the Photon completely wireless (either with a mobile app or using the Node.js based Photon CLI). If you've every setup a Chromecast then you have seen this workflow in action.

### Prototype to Production

Particle has made several design choices geared toward making it easier to get from prototype to production. This is aimed at answering one of the longest-standing dilemmas faced by Markers, how to take your breadboard project beyond the basement. With this in mind, Particle has started a sited dedicated to this topic ([http://www.proto2prod.com/](http://www.proto2prod.com/)). They have also made manufacturing [friendly versions available](https://www.particle.io/prototype#p0-and-p1). If you have been curious about what it takes to move into production, this site is a fascinating read. With this in mind, Particle offers the Photon in manufacturing friendly form factors that help simplfy the process. They've also started to design the entire design to manufacturing process for the community. They have started a separate site at [http://www.proto2prod.com/](http://www.proto2prod.com/) that covers this topic in surprisingly easy to digest

### Still Some Issues

There are still a few issues with the Core that carry over to the Photon. It still has a finicky sleep state for example (it wakes like a teenager, somewhat unreliably). The documentation is excellent but the format and organization make it challenging to find what you are looking for. And while onboarding is easier, it could be improved by embedding a webserver to handle configuration (something I understand they are working on). Overall however, the Photon will be my go-to microcontroller for the time being. It's small, effective and inexpensive enough to get pretty excited about.   

* Particle Core Hardware Specs - [http://docs.particle.io/core/hardware/](http://docs.particle.io/core/hardware/) 
* Particle Photon Hardware Specs - [http://docs.particle.io/photon/hardware/](http://docs.particle.io/photon/hardware/) 
* Particle Store - [https://store.particle.io/](https://store.particle.io/)
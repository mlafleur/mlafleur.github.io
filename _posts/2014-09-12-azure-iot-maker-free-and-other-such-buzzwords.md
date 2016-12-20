---
Title: >
  Azure, IoT, Maker, Free and Other Such
  Buzzwords
Published: 2014-09-12 15:36:38
Excerpt: 'Can your average Developer/Maker afford to use Azure? I decided to skip any “back of the napkin” calculations (since most napkins are notoriously unreliable finks when it comes to architecture and finances) and actually build something.  My criteria was simple, stand up an app on Azure that could communicate with 15-20 “things” for less than $12 per month. I determined this amount scientifically; it is what it costs for a 4-Screen Netflix account. I failed, it ended up being free. '
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3546619226";}'
author:
  - Marc LaFleur
post_date:
  - 2014-09-12 15:36:38
post_excerpt:
  - 'Can your average Developer/Maker afford to use Azure? I decided to skip any “back of the napkin” calculations (since most napkins are notoriously unreliable finks when it comes to architecture and finances) and actually build something.  My criteria was simple, stand up an app on Azure that could communicate with 15-20 “things” for less than $12 per month. I determined this amount scientifically; it is what it costs for a 4-Screen Netflix account. I failed, it ended up being free. '
permalink:
  - >
    /azure-iot-maker-free-and-other-such-buzzwords/
---
A few months back I got into a discussion with a coworker around the cloud and the Maker community. The question, was Azure (any cloud service really) too cost prohibitive an individual developer to justify? I didn't think so but to prove it I decided to skip any “back of the napkin” calculations (since napkins are notoriously unreliable finks when it comes to architecture and finances) and move directly to building an app.  My criteria was simple, stand up an app on Azure that could communicate with 15-20 “things” for less than $12 per month. I determined this amount scientifically; it is what it costs for a  <a href="http://netflix.com" target="_blank">Netflix family account</a>.

<strong>Building Things out</strong>
I deiced to start with a simple temperature sensor attached to an Arduino, tracking both the current state and the incremental changes in Azure. My Arduino didn't have Ethernet so I opted to the same NRF24L01 radio I discussed in <a href="http://massivescale.azurewebsites.net/breaker-7-6-this-is-pi-netduino-do-you-copy/" target="_blank">“Breaker 7-6, This is Pi, Netduino Do You Copy?”</a>. On the Raspberry Pi side, I again leveraged Node.js to receive the transmission and then converted the data into a JSON object I could post to a REST service.

In Azure I stood up a REST API using <a href="http://www.asp.net/web-api" target="_blank">ASP.NET Web API</a>. It took the JSON object, converted it to a Thing and stored it in Azure Table Storage. I had originally defined a Thing as simply an ID with a property bag. Over time I have further refined this model as I found certain properties such as Name (“Office Temp”) and Type (“DHT22”) were almost always needed. Today my Thing includes a couple of core properties (ID, Name, Type and Agent) and a bag of Named Values to store properties unique to a thing.

One of the first realizations I had was that simply catching the data was not enough.  It was in many ways just a log file being stored in a far-away data center. In order to be valuable I needed to be able to make that data actionable and provide command and control of the devices I had attached. To support these scenarios I added Events to the mix. Events can be used to track the state of a Thing (Add, Delete or Update events) or simply to send a message to a Thing. This functionality made use of Azure Storage Queues and another REST service to retrieve them (I’ve since added support for Service Bus Queues and Topics as well).

Once I had these systems up and running I was able to check the temperature of my Office from anywhere in the world. An interesting technical achievement sure, but not exactly exciting stuff. I had something interesting but what I needed now was to make it do something useful. For that I turned to automating my home.

I started by leveraging from <a href="http://http://www.x10.com/" target="_blank">X10 </a>devices I picked up at a yard sale a few years ago but never got around to using. Thanks to <a href="http://www.ebay.com/sch/i.html?_nkw=x10" target="_blank">eBay</a>, I was able to pick up some USB control unit (<a href="http://kbase.x10.com/wiki/CM15A" target="_blank">CM15A </a>and <a href="http://kbase.x10.com/wiki/CM19A" target="_blank">CM19A </a>for those who are interested). I again turned to my Raspberry Pi, installing a brilliant little open source project called <a href="http://x10linux.blogspot.com/2012/08/installing-mochad-on-raspberry-pi.html" target="_blank">Mochad</a>. Mochad is a driver for CM15A and CM19A that exposes an interface using simple TCP/IP sockets. To turn on a light I need only open a socket to Mochad, send it the command as plan text and it handles the rest. To hook it up to Azure I created a simple Agent (thus the Agent property mentioned previously) which would push the state of my X10 up to Azure and translate Events into Mochad commands.

Today I have quite a number of devices hooked up, with a bunch more on the To-Do list. I've since branched out from simply <a href="http://x10.com" target="_blank">X10 </a>and added some <a href="http://insteon.com" target="_blank">Insteon </a>switches, a few <a href="z-wave.com" target="_blank">Z-Wave</a> devices and even picked up a <a href="http://www.quirky.com/shop/732" target="_blank">Wink ReFule</a> for $20 at Home Depot that tells me how much propane I have left. All of these devices are managed via Agents running on a Pi (I've since added a second one since it was pretty maxed out and for $35 it was not exactly a hard decision).

<h3><strong>Was there a point to all this?</strong></h3>

I know, I know. That’s all great and everything but what about the challenge I set out to accomplish way back in the first paragraph? How much does something like this actually cost? Turns out, nothing. Seriously. How?

To keep my costs low I leveraged every free and near-free service available on Azure. If you take a gander at the <a href="http://azure.microsoft.com/en-us/pricing/overview/" target="_blank">Azure Price</a> list, you'll notice it is all based on consumption (there are a few rare exceptions). If you read closely you'll note the pricing is also pro-rated, meaning if you use just a little it will cost even less. <a href="http://azure.microsoft.com/en-us/pricing/details/storage/" target="_blank">Take Storage for example</a>, today it shows a price of $0.07 USD per GB for Locally Redundant Storage. Doing the math, you need to consume at least 100 MB before you reach $0.01 US. And how much Locally Redundant Storage have I used to hold my 200+ Things and 6,000 some odd events this month? About 4 MB. That translates a sub-penny price which simply is not billed, making my total Storage costs zero.

To be fully transparent, I did eventually incur some costs for bandwidth and storage transactions but these were ~$1 per month (.86 if I recall correctly). I also upgraded from a Free instance to a Shared instance (~$10 per month) to get around the 165MB per day limit of the Free edition. In both cases these were necessitated by stress testing the system and sharing the service with a few like-minded developers to play with it. If I had limited myself to the initial criteria (15-20 devices) it could have easily remained free. But even taking this in to account, I’m still .99 under budget.

<h3><strong>Introducing Iotiva</strong></h3>

I had intended on publishing my architecture and code samples for the community but after getting this far I've decided it would more valuable as a coherent app someone could use right away. With that in mind I've begun the process of migrating my proof of concept from a “Project” to a “Product”. I've named it Iotiva and open sourced the code under an MIT license. It is available now on GitHub (<a href="https://github.com/iotiva/Iotiva">https://github.com/iotiva/Iotiva</a>). I've also opened up my live implementation for others to use for free at <a href="http://www.iotiva.com" target="_blank">Iotiva.com</a>.

Over the course of the next few weeks and months I share mode on how Iotiva is architected, some of the decisions that were made (and why) as well as some of the optional features (such the Service Bus option I mentioned earlier). I will also make sure I write up exactly how I used Iotiva to turn my Pi into a X10 Hub (and annoyed my wife and kids by shutting lights on and off while demoing it from 1,500 miles away).
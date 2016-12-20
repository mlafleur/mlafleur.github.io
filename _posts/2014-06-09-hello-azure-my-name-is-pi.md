---
ID: 1794
post_title: Hello Azure, My Name is Pi
author: Marc LaFleur
post_date: 2014-06-09 23:24:44
post_excerpt: >
  I’ve been working on a little project
  at home recently and I needed to get
  data from some remote sensors in to the
  cloud. I also happened to have a couple
  of Raspberry Pi units begging me to do
  something fun. So with an Azure account
  and Raspberry in hand it was time to
  write the next killer app, Hello World
  with Azure in the middle.
layout: post
permalink: >
  http://massivescale.com/hello-azure-my-name-is-pi/
published: true
dsq_thread_id:
  - "3539052294"
---
I’ve been working on a little project at home recently and I needed to get data from some remote sensors in to the cloud. I also happened to have a couple of <a href="http://www.amazon.com/gp/product/B00LPESRUK/ref=as_li_tl?ie=UTF8&amp;camp=1789&amp;creative=390957&amp;creativeASIN=B00LPESRUK&amp;linkCode=as2&amp;tag=soapb30-20&amp;linkId=LCABE5KBPNFINAXY&quot;&gt;Raspberry%20Pi&lt;/a&gt;&lt;img src=&quot;http://ir-na.amazon-adsystem.com/e/ir?t=soapb30-20&amp;l=as2&amp;o=1&amp;a=B00LPESRUK" target="_blank">Raspberry Pi </a>units begging me to do something fun.

I decided that before I got to deep in the weeds, I should do a couple of small POCs up front. This article outlines my very first POC – Hello World with Azure in the middle.

&nbsp;

<h4><strong>Installing Node on Raspbian</strong></h4>

For a number of reasons I chose to use Node.js for this project; mostly because I know JS and we have an Azure SDK available.  It turned out that getting Node installed was a bit more confusing than I expected!

Here is the problem; while there is a package for Node available on Raspbian, it is very much out of date. I was able to compile the latest build from GitHub but this was a “little slow” (as in 20-30 minutes while I sat wondering why I tried to compile this thing from source). Thankfully one of the good folks at <a href="https://learn.adafruit.com/raspberry-pi-hosting-node-red/setting-up-node-dot-js" target="_blank">AdaFruit had a much better solution</a> and in less than 2 minutes I had Node v0.10.28 up and running.

<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:e3ed33a4-21c1-44ce-ac0a-f30df819b333" class="wlWriterEditableSmartContent" style="margin: 0px; padding: 0px; float: none; display: inline;">

[sourcecode language="bash"]
sudo wget http://node-arm.herokuapp.com/node_latest_armhf.deb
sudo dpkg -i node_latest_armhf.deb
node -v
[/sourcecode]

</div>

<h4><strong>Additional Packages</strong></h4>

Node has its own package managed called "npm" (Node Package Manager). There are a ton of packages for doing all sorts of things, including Azure.

<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:a94fe9fa-a4c7-4a2e-bc4d-b5c2b4f5f6ab" class="wlWriterEditableSmartContent" style="margin: 0px; padding: 0px; float: none; display: inline;">

[sourcecode language="bash"]
npm install azure
npm install node-uuid
npm install async
[/sourcecode]

</div>

This will install the following packages:

<ul>
    <li>Azure - The Microsoft Azure SDK for Node.js.</li>
    <li>UUID - A library for generating unique identifiers. We'll use this to generate record IDs.</li>
    <li><a href="https://github.com/caolan/async" target="_blank">Async </a>- One amazing library that makes JS async code joyous (how's that for en endorsement?).</li>
</ul>

<h4><strong>Adding a storage account</strong></h4>

Before we can create our table, we need to create a Storage Account in Azure to hold our data. This process is described very clearly in the documentation at <a href="http://azure.microsoft.com/en-us/documentation/articles/storage-create-storage-account/">http://azure.microsoft.com/en-us/documentation/articles/storage-create-storage-account/</a>.

<h4>Hello World</h4>

Now that we have our components installed, lets sling some Node goodness at Azure. You can use any editor you like but for here I'll use nano since it is already installed (I actually tend to use Sublime 2 on Windows over a Samba connection but that require a lot more configuration).

Back at our command prompt, lets tell nano to create and open a new file named helloazure.js:

<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:a546cc15-b576-475c-a3d8-2b419cfc647d" class="wlWriterEditableSmartContent" style="margin: 0px; padding: 0px; float: none; display: inline;">

[sourcecode language="bash"]
nano helloazure.js
[/sourcecode]

</div>

Now we have the ever so lovely nano UI in front of us. We'll start by telling Node about the libraries we are referencing:

<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:4d414a9c-2eff-4b24-8ee5-33e36511b4b8" class="wlWriterEditableSmartContent" style="margin: 0px; padding: 0px; float: none; display: inline;">

[sourcecode language="javascript"]
var azure = require('azure'); // Azure SDK
var uuid = require('node-uuid'); // Unique ID Library
var async = require('async'); // Aync code helper
[/sourcecode]

</div>

Next we need to tell the script our Storage Account and the secret Access Key. These can be found in your Azure Management Portal; simply go to your Storage Account and select "Manage Keys". Once you are there, copy and paste the values in to the code below.

<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:0a3c4aff-0445-4013-a106-19ee3b8cea40" class="wlWriterEditableSmartContent" style="margin: 0px; padding: 0px; float: none; display: inline;">

[sourcecode language="javascript"]
var storageAccount = &quot;YourStorageAccountName&quot;;
var storageAccessKey = &quot;YourStorageAccountKey&quot;;
[/sourcecode]

</div>

The next step is to reference the TableService. This is part of the Azure SDK and provides the functions for interacting with data tables.
<script src="http://s0.wp.com/wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shCore.js"></script>

<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:d0a16e43-125d-4f52-a87a-e5e04fa4a1ce" class="wlWriterEditableSmartContent" style="margin: 0px; padding: 0px; float: none; display: inline;">

[sourcecode language="javascript"]
var tableService = azure.createTableService(storageAccount, storageAccessKey);
[/sourcecode]

</div>

Finally we'll use the Async library's Waterfall feature to create our table (if needed) and the records (if needed). Waterfall allows us to run multiple functions in sequence while passing data from one function to the next. Note that the first variable returned is always null, this is because the first value is always an error code when using waterfall. If you callback with something else the waterfall stops and an error is returned.

This code is doing a couple of things. First it is creating a table called TestTable1 and then it is adding two records with the values 'Hello' and 'World' in the property TextLabel. Once those are complete we are reading the records back out of Azure and displaying the results to the console. In essence, this is Hello World with Azure in the middle.

https://gist.github.com/mlafleur/44020000d0a2401c0702

The following is the complete script.

<a href="https://gist.github.com/mlafleur/060394f0562beb87c430">https://gist.github.com/mlafleur/060394f0562beb87c430</a>
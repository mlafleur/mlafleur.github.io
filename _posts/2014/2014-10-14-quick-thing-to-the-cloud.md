---
title: Quick Thing, To The Cloud!
excerpt: |
  A recently wrote about a little side-project I've been working on called Iotiva - a lightweight IoT backend using free and low-cost Azure resources. Here I'll cover the basics of getting data from your "Thing" to the cloud. Wait. That sounded dirty....
tags:
  - Azure
  - IoT
  - Iotiva
  - JQuery
---
A <a href="http://massivescale.azurewebsites.net/azure-iot-maker-free-and-other-such-buzzwords/">recently wrote</a> about a little side-project I've been working on called <a href="IOTIVA.com">Iotiva</a> - a lightweight IoT backend using free and low-cost Azure resources. Here I'll cover the basics of getting data from your "Thing" to the cloud. Wait. That sounded dirty. How about getting data from your "Device" to the cloud? Hmmm, not much better. I know, my wife refers to my ever-growing collection of microcontrollers and single-board-computers as my "Junk" what about… Ugh. So what if there isn't way to say it without it sounding like celebrity photo leak. Let's just get to some code.

Most of the devices I work with have fairly limited capabilities when it comes to pushing bits around a network. In the many cases they have literally zero networking capabilities and I end up using some flavor of serial over wireless to push my bits to a more robust proxy. We'll gloss over those devices for the time being and assume your device has a least rudimentary network and HTTP support. If you're interested in hardware options that fit the bill, I highly recommend the <a href="http://www.spark.io/">Spark.io</a> Core or the <a href="http://www.amazon.com/gp/product/B00LPESRUK/ref=as_li_tl?ie=UTF8&amp;camp=1789&amp;creative=390957&amp;creativeASIN=B00LPESRUK&amp;linkCode=as2&amp;tag=soapb30-20&amp;linkId=LCABE5KBPNFINAXY"&gt;Raspberry%20Pi&lt;/a&gt;&lt;img src="http://ir-na.amazon-adsystem.com/e/ir?t=soapb30-20&amp;l=as2&amp;o=1&amp;a=B00LPESRUK" target="_blank">Raspberry Pi</a>, both have robust network and HTTP support with a great community behind them. That said, since every platform is a little different I'm going to use <a href="https://jquery.org/" target="_blank">JQuery</a> for my examples here.
### Repositories
Iotiva segments user data by Repository ID. Each user gets a unique Repository and it is the associated with all of the user's data and event queues. Iotiva also supports the concept of a Public Repository which requires no authentication (so please don't push your home security systems data to it, thanks).

<img src="/assets/wp/2014/10/101414_1619_QuickThingT1.png" alt="" />
## 
### Posting Data
Each "Thing" in Iotiva contains a set of "native properties" and a collection of key-value pairs. The native properties represent data that is used by Iotiva itself while the key-value property bag holds a user-defined collection of named strings.
<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:2e47ce6c-d579-4301-a963-2e55463951d3" class="wlWriterEditableSmartContent" style="float: none;margin: 0px;padding: 0px">

```json
{
    "Id": "Unique ID",
    "Name": "Thing Name (optional)",
    "Agent": "Thing Agent (optional)",
    "Title": "Thing Name or ID if null",
    "LastChanged": "UNC Date / Time of Last Change",
    "Properties": {
        "Prop1": "Val1",
        "Prop2": "Val2",
        "Prop3": "Val3"
    }
}
```

</div>
Data sent to Iotiva is supplied in <a href="http://en.wikipedia.org/wiki/Percent-encoding#The_application.2Fx-www-form-urlencoded_type" target="_blank">application/x-www-form-urlencoded</a> format. I chose this format for it's simplicity as few devices are capable of natively serializing or parsing JSON. The data in this format looks very similar to URL parameters with each param containing "&lt;property&gt;=&lt;value&gt;" delimited by ampersands.  In our token example above the data sent looks like "grant_type=password&amp;username=user%40domain.com&amp;password=somepassword".

When posting a Thing the <em>only required property is ID</em>. This is a unique value used to identify a given Thing in a Repository. It can be any string value and is the only value not editable (i.e. changing an ID and posting will create a new Thing). It is also case-sensitive so keep that in mind when formatting your IDs.

Posting also non-destructive, when you supply data it will add or change  values but never delete them. This allows you to make multiple Posts to a Thing with each post updating a single property (useful for seriously memory constrained devices). It also allows you to augment a Thing from another source. This allows you to have an app that reads data from a Thing store app-specific data with the Thing itself (I'll go into detail when I cover command-and-control scenarios).

Let's use JQuery to post some data to the Public Repository:
<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:86117e21-abbd-4d77-be12-5cb184c90921" class="wlWriterEditableSmartContent" style="float: none;margin: 0px;padding: 0px">

```javascript
$.post('https://iotiva.azurewebsites.net//api/thing/MyFirstThing',
    {
        Name: "My First Thing",
        SaySomething: "Hello World"
    },
    function (data) {
        console.log(JSON.stringify(data, undefined, 2));
    });
```

</div>
### 
### Posting Double-Super-Secret Private Data
We just created our first Thing in the Public Repository with an ID of "MyFirstThing". This is nice but is isn't typically what I'm interested in doing, the last thing I need is someone anonymously mucking with my Things. To prevent that we need to use the retrieve an authentication token.  Iotiva uses OAUTH Bearer Tokens for this purpose. Before you can make secure calls to your repository, you generate a Bearer Token by passing a username and password to <a href="https://iotiva.azurewebsites.net/token">https://iotiva.azurewebsites.net/token</a>. If the credentials are valid Iotiva will return a JSON object containing the following information:
<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:fb486e31-f4fb-435c-8ba6-30177c165191" class="wlWriterEditableSmartContent" style="float: none;margin: 0px;padding: 0px">

```json
{
    "access_token": "crazy long encrypted token",
    "token_type": "bearer",
    "expires_in": 1209599,
    "userName": "user@domain.com",
    ".issued": "Tue, 14 Oct 2014 15:44:37 GMT",
    ".expires": "Tue, 28 Oct 2014 15:44:37 GMT"
}
```

</div>
Tokens live for 14 days, after which they must be discarded and a new token generated. This token is passed back to Iotiva in the Authorization header prefaced with the token_type ("bearer"). Once this is included, Iotiva will be able to identify the correct Repository to store the data in.  Let's take a look at this call using JQuery's Ajax method:
<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:6d0f15e2-49d5-4d78-986e-25958d73645f" class="wlWriterEditableSmartContent" style="float: none;margin: 0px;padding: 0px">

```javascript
var authToken;
$.ajax({
	type: "POST",
    url: https://iotiva.azurewebsites.net/token,
    data: {
		"grant_type":"password",
		"username":"user@domain.com",
		"password":"somepassword"
	},
    success: (data, status) =&gt; {
        authToken = data;
        console.log(authToken.access_token);
    },
    dataType: 'json'
});

```

</div>
Now that we have a valid token (stored in the authToken variable) we need to manipulate the HTTP Headers to include the encrypted token.  With JQuery we can add this header by leveraging the beforeSend feature of the JQuery.Ajax() method. Assuming we already have the token in the authToken variable, we can make a post to JQuery like this:
<div id="scid:C89E2BDB-ADD3-4f7a-9810-1B7EACF446C1:6b7f62cb-2a13-4d29-98e6-2a2734e41cad" class="wlWriterEditableSmartContent" style="float: none;margin: 0px;padding: 0px">

```javascript
$.ajax({
    type: "POST",
    beforeSend: (xhr) =&gt; {
        xhr.setRequestHeader("Authorization", "Bearer " + authToken.access_token)
    },
    url: 'https://iotiva.azurewebsites.net/api/thing/MyFirstThing',
    data: {
        Name: "My First Thing",
        SaySomething: "Hello World"
    },
    success: function (data, status) {
        console.log(JSON.stringify(data, undefined, 2));

    }
});
```

</div>
Now that we have the data up in Iotiva, you can see the results at <a title="http://iotiva.azurewebsites.net/Home/RepoItems" href="http://iotiva.azurewebsites.net/Home/RepoItems" target="_blank">http://iotiva.azurewebsites.net/Home/RepoItems</a>. If you would like to see the actual JSON then fire up your favorite REST tool (I'm partial to <a title="http://www.getpostman.com/" href="http://www.getpostman.com/" target="_blank">PostMan</a> myself) and point it at <a href="https://iotiva.azurewebsites.net/api/thing/MyFirstThing" target="_blank">https://iotiva.azurewebsites.net/api/thing/MyFirstThing</a>.

The examples here are using JQuery and works well for my purpose here but for a more robust JavaScript implementation I would suggest Node.js. Aside from being available just about everywhere, it has an easy to use package manager that makes adding SDKs trivial.  If you are interested in using Node, I recently published the first draft of an <a href="https://github.com/iotiva/iotiva-node" target="_blank">Iotiva SDK for Node</a> on GitHub.
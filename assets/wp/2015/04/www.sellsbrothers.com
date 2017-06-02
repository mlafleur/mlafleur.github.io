

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head id="ctl00_Head1"><title>
	
  Marquee de Sells: Chris's insight outlet

</title><link href="/Content/Site.css" rel="stylesheet" type="text/css" />
  <link rel="shortcut icon" href="http://www.sellsbrothers.com/content/favicon.ico" />
  
  <link rel="alternate" type="application/atom+xml" title="ATOM 1.0" href="http://www.sellsbrothers.com/posts?format=atom10" />
</head>
<body style="margin: 0px; background-color: silver;">
  <div id="header" class="container" style="height: 135px; background-image: url(/Content/images/sellsbrothers_home_ext.jpg); background-repeat: repeat-x;">
    <!-- header graphic -->
    <div style="width: 852px; height: 135px; white-space: nowrap; background-image: url(/Content/images/sellsbrothers_home.jpg);">
      <a href="/">
        <!-- menu spacing and logo home page link -->
        <span style="float: left; width: 185px; height: 135px;"> </span></a>
      <!-- menu items -->
      <div style="padding-top: 5px">
        
        <a class="menulinkW" href="/">:NEWS</a>  
        
        <a class="menulinkW" href="/interview">:INTERVIEW</a>  
        
        <a class="menulinkW" href="/spout">:THE SPOUT</a>  
        
        <a class="menulinkW" href="/tools">:TOOLS</a>  
        
        <a class="menulinkW" href="/writing">:WRITING & SPEAKING</a>  
        
        <a class="menulinkW" href="/fun">:FUN</a>  
        
        <a class="menulinkW" href="/colophon">:COLOPHON</a>  
        
        <a class="menulinkW" href="mailto:csells@sellsbrothers.com">:CONTACT</a>  
      </div>
    </div>
  </div>
  <!-- NOTE: the "overflow: auto" on the content is to keep the children inside the content div so the background color applies -->
  <div id="content" class="container" style="background-color: White; background-repeat: repeat; overflow: auto;">
    <div class="leftPadding">
      <p>
         
      </p>
    </div>
    <div class="centerContent">
      
  <h1>
    
    <a href="http://www.sellsbrothers.com/posts?format=atom10">
      <img style="width: 28px; height: 28px; float: right; margin: 3px;" src="/content/images/icon-feed-28x28.png"
        alt="Marquee de Sells: Chris's insight outlet via ATOM 1.0" /></a>
    <a href="http://twitter.com/csells">
      <img style="width: 28px; height: 28px; float: right; margin: 3px;" src="/content/images/icon-twitter-28x28.png"
        alt="csells on twitter" /></a>
  </h1>
  <p>
    You've reached the internet home of Chris Sells, who has a long history as a contributing member of the Windows developer community. He enjoys long walks on the beach and various computer technologies.
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Sunday, Jan 4, 2015, 4:39 AM
    
    in
    <a href="/spout">The Spout</a>
    <a href="/.net">.NET</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/13740">Handling Orientation Changes in Xamarin.Forms Apps</a></h2>
  <p>
    By default, Xamarin.Forms handles orientation changes for you automatically, e.g.
 <a href="http://www.sellsbrothers.com/posts/Image/258"><img title="ss1[5]" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="ss1[5]" src="http://www.sellsbrothers.com/posts/Image/259" width="292" height="484" /></a>  <a href="http://www.sellsbrothers.com/posts/Image/260"><img title="ss4" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="ss4" src="http://www.sellsbrothers.com/posts/Image/261" width="644" height="388" /></a>
  <em>Xamarin.Forms handles orientation changes automatically</em>
  In this example, the labels are above the text entries in both the portrait and the landscape orientation, which Xamarin.Forms can do without any help from me. However, what if I want to put the labels to the left of the text entries in landscape mode to take better advantage of the space? Further, in the general case, you may want to have different layouts for each orientation. To be able to do that, you need to be able to detect the device’s current orientation and get a notification when it changes. Unfortunately, Xamarin.Forms provides neither, but luckily it’s not hard for you to do it yourself.
  ## Finding the Current Orientation  To determine whether you’re in portrait or landscape mode is pretty easy:
  <pre class="code"><span style="background: white; color: blue">static bool </span><span style="background: white; color: black">IsPortrait(</span><span style="background: white; color: #2b91af">Page </span><span style="background: white; color: black">p) { </span><span style="background: white; color: blue">return </span><span style="background: white; color: black">p.Width &lt; p.Height; }</span></pre>

This function makes the assumption that portrait mode has a smaller width. This doesn’t work for all future imaginable devices, of course, but in the case of a square device, you’ll just have to take your changes I guess.


## Orientation Change Notifications

Likewise, Xamarin.Forms doesn’t have any kind of a OrientationChanged event, but I find that handling SizeChanged does the trick just as well:


<pre class="code"><span style="background: white; color: black">SizeChanged += (sender, e) =&gt; Content = IsPortrait(</span><span style="background: white; color: blue">this</span><span style="background: white; color: black">) ? portraitView : landscapeView;</span></pre>

The SizeChanged event seems to get called exactly once as the user goes from portrait to landscape mode (at least in my debugging, that was true). The different layouts can be whatever you want them to be. I was able to use this technique and get myself a little extra vertical space in my landscape layout:


<a href="http://www.sellsbrothers.com/posts/Image/262"><img title="ss2" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="ss2" src="http://www.sellsbrothers.com/posts/Image/263" width="644" height="388" /></a>


<em>Using a custom layout to put the labels on the left of the text entries instead of on top</em>&#160;


Of course, I could use this technique to do something completely differently in each orientation, but I was hoping that the two layouts made sense to the user and didn’t even register as special, which Xamarin.Forms allowed me to do.
  
  </p>
  <p>
    <a data-disqus-identifier="13740" href="/Posts/Details/13740#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Friday, Jan 2, 2015, 7:36 PM
    
    in
    <a href="/spout">The Spout</a>
    <a href="/.net">.NET</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/13739">Launching the Native Map App from Xamarin.Forms</a></h2>
  <p>
    My goal was to take the name and address of a place and show it on the native map app regardless of what mobile platform on which my app was running. While Xamarin.Forms provides a cross-platform API to launch the URL that starts the map app, the URL format is different depending on whether you’re using <a href="http://msdn.microsoft.com/en-us/library/windows/apps/jj635237.aspx">the Windows Phone 8 URI scheme for Bing maps</a>, <a href="http://developer.android.com/guide/components/intents-common.html#Maps">the Android Data URI scheme for the map intent</a> or <a href="https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/MailLinks/MailLinks.html#//apple_ref/doc/uid/TP40007899-CH4-SW1">the Apple URL scheme for maps</a>.
  This is what I came up with:
  <pre class="code"><span style="background: white; color: blue"><pre class="code"><span style="background: white; color: blue">public class </span><span style="background: white; color: #2b91af">Place </span><span style="background: white; color: black">{
  </span><span style="background: white; color: blue">public string </span><span style="background: white; color: black">Name { </span><span style="background: white; color: blue">get</span><span style="background: white; color: black">; </span><span style="background: white; color: blue">set</span><span style="background: white; color: black">; }
  </span><span style="background: white; color: blue">public string </span><span style="background: white; color: black">Vicinity { </span><span style="background: white; color: blue">get</span><span style="background: white; color: black">; </span><span style="background: white; color: blue">set</span><span style="background: white; color: black">; }
  </span><span style="background: white; color: blue">public </span><span style="background: white; color: #2b91af">Geocode </span><span style="background: white; color: black">Location { </span><span style="background: white; color: blue">get</span><span style="background: white; color: black">; </span><span style="background: white; color: blue">set</span><span style="background: white; color: black">; }
  </span><span style="background: white; color: blue">public </span><span style="background: white; color: #2b91af">Uri </span><span style="background: white; color: black">Icon { </span><span style="background: white; color: blue">get</span><span style="background: white; color: black">; </span><span style="background: white; color: blue">set</span><span style="background: white; color: black">; }
}</span><span style="background: white; color: black">
</span></pre>public void </span><span style="background: white; color: black">LaunchMapApp(</span><span style="background: white; color: #2b91af">Place </span><span style="background: white; color: black">place) {
  </span><span style="background: white; color: green">// Windows Phone doesn't like ampersands in the names and the normal URI escaping doesn't help
  </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">name = place.Name.Replace(</span><span style="background: white; color: #a31515">"&amp;"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"and"</span><span style="background: white; color: black">); </span><span style="background: white; color: green">// var name = Uri.EscapeUriString(place.Name);
  </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">loc = </span><span style="background: white; color: blue">string</span><span style="background: white; color: black">.Format(</span><span style="background: white; color: #a31515">"{0},{1}"</span><span style="background: white; color: black">, place.Location.Latitude, place.Location.Longitude);
  </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">addr = </span><span style="background: white; color: #2b91af">Uri</span><span style="background: white; color: black">.EscapeUriString(place.Vicinity);

  </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">request = </span><span style="background: white; color: #2b91af">Device</span><span style="background: white; color: black">.OnPlatform(
    </span><span style="background: white; color: green">// iOS doesn't like %s or spaces in their URLs, so manually replace spaces with +s
    </span><span style="background: white; color: blue">string</span><span style="background: white; color: black">.Format(</span><span style="background: white; color: #a31515">"http://maps.apple.com/maps?q={0}&amp;sll={1}"</span><span style="background: white; color: black">, name.Replace(</span><span style="background: white; color: #a31515">' '</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">'+'</span><span style="background: white; color: black">), loc),

    </span><span style="background: white; color: green">// pass the address to Android if we have it
    </span><span style="background: white; color: blue">string</span><span style="background: white; color: black">.Format(</span><span style="background: white; color: #a31515">"geo:0,0?q={0}({1})"</span><span style="background: white; color: black">, </span><span style="background: white; color: blue">string</span><span style="background: white; color: black">.IsNullOrWhiteSpace(addr) ? loc : addr, name),

    </span><span style="background: white; color: green">// WinPhone
    </span><span style="background: white; color: blue">string</span><span style="background: white; color: black">.Format(</span><span style="background: white; color: #a31515">"bingmaps:?cp={0}&amp;q={1}"</span><span style="background: white; color: black">, loc, name)
  );

  </span><span style="background: white; color: #2b91af">Device</span><span style="background: white; color: black">.OpenUri(</span><span style="background: white; color: blue">new </span><span style="background: white; color: #2b91af">Uri</span><span style="background: white; color: black">(request));
}</span></pre>

This code was testing on several phone and tablet emulators and on 5 actual devices: an iPad running iOS 8, an iPad Touch running iOS 8, a Nokia Lumia 920 running Windows Phone 8.1, an LG G3 running Android 4.4 and an XO tablet running Android 4.1. As you can tell, each platform has not only it’s own URI format for launching the map app, but quirks as well. However, this code works well across platforms. Enjoy.
  
  </p>
  <p>
    <a data-disqus-identifier="13739" href="/Posts/Details/13739#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Thursday, Jan 1, 2015, 6:09 PM
    
    in
    <a href="/spout">The Spout</a>
    <a href="/.net">.NET</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/13738">App and User Settings in Xamarin.Forms Apps</a></h2>
  <p>
    Settings allow you to separate the parameters that configure the behavior of your app separate from the code, which allows you to change that behavior without rebuilding the app. This is handle at the app level for things like server addresses and API keys and at the user level for things like restoring the last user input and theme preferences. Xamarin.Forms provides direct support for neither, but that doesn’t mean you can’t easily add it yourself.
  ## App Settings  Xamarin.Forms doesn’t have any concept of the .NET standard app.config. However, it’s easy enough to add the equivalent using embedded resources and the XML parser. For example, I built a Xamarin.Forms app for finding spots for coffee, food and drinks between where I am and where my friend is (<a href="https://github.com/csells/middlemeeter">MiddleMeeter, on GitHub</a>). I’m using the Google APIs to do a bunch of geolocation-related stuff, so I need a Google API key, which I don’t want to publish on GitHub. The easy way to make that happen is to drop the API key into a separate file that’s loaded at run-time but to not check that file into GitHub by adding it to .gitignore. To make it easy to read, I added this file as an Embedded Resource in XML format:
  <a href="http://www.sellsbrothers.com/posts/Image/256"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/257" width="371" height="480" /></a>
  <em>Adding an XML file as an embedded resource makes it easy to read at run-time for app settings</em>
  I could’ve gone all the way and re-implemented the entire .NET configuration API, but that seemed like overkill, so I kept the file format simple:
  <pre class="code"><span style="background: white; color: blue">&lt;?</span><span style="background: white; color: #a31515">xml </span><span style="background: white; color: red">version</span><span style="background: white; color: blue">=</span><span style="background: white; color: black">"</span><span style="background: white; color: blue">1.0</span><span style="background: white; color: black">" </span><span style="background: white; color: red">encoding</span><span style="background: white; color: blue">=</span><span style="background: white; color: black">"</span><span style="background: white; color: blue">utf-8</span><span style="background: white; color: black">" </span><span style="background: white; color: blue">?&gt;
&lt;</span><span style="background: white; color: #a31515">config</span><span style="background: white; color: blue">&gt;
  &lt;</span><span style="background: white; color: #a31515">google-api-key</span><span style="background: white; color: blue">&gt;</span><span style="background: white; color: black">YourGoogleApiKeyHere</span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: #a31515">google-api-key</span><span style="background: white; color: blue">&gt;
&lt;/</span><span style="background: white; color: #a31515">config</span><span style="background: white; color: blue">&gt;</span></pre>

Loading the file at run-time uses the normal .NET resources API:


<pre class="code"><span style="background: white; color: blue">string </span><span style="background: white; color: black">GetGoogleApiKey() {
</span><span style="background: white; color: green">  </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">type = </span><span style="background: white; color: blue">this</span><span style="background: white; color: black">.GetType();
  </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">resource = type.Namespace + </span><span style="background: white; color: #a31515">"." </span><span style="background: white; color: black">+<br />    </span><span style="background: white; color: #2b91af">Device</span><span style="background: white; color: black">.OnPlatform(</span><span style="background: white; color: #a31515">"iOS"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"Droid"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"WinPhone"</span><span style="background: white; color: black">) + </span><span style="background: white; color: #a31515">".config.xml"</span><span style="background: white; color: black">;
  </span><span style="background: white; color: blue">using </span><span style="background: white; color: black">(</span><span style="background: white; color: blue">var </span><span style="background: white; color: black">stream = type.Assembly.GetManifestResourceStream(resource))
  </span><span style="background: white; color: blue">using </span><span style="background: white; color: black">(</span><span style="background: white; color: blue">var </span><span style="background: white; color: black">reader = </span><span style="background: white; color: blue">new </span><span style="background: white; color: #2b91af">StreamReader</span><span style="background: white; color: black">(stream)) {
    </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">doc = </span><span style="background: white; color: #2b91af">XDocument</span><span style="background: white; color: black">.Parse(reader.ReadToEnd());
    </span><span style="background: white; color: blue">return </span><span style="background: white; color: black">doc.Element(</span><span style="background: white; color: #a31515">"config"</span><span style="background: white; color: black">).Element(</span><span style="background: white; color: #a31515">"google-api-key"</span><span style="background: white; color: black">).Value;
  }
}</span></pre>

I used XML as the file format not because I’m in love with XML (although it does the job well enough for things like this), but because LINQ to XML is baked right into Xamarin. I could’ve used JSON, too, of course, but that requires an extra NuGet package. Also, I could’ve abstracting things a bit to make an easy API for more than one config entry, but I’ll leave that for enterprising readers.


## User Settings

While app settings are read-only, user settings are read-write and each of the supported Xamarin platforms has their own place to store settings, e.g. .NET developers will likely have heard of Isolated Storage. Unfortunately, Xamarin provides no built-in support for abstracting away the platform specifics of user settings. Luckily, <a href="https://twitter.com/jamesmontemagno">James Montemagno</a> has. In his <a href="https://www.nuget.org/packages/Xam.Plugins.Settings/">Settings Plugin NuGet package</a>, he makes it super easy to read and write user settings. For example, in my app, I pull in the previously stored user settings when I’m creating the data model for the view on my app’s first page:


<pre class="code"><span style="background: white; color: blue">class </span><span style="background: white; color: #2b91af">SearchModel </span><span style="background: white; color: black">: </span><span style="background: white; color: #2b91af">INotifyPropertyChanged </span><span style="background: white; color: black">{
  </span><span style="background: white; color: blue">string </span><span style="background: white; color: black">yourLocation;
<strong>  </strong></span><strong><span style="background: white; color: green">// reading values saved during the last session (or setting defaults)
  </span><span style="background: white; color: blue">string </span><span style="background: white; color: black">theirLocation = </span><span style="background: white; color: #2b91af">CrossSettings</span><span style="background: white; color: black">.Current.GetValueOrDefault(</span><span style="background: white; color: #a31515">"theirLocation"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">""</span></strong><strong><span style="background: white; color: black">);
  </span><span style="background: white; color: #2b91af">SearchMode </span><span style="background: white; color: black">mode = </span><span style="background: white; color: #2b91af">CrossSettings</span><span style="background: white; color: black">.Current.GetValueOrDefault(</span><span style="background: white; color: #a31515">"mode"</span><span style="background: white; color: black">, </span><span style="background: white; color: #2b91af">SearchMode</span></strong><span style="background: white; color: black"><strong>.food);
</strong>  </span><span style="background: white; color: green">...
</span><span style="background: white; color: black">}</span></pre>


The beauty of James’s API is that it’s concise (only one function to call to get a value or set a default if the value is missing) and type-safe, e.g. notice the use of a string and an enum here. He handles the specifics of reading from the correct underlying storage mechanism based on the platform, translating it into my native type system and I just get to write my code w/o worrying about it. Writing is just as easy:


<pre class="code"><span style="background: white; color: blue">async void </span><span style="background: white; color: black">button1_Clicked(</span><span style="background: white; color: blue">object </span><span style="background: white; color: black">sender, </span><span style="background: white; color: #2b91af">EventArgs </span><span style="background: white; color: black">e) {
  </span><span style="background: white; color: blue">...</span><span style="background: white; color: black">

<strong>  </strong></span><strong><span style="background: white; color: green">// writing settings values at an appropriate time
  </span><span style="background: white; color: #2b91af">CrossSettings</span><span style="background: white; color: black">.Current.AddOrUpdateValue(</span><span style="background: white; color: #a31515">"theirLocation"</span></strong><strong><span style="background: white; color: black">, model.TheirLocation);
  </span><span style="background: white; color: #2b91af">CrossSettings</span><span style="background: white; color: black">.Current.AddOrUpdateValue(</span><span style="background: white; color: #a31515">"mode"</span></strong><span style="background: white; color: black"><strong>, model.Mode);
</strong>
  ...</span><span style="background: white; color: black">
}</span></pre>


My one quibble is that I wish the functions were called Read/Write or Get/Set instead of GetValueOrDefault/AddOrUpdateValue, but James’s function names make it very clear what’s actually happening under the covers. Certainly the functionality makes it more than worth the extra characters.


## User Settings UI

Of course, when it comes to building a UI for editing user settings at run-time, Xamarin.Forms has all kinds of wonderful facilities, including a TableView intent specifically for settings (TableIntent.Settings). However, when it comes to extending the platform-specific Settings app, you’re on your own. That’s not such a big deal, however, since only iOS actually supports extending the Settings app (using <a href="https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/UserDefaults/Preferences/Preferences.html">iOS Settings Bundles</a>). Android doesn’t support it at all (they only let the user configure things like whether an app has permission to send notifications) and while Windows Phone 8 has an extensible Settings Hub for their apps, it’s <a href="http://www.dennisdel.com/?p=223">a hack if you do it with your own apps</a> (and unlikely to make it past the Windows Store police).


## Where Are We?

So, while Xamarin.Forms doesn’t provide any built in support for app or user settings, the underlying platform provides enough to make implementing the former trivial and the Xamarin ecosystem provides nicely for the latter (thanks, James!).


Even more interesting is what Xamarin has enabled with this ecosystem. They’ve mixed their very impressive core .NET and C# compiler implementation (Mono) with a set of mobile libraries providing direct access to the native platforms (MonoTouch and MonoDroid), added a core implementation of UI abstraction (Xamarin.Forms) and integration into the .NET developer’s IDE of choice (Visual Studio) together with an extensible, discoverable set of libraries (NuGet) that make it easy for 3rd party developers to contribute. That’s a platform, my friends, and it’s separate from the one that Microsoft is building. What makes it impressive is that it takes the army of .NET developers and points them at the current hotness, i.e. building iOS and Android apps, in a way that Microsoft never could. Moreover, because they’ve managed to also support Windows Phone pretty seamlessly, they’ve managed to get Microsoft to back them.


We’ll see how successful Xamarin is over time, but they certainly have a very good story to tell .NET developers.
  
  </p>
  <p>
    <a data-disqus-identifier="13738" href="/Posts/Details/13738#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Saturday, Nov 1, 2014, 5:43 PM
    
    in
    <a href="/spout">The Spout</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/13737">Microsoft Fan Boy Goes To Google</a></h2>
  <p>
    <img style="float: right; margin: 0px 0px 5px 5px; display: inline" src="http://www.sellsbrothers.com/posts/Image/255" width="240" align="right" height="85" />In 1992, I was a Unix programmer in Minneapolis. I’d graduated with a BS in Computer Science from the University of MN a year earlier and had written my programming assignments in C and C++ via first a VT100 terminal and then a VT100 terminal emulator on my Mac (running System 7, if you’re curious). My day job was at an AT&amp;T VAR building multi-user voice response systems on Unix System V. My favorite editor was vi (not vim) and, like all good vi programmers, I hated emacs with a white hot passion.
  Being bored with my current job, I posted my resume on the internet, which meant uploading it in ASCII text to an FTP site where tech companies knew to look for it. The tech company that found it was Intel. To prepare for my interview in Portland, OR, I went to play with a Windows 3.1 machine that someone had set up in the office, but nobody used. I had a Mac at home and Unix at work and for the 10 minutes that I could stand to use it, Windows 3.1 seemed like the worst of both. In spite of my distaste, Intel made an offer I couldn’t refuse and I found myself moving with my new wife to a new city for a new job and a new technology stack.
  The move to Intel started my love affair with Windows (starting with Windows 95, of course, let’s be reasonable). Over the years, I grew to love Word, Excel, Visio, PowerPoint, Outlook, Live Writer, Skype, Windows XP, Windows 7, COM, ATL, .NET, C# and of course the Big Daddy for Windows developers: Visual Studio. Not only did I become a Windows fan boy (I can’t tell you how lonely it is to own a Windows Phone after the iPhone was released), but I became I contributing member of the Windows community, accounting for nearly 100% of the content on this web site, first published in 1995 solely to provide links to my DevelopMentor students, but growly steadily since (over 2600 posts in 20 years). Add to that to <a href="http://sellsbrothers.com/writing">more than a dozen books and countless public speaking engagements, magazine articles and internet appearances</a> and you’ve got a large investment in the Windows technology stack.
  Of course, as I take on roles beyond consultant, speaker, author and community PM, I contribute less and less (although I do love spouting off into <a href="https://twitter.com/csells">my twitter feed</a>). Even so, I’ve been a regular attendee to Windows-related events and 90% of my friends are also Windows developers, so the idea of leaving not just a technology ecosystem but an entire community behind is a pretty daunting one.
  And then, about 45 days ago, Google came knocking with an offer I couldn’t refuse. A few days after that, before I’ve even officially accepted the offer, I find myself in a bidding war for a house in Kirkland, WA that the wife and I both love (which almost never happens). So, for the first time since 1992, with my three boys graduated from high school, I find myself moving with my new wife to a new city for a new job and a new technology stack. As I write this, it’s the Friday before my Noogler orientation week (New Googler – get it?). I’ll be working on tools for Google cloud developers, which matches my Windows experience helping developers build distributed systems, although there’s going to be a huge learning curve swapping in the details.
  After 20 years with Visual Studio, I don’t know if my fingers still know vi, but I can’t wait to find out. If I get a beer or two in me, I might even give emacs another try…
  
  </p>
  <p>
    <a data-disqus-identifier="13737" href="/Posts/Details/13737#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Friday, Aug 1, 2014, 3:09 PM
    
    in
    <a href="/interview">Interview</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12739">Future Proof Your Technical Interviewing Process: Hiring or Not</a></h2>
  <p>
    <img style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; float: right; padding-top: 0px; padding-left: 0px; margin: 0px 0px 5px 5px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" src="http://www.resumetarget.com/blog/wp-content/uploads/2013/06/bad-interview.jpg" width="240" align="right" height="135" />This is the last in a 4-part series on how to interview well. Parts 1-3 covered <a href="http://www.sellsbrothers.com/Posts/Details/12736">the phone screen</a>, <a href="http://www.sellsbrothers.com/Posts/Details/12737">the technical interview</a> and <a href="http://www.sellsbrothers.com/Posts/Details/12738">the fit interviews</a>. In his part, we’ll wrap up by talking about how to make the hiring decision.
  ## Make Time For Questions</h2>  As important as what questions you ask the candidate are leaving time for them to ask their questions. Remember that they're interviewing you, too. Be open and honest about the answers; technical people have a sensitive bullshit detector, so don't try to pretend that everything is perfect; they’ll know if you’re not being sincere. However, it’s a fine line. If you find yourself dwelling on the negative, you have to wonder if you've found a good fit for yourself.
  Also, don't forget to factor their questions into your own thinking about the candidate. The questions they ask about a job and a team they're going to be spending 40+ hours/week with is as good an indicator of how they think as anything else.
  <h2>Making the Call</h2>  As you pass the interview candidate from person to person, make sure that you spend a few minutes in private with the next interviewer talking about what you heard that you liked as well as things you'd like them to circle back on. You want to give them an opportunity to try again, either to convince you it's not an issue or to confirm that it is.
  Every interviewer should share their thoughts about the candidate soon while they're fresh. You can send an email around to the team as you finish or get together in the same room after the candidate has headed home, but it should be the same day; those first impressions matter.
  Ultimately each interviewer will provide three pieces of information: a thumbs up/down (whether you use actual thumbs for this process is up to you : ), a confidence level (do you really love this person? are you on the fence?) and an explanation (“I loved how they think about the customer!” or “They never figured out how to efficiently search an infinite space of possible solutions.”)
  The set of interview results will come out in three ways:
  <ol>   <li>Everyone loved that candidate. Hire them. </li>    <li>Everyone hated the candidate. Don't hire them. Be polite! </li>    <li>There's a mix. Discuss. Potentially get more info. </li> </ol>  Of course, options #1 and #2 are easy to deal with. Unfortunately, option #3 is where most candidates fall. The question is, what do you do with a candidate with mixed results? If you're following the principle that it's better to send a good candidate away then to hire a bad candidate, then you'll pass on them. However, you'll want to spend some extra time on candidates like these. Discuss it amongst the team. See how adamant the thumbs up voters are and why. See how adamant the thumbs down voters are and why. If the candidate is on the fence but leaning towards "hire," pick someone else to talk to them and/or get them into a different environment, e.g. the bar down the street or the bowling alley at the company Xmas party, and see how they do.
  Ultimately, it boils down to one thing: does the team as a whole want to bring the candidate into the team? If so, great. If not, let them go. Certainly a senior member of the company or department can override the team and hire a candidate above their objections, but I wouldn't recommend it. You're much more likely to hurt a good team in those situations then to help it.
  <h2>Where Are We?  Whether you agree with the specifics of this process or not, I encourage you to spend the time to really examine your process. You want the team you build to be more than the sum of the parts, but that kind of magic requires first that you have great parts.
  
  </p>
  <p>
    <a data-disqus-identifier="12739" href="/Posts/Details/12739#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Tuesday, Jul 29, 2014, 4:19 PM
    
    in
    <a href="/interview">Interview</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12738">Future Proof Your Technical Interviewing Process: The Fit Interviews</a></h2>
  <p>
    <img style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; float: right; padding-top: 0px; padding-left: 0px; margin: 0px 0px 5px 5px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" src="http://a.abcnews.com/images/Entertainment/ko_the_a_team_mi_130122_wmain.jpg" width="240" align="right" height="135" />If you just found yourself here, you’ve stumbled onto a multi-part series on the technical interviewing process. Part 1 covered <a href="http://www.sellsbrothers.com/Posts/Details/12736">the phone screen</a> and part 2 covered <a href="http://www.sellsbrothers.com/Posts/Details/12737">the technical interview</a>. Today we’re going to discuss the “fit” interviews, that is, team and cultural fit.
  ## The Team Fit Interview</h2>  Modern software development is done in teams. You want to be able to judge any candidate as a productive, positive member of your team. They don't necessarily have to have experience doing things the way you do them, but they should show the ability to adapt when issues arise. Your job in the team fit interview is to break the important things that happen in your team into situations that you can ask your candidate about. The following are pretty standard examples:
  <ul>   <li>What's the right process for gathering requirements? </li>    <li>How do you convince someone that you've got a good idea? </li>    <li>What do you do when you can't convince them? </li>    <li>How do you deal with vague requirements? </li>    <li>What happens if you're asked to do something you don't agree with? </li>    <li>etc. </li> </ul>  However, you have to be careful here. Pretty much anyone can give you the "right" answers to these questions, but you don't want the "right" answers – you want the <em>real</em> answers. How does a candidate actually behave in the face of these situations?
  The best way I know of to get the real answers out of someone is something called <a href="http://en.wikipedia.org/wiki/Job_interview#Behavioral_questions">Behavioral Interviewing</a>. The idea is simple: instead of asking someone how they would act if faced with a certain situation, ask them to describe an example in their past when they've had to deal with that situation. Discuss it with them. How did their strategy work for them? What did they learn? What would they do differently?
  Just this one shift from “how <em>would </em>you deal with this situation” to “how <em>did </em>you deal with this situation” will get you a much deeper look into how a candidate actually behaves, which allows you to decide if they're a good fit for your team.
  <h2>The Cultural Fit Interview</h2>  This goal of the cultural fit interview is to figure out if the candidate will like their new working environment and whether the team will be glad to have them. It's enormously important and very difficult to access. One typical way to approach this type of interview is to ask the following kinds of questions, also in a Behavioral Interviewing style:
  <ul>   <li>(You're a startup) How do you like the idea of quick decisions, hard work on short deadlines, light process and tight purse strings? </li>    <li>(You're an established company) How do you like the idea of getting buy-in with a set of stakeholders, making sure we don't ship anything until it's done, following an established process and sticking to a budget? </li>    <li>What's more important: the customers or the business? </li>    <li>What kinds of activities are most important to you? Do you like to be focused on your set of tasks or do you like to do a lot of different things? </li>    <li>What makes you as productive as you can be? </li>    <li>Where do you see your career path taking you? </li>    <li>etc. </li> </ul>  These questions are much more vague and really meant to start a conversation, but they're also very hit-and-miss. If you happen to hit the right path, you can really crack a candidate open like a ripe nut.
  Also, you want to be careful how you interpret the answers. If you don't filter out people that aren't a good fit for the culture of the company, they'll be unhappy and you'll be unhappy. On the other hand, if you filter too much, you'll lose out on the benefits of diversity. It's a hard line to walk.
  Another way to approach a culture fit interview is to get creative. Maybe invite the person to a company event, perhaps a semi-public mixer or a Friday afternoon beer bash. Maybe sit down with the team over lunch and play a game together. Maybe sit in the café and grab lunch in a small group and see how the conversation goes.
  I think the key to finding a good fit culturally is to spend time with the candidate that doesn’t center around the technology you’re using to build your products. For example, involving a candidate in something that the team does for fun can go a long way towards finding a great new member for your team.
  <h2>Next Time  #   Tune in next time for when we wrap this series up and talk about <a href="http://www.sellsbrothers.com/Posts/Details/12739">how to make the hiring decision</a>.
  
  </p>
  <p>
    <a data-disqus-identifier="12738" href="/Posts/Details/12738#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Thursday, Jul 24, 2014, 12:46 AM
    
    in
    <a href="/interview">Interview</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12737">Future Proof Your Technical Interviewing Process: The Technical Interview</a></h2>
  <p>
    <img style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; float: right; padding-top: 0px; padding-left: 0px; margin: 0px 0px 5px 5px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" src="http://static4.businessinsider.com/image/4c2a1b167f8b9aad33200000-480/math-pic-equation.jpg" width="240" align="right" height="180" />It’s incredibly important to interview well as you’re building your technical team. Further, interviewing well is hard to do and, like anything, you only get out of it what you put into it. In part 1 of this series, we discussed <a href="http://www.sellsbrothers.com/Posts/Details/12736">the phone screen</a>. In this part, we’ll discuss the technical interview.
  ## The Technical Interview</h2>  The only way to really know if someone can deliver technically is to give them a problem to solve and watch them solve it. You can do this with simple data structure problems on the whiteboard, test questions on paper, algorithm problems in notepad, real-world problems with some pair programming or puzzle problems with them waving their hands wildly in the air. In a technical interview, you should encourage the candidate to think out loud, because you care more about how they go about solving the problem then actually getting to an answer. You will look for the following things:
  <ul>   <li>Are they asking questions to solidify vague requirements? </li>    <li>Are they approaching the problem from a logical angle (even if it's different from what you had in mind)? Does problem solving come naturally to them? </li>    <li>Are they making the right use of the features available in whatever sandbox you gave them in which to solve the problem, e.g. making good use of list comprehensions in Python? </li>    <li>Are they writing good code and pointing out the shortcuts they're taking due to the medium they're using, e.g. the whiteboard? Does the coding come naturally to them or are they struggling? </li>    <li>Do they come up with a reasonable answer? Are they on the right path even if they run out of time? </li>    <li>Do they understand the "why" behind their answer as well as the "how?" </li> </ul>  This last one is the one I tend to focus on the most. <b>Even more important than a candidate having knowledge of the technologies you're going to ask them to use is <em>their ability to understand new technologies over time</em>.</b>
  My father always says that while teenage drivers hopped up on testosterone may get into the most accidents, they're the ones that push the cars to see what they will do. You want to hire engineers that have pushed technologies past their limits for the pure joy of it. Those are going to be the ones that build the deep knowledge and can adapt in the future to whatever comes their way.
  I filter for deep understanding by not just digging into not only the "how" of whatever they claim to know best, but also the "why." They may know how to build a factory in Angular, but do they understand what a factory is and why Angular does it that way? They may know how to manage their resources in the face of the JVM's garbage collector, but do they know why we use garbage collection and what the downsides are? Do they understand what canvas is good for, what SVG is good for and when to choose which?
  The key here is that <b>past behavior indicates future behavior</b> – if they're developed deep understanding of the technologies they've learned before, chances are pretty good that they're going to be able to do that for the new technologies your team adopts in the future. There is no better way to understand how well they’re going to do on future technical challenges than hearing how they’ve handled such challenges in the past and seeing how they do it right in front of you.
  <h2>What’s Next in This Series</h2>  <h2>  However, the technical fit is not the only thing you need to look for – you also want to make sure that they will fit in well on your team and the company culture overall. We’ll talk about these in <a href="http://www.sellsbrothers.com/Posts/Details/12738">the next piece in this series</a>.
  
  </p>
  <p>
    <a data-disqus-identifier="12737" href="/Posts/Details/12737#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Monday, Jul 21, 2014, 9:08 PM
    
    in
    <a href="/spout">The Spout</a>
    <a href="/interview">Interview</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12736">Future Proof Your Technical Interviewing Process: The Phone Screen</a></h2>
  <p>
    <img style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; float: right; padding-top: 0px; padding-left: 0px; margin: 0px 0px 5px 5px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" src="http://www.cornonthejob.com/wp-content/uploads/2011/12/Bad-Interviewer11.jpg" width="240" align="right" height="159" />In 30 years, I've done a lot of interviewing from both sides of the table. Because of my chosen profession, my interviewing has been for technical positions, e.g. designers, QA, support, docs, etc., but mostly for developers and program managers, both of which need to understand a system at the code level (actually, I think VPs and CTOs need to understand a system at the code level, too, but the interview process for those kinds of people is a superset of what I'll be discussing in this series).
  In this discussion, I'm going to assume you've got a team doing the interview, not just a person. Technical people need to work well in teams and you should have 3-4 people in the interview cycle when you're picking someone to join the team.
  ## The Most Important Thing!</h2>  Let me state another assumption: you care about building your team as much as you care about building your products. Apps come and go, but a functional team is something you want to cherish forever (if you can). If you just want to hire someone to fill a chair, then what I'm about to describe is not for you.
  The principle I pull from this assumption is this: <b>it's better to let a good candidate go then to hire a bad one.</b>
  A bad hire can do more harm than a good hire can repair. Turning down a "pretty good" candidate is the hardest part of any good interview process, but this one principle is going to save you more heartache than any other.
  <h2>The Phone Screen</h2>  So, with these assumptions in mind, the first thing you always want to do when you've got a candidate is to have someone you trust do a quick phone screen, e.g. 30 minutes. This can be an HR person or someone that knows the culture of the company and the kind of people you're looking for. A phone screen has only one goal: to avoid wasting the team's time. If there's anything that's an obvious mismatch, e.g. you require real web development experience, but the phone screen reveals that the candidate really doesn’t, then you say "thanks very much" and move on to the next person.
  If it's hard to get a person to come into your office -- maybe they're in a different city -- you'll also want to add another 30 minutes to do a technical phone screen, too, e.g.
  <ul>   <li>Describe the last app they built with Angular. </li>    <li>Tell me how JVM garbage collection works. </li>    <li>What’s the right data structure to hold the possible solutions to tic-tac-toe? </li> </ul>  Whatever it is, you want to make reasonably sure that they're going to be able to keep up with their duties technically before you bring them on site, or you’re just wasting the team’s time.
  At this point, if you're hiring a contractor, you may be done. Contractors are generally easy to fire, so you can bring them on and let them go easily. Some companies start all of their technical hires as contractors first for a period of 30-90 days and only hire them if that works out.
  If you’re interviewing for an FTE position, once they’ve passed the phone screen, you're going to bring them into the office.
  You should take a candidate visit seriously; you're looking for a new family member. Even before they show up, you make sure you have a representative sample of the team in the candidate's interview schedule. At the very least, you need to make sure that you have someone to drill into their technical abilities, someone to deal with their ability to deliver as part of a team and someone to make sure that they're going to be a cultural fit with the company as a whole. Each of these interview types is different and deserves it's own description.
  <h2>Future Posts in This Series  Tune in to future posts in this series where we’ll be discussing:
  <ul>   <li><a href="http://www.sellsbrothers.com/Posts/Details/12737">The Technical Interview</a> </li>    <li><a href="http://www.sellsbrothers.com/Posts/Details/12738">The Fit Interviews</a> </li>    <li><a href="http://www.sellsbrothers.com/Posts/Details/12739">Hiring or Not</a> </li> </ul>  
  </p>
  <p>
    <a data-disqus-identifier="12736" href="/Posts/Details/12736#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Friday, Jul 18, 2014, 9:49 PM
    
    in
    <a href="/interview">Interview</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12735">Head of Google interviewing says “results matter, riddles don’t”</a></h2>
  <p>
    <a href="http://www.sellsbrothers.com/posts/Image/254"><img title="google" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; float: right; padding-top: 0px; padding-left: 0px; margin: 0px 0px 5px 5px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="google" src="http://www.sellsbrothers.com/posts/Image/255" width="240" align="right" height="85" /></a>Google, like Microsoft, is famous for asking brain-teaser style questions during their interviews. However, in <a href="http://www.nytimes.com/2013/06/20/business/in-head-hunting-big-data-may-not-be-such-a-big-deal.html">a June, 2013 interview with the New York Times</a>, Laszlo Bock, the Sr. VP of HR for Google, said that
  “[B]ainteasers are a complete waste of time. How many golf balls can you fit into an airplane? How many gas stations in Manhattan? A complete waste of time. They don’t predict anything. They serve primarily to make the interviewer feel smart.”
  In <a href="http://www.nytimes.com/2014/04/20/opinion/sunday/friedman-how-to-get-a-job-at-google-part-2.html">another interview</a>, Bock said that when putting together a resume, focus on what you did in relation to the expectations:
  “The key is to frame your strengths as: ‘I accomplished X, relative to Y, by doing Z.’ Most people would write a résumé like this: ‘Wrote editorials for The New York Times.’ Better would be to say: ‘Had 50 op-eds published compared to average of 6 by most op-ed [writers] as a result of providing deep insight into the following area for three years.’ Most people don’t put the right content on their résumés.”
  Amen!
  
  </p>
  <p>
    <a data-disqus-identifier="12735" href="/Posts/Details/12735#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Thursday, Jul 17, 2014, 12:05 AM
    
    in
    <a href="/spout">The Spout</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12734">Moving My ASP.NET Web Site to Disqus</a></h2>
  <p>
    <a href="http://disqus.com/"><img style="float: right; margin: 5px; display: inline" src="https://a.disquscdn.com/dotcom/d-e357401/img/logos/logo-navbar-blue.png" align="right" /></a>I’m surprised how well that <a href="http://www.sellsbrothers.com/Posts/Details/12548">my commentRss proposal</a> has been accepted in the world. As often as not, if I’m digging through an RSS feed for a site that supports comments, that site also provides a commentRss element for each item. When I proposed this element, my thinking was that I could make a comment on an item of interest, then check a box and I’d see async replies in my RSS client, thereby fostering discussion. Unfortunately, RSS clients never took the step of allowing me to subscribe to comments for a particular item and a standard protocol for adding a comment never emerged, which made it even less likely for RSS clients to add that check box. All in all, commentRss is a failed experiment.
  ## Fostering Discussion in Blog Post Comments</h2>  However, the idea of posting comments to a blog post and subscribing to replies took off in another way. For example, Facebook does a very good job in fostering discussion on content posted to their site:
  <a href="http://www.sellsbrothers.com/posts/Image/248"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/249" width="591" height="768" /></a>
  <em>The Facebook supports comments and discussions nicely</em>
  &#160;
  Not only does Facebook provide a nice UI for comments, but as I reply to comments that others have made, they’re notified. In fact, as I was taking the screenshot above, I replied to Craig’s comment and within a minute he’d pressed the Like button, all because of the support Facebook has for reply notification.
  However, Facebook commenting only works for Facebook content. I want the same kind of experience with my own site’s content. For a long time, I had my own custom commenting system, but the bulk of the functionality was around keeping spam down, which was a huge problem. I recently dumped my comments to an XML format and of the 60MB of output, less than 8MB were actual comments – more than 80% was comment spam. I tried added <a href="http://www.google.com/recaptcha/intro/index.html">reCAPTCHA</a> and eventually email approval of all comments, but none of that fostered the back-and-forth discussions over time because I didn’t have notifications. Of course, to implement notifications, you need user accounts with email verification, which was a whole other set of features that I just never got around to implementing. And even if I did, I would have taken me a lot more effort to get to the level of quality that <a href="http://www.disqus.com/">Disqus</a> provides.
  <h2>Integrating Disqus Into Your Web Site  Disqus provides a service that lets me import, export and manage comments for my site’s blog posts, the UI for my web site to collect and display comments and the notification system that fosters discussions. And they watch for spam, too. Here’s what it looks like on a recent post on my site:
  <a href="http://www.sellsbrothers.com/posts/Image/250"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/251" width="646" height="367" /></a>
  <em>The Disqus services provides a discussion UI for your web site</em>
  &#160;
  Not only does Disqus provide the UI for comments, but it also provides the account management so that commenters can have icons and get notifications. With the settings to allow for guest posting, the barrier to entry for the reader that wants to leave a comment is zero. Adding the code to enable it on your site isn’t zero, but it’s pretty close. Once you’ve established a free account on <a href="http://disqus.com/admin/create/">disqus.com</a>, you can simply create a forum for your site and drop in some boilerplate code. Here’s what I added to my MVC view for a post’s detail page to get the discussion section above:
  <pre class="code"><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: #006400">-- Details.aspx –</span><span style="background: yellow; color: black">%&gt;</span></pre>

<pre class="code"><span style="background: white; color: black">...
</span><span style="background: white; color: blue">&lt;</span><span style="background: white; color: maroon">asp</span><span style="background: white; color: blue">:</span><span style="background: white; color: maroon">Content </span><span style="background: white; color: red">ID</span><span style="background: white; color: blue">="Content2" </span><span style="background: white; color: red">ContentPlaceHolderID</span><span style="background: white; color: blue">="MainContent" </span><span style="background: white; color: red">runat</span><span style="background: white; color: blue">="server"&gt;
</span><span style="background: white; color: blue"><span style="background: white; color: black"> </span> </span><span style="background: white; color: #006400">&lt;!-- post –&gt;
</span><span style="background: white; color: black">  ...</span></pre>

<pre class="code"><span style="background: white; color: black"></span><span style="background: white; color: blue">  &lt;</span><span style="background: white; color: maroon">h1</span><span style="background: white; color: blue">&gt;</span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">Model.Post.Title </span><span style="background: yellow; color: black">%&gt;</span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">h1</span><span style="background: white; color: blue">&gt;
  &lt;</span><span style="background: white; color: maroon">div</span><span style="background: white; color: blue">&gt;</span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">Model.Post.Content </span><span style="background: yellow; color: black">%&gt;</span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">div</span><span style="background: white; color: blue">&gt;
<strong>  </strong></span><strong><span style="background: white; color: #006400">&lt;!-- comments --&gt;
  </span><span style="background: white; color: blue">&lt;</span><span style="background: white; color: maroon">div </span><span style="background: white; color: red">id</span><span style="background: white; color: blue">="disqus_thread"&gt;&lt;/</span><span style="background: white; color: maroon">div</span></strong><strong><span style="background: white; color: blue">&gt;
  &lt;</span><span style="background: white; color: maroon">script </span><span style="background: white; color: red">type</span></strong><strong><span style="background: white; color: blue">="text/javascript"&gt;
    var </span><span style="background: white; color: black">disqus_shortname = </span><span style="background: white; color: #a31515">"YOUR-DISQUS-SITE-SHORTNAME-HERE"</span></strong><strong><span style="background: white; color: black">;
    </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">disqus_identifier = </span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">Model.Post.Id </span><span style="background: yellow; color: black">%&gt;</span></strong><strong><span style="background: white; color: black">;
    </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">disqus_title = </span><span style="background: white; color: #a31515">"</span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">Model.Post.Title </span><span style="background: yellow; color: black">%&gt;</span><span style="background: white; color: #a31515">"</span></strong><strong><span style="background: white; color: black">;</span></strong><span style="background: white; color: black"><strong>

    </strong></span><strong><span style="background: white; color: green">/* * * DON'T EDIT BELOW THIS LINE * * */
    </span><span style="background: white; color: black">(</span><span style="background: white; color: blue">function </span></strong><strong><span style="background: white; color: black">() {
      </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">dsq = document.createElement(</span><span style="background: white; color: #a31515">'script'</span><span style="background: white; color: black">); dsq.type = </span><span style="background: white; color: #a31515">'text/javascript'</span><span style="background: white; color: black">; dsq.async = </span><span style="background: white; color: blue">true</span></strong><strong><span style="background: white; color: black">;
      dsq.src = </span><span style="background: white; color: #a31515">'//' </span><span style="background: white; color: black">+ disqus_shortname + </span><span style="background: white; color: #a31515">'.disqus.com/embed.js'</span></strong><strong><span style="background: white; color: black">;
      (document.getElementsByTagName(</span><span style="background: white; color: #a31515">'head'</span><span style="background: white; color: black">)[0] || document.getElementsByTagName(</span><span style="background: white; color: #a31515">'body'</span></strong><strong><span style="background: white; color: black">)[0]).appendChild(dsq);
    })();
  </span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">script</span></strong><span style="background: white; color: blue"><strong>&gt;
</strong>&lt;/</span><span style="background: white; color: maroon">asp</span><span style="background: white; color: blue">:</span><span style="background: white; color: maroon">Content</span><span style="background: white; color: blue">&gt;
</span></pre>

The discussion section for any post is just a div with the id set to “disqus_thread”. The code is from the useful-but-difficult-to-find <a href="https://help.disqus.com/customer/portal/articles/472097-universal-embed-code">Disqus universal embed code docs</a>. The JavaScript added to the end of the page creates a Disqus discussion control in the div you provide using the JS variables defined at the top of the code. The only JS variable that’s required is the disqus_shortname, which defines the Disqus data source for your comments. The disqus_identifier is a unique ID associated with the post. If this isn’t provided, the URL for the page the browser is currently showing will be used, but that doesn’t work for development mode from localhost or if the comments are hosted on multiple sites, e.g. a staging server and a production server, so I recommend setting disqus_identifier explicitly. The disqus_title will likewise be taken from the current page’s title, but it’s better to set it yourself to make sure it’s what you want.


And that’s it. Instead of tuning your UI in the JS code, you do so in the settings on disqus.com yourself an includes things like the default order of comments, the color scheme, how much moderation you want, etc.


There’s one more page on your site where you’ll want to integrate Disqus: the page the provides the list of posts along with the comment link and comment count:


<a href="http://www.sellsbrothers.com/posts/Image/252"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/253" width="646" height="393" /></a>


<em>Disqus will add comment count to your comment lists, too</em>


&#160;


Adding support for the comment count is similar to adding support for the discussion itself:


<pre class="code"><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: #006400">-- Index.aspx --</span><span style="background: yellow; color: black">%&gt;
</span><span style="background: white; color: blue">...</span></pre>

<pre class="code"><span style="background: white; color: blue">&lt;</span><span style="background: white; color: maroon">asp</span><span style="background: white; color: blue">:</span><span style="background: white; color: maroon">Content </span><span style="background: white; color: red">ID</span><span style="background: white; color: blue">="Content2" </span><span style="background: white; color: red">ContentPlaceHolderID</span><span style="background: white; color: blue">="MainContent" </span><span style="background: white; color: red">runat</span><span style="background: white; color: blue">="server"&gt;
<span style="background: white; color: blue">  ...</span></span></pre>

<pre class="code"><span style="background: white; color: #006400">  &lt;!-- post --&gt;
</span><span style="background: white; color: blue">  &lt;</span><span style="background: white; color: maroon">h2</span><span style="background: white; color: blue">&gt;</span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">Html.ActionLink(post.Title, </span><span style="background: white; color: #a31515">"Details"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"Posts"</span><span style="background: white; color: black">, </span><span style="background: white; color: blue">new </span><span style="background: white; color: black">{ id = post.Id }, </span><span style="background: white; color: blue">null</span><span style="background: white; color: black">) </span><span style="background: yellow; color: black">%&gt;</span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">h2</span><span style="background: white; color: blue">&gt;
  &lt;</span><span style="background: white; color: maroon">p</span><span style="background: white; color: blue">&gt;</span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">post.Content </span><span style="background: yellow; color: black">%&gt;</span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">p</span><span style="background: white; color: blue">&gt;
<span style="background: white; color: #006400"><strong>  &lt;!-- comment link --&gt; </strong></span></span></pre>

<pre class="code"><span style="background: white; color: blue"><span style="background: white; color: #006400"></span><strong>  &lt;</strong></span><strong><span style="background: white; color: maroon">p</span><span style="background: white; color: blue">&gt;</span><span style="background: yellow; color: black">&lt;%</span><span style="background: white; color: blue">= </span><span style="background: white; color: black">Html.ActionLink(</span><span style="background: white; color: #a31515">"0 comments"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"Details"</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"Posts"</span><span style="background: white; color: black">, </span><span style="background: white; color: blue">null</span><span style="background: white; color: black">, </span><span style="background: white; color: blue">null</span><span style="background: white; color: black">, </span><span style="background: white; color: #a31515">"disqus_thread"</span><span style="background: white; color: black">,<br /></span></strong><strong><span style="background: white; color: black">           </span><span style="background: white; color: blue">new </span><span style="background: white; color: #2b91af">RouteValueDictionary</span><span style="background: white; color: black">(<br /></span></strong><strong><span style="background: white; color: black">             </span><span style="background: white; color: blue">new </span><span style="background: white; color: black">{ id = post.Id }),<br /></span></strong><strong><span style="background: white; color: black">             </span><span style="background: white; color: blue">new </span><span style="background: white; color: #2b91af">Dictionary</span><span style="background: white; color: black">&lt;</span><span style="background: white; color: blue">string</span><span style="background: white; color: black">, </span><span style="background: white; color: blue">object</span><span style="background: white; color: black">&gt;() { { </span><span style="background: white; color: #a31515">"data-disqus-identifier"</span><span style="background: white; color: black">, post.Id } }) </span><span style="background: yellow; color: black">%&gt;</span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">p</span></strong><span style="background: white; color: blue"><strong>&gt;
</strong><span style="background: white; color: blue">  ...</span></span></pre>

<pre class="code"><span style="background: white; color: blue"><span style="background: white; color: blue"></span></span><strong><span style="background: white; color: blue">  &lt;</span><span style="background: white; color: maroon">script </span><span style="background: white; color: red">type</span></strong><span style="background: white; color: blue"><strong>="text/javascript"&gt;
    </strong></span><strong><span style="background: white; color: green">// from: https://help.disqus.com/customer/portal/articles/565624
    </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">disqus_shortname = </span><span style="background: white; color: #a31515">"sellsbrothers"</span></strong><span style="background: white; color: black"><strong>;

    </strong></span><strong><span style="background: white; color: green">/* * * DON'T EDIT BELOW THIS LINE * * */
    </span><span style="background: white; color: black">(</span><span style="background: white; color: blue">function </span></strong><strong><span style="background: white; color: black">() {
      </span><span style="background: white; color: blue">var </span><span style="background: white; color: black">s = document.createElement(</span><span style="background: white; color: #a31515">'script'</span><span style="background: white; color: black">); s.async = </span><span style="background: white; color: blue">true</span></strong><strong><span style="background: white; color: black">;
      s.type = </span><span style="background: white; color: #a31515">'text/javascript'</span></strong><strong><span style="background: white; color: black">;
      s.src = </span><span style="background: white; color: #a31515">'http://' </span><span style="background: white; color: black">+ disqus_shortname + </span><span style="background: white; color: #a31515">'.disqus.com/count.js'</span></strong><strong><span style="background: white; color: black">;
      (document.getElementsByTagName(</span><span style="background: white; color: #a31515">'HEAD'</span><span style="background: white; color: black">)[0] || document.getElementsByTagName(</span><span style="background: white; color: #a31515">'BODY'</span></strong><strong><span style="background: white; color: black">)[0]).appendChild(s);
    }());
  </span><span style="background: white; color: blue">&lt;/</span><span style="background: white; color: maroon">script</span></strong><span style="background: white; color: blue"><strong>&gt;
</strong>&lt;/</span><span style="background: white; color: maroon">asp</span><span style="background: white; color: blue">:</span><span style="background: white; color: maroon">Content</span><span style="background: white; color: blue">&gt;
</span></pre>

Again, this code is largely boilerplate and comes from <a href="https://help.disqus.com/customer/portal/articles/565624">the Disqus comment count docs</a>. The call to Html.ActionLink is just a fancy way to get an A tag with an href of the following format:


<blockquote>
  &lt;a href="/Posts/Details/&lt;&lt;POST-ID&gt;&gt;<strong>#disqus_thread</strong>" <strong>data-disqus-identifier="&lt;&lt;POST-ID&gt;&gt;"</strong>&gt;<strong>0 comments</strong>&lt;/a&gt;

</blockquote>

The “disqus_thread” tag at the end of the href does two things. The first is that it provides a link to the discussion portion of the details page so that the reader can scroll directly to the comments after reading the post. The second is that it provides a tag for the Disqus JavaScript code to change the text content of the A tag to show the number of comments.


The “data-disqus-identifier” attribute sets the unique identifier for the post itself, just like the disqus_identifier JS variable we saw earlier.


The A tag text content that you provide will only be shown if Disqus does not yet know about that particular post, i.e. if there are no comments yet, then it will leave it alone. However, if Disqus does know about that post, it will replace the text content of the A tag as per your settings, which allow you to be specific about how you want 0, 1 and n comments to show up on your site; “0 comments”, “1 comment” and “{num} comments” are the defaults. 


## Importing Existing Comments into Disqus

At this point, your site is fully enabled for Disqus discussions and you can deploy. In the meantime, if you’ve got existing comments like I did, you can import them using Disqus’s implementation of the WordPress WXR format, which is essentially RSS 2.0 with embedded comments. <a href="https://help.disqus.com/customer/portal/articles/472150">The Disqus XML import docs</a> describe the format and some important reminders. The two reminders they list are important enough to list again here:


<ul>
  <li><strong>“Register a test forum and import to that forum first to work out the kinks.” </strong>Because Disqus only lists some of the restrictions on their site for the imported data, I probably had to do a dozen or more imports before I get everything to move over smoothly. I ended up using two test forums before I was confident enough to import comments into my the real forum for my site. </li>

  <li><strong>“Keep individual file sizes &lt; 50 MB each.”</strong> In fact, I found 20MB to be the maximum reliable size. I had to write my script to split my comments across multiple files to keep to this limit or my uploads would time out. </li>
</ul>

&#160;


The XML import docs do a good job showing what the XML format is as an example, but they only list one of the data size requirements. In my work, I found several undocumented limits as well:


<ul>
  <li><strong>comment_content must be &gt;= 3 characters (space trimmed) and &lt;= 25,000 characters. </strong>I found out the max when trying to import some of my unapproved spam comments. </li>

  <li><strong>comment_author and comment_author_email must be &lt;= 75 characters. </strong>You may get errors about comment_author being too long even if you haven’t provided one; that just means that Disqus has grabbed comment_author_email as the contents for comment_author. </li>

  <li><strong>post_date_gmt and comment_date_gmt</strong> <strong>must be formatted correctly as yyyy-MM-dd HH:mm:ss. </strong>Of course, they must be in GMT, too. </li>

  <li><strong>The actual post content should be empty.</strong> Even though it looks like you’re uploading your entire blog via RSS, you’re only providing enough of the post content to allow Disqus to map from post to associated comments, like the thread_identifier referenced as disqus_thread in the JavaScript code above, as well as to show the post title and date as appropriate. The only real content you’re importing into Disqus is the comment content associated with each post. </li>
</ul>

Something else to keep in mind is that as part of the comment import process is that Disqus translates the XML data into JSON data, which makes sense. However, they report their errors in terms of the undocumented JSON data structure, which can be confusing as hell. For example, I kept getting a “missing or invalid message” error message along with the JSON version of what I thought the message was to which they were referring. The problem was that by “message”, Disqus didn’t mean “the JSON data packet for a particular comment,” they meant “the field called ‘message’ in our undocumented JSON format which is mapped from the comment_content element of the XML.” I went round and round with support on this until I figured that out. Hopefully I’ve saved future generations that trouble.


If you’re a fan of LINQPad or C#, you can see <a href="https://github.com/csells/sb4/blob/master/Solution%20Items/sb-com%20creating%20WXR%20file%20for%20Disqus%20comment%20export.linq">the script I used to pull the posts and comments out of my site’s SQL Server database</a> (this assumes an Entity Framework mapping in a separate DLL, but you get the gist). The restrictions I mention above are encapsulated in this script.


## Where Are We?

Even though my rssComments extension to the RSS protocol was a failed experiment, the web has figured out how to foster spam-free, interactive discussions with email notifications across web sites. The free Disqus service provides as implementation of this idea and it does so beautifully. I wish importing comments was as easy as integrating the code, but since I only had to do it once, the juice was more than worth the squeeze, as <a href="http://michaelweinhardtphotography.com/">a dear Australian friend of mine</a> likes to say. Enjoy!
  
  </p>
  <p>
    <a data-disqus-identifier="12734" href="/Posts/Details/12734#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Friday, Jul 11, 2014, 10:45 PM
    
    in
    <a href="/spout">The Spout</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12733">Moving My Site to Azure: DNS &amp; SSL</a></h2>
  <p>
    This part 3 of a multi-part series on taking a real-world web site (mine) written to be hosted on an ISP (<a href="http://securewebs.com">securewebs.com</a>) and moving it to the cloud (Azure). The first two parts talked about <a href="http://www.sellsbrothers.com/Posts/Details/12731">moving my SQL Server instance to SQL Azure</a> and getting my legacy ASP.NET MVC 2 code running inside of Visual Studio 2013 and <a href="http://www.sellsbrothers.com/Posts/Details/12732">published to Azure</a>. In this installment, we’ll discuss how I configured DNS and SSL to work with my shiny new Azure web site.
  ## Configuring DNS</h2>  Now that I have my site hosted on <a href="http://sellsbrothers.azurewebsites.net">http://sellsbrothers.azurewebsites.net</a>, I’d like to change my DNS entries for sellsbrothers.com and www.sellsbrothers.com to point to it. For some reason I don’t remember, I have my domain’s name servers pointed at microsoftonline.com and I used Office365 to manage them (it has something to do with my Office365 email account, but I’m not sure why that matters…). Anyway, in the Manage DNS section of the Office365 admin pages, there’s a place to enter various DNS record types. To start, I needed to add two CNAME records:
  <a href="http://www.sellsbrothers.com/posts/Image/236"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/237" width="646" height="72" /></a>
  <em>The CNAME records needed to be awarded an IP address by Azure</em>
  &#160;
  <a href="http://en.wikipedia.org/wiki/CNAME_record">A CNAME record</a> is an alias to some other name. In this case, we’re aliasing the awveryify.sellsbrothers.com <a href="http://en.wikipedia.org/wiki/Fully_qualified_domain_name">FQDN</a> (the Host name field is really just the part to the left of the domain name to which you’re adding records, sellsbrothers.com in this case). This awverify string is just a string that Azure needs to see before it will tell you the IP address that it’s assigned to you as a way to guarantee that you do, in fact, own the domain. The www host name maps to the Azure web site name, i.e. mapping www.sellsbrothers.com to sellsbrothers.azurewebsites.net. The other DNS record I need is an A record, which maps the main domain, i.e. sellsbrothers.com, to the Azure IP address, which I’ll have to add later once Azure tells me what it is.
  After adding the awverify and www host names and waiting for the DNS changes to propagate (an hour or less in most cases), I fired up the configuration screen for my web site and chose the Manage Custom Domains dialog:
  <a href="http://www.sellsbrothers.com/posts/Image/238"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/239" width="646" height="476" /></a>
  <em>Finding the IP address to use in configuring your DNS name server from Azure</em>
  &#160;
  Azure provided the IP address after entering the www.sellsbrothers.com domain name. With this in hand, I needed to add the A record:
  <a href="http://www.sellsbrothers.com/posts/Image/240"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/241" width="646" height="98" /></a>
  <em>Adding the Azure IP address to my DNS name servers</em>
  &#160;
  An <a href="http://en.wikipedia.org/wiki/List_of_DNS_record_types">A record</a> is the way to map a host name to an IP address. The use of the @ means the undecorated domain, so I’m mapping sellsbrothers.com to the IP address for sellsbrothers.azurewebsites.net.
  Now, this works, but it’s not quite what I wanted. What I really want to do, and what the Azure docs hint at, is to simply have a set of CNAME records, including one that maps the base domain name, i.e. sellsbrothers.com, to sellsbrothers.azurewebsites.net directly and let DNS figure out what the IP address is. This would allow me to tear down my web server and set it up again, letting Azure assign whatever IP address it wanted and without me being required to update my DNS A record if I ever need to do that. However, while I should be able to enter a CNAME record with a @ host name, mapping it to the Azure web site domain name, Office365 the DNS management UI won’t let me do it and Office365 support wasn’t able to help.
  However, even if my DNS records weren’t future-proofed the way I’d like them to be, they certainly worked and now both sellsbrothers.com and www.sellsbrothers.com mapped to my new Azure web site, which is where those names are pointing as I write this.
  However, there was one more feature I needed before I was done ported my site to Azure: secure posting to my blog, which requires an SSL certificate.
  <h2></h2>  <h2>Configuring Azure with SSL</h2>  Once I had my domain name flipped over, I had one more feature I needed for my Azure-hosted web site to be complete – I needed to be able to make posts to my blog. I implemented <a href="http://bitworking.org/projects/atom/rfc5023.html">the AtomPub publishing protocol</a> for my web site years ago, mostly because it was a protocol with which I was very familiar and because it was one that <a href="http://en.wikipedia.org/wiki/Windows_Live_Writer">Windows Live Writer</a> supports. To make sure that only I could post to my web site, I needed to make sure that my user name and password didn’t transmit in the clear. The easiest way to make that happen was to enable HTTPS on my site using an SSL certificate. Of course, Azure supports HTTPS and SSL and the interface to make this happen is simple:
  <a href="http://www.sellsbrothers.com/posts/Image/242"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/243" width="646" height="455" /></a>
  <em>Azure’s certificate update dialog for added an SSL cert to your web site</em>
  &#160;
  Azure requires a file in the PKCS #12 format (generally using the .pfx file extension), which can be a container of several security-related objects, including a certificate. All of this is fine and dandy except that when you go to purchase your SSL cert, you’re not likely to get the file in pfx format, but in X.509 format (.cer or .crt file format). To translate the .crt file into a .pfx file, you need to generate a Certificate Signing Request (.csr) file with the right options so that you keep the private key (.key) file around for the conversion. For a good overview of the various SSL-related file types, <a href="http://blogs.msdn.com/b/kaushal/archive/2010/11/05/ssl-certificates.aspx">check out Kaushal Panday’s excellent blog post</a>.
  Now, to actual dig into the nitty gritty, first you’re going to have to choose an SSL provider. Personally, I’m a cheapskate and don’t do any ecommerce on my site, so my needs were modest. I got myself a RapidSSL cert from <a href="http://namecheap.com">namecheap.com</a> that only did domain validation for $11/year. After making my choice, the process went smoothly. To get started, you pay your money and upload a Certificate Signing Request (.crs file). I tried a couple different ways to get a csr file, but the one that worked the best was <a href="http://slproweb.com/products/Win32OpenSSL.html">the openssl command line tool for Windows</a>. With that tool installed and a command console (running in admin mode) at the ready, you can follow along with the <a href="http://azure.microsoft.com/en-us/documentation/articles/web-sites-configure-ssl-certificate/#get-a-certificate-using-openssl">Get a certificate using OpenSSL</a> section of the Azure documentation on SSL certs and be in good shape.
  Just one word of warning if you want to follow along with these instructions yourself: There’s a blurb in there about including intermediate certificates along with the cert for your site. For example, when I get my RapidSSL certificate, it came with a GeoTrust intermediate certificate. Due to <a href="http://stackoverflow.com/questions/24558174/error-uploading-ssl-certificate-to-windows-azure">a known issue</a>, when I tried to include the GeoTrust cert in my chain of certificates, Azure would reject it. Just dropping that intermediate cert on the floor worked for me, but your mileage may vary.
  <h2>Configuring for Windows Live Writer</h2>  Once I have my SSL uploaded to Azure, now I can configure WLW securely for my new Azure-hosted blog:
  <a href="http://www.sellsbrothers.com/posts/Image/244"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/245" width="601" height="484" /></a>
  <em>Adding a secure login for my Azure-hosted blog</em>
  &#160;
  You’ll notice that I use HTTPS as the protocol to let WLW know I’d like it to use encrypted traffic when it’s transmitting my user name and password. The important part of the rest of the configuration is just about what kind of protocol you’d like to use, which is AtomPub in my case:
  <a href="http://www.sellsbrothers.com/posts/Image/246"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/247" width="601" height="484" /></a>
  <em>Configuring WLW for the AtomPub Publishing protocol</em>
  &#160;
  If you’re interested in a WLW-compatible implementation of AtomPub written for ASP.NET, you can <a href="https://github.com/csells/sb4">download the source to my site from github</a>.
  <h2>Where are we?  Getting your site moved to Azure from an ISP involves more than just <a href="http://www.sellsbrothers.com/Posts/Details/12732">making sure you can deploy your code</a> – it also includes <a href="http://www.sellsbrothers.com/Posts/Details/12731">making sure your database will work in SQL Azure</a> and configuring your DNS and SSL settings as appropriate for your site’s new home.
  At this point, I’ve gotten a web site that’s running well in the cloud, but in the spirit of the cloud, I’ve also got an aging comment system that I replaced with <a href="http://disqus.com/">Disqus</a>, a cloud-hosted commenting system, which is the subject of <a href="https://www.sellsbrothers.com/Posts/Details/12734">my next post</a>. Don’t miss it!
  
  </p>
  <p>
    <a data-disqus-identifier="12733" href="/Posts/Details/12733#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Tuesday, Jul 8, 2014, 7:36 PM
    
    in
    <a href="/spout">The Spout</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12732">Moving My Site to Azure: ASP.NET MVC 2</a></h2>
  <p>
    In our last episode, I talked about <a href="http://www.sellsbrothers.com/Posts/Details/12731">the joy and wonder that is moving my site’s ISP-hosted SQL Server instance to SQL Azure</a>. Once I had the data moved over and the site flipped to using the new database, I needed to move the site itself over, which brought joy and wonder all it’s own.
  ## Moving to Visual Studio 2013</h2>  I haven’t had to do any <a href="http://www.sellsbrothers.com/posts/details/12670">major updates to my site since 2010 using Visual Studio 2010</a>. At that time, the state of the art was ASP.NET MVC 2 and Entity Framework 4, which is what I used. And the combination was a pleasant experience, letting me rebuild my site from scratch quickly and producing a site that ran like the wind. In fact, it still runs like the wind. Unfortunately, Visual Studio 2012 stopped supporting MVC 2 (and no surprise, Visual Studio 2013 didn’t add MVC 2 support back). When I tried to load my web site project into Visual Studio 2013, it complained:
  <a href="http://www.sellsbrothers.com/posts/Image/214"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/215" width="644" height="324" /></a>
  <em>This version of Visual Studio is unable to open the following projects</em>
  &#160;
  This error message lets me know that there’s a problem and the migration report provides a handy link to <a href="http://www.asp.net/whitepapers/mvc3-release-notes#upgrading">upgrade from MVC 2 to MVC 3</a>. The steps aren’t too bad and there’s even a tool to help, but had I followed them, loading the new MVC 3 version of my project into Visual Studio 2013 would’ve given me another error with another migration report and a link to <a href="http://www.asp.net/whitepapers/mvc4-release-notes#_Toc303253806">another web page, this time helping me move from MVC 3 to MVC 4</a> because VS2013 doesn’t support MVC 3, either. And so now I’m thinking, halfway up to my elbows in the move to MVC 3 that Visual Studio 2013 doesn’t like, that maybe there’s another way.
  It’s not that there aren’t benefits to move to MVC 4, but that’s not even the latest version. In fact, Microsoft is currently working on two versions of ASP.NET, <a href="http://www.asp.net/mvc/tutorials/mvc-5/introduction/getting-started">ASP.NET MVC 5</a> and <a href="http://www.asp.net/vnext">ASP.NET v.Next</a>. <em>Even if I do move my site forward two version of MVC, I’ll still be two versions behind.</em> Of course, the new versions have new tools and new features and can walk my dog for me, but by dropping old versions on the floor, I’d left with the choices of running old versions of Visual Studio side-by-side with new ones, upgrading to new versions of MVC just to run the latest version of VS (even if I don’t need any of the new MVC features) or saying “screw it” and just re-writing my web site from scratch. This last option might seem like what Microsoft wants me to do so that they can stop supporting the old versions of MVC, but what’s to stop me from moving to AWS, Linux and Node instead of to ASP.NET v.Next? The real danger of dropping the old versions on the floor; not that I’ll move over to another platform, because I’m an Microsoft fanboy and my MSDN Subscription gives me the OS and the tools for free, but that large paying customers say “screw it” and move their web sites to something that their tools are going to support for more than a few years.
  Luckily for me, there is another way: I can cheat. It turns out that if I want to load my MVC 2 project inside of Visual Studio 2013, all I have to do is remove a GUID from the csproj file inside the ProjectTypeGuids element. The GUID in question is listed on step 9 of <a href="http://www.asp.net/whitepapers/mvc3-release-notes#upgrading">Microsoft’s guide for upgrading from MVC 2 to MVC 3</a>:
  <a href="http://www.sellsbrothers.com/posts/Image/216"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/217" width="644" height="411" /></a>
  <em>Removing {F85E285D-A4E0-4152-9332-AB1D724D3325} from your MVC 2 project so it will load in Visual Studio 2013</em>
  &#160;
  By removing this GUID, I give up some of the productivity tools inside Visual Studio, like easily adding a new controller. However, I’m familiar enough with MVC 2 that I no longer need those tools and being able to actually load my project into the latest version of Visual Studio is more than worth it. Andrew Steele provides more details about this hack in <a href="http://stackoverflow.com/questions/13424079/how-do-i-open-an-old-mvc-project-in-visual-studio-2012-or-visual-studio-2013/13424080#13424080">his most excellent StackOverflow post</a>.
  Now, to get my MVC 2 project to actually build and run, I needed a copy of the MVC 2 assemblies, which I got from NuGet:
  <a href="http://www.sellsbrothers.com/posts/Image/218"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/219" width="644" height="365" /></a>
  <em>Adding the MVC 2 NuGet package to my project inside Visual Studio 2013</em>
  &#160;
  With these changes, I could build my MVC 2 project inside Visual Studio 2013 and run on my local box against my SQL Azure instance. Now I just need to get it up on Azure.
  <h2>Moving to Azure</h2>  Publishing my MVC 2 site to Azure was matter of right-clicking on my project and choosing the Publish option:
  <a href="http://www.sellsbrothers.com/posts/Image/220"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/221" width="616" height="484" /></a>
  <em>Publishing a web site to Azure using the Solution Explorer’s Publish option inside Visual Studio 2013</em>
  &#160;
  Selecting the Windows Azure Web Sites as the target and filling in the appropriate credentials was all it took to get my site running on Azure. I did some battle with the “<a href="http://stackoverflow.com/questions/9300927/error-to-use-a-section-registered-as-allowdefinition-machinetoapplication-beyo">Error to use a section registered as allowDefinition='MachineToApplication' beyond application level</a>” bug in Visual Studio, but the only real issue I had was that Azure seemed to need the “Precompile during publishing” option set or it wasn’t able to run my MVC 2 views when I surfed to them:
  &#160;
  <a href="http://www.sellsbrothers.com/posts/Image/222"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/223" width="616" height="484" /></a>
  <em>Setting the “Precompile during publishing” option for Azure to run my MVC 2 views</em>
  &#160;
  With that setting in place, my Azure site just ran at the Azure URL I had requested: <a href="http://sellsbrothers.azurewebsites.net">http://sellsbrothers.azurewebsites.net</a>. 
  <h2>Where are we?  I’m a fan of <a href="http://www.asp.net/vnext/overview/aspnet-vnext/getting-started-with-aspnet-vnext-and-visual-studio">the direction of ASP.NET v.Next</a>. The order of magnitude reduction in working set, the open source development and the use of NuGet to designate pieces of the framework that you want are all great things. My objection is that I don’t want to be forced to move forward to new versions of a framework if I don’t need the features. If I am forced, then that’s just churn in working code that’s bound to introduce bugs.
  <a href="https://www.sellsbrothers.com/Posts/Details/12733">Tune in next time</a> and we’ll discuss the fun I had configuring the DNS settings to make Azure the destination for sellsbrothers.com and to add SSL to enable secure login for posting articles via AtomPub and Windows Live Writer.
  
  </p>
  <p>
    <a data-disqus-identifier="12732" href="/Posts/Details/12732#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Monday, Jul 7, 2014, 2:45 AM
    
    in
    <a href="/spout">The Spout</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12731">Moving My Site to Azure: The Database</a></h2>
  <p>
    <a href="https://www.youtube.com/watch?v=PjWKE-IJ4R8">In a world</a> where the cloud is not longer the wave of the future, but the reality of the present, it seems pretty clear that it’s time to move <a href="http://sellsbrothers.com">sellsbrothers.com</a> from my free ISP hosting (thanks <a href="http://securewebs.com/">securewebs.com</a>!) to the cloud, specially Microsoft’s Azure. Of course, I’ve had an Azure account since its inception, but there has been lots of work to streamline the Azure development process in the last two years, so now should be the ideal time to jump in and see how blue the waters really are.
  As with any modern web property, I’ve got three tiers: presentation, service and database. Since the presentation tier uses server-side generated UI and it’s implementation is bundled together with the service tier, there are two big pieces to move – the ASP.NET site implementation and the SQL Server database instance. I decided to move the database first with the idea that once I got it hosted on Azure, I can simply flip the connection string to point the existing site to the new instance while I was doing the work to move the site separately.
  ## Deploy Database To Windows Azure SQL Database from SSMS</h2>  The database for my site does what you’d expect – it keeps track of the posts I make (like this one), the images that go along with each post, the comments that people make on each post, the writing and talks I give (shown on <a href="http://sellsbrothers.com/writing">the writing page</a>), book errata, some details about the navigation of the site, etc. In SQL Server Management Studio (SSMS), it looks pretty much like you’d expect:
  <a href="http://www.sellsbrothers.com/posts/Image/190"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/191" width="644" height="476" /></a>
  <em>sellsbrothers.com loaded into SQL Server Management Studio</em>
  &#160;
  However, before moving to Azure SQL Server, I needed a SQL Azure instance to move the data to, so I fired up <a href="https://manage.windowsazure.com">the Azure portal</a> and created one:
  <a href="http://www.sellsbrothers.com/posts/Image/192"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/193" width="644" height="296" /></a>
  <em>Creating a new SQL Azure database</em>
  &#160;
  In this case, I chose to create a new SQL Azure instance on a new machine, which Azure will spin up for us in a minute of two (and hence the wonder and beauty that is the cloud). I choose the Quick Create option instead of the Import option because the Import option required me to provide a .bacpac file, which was something I wasn’t familiar with. After creating the SQL Server instance and the corresponding server, clicking on the new server name (di5fa5p2lg in this case) gave me the properties of that server, including the Manage URL:
  <a href="http://www.sellsbrothers.com/posts/Image/194"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/195" width="644" height="330" /></a>
  <em>SQL Azure database properties</em>
  &#160;
  If you click on the Manage URL, you will have a web interface for interacting with your SQL Azure server, but more importantly for this exercise, the <a href="http://en.wikipedia.org/wiki/Fully_qualified_domain_name">FQDN</a> is what I needed to plug into SSMS so that I can connect to that server. I’ll need that in a minute, because in the meantime, I’d discovered what looked like the killer feature for my needs in the 2014 edition of SSMS:
  <a href="http://www.sellsbrothers.com/posts/Image/196"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/197" width="644" height="209" /></a>
  <em>Deploy Database to Windows Azure Database in SSMS 2014</em>
  &#160;
  By right-clicking on the database on my ISP in SSMS and choosing Tasks, I had the Deploy Database To Windows Azure SQL Database option. I was so happy to choose this option and see the Deployment Settings screen of the Deploy Database dialog:
  <a href="http://www.sellsbrothers.com/posts/Image/198"><img title="Untitled-2" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="Untitled-2" src="http://www.sellsbrothers.com/posts/Image/199" width="540" height="484" /></a>
  <em>SSMS Deploy Database dialog</em>
  &#160;
  Notice the Server connection is filled in with the name of my new SQL Server instance on Azure. It started blank and I filled it in by pushing the Connect button:
  <a href="http://www.sellsbrothers.com/posts/Image/200"><img title="Untitled-7" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="Untitled-7" src="http://www.sellsbrothers.com/posts/Image/201" width="644" height="469" /></a>
  <em>SSMS Connect to Server dialog</em>
  &#160;
  The Server name field of the Connect to Server dialog is where the FQDN we pulled from the Manage URL field of Azure database server properties screen earlier and the credentials are the same as I set when I created the database. However, filling in this dialog for the first time gave me some trouble:
  <a href="http://www.sellsbrothers.com/posts/Image/202"><img title="Untitled-8" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="Untitled-8" src="http://www.sellsbrothers.com/posts/Image/203" width="644" height="254" /></a>
  <em>SQL Azure: Cannot open server ‘foo’ requested by the login</em>
  &#160;
  SQL Azure is doing the right thing here to keep your databases secure by disabling access to any machine that’s not itself managed by Azure. To enable access from your client, look for the “Set up Windows Azure firewall rules for this IP address” option on the SQL database properties page in your Azure portal. You’ll end up with a server firewall rule that looks like the following (and that you may want to remove when you’re done with it):
  <a href="http://www.sellsbrothers.com/posts/Image/204"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/205" width="644" height="250" /></a>
  <em>SQL Azure server firewall rules</em>
  &#160;
  Once the firewall has been configured, filling in the connection properties and starting the database deployment from my ISP to Azure was when my hopes and dreams were crushed:
  <a href="http://www.sellsbrothers.com/posts/Image/206"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/207" width="644" height="256" /></a>
  <em>SSMS Deploy Database: Operation Failed</em>
  &#160;
  Clicking on the Error links all reported the same thing:
  <a href="http://www.sellsbrothers.com/posts/Image/208"><img title="Untitled-4" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="Untitled-4" src="http://www.sellsbrothers.com/posts/Image/209" width="644" height="203" /></a>
  <em>Error validating element dt_checkoutobject: Deprecated feature ‘String literals as column aliases’ is not supported by SQL Azure</em>
  &#160;
  At this point, all I could think was “what the heck is dt_checkoutobject” (<a href="http://social.msdn.microsoft.com/Forums/sqlserver/en-US/200ea417-f798-40e6-97a7-3ed8b174d962/mysterious-stored-procedures?forum=sqltools">it’s something that Microsoft added to my database</a>), what does it mean for to use string literals as column aliases (it’s a <a href="http://stackoverflow.com/questions/16284012/no-longer-able-to-create-a-bacpac-sql70015-deprecated-feature-string-literals/16284161#16284161">deprecated feature that SQL Azure doesn’t support</a>) and why would Microsoft deprecate a feature that they used themselves on a stored proc that they snuck into my database?! Unfortunately, we’ll never know the answer to that last question. However, my righteous indignation went away as I dug into my schema and found several more features that SQL Azure doesn’t support that I put into my own schema (primarily it was the lack of clustered indexes for primary keys, which <a href="http://blogs.msdn.com/b/sqlazure/archive/2010/05/12/10011257.aspx">SQL Azure requires to keep replicas of your database in the cloud</a>). Even worse, I found one table that listed errata for my books that didn’t have a primary key at all and because no one was keeping track of data integrity, all of the data was in that table twice (I can’t blame THAT on Microsoft : ).
  And just in case you think you can get around these requirements and sneak your database into SQL Azure w/o the updates, manually importing your data using <a href="http://blogs.msdn.com/b/brunoterkaly/archive/2013/09/26/how-to-export-an-on-premises-sql-server-database-to-windows-azure-storage.aspx">a bacpac file</a> is even harder, since you now have to make the changes to your database before you can create the bacpac file and you have to upload the file to Azure’s blob storage, which requires <a href="http://azurestorageexplorer.codeplex.com/">a whole other tool that Microsoft doesn’t even provide</a>.
  <h2>Making your Database SQL Azure-compatible using Visual Studio</h2>  To make my SQL database compatible with SQL Azure required changing the schema for my database. Since I didn’t want to change the schema for a running database on my ISP, I ended up copying the database from my ISP onto my local machine and making my schema changes there. Getting to point of SQL Azure-compatibility, however, required me to have the details of which SQL constructs SQL Azure supported and didn’t support. Microsoft provides <a href="http://msdn.microsoft.com/en-us/library/azure/ee336245.aspx">overview guidance on the limitations of SQL Azure</a>, but it’s not like having an automated tool that can check every line of your SQL. Luckily, Microsoft provides such a tool built into Visual Studio.
  To bring Microsoft’ SQL compiler to bear to check for SQL Azure compatibility requires using VS to create a SQL Server Database Project and then pointing it at the database you’d like to import from (which is the one copied to my local machine from my ISP in my case). After you’ve imported your database’s schema, doing a build will check your SQL for you. To get VS to check your SQL for Azure-compatibility, simply bring up the project settings and choose Windows Azure SQL Database as the Target platform:
  <a href="http://www.sellsbrothers.com/posts/Image/210"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/211" width="644" height="356" /></a>
  <em>Visual Studio 2014: Setting Database Project Target Platform</em>
  &#160;
  With this setting in place, compiling your project will tell you what’s wrong with your SQL from an Azure point-of-view. Once you’ve fixed your schema (which may require fixing your data, too), then you can generate a change script that updates your database in-place to make it Azure-compatible. For more details, check out Bill Gibson’s excellent article <a href="http://blogs.msdn.com/b/ssdt/archive/2012/04/19/migrating-a-database-to-sql-azure-using-ssdt.aspx">Migrating a Database to SQL Azure using SSDT</a>.
  <h2>The Connection String</h2>  Once the database has been deployed and tested (SSMS or the Manage URL are both good ways to test that your data is hosted the way you think it should be), then it’s merely a matter of changing the connection string to point to the SQL Azure instance. You can compose the connection string yourself or you can choose the “View connection strings for ADO.NET, ODBC, PHP and JDBC” option from your database properties page on Azure:
  <a href="http://www.sellsbrothers.com/posts/Image/212"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://www.sellsbrothers.com/posts/Image/213" width="642" height="417" /></a>
  <em>SQL Azure: Connection Strings</em>
  &#160;
  You’ll notice that while I blocked out some of the details of the connection string in my paranoia, that Azure itself is too paranoid to show the password; don’t forget to insert it yourself and to put it into a .config file that doesn’t make it into the SCCS.
  <h2></h2>  <h2>Where are we?  In porting sellsbrothers.com from an ISP to Azure, I started with the database. The tools are there (nice tools, in fact), but you’ll need to make sure that your database schema is SQL Azure-compatible, which can take some doing. In <a href="http://sellsbrothers.com/Posts/Details/12732">the next installment</a>, I’ll talk about how I moved the implementation of the site itself, which was not trivial, as it is implemented in ASP.NET MVC 2, which has been long abandoned by Microsoft.
  If you’d like to check out the final implementation in advance of my next post, you help yourself to <a href="https://github.com/csells/sb4">the sellsbrothers.com project on github</a>. Enjoy.
  
  </p>
  <p>
    <a data-disqus-identifier="12731" href="/Posts/Details/12731#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Monday, Dec 23, 2013, 4:20 PM
    
    in
    <a href="/spout">The Spout</a>
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12726">Bringing The Popular Tech Meetups to Portland</a></h2>
  <p>
    <a href="http://www.meetup.com/PDX-Tech/"><img title="pdx-tech-meetup-logo" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; float: right; padding-top: 0px; padding-left: 0px; margin: 0px 0px 5px 5px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="pdx-tech-meetup-logo" src="http://www.sellsbrothers.com/posts/Image/165" width="240" align="right" height="133" /></a>I’ve been watching the Portland startup scene for years. However, in the last 12 months, it’s really started to take off, so when I had an opportunity to mentor at the recent <a href="http://portland.startupweekend.org/">Portland Startup Weekend</a>, I was all over it. I got to do and see all kinds of wonderful things at PDXSW, but one of the best was meeting <a href="https://twitter.com/thubten">Thubten Comerford</a> and <a href="https://twitter.com/Phillipi">Tyler Phillipi</a>. Between the three of us, we’re bringing the very popular Tech Meetup conference format to Portland.
  The idea of a Tech Meetup is meant to be focused on pure tech. In fact, at <a href="http://nytm.org/">the largest of the Tech Meetups in New York</a> (33,000 members strong!), they have a rule where it’s actually rude to ask about the business model. The Tech Meetups are tech for tech’s sake. If you’re in a company big or small or if you’re just playing, cool tech always has a place at <a href="http://www.meetup.com/PDX-Tech/">the Portland Tech Meetup</a>.
  The format is simple and if you’re familiar with the way they do things in <a href="http://www.meetup.com/bdnewtech/events/154800842/">Boulder</a> or <a href="http://www.meetup.com/SeattleTechMeetup/">Seattle</a>, you’re already familiar with it. Starting on January 20th, 2014, every 3rd Monday at 6pm, we’ll open the doors for some networking time, providing free food and drink to grease the skids. At 7pm, we’ll start the tech presentation portion of the evening, which should be at least five tiny talks from tech presenters of all kinds. After the talks, we’ll wrap up around 8pm and then head to the local water hold for the debrief.
  <strong>If this sounds interesting to you, </strong><a href="http://www.meetup.com/PDX-Tech/"><strong>sign up right now</strong></a><strong>!</strong>
  <strong>If you’d like to present, </strong><a href="mailto:csells@sellsbrothers.com?subject=I'd like to present at the Portland Tech Meetup!"><strong>drop me a line</strong></a><strong>!</strong>
  <strong>If you’d like to sponsor, </strong><a href="https://twitter.com/thubten"><strong>let Thubten know</strong></a><strong>.</strong>
  We’re very excited about bringing this successful event to Portland, so don’t be shy about jumping in; the water is fine…
  
  </p>
  <p>
    <a data-disqus-identifier="12726" href="/Posts/Details/12726#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <!-- post -->
  <p class="postDate">
    Friday, Dec 20, 2013, 1:02 PM
    
  </p>
  <hr />
  <h2>
    <a href="/Posts/Details/12725">The Party Is Just Getting Started At Snapflow!</a></h2>
  <p>
    <a href="http://snapflow.com"><img title="snapflow logo" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; float: right; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="snapflow logo" src="http://www.sellsbrothers.com/posts/Image/162" width="240" align="right" height="75" /></a>This has been my first week at <a href="http://snapflow.com">Snapflow</a> and what a week it’s been! I’ve already spend a good part of two days with actual customers that are excited about using Snapflow to build their web and mobile applications, started on a technical spike for one of those apps to be delivered on our platform in February and found the local Hawaiian teriyaki place.
  As Chief Technical Officer at Snapflow, I’ll have influence over internal technology direction and external outreach, help to build our suite of products as well as growing the engineering team and work to understand our customers and make sure that they’re happy.
  Snapflow’s customers are enterprise verticals building web sites and mobile apps. They want to build apps with global reach and cloud scale, but they don’t want to manage VMs for their databases, custom logic and REST APIs. With Snapflow, they get to configure their data model, design their custom logic with workflow and the REST API falls naturally from that. Further, because Snapflow provides enterprise-grade services, customers get top notch tools, security at the granularity they need, multi-tenancy to deal with app variations across groups or geographies, and guaranteed uptime. Our customers can then build their client apps however we want, but so far it’s been overwhelmingly HTML-based, so you’ll soon see tools from us to support that even more.
  Technology-wise, we’ve got an amazing mix of AWS-based cloud hosting, Mongo DB and .NET on the server-side with HTML5-based tools and apps using Angular, Bootstrap and Kendo UI on the client-side.
  And <a href="http://www.snapflow.com/about">we’re hiring</a>! Snapflow has more work than we can do right now and <a href="http://www.snapflow.com/about">we’d love your help</a>. I had other choices when it came to my next adventure, but Snapflow is that rare combination of people, technology and opportunity that I just couldn’t pass up. It’s <em>the</em> hot enterprise startup in Portland. <a href="http://www.snapflow.com/about">Come join the party!</a>
  
  </p>
  <p>
    <a data-disqus-identifier="12725" href="/Posts/Details/12725#disqus_thread">0 comments</a>
  </p>
  
  <br />
  <br />
  <hr />
  <p>
    <a href="/?page=1">2634 older posts</a>
    
         
    
    No newer posts
    
  </p>
  <script type="text/javascript">
    // from: https://help.disqus.com/customer/portal/articles/565624
    var disqus_shortname = "sellsbrothers";

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function () {
      var s = document.createElement('script'); s.async = true;
      s.type = 'text/javascript';
      s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
      (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
    }());
  </script>

    </div>
    <div class="rightAds">
      <!-- search, badges and ads -->
      
      
<div id="WLSearchBoxDiv">
  <form method="get" action="http://www.google.com/search">
    <input name="q" style="color: #808080;"
      value="sellsbrothers.com search"
      onfocus="if(this.value==this.defaultValue)this.value=''; this.style.color='black';" onblur="if(this.value=='')this.value=this.defaultValue; " />
    <input type="hidden" name="sitesearch" value="sellsbrothers.com" />
  </form>
</div>

<!-- 160x600 ad tag -->
<div data-type="ad" data-publisher="sellsbrothers.com" data-zone="ron" data-format="160x600"></div>
<script type='text/javascript'>
  function _dmBootstrap(file) {
    var _dma = document.createElement('script');
    _dma.type = 'text/javascript';
    _dma.async = true;
    _dma.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + file;
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(_dma);
  }
  function _dmFollowup(file) { if (typeof DMAds === 'undefined') _dmBootstrap('cdn2.DeveloperMedia.com/a.min.js'); }
  (function () { _dmBootstrap('cdn1.DeveloperMedia.com/a.min.js'); setTimeout(_dmFollowup, 2000); })();
</script>

    </div>
  </div>
  <!-- NOTE: the "overflow: auto" on the footer is to keep the padding inside the footer div -->
  <div id="footer" class="container" style="overflow: auto; background-color: #999999;">
    <div class="leftPadding">
       
    </div>
    <div class="footerContent">
      <!-- bottom navigation -->
      <p class="footerText" style="white-space: nowrap">
        
        <a class="footerText" href="/">
          news</a>  
        
        <a class="footerText" href="/interview">
          interview</a>  
        
        <a class="footerText" href="/spout">
          the spout</a>  
        
        <a class="footerText" href="/tools">
          tools</a>  
        
        <a class="footerText" href="/writing">
          writing & speaking</a>  
        
        <a class="footerText" href="/fun">
          fun</a>  
        
        <a class="footerText" href="/colophon">
          colophon</a>  
        
        <a class="footerText" href="mailto:csells@sellsbrothers.com">contact</a>  
      </p>
      
<!-- text links -->
<p>
  
</p>

      <!-- copyright -->
      <p class="footerText">
        This content is copyright (c) 1995-2012, Chris Sells. All rights reserved. No warranties extended. Some assembly required. Void where prohibited. You may link to this site freely from your own site. You may quote small excerpts from this site, but please include a link to the original source on this site.
      </p>
    </div>
  </div>
  <!-- google analytics -->
  <script type="text/javascript">
    (function (i, s, o, g, r, a, m) {
      i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
      }, i[r].l = 1 * new Date(); a = s.createElement(o),
      m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-583310-1', 'sellsbrothers.com');
    ga('send', 'pageview');

  </script>
</body>
</html>

---
Title: Porting to MySpace using Silverlight
Published: 2011-04-13 20:00:18
Excerpt: ""
views:
  - 'a:1:{i:0;s:4:"1577";}'
sbg_selected_sidebar:
  - 'a:1:{i:0;s:66:"a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}";}'
sbg_selected_sidebar_replacement:
  - 'a:1:{i:0;s:66:"a:5:{i:0;s:1:"0";i:1;s:1:"0";i:2;s:1:"0";i:3;s:1:"0";i:4;s:1:"0";}";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3538636499";}'
author:
  - Marc LaFleur
post_date:
  - 2011-04-13 20:00:18
post_excerpt:
  - ""
permalink:
  - /porting-to-myspace-using-silverlight/
---
I was looking for a simple way to bring an existing web application to MySpace. I wanted to be able to place this app on a Profile page so that visitors could interact with it (similar to the Music and Video players provided by MySpace).  My initial thought was to simply use an IFRAME that displayed my application. Unfortunately this turned out to be impossible as MySpace doesn't allow IFRAMEs  to be placed on Profile or Home surfaces.

So how does one quickly turn their HTML application into a MySpace application without rewriting a ton of code? Enter <a href="http://www.silverlight.net/" target="_blank">Microsoft Silverlight</a> and the <a href="http://www.telerik.com/products/silverlight/htmlplaceholder.aspx" target="_blank">RadHtmlPlaceHolder control from Telerik</a>. MySpace supports Silverlight applications, just like Flash. And with an install base somewhere around <a href="http://www.riastats.com/" target="_blank">70%</a> now, I decided Silverlight is absolutely a viable option for my app.

The HTML Place Holder control from Telerik allows you to display HTML content within the Silverlight canvas. After checking with MySpace, I was told this was an acceptable use of Silverlight on MySpace.

I started by creating a Silverlight project. It is quite simple really, a single canvas with the HTML Place Holder control on it (set to 100% height and width) . I then added some code to handle the initÂ parameter for the URL to display.

In my App.xaml.cs I added:

[csharp]
private void Application_Startup(object sender, StartupEventArgs e)
{
    this.RootVisual = new MainPage(e.InitParams);
}
[/csharp]

In my MainPage.xaml.cs I added:

[csharp]
public MainPage(IDictionary&amp;lt;string, string&amp;gt; initParams)
{
    InitializeComponent();
    radHtmlPlaceholder1.SourceUrl = new Uri(initParams[&amp;quot;URI&amp;quot;]);
}
[/csharp]

That is the entirety of the Silverlight application. Pretty simple. I told Silverlight that the host for my Silverlight application was my existing web application, so it created the host automatically for me. I didn't need to do anything else.

In MySpace, I added the following code to call my new Silverlight application:

[js wraplines="false"]
 &lt;div id=&quot;content&quot;&gt;&lt;/div&gt;
    
&lt;script type=&quot;text/javascript&quot;&gt;
	var contentElement = document.getElementById(&quot;content&quot;);
	var initValue = &quot;URI= &lt;URL TO DISPLAY&gt;&quot;;

	var object = '&lt;object data=&quot;data:application/x-silverlight-2,&quot; height=&quot;100%&quot; type=&quot;application/x-silverlight-2&quot; width=&quot;100%&quot;&gt; '
	object = object + '&lt;param name=&quot;source&quot; value=&quot;&lt;URL TO XAP FILE&gt;&quot; /&gt;&lt;param name=&quot;onError&quot; value=&quot;onSilverlightError&quot; /&gt; '
	object = object + '&lt;param name=&quot;background&quot; value=&quot;Transparent&quot; /&gt;&lt;param name=&quot;minRuntimeVersion&quot; value=&quot;4.0.50401.0&quot; /&gt;&lt;param name=&quot;autoUpgrade&quot; value=&quot;true&quot; /&gt; '
	object = object + '&lt;param name=&quot;windowless&quot; value=&quot;true&quot; /&gt;&lt;param name=&quot;enableHtmlAccess&quot; value=&quot;true&quot; /&gt;&lt;param name=&quot;initparams&quot; value=&quot;' + initValue + '&quot; /&gt; '
	object = object + '&lt;a href=&quot;http://go.microsoft.com/fwlink/?LinkID=149156&amp;v=4.0.50401.0&quot; style=&quot;text-decoration: none&quot;&gt; '
	object = object + '&lt;img alt=&quot;Get Microsoft Silverlight&quot; src=&quot;http://go.microsoft.com/fwlink/?LinkId=161376&quot; style=&quot;border-style: none&quot; /&gt; &lt;/a&gt; &lt;/object&gt; '
	contentElement.innerHTML = object;
&lt;/script&gt;
[/js]

Hopefully this helps someone else out there. Feel free to contact me with any questions.
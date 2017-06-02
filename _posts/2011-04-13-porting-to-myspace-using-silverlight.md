---
Title: Porting to MySpace using Silverlight
Excerpt: ""
Tags:
  - WebDev
---
I was looking for a simple way to bring an existing web application to MySpace. I wanted to be able to place this app on a Profile page so that visitors could interact with it (similar to the Music and Video players provided by MySpace).  My initial thought was to simply use an IFRAME that displayed my application. Unfortunately this turned out to be impossible as MySpace doesn't allow IFRAMEs  to be placed on Profile or Home surfaces.

So how does one quickly turn their HTML application into a MySpace application without rewriting a ton of code? Enter <a href="http://www.silverlight.net/" target="_blank">Microsoft Silverlight</a> and the <a href="http://www.telerik.com/products/silverlight/htmlplaceholder.aspx" target="_blank">RadHtmlPlaceHolder control from Telerik</a>. MySpace supports Silverlight applications, just like Flash. And with an install base somewhere around <a href="http://www.riastats.com/" target="_blank">70%</a> now, I decided Silverlight is absolutely a viable option for my app.

The HTML Place Holder control from Telerik allows you to display HTML content within the Silverlight canvas. After checking with MySpace, I was told this was an acceptable use of Silverlight on MySpace.

I started by creating a Silverlight project. It is quite simple really, a single canvas with the HTML Place Holder control on it (set to 100% height and width) . I then added some code to handle the init parameter for the URL to display.

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
 &lt;div id="content"&gt;&lt;/div&gt;
    
&lt;script type="text/javascript"&gt;
	var contentElement = document.getElementById("content");
	var initValue = "URI= &lt;URL TO DISPLAY&gt;";

	var object = '&lt;object data="data:application/x-silverlight-2," height="100%" type="application/x-silverlight-2" width="100%"&gt; '
	object = object + '&lt;param name="source" value="&lt;URL TO XAP FILE&gt;" /&gt;&lt;param name="onError" value="onSilverlightError" /&gt; '
	object = object + '&lt;param name="background" value="Transparent" /&gt;&lt;param name="minRuntimeVersion" value="4.0.50401.0" /&gt;&lt;param name="autoUpgrade" value="true" /&gt; '
	object = object + '&lt;param name="windowless" value="true" /&gt;&lt;param name="enableHtmlAccess" value="true" /&gt;&lt;param name="initparams" value="' + initValue + '" /&gt; '
	object = object + '&lt;a href="http://go.microsoft.com/fwlink/?LinkID=149156&amp;v=4.0.50401.0" style="text-decoration: none"&gt; '
	object = object + '&lt;img alt="Get Microsoft Silverlight" src="http://go.microsoft.com/fwlink/?LinkId=161376" style="border-style: none" /&gt; &lt;/a&gt; &lt;/object&gt; '
	contentElement.innerHTML = object;
&lt;/script&gt;
[/js]

Hopefully this helps someone else out there. Feel free to contact me with any questions.
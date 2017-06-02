---
Title: Awesome Azure Mobile Services
Excerpt: >
  Part of a series covering Windows Client
  development. In this article we’ll
  integrate Azure Mobile Services into the
  awesome RMV Awesome app.
Tags:
  - Azure
  - Azure Mobile Services
  - RMV Awesome
  - Windows
---
I love talking about <a href="http://www.windowsazure.com/en-us/services/mobile-services/" target="_blank">Azure Mobile Services</a>. It is one of those services that developers are always shocked is available from Microsoft. Why shocked? Well, Azure Mobile Services is a fully-baked backend for apps that delivers data storage, custom API's, scheduled jobs, authentication (Microsoft, Facebook, Twitter and Google) and push notifications. Further more, it is truly cross-platform with <a href="http://www.windowsazure.com/en-us/develop/mobile/developer-tools/" target="_blank">SDKs available</a> for Windows Store, Windows Phone, iOS, Android, Xamarin and Unity 3D. Oh, and did I forgot to mention that the <a href="http://www.windowsazure.com/en-us/pricing/details/mobile-services/" target="_blank">pricing starts at free</a>? If you're building apps on <em>any</em> platform, Azure Mobile Services simply rocks.

Back in my <a title="RMV Awesome!" href="http://massivescale.azurewebsites.net/rmv-awesome/" target="_blank">first post </a>using the RMV Awesome example app I pointed out a major flaw in my implementation:
<blockquote>In order to keep things simple, I decided to code in some static that I'm sure won't change any time soon. Obviously this is - to put it mildly - less than idea and I cannot state strongly enough that you should not do this. This is a demo so I'm cutting this corner but in a real app this data belongs out of band from the app itself. In a later demo I'll show how you can use Azure to accomplish this but for the time being I'll be doing the wrong thing.</blockquote>
Well, in this post I'll do just that. We're going to get this static data out of the app and into the cloud where it belongs. We're going to leverage the data feature of Azure Mobile Services to store branch information not provided by the Massachusetts RMV's XML feed. This will allow us to update this data when needed without requiring a new release of the application. It becomes just another data source for the app to consume.
## Assumptions
I'm going to assume you already have an Azure account set up. If you don't have one yet, no worries. There is a <a href="http://www.windowsazure.com/en-us/pricing/free-trial/" target="_blank">free trial</a> of Azure available. If you have an MSDN subscription then even better, you get a up to $150 worth of Azure each month by <a href="http://www.windowsazure.com/en-us/pricing/member-offers/msdn-benefits/" target="_blank">simply signing up</a>. You could also purchase Azure under the pay-as-you-go plan and only pay for what you consume (which in this case isn't much if you're using the free tier).

I'm also going to assume that you have Visual Studio 2013 and have connected your <a href="http://msdn.microsoft.com/en-us/library/windowsazure/gg551722.aspx" target="_blank">Azure subscription to Visual Studio</a>.
<em>Disclaimer: While Azure Mobile Services starts at free, you may incur some charges if for example you exceed the limits of the free tier (more than 500 users, more than 20GB of storage, more than 500,000 transactions or more than 5GB of bandwidth). Please keep this in mind. </em>


## Setting Up Our Service
To get started we will create a new Mobile Service in the Azure Portal. We start by clicking the New icon, selecting MOBILE SERVICE and then Create. This presents the following dialog:

<img title="CreateMobileService" src="/assets/wp/2014/02/CreateMobileService.png" alt="CreateMobileService" border="0" />

For the URL I'm using RMVAwesomeMobileService. I'm also selecting “Use an existing SQL database” as I've previously set up a Mobile Service on this subscription (all of your mobile services share the same 20GB database at the free tier). I've also selected the East US Region (just happens to be where I am and since Massachusetts is also in the East Region it makes as much sense as anything else). After clicking the Next icon I'm presented with the Database dialog:

<img title="Createmobileservice2" src="/assets/wp/2014/02/createmobileservice2.png" alt="Createmobileservice2" border="0" />

I've blurred out these values because they are not safe for publishing but it is pretty self explanatory. I'm picking my database (or entering a name if I were creating a new one) and passing in my Login Name and Password. Clicking the Check Mark will start the creation process which take a couple of minutes as Azure provisions the resources. Once this is done you can open your new Service and see the Getting Started page.

<img title="CreateMobileService4" src="/assets/wp/2014/02/CreateMobileService4.png" alt="CreateMobileService4" border="0" />

Now that we have our Service provisioned, we can start fleshing things out a bit.  In our particular case, we're not looking to store data <em>from </em>the application. Instead we're looking to make a read-only data set available to the app. With that in mind, we're going to start out by creating a Table to store the data. Selecting the DATA tab tells us we don't have any Tables defined and presents us the option of creating one. We will do just that:

<img title="CreateBranchTable" src="/assets/wp/2014/02/CreateBranchTable.png" alt="CreateBranchTable" border="0" />

I've named this table Branch and changed the default permissions such that only I can Add/Delete/Update but anyone with the key can read it. This gives me an empty container to use but until we populate it, there isn't much value here. To populate the Table I created a small utility called ADSUtil (which stands for Awesome Data Service Utility. Branding people, got to stick to your branding).

<em>NOTE: In order for this utility to run, I need to change my table permissions on Insert and Delete to allow my utility to run. Once I've run it I change it back. In production I would handle this differently but given that I'm unlikely to update this table very often it isn't too difficult to make updates a two step process.</em>
## Table Population
My ADSUtil app is a Windows Store App only in name, it doesn't follow any of the conventions of a Modern UI app. Given that it is a simple utility I'm not being picky here. The primary reason I used a Windows Store template was that integrating with Azure Mobile Services is a little easier. A lot of the wiring is automated by Visual Studio for me. I used the basic Blank template and named it ADSUtil. I made a reference to our previously created <a title="Leveraging Portable Class Libraries" href="http://massivescale.azurewebsites.net/leveraging-portable-class-libraries/">RMV Awesome PCL</a> so that I can leverage the existing Branch class definition but otherwise it is self contained.

Adding Azure Mobile Services is extremely simple when you're doing it directly in a Windows Store App. Right click on your Project and select the Add submenu. In there you'll find “Connected Service”. Once selected you are presented with all of the available Azure services you've configured, which in this case includes our new RMVAwesomeMobileService.

<img title="AddConnectedService" src="/assets/wp/2014/02/AddConnectedService.png" alt="AddConnectedService" border="0" />

Click ok adds the required code for our service to ADSUtil. Once that is complete I simply opened the default MainPage.xaml.cs file and added the following code:

{% gist 5dc184b0b0ba91a06035  %}

This is rather straightforward code. I first attempt to delete every entry within the table. Once that is done I generate a new data set and insert each record into the table. I could have updated existing, inserted only new, etc. but that would have required extra code and given the small size of this set it was easier to rip and replace when it is needed (which is pretty rare). I won't bother including the entire GetBranchData() method here (it is rather large) but the gist of it can be understood from this gist (sorry, couldn't resist):

{% gist 5dc184b0b0ba91a06035  %}

Now that we have a populated table, we can move on to consuming it from RMV Awesome. This is where leveraging PCLs will really pay off, we only need to do this once to get the benefit in both places.
## Consuming Our Mobile Data
Adding Azure Mobile Services to a PCL is a little different than adding it directly to a Windows Store app. Rather than a simple “Add Connected Service”, we need to manually reference the <a href="http://www.nuget.org/packages/WindowsAzure.MobileServices/" target="_blank">NuGet libraries for Azure Mobile Services</a>.

Open up the Package Manager Console, select “RMV Awesome PCL” as the project and enter Install-Package WindowsAzure.MobileServices to install. <strong>You will also need to install these in the client apps, </strong>so we’ll repeat this process against the “RMV Awesome W8” and “RMV Awesome WP8” projects.

One we have the references we need to make some changes in our data population code. In the previous versions we hardcoded our initial list of branches and then updated the wait times from the XML feed. In keeping with the existing architecture, I’ll add a new class called AzureBranchData which replaces the previous StaticBranchData. This class will be responsible for fetching the list of Branches and populating a view model.  This turns out to be extremely easy, only 2 lines of code:

{% gist 5dc184b0b0ba91a06035  %}

The only remaining change is to our MainViewModel. We need to tell it to source it’s list from AzureBranchData rather than the old StaticBranchData class. To that end I’ve refactored FetchXMLFeed() as follows:

{% gist 5dc184b0b0ba91a06035  %}

We now have a working RMV Awesome leveraging Azure Mobile Services for Windows 8.1 and Windows Phone 8. Like I said in the beginning, I love talking about Azure Mobile Services. It doesn’t get much easier than this.

 

The code is available on GitHub at <a href="https://github.com/mlafleur/RMVAwsome/releases/tag/T5">https://github.com/mlafleur/RMVAwsome/releases/tag/T5</a> or follow the live development at <a href="https://github.com/mlafleur/RMVAwsome">https://github.com/mlafleur/RMVAwsome</a>.
---
Title: Windows Azure for Amazon AWS Users
Published: 2012-05-22 16:19:26
Excerpt: ""
views:
  - 'a:1:{i:0;s:5:"11124";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3544151432";}'
author:
  - Marc LaFleur
post_date:
  - 2012-05-22 16:19:26
post_excerpt:
  - ""
permalink:
  - /windows-azure-for-amazon-aws-users/
---
One hurdle I run across while talking to <a href="http://aws.amazon.com/" target="_blank">AWS</a> users about <a href="http://windowsazure.com" target="_blank">Azure</a>Â comes down to terminology. Every cloud vendor has their own vernacular and this can be a source of endless frustration when one starts to compare the two services. Developers that have already wrapped their mind around AWS' parlance often find themselves struggle to understand Azure's.

There is of course a intrinsic difference between the two platforms which contributes to the confusion. And before we draw any lines between the two platforms, we should first address this fundamental difference.
<h1>Infrastructure vs. Platform</h1>
<p align="left">There are three primary <a href="http://en.wikipedia.org/wiki/Cloud_computing#Service_Models" target="_blank">Cloud Service Models</a> in the market today - Infrastructure as a Service (<a href="http://en.wikipedia.org/wiki/Category:Infrastructure_as_a_Service" target="_blank">IaaS</a>), Platform as a Service (<a href="http://en.wikipedia.org/wiki/Platform_as_a_service" target="_blank">PaaS</a>) and Software as a Service (<a href="http://en.wikipedia.org/wiki/Software_as_a_service" target="_blank">SaaS</a>).</p>
<p align="left"><a href="http://massivescale.azurewebsites.net/wp-content/uploads/2012/05/IaaS-vs-PaaS1.png"><img style="background-image: none; float: right; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="IaaS vs PaaS" src="http://massivescale.azurewebsites.net/wp-content/uploads/2012/05/IaaS-vs-PaaS_thumb1.png" alt="IaaS vs PaaS" width="437" height="300" align="right" border="0" /></a>Amazon Web Services is fundamentally an Infrastructure as a Service solution. Azure on the other hand is fundamentally a Platform as a Service solution. While it is true that they both offer some components from each Service Model, they remain primarily influenced by their core model.</p>
<p align="left">Essentially the difference comes down to where you place the abstraction layer. With IaaS they provideÂ a virtualization infrastructure and leave the rest to the you. PaaS on the other handÂ includes both the infrastructure and the runtime environment (OS, runtimes, middleware, etc.).</p>
<p align="left">By further abstracting away from the physical environment, PaaS delivers fantastic scalability with substantially less management overhead. You manage your application and your data, the rest is handled for you automatically.</p>

<h1>Connecting the Dots</h1>
<p align="left"><em>A word of warning (and preemptionÂ of the inevitable complaints): I am making certain generalizations to make this more digestible. In doing so, some nuances of the various platforms may be overlooked. <a href="http://massivescale.azurewebsites.net/wp-content/uploads/2012/05/AmazonAzureComp.png"><img style="background-image: none; float: right; padding-top: 0px; padding-left: 0px; margin: 2px 0px 5px 10px; display: inline; padding-right: 0px; border-width: 0px;" title="AmazonAzureComp" src="http://massivescale.azurewebsites.net/wp-content/uploads/2012/05/AmazonAzureComp_thumb.png" alt="AmazonAzureComp" width="404" height="208" align="right" border="0" /></a></em></p>
<p align="left">At the highest level there is some parity between AWS and Azure. They both divide the service into four primary categories Compute, Storage, Database and Networking. As you move down the stack however is becomes muddier. Hopefully the following will help simplify transitioning from Amazon to Azure.</p>

<h2></h2>
<h2>Elastic Compute Cloud (EC2)</h2>
<p align="left">The closest allegory to EC2 is Azure's <strong><a href="http://www.windowsazure.com/en-us/home/features/compute/" target="_blank">VM Role</a></strong>Â (currentlyÂ in Beta). Specifically it aligns with an EC2 instance leveraging Local Instance Store. They both are stateless instances (meaning they don't persist data on the root disc). Both also support a file system persistent model to deal with the inevitable files that get generated (see below). Unlike AWSÂ however, Azure uses a user-supplied VHD rather than building the image in the cloud directly.</p>
<p align="left">Unlike the VM Role, there is no allegory for the Web or Worker Roles. These roles are pure PaaS instances. You publish your application to them and the underlying platform is maintained for you.</p>

<h3><span style="font-weight: normal;">Web Role </span></h3>
<a href="http://www.windowsazure.com/en-us/home/features/compute/" target="_blank">Web roles</a>Â in Windows Azure are special purpose, and provide a dedicated Internet Information Services (IIS) web-server used for hosting front-end web applications. You can quickly and easily deploy web applications to Web Roles and then scale up or down to meet demand.
<h3><span style="font-weight: normal;">Worker Role </span></h3>
<a href="http://www.windowsazure.com/en-us/home/features/compute/" target="_blank">Worker roles</a> run asynchronous, long-running or perpetual tasks in the background. They are very similar to Windows Services or Daemons. When you separate your application's background processes in a Worker role and host the front-end in a Web role, you can better distribute your application logic and have more fine grain control over how your application scales.
<h2 align="left">Elastic Block Storage (EBS)</h2>
<p align="left"><strong><a href="http://www.windowsazure.com/en-us/home/features/storage/" target="_blank">Azure Drive</a></strong>Â aligns quite well with EBS. The Azure Drive is a VHDÂ hosted within Azure Storage (technically within something called a Page Blob). This VHDÂ can beÂ mounted by your Web, Worker or VM Role. This drive looks like any other secondary drive connected to a server. Data written to an Azure Drive will persist outside of the instance that mounted it. You can also mount an Azure Drive Snapshot, providing a read-only data store to a large number of instances.</p>

<h2 align="left">DynamoDB (Beta)</h2>
<p align="left">Dynamo is a NoSQL database that is very similar to <strong><a href="http://www.windowsazure.com/en-us/home/features/storage/" target="_blank">Azure Table Storage</a></strong>. NoSQLÂ is an excellent way to store unstructured or loosely structured data in a cloud environment. Wile they lack the referential integrity of a relational database, they are extremely efficient. This efficiency allows them to scale incredibly well.</p>

<h2>Simple Storage Service (S3)</h2>
When it comes to storing stuff in the cloud, the examples sitedÂ almost always revolve around digital media of some type. AWS S3 is Amazon's answer, <strong><a href="http://www.windowsazure.com/en-us/home/features/storage/" target="_blank">Azure Blob Storage</a></strong> is Microsoft's. They both serve the same purpose, storing large binary objects.
<h2>Simple Queue Services (SQS)</h2>
Queuing is vital to successfully scaling out in the cloud. Azure includes a persistent and reliable messaging service called <strong><a href="http://www.windowsazure.com/en-us/home/features/storage/" target="_blank">Azure Queue</a></strong>. This is the primary way your machines (AWS) or roles (Azure) relay information to each other.
<h2>Relational Database Service (RDS)</h2>
As sexy as NoSQL is, it doesn't replace traditional relational database. When you need to store structured data with transactional support, turn to <strong><a href="http://www.windowsazure.com/en-us/home/features/sql-azure/" target="_blank">SQL Azure</a></strong>. SQL Azure is a high availability clustered SQL platform. It uses the same tooling as SQL Server, making it a relatively easy transition from traditional SQL Server deployments.
<h2>Other Stuff</h2>
Both platforms also have a host of additionalÂ services that you can add into the mix as well. I've decided to forgo diving into them at this time rather risk getting stuck in the weeds sorting out things like Rout53 and <a href="http://www.windowsazure.com/en-us/home/features/virtual-network/" target="_blank">Traffic Manager</a>. These are more advanced topics and beyond the scope of what I covered here.
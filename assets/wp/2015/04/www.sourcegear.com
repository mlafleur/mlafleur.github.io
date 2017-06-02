<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<!-- makes rss feed autodiscoverable -->
<link rel="alternate" type="application/atom+xml" title="SourceGear.com feed" href="news/atom.xml" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>SourceGear</title>
<link href="css/SG5.css" rel="stylesheet" type="text/css" />

<script src="../scripts/jquery.js" type="text/javascript"></script>
<script src="../scripts/pageutil.js" type="text/javascript"></script>

<!-- make dropdowns work in IE -->
<script type="text/javascript"><!--//--><![CDATA[//><!--

sfHover = function() {
	var sfEls = document.getElementById("headernav").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);

//--><!]]></script>
</head>

<body class="main1">
<div id="container">

<div id="headerSG">
  <div id="logo"> <a href="http://www.sourcegear.com"><img src="images/SGlogo160x29.png" width="160" height="29" alt="SourceGear logo" /></a> </div>
  
<div id="bluenavbar">
	  <ul id="headernav">
        <li><a href="#">Products</a>
        	<ul id="headernavprod">
            	<li><a href="/vault/">Vault</a></li>
                <li><a href="/veracity/">Veracity</a></li>
                <li><a href="/diffmerge/">DiffMerge</a></li>
                <li><a href="/sos/">SourceOffSite</a></li>
             </ul>
        </li>
        <li><a href="#">Downloads</a>
        	<ul id="headernavdl">
                <li><a href="/vault/downloads.html">Vault</a></li>
                <li><a href="http://veracity-scm.com/downloads.html">Veracity</a></li>
                <li><a href="/diffmerge/downloads.php">DiffMerge</a></li>
                <li><a href="/sos/downloads.html">SourceOffSite</a></li>
             </ul>
        </li>
        <li><a href="/support.html">Support</a>  
        	<ul id="headernavsup">
            	<li><a href="http://support.sourcegear.com/">Vault Support</a></li>
                <li><a href="http://veracity-scm.com/qa/">Veracity Support</a></li>
                <li><a href="https://csp.sourcegear.com">Store</a></li>
                <li><a href="/support.html">Contact Support</a></li>
             </ul>
        </li>
        <li><a href="https://csp.sourcegear.com/">Store</a></li>
        <li class="lastlink"><a href="/company/">Company</a></li>
      </ul>
    </div>
<br class="clearfloat" />  
  </div>

<p> 
   <br>
   <br>
   <center><a href="/vault/documentation/Vault8featureoutline.html"><img src="/images/v8-banner.png"/></a></center>
</p>


<p> 
   <br>
   <br>
</p>



<!--<h2 class="homecopy"><strong><em>SourceGear</em></strong> offers two premier version control solutions designed and constructed in very different ways.</h2><br />-->


<!-- end #headrSG -->

<div id="mainContentH" class="class2">
  <div class="ContentRH">
    <div id="greenbox">
    	<div class="InsideBox"> <a href="/diffmerge/"><img src="images/DiffMerge210.png" width="210" height="55" alt="DiffMerge logo" /></a>
          <br /><br />
          <a href="/diffmerge/"><em><strong>DiffMerge</strong></em></a> is an application to visually compare and merge files for Windows, Mac OS X, and Linux. <a href="/diffmerge/"><em><strong>DiffMerge</strong></em></a> can graphically show the changes between multiple files with intra-line highlighting and full support for editing.

    	</div>
        <div class="greenboxNav">
          <ul>
            <li><a href="/diffmerge/">Learn More</a></li>
            <li><a href="/diffmerge/register">Register</a></li>
            <li><a href="/diffmerge/downloads.php">Download Now</a></li>
          </ul>  
        </div>
    </div>
  </div>
</div>



<div class="ContentLH">
   <div id="bluebox">
    	<div class="InsideBox"> <a href="/vault/"><img src="images/Vault210.png" width="210" height="55" alt="Vault logo" /></a>
          <br /><br />
          <strong><em><a href="/vault/">SourceGear Vault</a></em></strong> is a version control tool for professional development teams designed to be a compelling replacement for Visual SourceSafe. <a href="/vault/"><strong><em>Vault</em></strong></a> has everything you need — reliable versioning of your source code, excellent remote performance, flexible security, native work item tracking, build management, and more.

        </div>
        <div class="blueboxNav">
          <ul>
            <li><a href="/vault/">Learn More</a></li>
            <li><a href="/vault/eval/">Try For Free</a></li>
            <li><a href="/vault/downloads.html">Download Now</a></li>
          </ul>
        </div>
    </div>
</div>    


<!--
    <div id="greenbox">
    	<div class="InsideBox"> <a href="/veracity/"><img src="images/VeracityBySG210.png" width="210" height="55" alt="Veracity logo" /></a>
          <br /><br />
	          <p class="greenboxlinks"><a href="/veracity/"><em><strong>Veracity</strong></em></a> is an open source version control and bug tracking system 	for Windows, Mac OS X, and Linux.
	Together with SourceGear’s hosting </p>
          solution, <a href="http://www.onveracity.com"><em><strong>onVeracity.com</strong></em><strong></strong></a>, <a 	href="/veracity/"><strong><em>Veracity</em></strong></a>  is a complete <strong>DVCS</strong> solution that  offers great extras like scrum burndown 	charts, a wiki, build management and an <a 	href="/veracity/ipadapp.html">iPad app</a>.

    	</div>
        <div class="greenboxNav">
          <ul>
            <li><a href="/veracity/">Learn More</a></li>
            <li><a href="http://www.onveracity.com">Project Hosting</a></li>
            <li><a href="http://www.veracity-scm.com/downloads.html">Download Now</a></li>
          </ul>  
        </div>
    </div>
-->




<div class="ContentRH">
    <div class="bluefade">
        ## <em>Other Products by SourceGear</em>
    </div>
    <div id="otherprods">
        <div id="DM">
            <div class="prodcopy">
                ### <a href="/veracity/"><strong>Veracity</strong></a>
                <strong><em>Veracity</em></strong> is an open source distributed version control and bug tracking system for Windows, Mac OS X, and Linux.

            </div>
            <div class="prodlogo"> <a href="/veracity/"><img src="images/veracity100.png" width="100" height="100" alt="Veracity logo" /></a>
            </div>
        </div>
        <div id="SOS">
            <div class="prodcopy">
                ### <strong><a href="/sos/">SourceOffSite 5.0.3</a></strong>
                <em><strong>SourceOffSite</strong></em> is an add-on product which allows developers to access a Visual SourceSafe database over the internet.

            </div>
            <div class="prodlogo"> <a href="/sos/"><img src="images/SOS100.jpg" width="100" height="100" alt="SOS logo" /></a></div>
                     
        </div>
    </div>
</div>
<div class="ContentLH">
    <div class="greenfade">
        <div id="EricImage"></div>
        ## <strong><em>Eric Sink</em></strong>
    </div>
    <div id="EricContent">
        SourceGear founder and author of

        <a href="http://www.amazon.com/Version-Control-Example-Eric-Sink/dp/0983507902/ref=sr_1_2?s=books&amp;ie=UTF8&amp;qid=1342033930&amp;sr=1-2">Version Control by Example</a>

        and

        <a href="http://www.amazon.com/Eric-Business-Software-Experts-Voice/dp/1590596234/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1342033930&amp;sr=1-1">Eric Sink on the Business of Software</a>
<br />
        Keep up to date with Eric's latest ideas and musings in the world of version control, software development, and life by visiting <a href="http://www.ericsink.com">ericsink.com</a>

         

         

         

         

         

         

         

    </div>
</div>




<!-- #BeginLibraryItem "/Library/footer.lbi" -->
<div id="footer">
  Copyright © 2013 SourceGear, LLC.

  <!-- end #footer -->
</div>
<!-- #EndLibraryItem --><!-- end #container --></div>

<!-- #BeginLibraryItem "/Library/tracking scripts.lbi" -->
  <!-- tracking -->
  <script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ?
"https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost +
"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
  </script>
  <script type="text/javascript">
var pageTracker = _gat._getTracker("UA-615434-1");
pageTracker._initData();
pageTracker._trackPageview();
  </script>
  <!-- end tracking -->
  <!-- #EndLibraryItem -->

<!-- Google Code for landing page visitors Remarketing List -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 1072509529;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "3Dc-CMCp4gIQ2eS0_wM";
var google_conversion_value = 0;
/* ]]> */
</script>

<script type="text/javascript" src="http://www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1072509529/?label=3Dc-CMCp4gIQ2eS0_wM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
</body>
</html>
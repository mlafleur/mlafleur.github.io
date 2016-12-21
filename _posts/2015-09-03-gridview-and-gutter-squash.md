---
Title: GridView and Gutter Squash
Published: 2015-09-03 14:30:31
Excerpt: >
  There was a gutter in my window and it
  was mocking me and so I squashed it.
Tags: ""
dsq_thread_id:
  - 'a:1:{i:0;s:10:"4094652632";}'
author:
  - Marc LaFleur
post_date:
  - 2015-09-03 14:30:31
post_excerpt:
  - >
    There was a gutter in my window and it
    was mocking me and so I squashed it.
permalink:
  - /gridview-and-gutter-squash/
---
I was whipping up a quick code sample today and noticed something. It was in no way related to the sample code I was writing. It did however annoying me a little which of course meant spending an hour or so of my day trying to work around it.

What I found annoying was this little gutter on the right-hand side of my sample's window. It was clear what it was, I had a GridView with several items that were each 200px wide. My Window happened to be 995px wide which meant it rendered 4 items (800px of the window), leaving 195 pixels untouched. Here is an example of what I'm talking about:

<img class="alignnone size-medium wp-image-2731" src="https://massivescale.blob.core.windows.net/blogmedia//2015/09/FishGridBroke-768x492.png" alt="FishGridBroke" width="768" height="492" />

Notice the empty space on the right? Is it mocking you too? Because was sure as hell mocking me! That evil vile mocking gutter of... Sorry, back to the program.

To fix this issue I decided to dynamically resize my item. This isn't always a viable option since there are cases were your items must be a fixed size, but in my case it this wasn't an issue. I happened to be displaying text/media (e.g. rss feed items) so making them little larger/smaller was perfectly acceptable.

To solve this issue I added an ItemsPanelTemplate to my GridView. My template is really just the standard ItemsWrapGrid but we need to reference explicitly so we can bind to the resizing event.

Here is the XAML (both before and after):

https://gist.github.com/mlafleur/7a14819b2fa344cebaf8

https://gist.github.com/mlafleur/a8790648e64c7144263a

The key bit here is wiring up the SizeChanged event. This is where we will adjust the width of our items behind the scenes:

https://gist.github.com/mlafleur/b52e8c2617a64e2e93b6

With this code in place my page no longer shows a gutter.

<img class="alignnone size-medium wp-image-2741" src="https://massivescale.blob.core.windows.net/blogmedia//2015/09/FishGridFixed-768x486.png" alt="FishGridFixed" width="768" height="486" />

Obviously this example is pretty bare bones. A real world implementation should include more robust logic than simple rounding. For example, maybe <em>some</em>  gutter is better than losing a column. A min/max width for items would help keep sizes things within reason. That said, hopefully this gives you a starting point.
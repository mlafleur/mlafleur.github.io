---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: default
---
<div class="home">
    {% for post in site.posts %}

      <div>
        <h2>
          <a class="post-link" href="{{ post.url | relative_url }}">{{ post.Title | escape }}</a>
        </h2>
        <p>
          {{ post.Excerpt }}
        </p>        
        <div>
          <a class="post-link" href="{{ post.url | relative_url }}">[Read More...]</a>
        </div>
      </div>
    {% endfor %}



  <p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | relative_url }}">via RSS</a></p>



</div>
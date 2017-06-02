---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: default
---
<div class="home">
    {% for post in site.posts %}
      <hr/>
      <p>
        <h2>
          <a class="post-link" href="{{ post.url | relative_url }}">{{ post.Title | escape }}</a>
        </h2>
          {{ post.Excerpt }}
        <br />
        <a class="post-link" href="{{ post.url | relative_url }}">[Read More...]</a>
      </p>
    {% endfor %}



  subscribe <a href="{{ "/feed.xml" | relative_url }}">via RSS</a>




</div>
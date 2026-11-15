---
layout: default
draft: true
permalink: /preview/0rgha01zbq/
---

<h1 class="post-title">Hidden previews</h1>

<p>Posts in progress. Nothing on this page is linked from the site, listed on the blog page, put in the RSS feed, or indexed by search engines. Bookmark this page.</p>

{% assign previews = site.posts | where_exp: "post", "post.draft == true" %}
{% if previews.size == 0 %}<p><em>No hidden previews right now.</em></p>{% endif %}
<ul class="post-list">{% for post in previews %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endfor %}
</ul>

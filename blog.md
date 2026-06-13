---
layout: page
title: Blog
---

{% assign ml_posts = site.posts | where: "section", "ml" %}
{% assign music_posts = site.posts | where: "section", "music" %}
{% assign meta_posts = site.posts | where: "section", "meta-research" %}
{% assign agentic_posts = site.posts | where: "section", "agentic-coding" %}

## Machine Learning

*Energy-based models, autoregressive models, learning theory, and formal methods for AI.*

<ul class="post-list">{% for post in ml_posts %}{% assign post_yyyymmdd = post.date | date: "%Y%m%d" %}{% if post_yyyymmdd > "20260508" %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endif %}{% endfor %}
  <li>
    <span class="post-meta">May 8, 2026</span>
    <h3><a class="post-link" href="{{ site.baseurl }}veribench/blog/veribench-launch/">VeriBench: An End-to-End Formal Verification Benchmark for AI Coding Agents</a></h3>
  </li>{% for post in ml_posts %}{% assign post_yyyymmdd = post.date | date: "%Y%m%d" %}{% if post_yyyymmdd <= "20260508" %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endif %}{% endfor %}
</ul>

## Music

*Jazz, arrangements, and other musical projects.*

<ul class="post-list">{% for post in music_posts %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endfor %}
</ul>

## Meta-Research: How to Do Research

*Research practice — picking directions, moving fast, writing, and thriving in the community — plus the self-development that supports it (e.g., mindfulness).*

<ul class="post-list">{% for post in meta_posts %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endfor %}
</ul>

## Agentic Coding

*Working with AI coding agents: workflows, prompt design, and writing in the AI era.*

<ul class="post-list">{% for post in agentic_posts %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endfor %}
</ul>

{% assign known_sections = "ml|music|meta-research|agentic-coding" | split: "|" %}
{% assign other_count = 0 %}
{% for post in site.posts %}{% unless known_sections contains post.section %}{% assign other_count = other_count | plus: 1 %}{% endunless %}{% endfor %}
{% if other_count > 0 %}
## Other

<ul class="post-list">{% for post in site.posts %}{% unless known_sections contains post.section %}
  <li>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
  </li>{% endunless %}{% endfor %}
</ul>
{% endif %}

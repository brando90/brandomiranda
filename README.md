# My notes on making a static website

# Initializing a jekyll project

To start/create a brand new webpage with jekyll do the following:
```
jekyll new brandos-awesome-statitic-site
```
it will dump all the jekyll stuff in that new folder. If you messed up and already have a folder like that you can do:
```
jekyll --force new brandos-awesome-statitic-site
```
this will overwrite things. Careful!

# Run localhost version of the static site:

Run a localhost version of the website:

```
bundle exec jekyll serve
```

Then on the terminal there is a url for the local serving of your static site:

```
Server address: http://127.0.0.1:4000/
```
put that in the browser search bar.

# Gemfile #

To understand a Gemfile we need to understand what is a Gem.

## Gem ##

A Gem is a downloadable package of Ruby code or a budle of code we can include in Ruby projects.  This allows us to take someone else's code and drop it into our own project. Jekyll itself is a Gem as well as many Jekyll plugins.

## Gemfile ##

A Gemfile is Ruby’s dependency management system or in other words, a list of Gems a Ruby project needs to run.

Source/useful links:

- https://learn.cloudcannon.com/jekyll/gemfiles-and-the-bundler/

# Themes

Recall that a Gem is a downloadable package of Ruby code. Themes can be packaged as Gems.

# Adding a main page that isn't the "here are my blogs list"

TODO: want to change what is the main page of my website and have a seperate stand alone page for the list of posts.

- https://talk.jekyllrb.com/t/how-to-have-a-main-page-that-is-not-the-list-of-my-blogs/3416

# Adding a post

To create a blog post you can create it manually in the `_posts` folder. e.g. by creating a `.md` file with the usual stuff above (TODO check name of this, front page or something?):

```
---
layout: post
title: HelloWorld!
date: 2019-09-10 11:02 -0500
category: personal
tags: fun
comments: true
---
```


# Adding a seperate standalone page

TODO

# _config.yml

TODO

# _include, _layout, _posts, _site

TODO

# Images

TODO

# Links between pages

TODO

# Public directory

TODO

# Disqus (discussion section)

To add the comment section/discussion do the following:

TODO:
- https://stackoverflow.com/questions/57881099/where-does-the-universal-embed-code-go-for-disqus-and-jekyll
- https://github.com/jekyll/minima#enabling-comments-via-disqus
- https://talk.jekyllrb.com/t/where-does-the-universal-embed-code-go/3340

# Useful resources:

- Lynda: https://www.linkedin.com/learning/learning-static-site-building-with-jekyll/add-a-post?u=42250305
- youtube: 
  - TODO

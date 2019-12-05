# My notes on making a static website

# Initializing a jekyll project

To start/create a brand new webpage (in your current directory) with jekyll do the following:

```
jekyll new brandos-awesome-statitic-site
```

it will create a folder for your site in `brandos-awesome-statitic-site` and dump all the jekyll stuff needed in it. If you messed up and already have a folder like that you can do:

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

A Gemfile is Ruby’s dependency management system or in other words, a list of Gems a Ruby project needs to run. I think of it as Ruby's pip but in a file. To install the gems for the current project do:

```
bundle
```

where the gemfile is located at. This will install the new gems (if there are new). You can check the newly installed gems with:

```
gem list
```

For the rest of the tutorial to work you might need to install the Jekyll compose plugins.
To do that write the following in the gemfile file:

```
gem 'jekyll-compose', group: [:jekyll_plugins]
```

now bundle it to install it:

```
bundle
```

the subcommands for Jekyll should now be installed!

## Bundler ##

Bulder 2: https://bundler.io/guides/bundler_2_upgrade.html

Source/useful links:

- https://learn.cloudcannon.com/jekyll/gemfiles-and-the-bundler/

# Themes #

## Themse with Gems ##

Recall that a Gem is a downloadable package of Ruby code. Themes can be packaged as Gems.

Lets install the Athena theme as an example. Add to your `Gemfile` the following (perhaps close to where all the themses you've installed are at):

```
gem "jekyll-athena"
```

then run:

```
bundle
```

to install the gem. Now you can use the gem! Just tell the `_config.yml` so that the server knows which one to run. For example, change the theme field as follows for our Athena example:

```
theme: "jekyll-athena"
```

Now you can use any theme you've installed by changing the `_config.yml` file!

## Forks ##

TODO: themes with Forks.

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

One can also use Jekyll. Make sure the following gem is installed by adding it to the gem file (that is tracking all of the gems):

```
gem 'jekyll-compose', group: [:jekyll_plugins]
```

This install subcommands that will be useful. Then run:

```
bundle
```

to install the gem that that was described in the gem file.
Now you don't have to create posts manually.
Instead do:

```
bundle exec jekyll post "post name"
```

now the file is created automatically. TODO: add how discuss works.

# Adding a seperate standalone page

To create a standlone page with jekyll run the following command:

```
bundle exec jekyll page "name-of-standlone-page"
```

this will create a `.md` outside of where the blog posts are (i.e. outsude `_posts`)
for your standlone wepage. It will have this when created:

```
---
layout: page
title: name-of-standlone-page
---

```

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

# Excluding files/directories in Jekyll

In the _config.yml file do:

exclude: [DIR, FILE, ...]

resource: https://talk.jekyllrb.com/t/can-i-exclude-files-in-my-project-folders-from-my-site/396

# Github pages

Go to the settings in the repo and activate the github pages hosting.


Resources:

- https://stackoverflow.com/questions/58598699/what-is-the-format-for-the-dependency-version-to-install-github-pages-and-jekyll
- https://talk.jekyllrb.com/t/how-to-install-github-pages-with-jekyll/3510

# Disqus (discussion section)

To add the comment section/discussion do the following:

# Common errors:

Bulder 2:

https://bundler.io/guides/bundler_2_upgrade.html

```
fatal: 'jekyll page' could not be found. You may need to install the jekyll-page gem or a related gem to be able to use this subcommand.
```

to solve that install some subcommands with:

# Seems this is needed to install a lot of subcommands, see: https://github.com/jekyll/jekyll-compose
gem 'jekyll-compose', group: [:jekyll_plugins]

# Updating Jekyll

https://jekyllrb.com/docs/upgrading/

```
bundle update jekyll
```

TODO:
- https://stackoverflow.com/questions/57881099/where-does-the-universal-embed-code-go-for-disqus-and-jekyll
- https://github.com/jekyll/minima#enabling-comments-via-disqus
- https://talk.jekyllrb.com/t/where-does-the-universal-embed-code-go/3340

# Useful resources:

- Lynda: https://www.linkedin.com/learning/learning-static-site-building-with-jekyll/add-a-post?u=42250305
- youtube:
  - TODO

- https://stackoverflow.com/questions/10529859/how-to-include-video-in-jekyll-markdown-blog


# Article to write

- Synergistic team
- my inspiration for Sketching (compast closed set)
- My professional website home
- Dance, my dance philosophy

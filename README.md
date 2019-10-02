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

# Themes

TODO: what is the theme that does NOT cause issues with disqus? Minima was problematic

# Disqus (discussion section)

To add the comment section/discussion do the following:

TODO:
- https://stackoverflow.com/questions/57881099/where-does-the-universal-embed-code-go-for-disqus-and-jekyll
- https://github.com/jekyll/minima#enabling-comments-via-disqus
- https://talk.jekyllrb.com/t/where-does-the-universal-embed-code-go/3340

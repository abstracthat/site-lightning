---
title: Site Lightning Documentation
description: Learn to use the Site Lightning boilerplate for wicked fast front-end development.
layout: page
---

__Please note__: These docs are not yet complete and this project is in active development.

## Site Config
In the root of the project you will find `site.yml`. This is where you give your site a name (shown in the header) and define what goes in the menus. The social account settings will be used to set up open-graph tags (used by Facebook, Twitter, etc) for your site.

## Command Your Project Using Gulp
Everything is in `gulpfile.coffee`. Basically you just use the first two here...

- `gulp` for development
- `gulp deploy` to deploy production ready files to your server.
- `gulp preview` if you want to preview the production build before deploying
- `gulp clean` if you need to banish some old files while developing

## Source Folder
All of your work happens in `source`. Your `.jade` and `.md` files go in `content/`. These turn into your pages. So `index.jade` is the homepage and `contact.jade` is `yoursite.com/contact` and `blog/a-post.md` is `yoursite.com/blog/a-post`.

## Writing Pages
You can write each page as Jade or markdown. You can and should use `:markdown` for blocks of prose in your jade files. See examples in `index.jade` and `tutorials/index.jade`.

If you choose to write a page in a markdown file (`.md`) then be sure to include a `layout` in the front-matter so we know which jade template to wrap the content in.

## Site Metadata
Jade has access to the site object in `site.json` which can be used for iterating over collections and so forth. By default the markdown posts are parsed for the intro paragraph and the first image.

Pages in each collection are sorted by date within the collection. Nested collections are supported but don't nest needlessly.

## Templates & Blocks
We are using Jade's block inheritance. Our templates or views go in `source/templates`. These are the main page wrappers. The base wrapper for everything is `source/templates/base.jade`. Here we have the html tag, css, js links. Probably you don't need much in here unless you are adding some js library.

If you want to make a new layout with some elements/content that stays the same on multiple pages you can make a new template that `extends base`.

## Styles
All of your styles go in `source/styles`. I made a `lib` folder for some components and mixins.

Presently there is very little style (yay!). Basically you get a normalized baseline and some sensible basic styles in `source/styles/templates`. Feel free to blow these away.

There are some colors, grid settings, and font-stacks defined in `settings.styl`.

Oh, and bonus! You get stylus sourcemaps in the browser inspector :).

### Stylus Mixins
You also have the very nice stylus library, [Axis](http://axis.netlify.com/) that gives you mixins you can use (or not). This is not some annoying framework like Bootstrap of Foundation and it is pretty much only mixins.

Media queries are handled by [Rupture](http://jenius.github.io/rupture/). I like mobile first so you can easily do it like this:

```stylus
.example
  padding .5rem
  +above(mobile)
    padding .75rem
  +above(desktop)
    padding 1rem
```

Also feel free to use px or rem or em instead of the variables and check out the other mixins in the [Rupture docs](http://jenius.github.io/rupture/).

### Grid System
For the grid we use [Jeet](http://jeet.gs/). It's similar to Bourbon's grid. Check out the source if you want to see what it does: `node_modules/jeet/stylus/jeet/_grid.styl` ...it's actually quite a small library. I have the default gutter set at 3%. That's in `source/styles/settings.styl` along with the breakpoints.

### JavaScript
Well Coffeescript actually. For your own JS, add it to `source/scripts/main.coffee`. If you have a lot and want to make it modular you can use Node's [CommonJS](http://wiki.commonjs.org/wiki/CommonJS) standard and `require` your modules. Here's a tutorial to the idea: [Understanding Modules](http://www.sitepoint.com/understanding-module-exports-exports-node-js/). Or keep it simple and all in `main.coffee`.

To add some opensource library you can either use Bower or NPM. If it's an npm package you can just `require` it in your main.coffee file and Browserify will include the dependency. If it's a Bower package (which probably most front-end stuff is) you can install it with Bower. Remember to save so it's in your `bower.json`.

```bash
bower install --save fastclick
```

Then to use it, add a script tag to `source/templates/base.jade`. During development it will be multiple files but the final production deploy will concat and minify all that together in the order you have it in `base.jade`.

Make sure you leave the `build:js` tags in there and that you add the script in between that tag and `endbuild`. The main Bower files go in the `/lib` folder so for our fastclick example...

```jade
// build:js script.min.js
script(src='/lib/fastclick.js')
script(src='/main.js')
// endbuild
```

## Read the Docs
Seriously you should quickly read the docs to make sure you know the languages well enough. Once you get the hang of it you will be flying. I listed them in order of importance.

0. [Jade](http://jade-lang.com/reference)
0. [Axis](http://axis.netlify.com/)
0. [Rupture](http://jenius.github.io/rupture/)
0. [Jeet](http://jeet.gs/)
0. [Stylus](http://learnboost.github.io/stylus/)
0. [Coffeescript](http://coffeescript.org/)

## Server Setup
Add your server to gulpfile.coffee as a string under the `server` variable. This should be whatever you type to ssh to your server (depends on your ssh hosts config), then a colon, then the absolute path to your website's public directory. For me this is: `projects:/var/www/sitelightning.co`. More details on setting up a cheap but powerful static site server coming soon.

### Nginx Setup
**I'm considering doing away with this by just renaming the files into folders in gulp, but for now...**

Instead of rendering `/contact-us/index.html` we just use `/contact-us.html` and let Nginx serve up this file when the browser requests `/contact-us`. That means links to a page are without a trailing slash and links to a folder index include the trailing slash (just like unix files and directories).

**Example Jade**:

```jade
a(href='/contact-us') Contact Us
a(href='/blog/') View the Blog Index
```

**IMPORTANT**
Copy the following to the bottom of your nginx config for the site. This config file should be here and you will need to sudo first to modify the file: `/etc/nginx/sites-enabled/yoursite.com.conf`.

Here is what you need to paste in before the last `}`.

```
if (!-f "${request_filename}index.html") {
    rewrite ^/(.*)/$ /$1 permanent;
}

if ($request_uri ~* "/index.html") {
    rewrite (?i)^(.*)index\.html$ $1 permanent;
}

if ($request_uri ~* ".html") {
    rewrite (?i)^(.*)/(.*)\.html $1/$2 permanent;
}

location / {
    try_files $uri.html $uri $uri/ =404;
}
```

---



Because making websites should be fun... and fast. Boilerplate for static site built with Jade, Stylus and Coffeescript, using Gulp.

## New Features
- Write basic content pages with markdown + front-matter
- site.json metadata content for entire site with ordered collections. Good for rendering index pages and menus (see `source/templates/includes/header.jade`).

## Config
Add your site global variables to site.yml. 

## TODO
0. opengraph meta per file
0. social menu (buttons / icons)
0. responsive images - resize versions
0. code syntax highlighting
0. rename urls and use different server setup all urls with trailing /
0. instant click
0. index - json
0. ajax client side infinite scroll
0. jade mixin svg icons

## Dependencies
You need [Gulp](http://gulpjs.com/) and [Bower](http://bower.io/). You'll also probably want some nice themes for your text editor for Jade, Stylus, and Coffeescript.

```bash
npm install -g gulp
npm install -g bower
```

## Clone and Run

```bash
git clone https://github.com/abstracthat/sitelightning.git your-site
cd your-site
npm install
gulp
```

## Main Gulp commands
Everything is in gulpfile.coffee. Basically you just use the first two here...

- `gulp` for development
- `gulp deploy` to deploy production ready files to your server.
- `gulp preview` if you want to preview the production build before deploying
- `gulp clean` if you need to banish some old files while developing

> Are you telling me that all I have to remember to type is... "gulp"? That is awesome!

## Server Setup
Add your server to gulpfile.coffee as a string under the `server` variable. This should be whatever you type to ssh to your server (depends on your ssh hosts config), then a colon, then the absolute path to your website's public directory. For me this is: `projects:/var/www/sitelightning.co`.

### Nginx Setup
**This is important**. Instead of rendering `/contact-us/index.html` we just use `/contact-us.html` and let Nginx serve up this file when the browser requests `/contact-us`. That means links to a page are without a trailing slash and links to a folder index include the trailing slash (just like unix files and directories).

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

## Development Tips
All of your work happens in source. Your `.jade` files go in `content/`. These turn into your pages. So `index.jade` is the homepage and `contact.jade` is `yoursite.com/contact` and `blog/a-post.jade` is `yoursite.com/blog/a-post`. I'll add support for markdown soon. For now you can `include` a markdown file in jade `include:markdown home.md` or just type the markdown indented in the jade file under `:markdown`. See examples in `index.jade` and `page.jade`.

### Templates & Blocks
We are using Jade's block inheritance. Our templates or views go in `source/templates`. These are the main page wrappers. The base wrapper for everything is `source/templates/base.jade`. Here we have the html tag, css, js links. Probably you don't need much in here unless you are adding some js library from Bower or something.

If you want to make a new layout with some elements/content that stays the same on multiple pages you can make a new template that `extends base`.

### Styles
All of your styles go in `source/styles`. I made a `lib` folder for some components, mixins, whatever. You can chunk your styles however you want and just `@import` them. You don't have to use underscores for partials.

Presently there is very little style (yay!). Basically you get normalize.css and some sensible defaults for typography (in `source/styles/lib/typography.styl`).

There are some colors, grid settings, and font-stacks defined in `settings.styl`.

Oh, and bonus! You get stylus sourcemaps in the browser inspector :).

#### MIXINS
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

#### GRID
For the grid we use [Jeet](http://jeet.gs/). It's similar to Bourbon's grid. Check out the source if you want to see what it does: `node_modules/jeet/stylus/jeet/_grid.styl` ...it's actually quite a small library. I have the default gutter set at 3%.

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

Because making websites should be fun... and fast. Boilerplate for static site built with Jade, Stylus and Coffeescript, using Gulp.

## New Features
- Write basic content pages with markdown + front-matter
- Add your site global variables to site.yml. 
- site.json metadata content for entire site with ordered collections. Good for rendering index pages and menus, i.e.
    - `source/content/tutorials/index.jade`
    - `source/templates/includes/header.jade`
    - `source/templates/includes/footer.jade`

## TODO
0. social menu and post share buttons
0. opengraph meta
0. rename urls and use different server setup all urls with trailing /
0. gulp responsive images
0. responsive image jade mixin
0. code syntax highlighting
0. client: ajax load json for infinite scrolling collection index https://github.com/infinite-scroll/infinite-scroll

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

Full documentation here: http://sitelightning.co/documentation.

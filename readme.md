Boilerplate for static sites and static file email marketing built with Jade, Stylus and Coffeescript, using Gulp. Best web delivery practices, solid SEO, and clean/DRY structure in mind. Fast. Easy. Fun. Read more + quick start here: http://sitelightning.co/

## Dependencies
[Node](https://nodejs.org/), [Gulp](http://gulpjs.com/) and [Bower](http://bower.io/): `npm i -g gulp bower`.

## Download and Run
1. Download the boilerplate `curl -L -o yoursite.zip http://github.com/abstracthat/site-lightning/archive/master.zip`
2. Unzip/rename and `cd` to your site's folder
3. Run `npm install && gulp`

Your first install can be a little slow due to graphics library testing. You might also need some dependencies: see [Sharp](https://github.com/lovell/sharp) and [imagemin](https://github.com/imagemin/imagemin).

To work on your email campaigns run `gulp email`.

## Related Projects
This boilerplate uses [Gulp Lightning](http://github.com/abstracthat/gulp-lightning). I've abstracted the library/boilerplate stuff into dependencies in that repo. This makes it easy to update your project by just bumping the version for `gulp-lightning` in the `package.json` file. The only other requirement is a local install of `gulp`.

Here are the related projects this boilerplate uses:

0. [Gulp Lightning](http://github.com/abstracthat/gulp-lightning)
0. [Happy Grid](http://github.com/abstracthat/happy-grid)
0. [Downbeat](http://github.com/abstracthat/downbeat)
0. [Stylus Lightning](http://github.com/abstracthat/stylus-lightning)
0. [Rupture](http://jenius.github.io/rupture/)
0. [Axis](http://axis.netlify.com/)
0. [Jade](http://jade-lang.com/reference)
0. [Stylus](http://learnboost.github.io/stylus/)
0. [Coffeescript](http://coffeescript.org/)

## TODO
Future additions...

### Responsive Images
0. add [responsive image / iframe lazy loader](https://github.com/aFarkas/lazysizes)
0. responsive image jade mixin
0. [automatically](https://github.com/mahnunchik/gulp-responsive) make all formats for each file 
0. Make open graph optimized images 1200x627
0. [favicons](https://github.com/haydenbleasel/gulp-favicons)

### Markdown Parser Customizations
0. customize Marked to parse images for classes to support lazyload
0. customize Marked lexer for youtube, video and audio blocks

### Blogging Enhancements
0. collection.jade uses first x posts
0. render remaining n-x posts to collection.html
0. client [loads html](https://api.jquery.com/load/) for remaining pages in that collection when [bottom approaching](https://github.com/sakabako/scrollMonitor).

### Search
0. Implement [lunr.js](http://lunrjs.com/)
0. autocomplete search template

### IE8 support
Support IE8 with conditional vendor polyfills.
https://github.com/Modernizr/Modernizr/wiki/HTML5-Cross-browser-Polyfills
https://github.com/corysimmons/boy/blob/master/css/reset/reset.css

- html5shiv
- selectivizr
- boxsizing.htc
- calc() polyfill
- css3pie (axis + htc file)
- legacy css style sheet (rupture rasterize option)
- png htc
- placeholder.js
- svg?

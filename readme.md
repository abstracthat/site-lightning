Because making websites should be fun... and fast. Boilerplate for static site built with Jade, Stylus and Coffeescript, using Gulp. Built with best web delivery practices, solid SEO, and simplicity and DRY-ness of site structure in mind.

Works as a Gulp static site generator. Loop through collections of files in folders. Meta data happy.

http://sitelightning.co/

## Dependencies
[Node](https://nodejs.org/), [Gulp](http://gulpjs.com/) and [Bower](http://bower.io/).

```bash
npm install -g gulp
npm install -g bower
```

## Clone and Run
After you `git clone` the repo and `cd` to your folder, just run...

```bash
npm install && gulp
```

Your first install can be a little slow due to graphics library testing. You might also need some dependencies: see [Sharp](https://github.com/lovell/sharp) and [imagemin](https://github.com/imagemin/imagemin).

## TODO
It's good enough to use but todo is...

### Responsive Images
0. add image / iframe lazy loader: https://github.com/aFarkas/lazysizes 
0. responsive image jade mixin
0. automatically make all formats for each file https://github.com/mahnunchik/gulp-responsive 
0. Make open graph images 1200x627
0. favicons: https://github.com/haydenbleasel/gulp-favicons

### Markdown Parser Customizations
0. replace gulp-markdown with Marked
0. customize Marked to parse images for classes to support lazyload
0. customize Marked lexer for youtube, video and audio blocks
0. code syntax highlighting. Highlight.js

### Blogging Enhancements
0. collection.jade uses first x posts
0. add to gulp: render remaining n-x posts to collection.html
0. client: collection index loads html for remaining pages when bottom approaching: https://github.com/sakabako/scrollMonitor + https://api.jquery.com/load/

### Search
0. Implement [lunr.js](http://lunrjs.com/)
0. autocomplete search template

### Code Generators
0. setup gulp-prompt https://github.com/Freyskeyd/gulp-prompt
0. gulp new:site (delete content, ask questions, populate files)
0. gulp new:collection (ask questions, populate files)
0. gulp new:page (ask questions, populate files)
0. gulp new:template (ask questions, populate files)
0. gulp new:style (ask questions, populate files)
0. gulp new:lib (this would be a stylus mixin, ask questions, populate files)

### Documentation
0. Write more doc

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

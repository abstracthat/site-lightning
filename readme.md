Because making websites should be fun... and fast. Boilerplate for static site built with Jade, Stylus and Coffeescript, using Gulp. Built with best web delivery practices, solid SEO, and simplicity in site structure in mind.

## TODO
0. test / finish parallax mixin for ARI site
0. drafts
0. prose.io config
0. add image / iframe lazy loader: https://github.com/aFarkas/lazysizes 
0. responsive image jade mixin
0. gulp responsive images https://github.com/mahnunchik/gulp-responsive automatically make all formats for each file
0. replace gulp-markdown with marked
0. customize marked to parse images for classes to support lazyload
0. favicons: https://github.com/haydenbleasel/gulp-favicons
0. customize marked lexer for youtube, video and audio blocks
0. code syntax highlighting. Highlight.js was not working when I tried
0. client: ajax load json for infinite scrolling collection index https://github.com/infinite-scroll/infinite-scroll
0. Make client-side coffeescript modular
0. setup gulp-prompt https://github.com/Freyskeyd/gulp-prompt
0. gulp new:site (delete content, ask questions, populate files)
0. gulp new:collection (ask questions, populate files)
0. gulp new:page (ask questions, populate files)
0. gulp new:template (ask questions, populate files)
0. gulp new:style (ask questions, populate files)
0. gulp new:lib (this would be a stylus mixin, ask questions, populate files)
0. move lib mixins to seperate projects and add them through npm
0. Write better doc
0. Write tutorials

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

Full documentation coming soon here: http://sitelightning.co/documentation.

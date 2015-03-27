Because making websites should be fun... and fast. Boilerplate for static site built with Jade, Stylus and Coffeescript, using Gulp. Built with best web delivery practices, solid SEO, and simplicity in site structure in mind.

Works as a Gulp static site generator. Loop through collections of files in folders. Meta data happy.

## Dependencies
[Node](https://nodejs.org/), [Gulp](http://gulpjs.com/) and [Bower](http://bower.io/).

You'll also probably want some nice themes for your text editor for Jade, Stylus, and Coffeescript.

```bash
npm install -g gulp
npm install -g bower
```

## Clone and Run
After you `git clone` the repo and `cd` to your folder, just run...

```bash
npm install && gulp
```

... install can be a little slow due to graphics library testing. You might also need some dependencies: see [Sharp](https://github.com/lovell/sharp) and [imagemin](https://github.com/imagemin/imagemin).

Full documentation coming soon here: http://sitelightning.co/documentation.

## TODO
It's good enough to use but todo is...

### Next
0. `.current-page` checks if page in current collection
0. test / finish parallax mixin
0. allow saving as drafts

### Responsive Images
0. add image / iframe lazy loader: https://github.com/aFarkas/lazysizes 
0. responsive image jade mixin
0. automatically make all formats for each file https://github.com/mahnunchik/gulp-responsive 
0. favicons: https://github.com/haydenbleasel/gulp-favicons

### Markdown Parser Customizations
0. replace gulp-markdown with Marked
0. customize Marked to parse images for classes to support lazyload
0. customize Marked lexer for youtube, video and audio blocks
0. code syntax highlighting. Highlight.js

### Blogging Enhancements
0. client: index async load json for remaining posts render when bottom approaching: https://github.com/sakabako/scrollMonitor
0. prose.io config

### Code Generators
0. setup gulp-prompt https://github.com/Freyskeyd/gulp-prompt
0. gulp new:site (delete content, ask questions, populate files)
0. gulp new:collection (ask questions, populate files)
0. gulp new:page (ask questions, populate files)
0. gulp new:template (ask questions, populate files)
0. gulp new:style (ask questions, populate files)
0. gulp new:lib (this would be a stylus mixin, ask questions, populate files)

### Organize
0. move lib mixins to seperate projects and add them through npm
0. Make client-side coffeescript modular with exports and require
0. Write better doc
0. Write tutorials

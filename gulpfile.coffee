# Load Gulp and all 'gulp-' plugins from package.json
gulp = require 'gulp'
plugins = (require 'gulp-load-plugins')()
# This can be removed after Gulp 4 is released
runSequence = require 'run-sequence'

# Server + browser with live refresh / injection
browserSync = require 'browser-sync'
reload = browserSync.reload
cleanUrls = require 'hygienist-middleware'

# Bower and Browserify
bowerFiles = require 'main-bower-files'
exists = (require 'fs').existsSync
browserify = require 'browserify'
transform = require 'vinyl-transform'

# Deployment via rsync ssh
rsync = (require 'rsyncwrapper').rsync

# Stylus libraries
axis = require 'axis'
jeet = require 'jeet'
rupture = require 'rupture'

# Date parsing
moment = require 'moment'

jade = require 'jade'
_ = require 'lodash'

# Enable markdown blocks in Jade and syntax highlighting
marked = require 'marked'
highlight = (require 'highlight.js').highlightAuto
# Use proper quotes and apostrophes
marked.setOptions
  smartypants: true

# My module to create site.json, a map of structured data for the site
# Pages in Collections are sorted by date
map = require './map'

# Settings: server and paths
server = 'projects:/var/www/sitelightning.co'
path =
  stylus: 'source/styles/**/*.styl'
  mainStylus: 'source/styles/main.styl'
  coffee: 'source/scripts/**/*.coffee'
  content: 'source/content/**/*.{jade,md}'
  markdown: 'source/content/**/*.md'
  jade: 'source/content/**/*.jade'
  allContent: 'source/{content,templates}/**/*'
  images: 'source/images'
  fonts: 'source/fonts'
  development: './development'
  production: './production'

# Build json sitemap
gulp.task 'map', (done) ->
  map done

# Compile Markdown source through Jade layout
gulp.task 'markdown', (done) ->
  site = require './site.json'
  gulp.src path.markdown
  .pipe plugins.plumber()
  .pipe plugins.frontMatter
    property: 'data'
  .pipe plugins.markdown
    smartypants: true
  .pipe plugins.data (file) ->
    date = new Date(file.data.date)
    if file.data.date
      file.data.datetime = moment(date).format()
      file.data.date = moment(date).format('MMMM Do, YYYY')
    file.data.layout = "./source/templates/#{file.data.layout}.jade"
    file.data.pretty = true
    data = _.extend {}, site, file.datas
  .pipe plugins.layout (file) ->
    file.data
  .pipe gulp.dest path.development
  done()

# Compile Jade source
gulp.task 'jade', ->
  site = require './site.json'
  gulp.src path.jade
  .pipe plugins.plumber()
  .pipe plugins.frontMatter
    property: 'data'
  .pipe plugins.data (file) ->
    date = new Date(file.data.date)
    if file.data.date
      file.data.datetime = moment(date).format()
      file.data.date = moment(date).format('MMMM Do, YYYY')
    data = _.extend {}, site, file.data
  .pipe plugins.jade
    pretty: true
  .pipe gulp.dest path.development

# Compile stylus to css with sourcemaps
gulp.task 'stylus', ->
  gulp.src path.mainStylus
  .pipe plugins.plumber()
  .pipe plugins.sourcemaps.init()
  .pipe plugins.stylus
    use: [
      jeet()
      rupture()
      axis
        implicit: false
    ]
  .pipe plugins.autoprefixer()
  .pipe plugins.sourcemaps.write()
  .pipe gulp.dest path.development
  .pipe reload stream: true

# Compile coffeescript to js with sourcemaps
gulp.task 'coffee', ->
  gulp.src path.coffee
  .pipe plugins.plumber()
  .pipe plugins.sourcemaps.init()
  .pipe plugins.coffee()
  # show coffeescript errors in the console
  .on 'error', plugins.util.log
  .pipe plugins.sourcemaps.write()
  .pipe gulp.dest path.development

# Use browserify to compile any require statments
gulp.task 'js', ['coffee'], ->
  gulp.src "#{path.development}/main.js"
  .pipe plugins.plumber()
  .pipe transform (file) ->
    (browserify file).bundle()
  .pipe gulp.dest path.development

# Install Bower dependencies and move to development lib folder
# To use a library add it to build blocks in base.jade
gulp.task 'installBower', ->
  plugins.bower()

gulp.task 'moveBowerFiles', ['installBower'], ->
  if exists './bower_components'
    gulp.src bowerFiles()
    .pipe gulp.dest "#{path.development}/lib"

gulp.task 'bower', [
  'installBower'
  'moveBowerFiles'
]

# Compile source files for development
gulp.task 'compile', [
  'bower'
  'js'
  'jade'
  'markdown'
  'stylus'
]

# Convert production files into development files
# concat, minify, optimize, cache bust
gulp.task 'optimize', ->
  # parse the html files for build blocks
  # return the concatenated file for each block
  assets = plugins.useref.assets searchPath: path.development
  gulp.src "#{path.development}/**/*.html"
  .pipe assets
  # minify css and js
  .pipe plugins.if '*.css', plugins.csso()
  .pipe plugins.if '*.js', plugins.uglify()
  .pipe gulp.dest path.production
  # bring back just the html files
  .pipe assets.restore()
  # remove/replace the build blocks
  .pipe plugins.useref()
  # minify the html
  .pipe plugins.if '*.html', plugins.minifyHtml()
  .pipe gulp.dest path.production

# cache bust asset file names
gulp.task 'cacheref', ->
  bust = new plugins.cachebust()

  gulp.src "#{path.production}/**/*.css"
  .pipe bust.resources()
  .pipe gulp.dest path.production

  gulp.src "#{path.production}/**/*.js"
  .pipe bust.resources()
  .pipe gulp.dest path.production

  gulp.src "#{path.production}/**/*.html"
  .pipe bust.references()
  .pipe gulp.dest path.production

# cleanup cachebust assets
gulp.task 'cachebust', ['cacheref'], ->
  gulp.src [
    "#{path.production}/script.min.js"
    "#{path.production}/style.min.css"
    ]
  .pipe plugins.clean()

# Optimize and move images
gulp.task 'images', ->
  gulp.src "#{path.images}/*"
  .pipe plugins.plumber()
  .pipe plugins.cache plugins.imagemin
    progressive: true
    interlaced: true
  .pipe gulp.dest "production/images"

# Move other files for production
gulp.task 'move', ->
  gulp.src [
    'source/fonts/**/*'
  ]
  .pipe gulp.dest "#{path.production}"

# Clear Gulp cache
gulp.task 'clear', (done) ->
  plugins.cache.clearAll done

# Delete development and production build folders
gulp.task 'clean', ['clear'], ->
  gulp.src [
    path.development
    path.production
    './bower_components'
    './site.json'
  ], read: false
  .pipe plugins.clean()

# Open a web browser and watch for changes
gulp.task 'browser', ->
  browserSync.init
    notify: false
    server:
      baseDir: [
        path.development
        './source'
      ]
      middleware: cleanUrls 'development'

  # Watch for changes
  gulp.watch path.allContent, ['jade', reload]
  gulp.watch path.stylus, ['stylus']
  gulp.watch path.coffee, ['js', reload]
  gulp.watch path.images, reload

# Open a web browser to test final production build
gulp.task 'previewBrowser', ->
  browserSync
    server:
      baseDir: path.production
      middleware: cleanUrls 'production'

# rsync the build directory to your server
gulp.task 'rsync', ->
  rsync
    ssh: true
    src: "#{path.production}/"
    dest: server
    recursive: true
    syncDest: true
    args: ['--verbose']
  , (erro, stdout, stderr, cmd) ->
    plugins.util.log(stdout)

#################
# Main Gulp Tasks
#################

# Develop (the defualt task)
gulp.task 'develop', ['map'], (done) ->
  runSequence 'compile', 'browser', done

gulp.task 'default', ['develop']

# Build full site ready for production
gulp.task 'build', (done) ->
  runSequence 'clean', 'compile', ['optimize', 'move', 'images'], 'cachebust', done

# Preview server for production
gulp.task 'preview', (done) ->
  runSequence 'build', 'previewBrowser', done

# Deploy production site
gulp.task 'deploy', (done) ->
  runSequence 'build', 'rsync', done

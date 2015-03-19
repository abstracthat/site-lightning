fs = require 'fs'
path = require 'path'

_ = require 'lodash'
directories = (require 'node-dir').subdirs
glob = require 'glob'
yaml = require 'yamljs'
moment = require 'moment'
cheerio = require 'cheerio'
frontMatter = require 'front-matter'
markdown = require 'marked'
markdown.setOptions
  smartypants: true

directory = 'source/content'

# scaffold the site object
site =
  site:
    name: ''
    url: ''
    title: ''
    description: ''
  pages: {}
  collections: {}

# pass in some site variables via site.yml
_.extend site, yaml.load './site.yml'

# Get the collections (folders) first so we can sort our pages into them
getCollections = (done) -> 
  directories "./#{directory}", (err, collections) ->
    for collection in collections
      url = "#{collection}/".replace directory, ''
      site.collections[url] =
        url: url
        pages: [] # array to push found pages into later
    done()

# Read the files and add the metadata to the site object
createMap = (done) ->
  glob "./#{directory}/**/*", nodir: true, (err, files) ->
    console.error if err
    for file in files
      data = fs.readFileSync file, 'utf8'
      content = frontMatter data
      meta = content.attributes
      post = ''
      
      # Build the parsed page metadata
      page = {}
      page.url = file.slice (file.indexOf directory) + directory.length
      .replace /(index)?(\.jade$|.\md$)/, ''
      page.title = meta.title if meta.title
      page.description = meta.description if meta.description
      page.tags = meta.tags if meta.tags

      # Parse the date
      if meta.date
        page.datetime = moment(new Date(meta.date)).format()
        page.date = moment(new Date meta.date).format('MMMM Do, YYYY')

      # Compile markdown and load html into cheerio
      if (path.extname file) is '.md'
        post = markdown content.body
        $ = cheerio.load post

        # unless intro is given in meta, take the first paragraph of the post
        if meta.intro
          page.intro = meta.intro
        else
          intro = $('p').first().html()
          page.intro = intro if intro

        # unless image is given in meta, take the first image from the post
        if meta.image
          page.image = content.attributes.image
        else
          image = $('img').attr('src')
          page.image = image if image
      
      # if it's not markdown (i.e. jade) then look for intro and image meta
      else
        page.intro = meta.intro if meta.intro
        page.image = content.attributes.image if meta.image

      # the url is either the root, page, collection, or page in a collection
      # root
      if page.url is '/'
        site.site.title = page.title
        site.site.description = page.description
      
      # page
      else if (page.url.match /\//g).length < 2
        site.pages[page.url] = page
      
      # collection index
      else if page.url.match /\/$/
        _.extend site.collections[page.url], page
      
      # page in a collection
      else
        collection = (path.dirname page.url) + '/'
        site.collections[collection].pages.push page
    
    # Finished with createMap, callback
    done()

# Sort the pages in each collection by date (newest first)
sortCollectionPages = (done) ->
  for key, collection of site.collections
    collection.pages.sort (a, b) ->
      new Date(b.datetime) - new Date(a.datetime)
  done()

# Write the site object to site.json
writeJSON = (done) ->
  fs.writeFileSync './site.json', JSON.stringify site
  done()

# Main program
module.exports = (done) ->
  getCollections -> createMap -> sortCollectionPages -> writeJSON -> done()

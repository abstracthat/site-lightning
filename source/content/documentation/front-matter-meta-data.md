---
title: Front-Matter Meta Data Cheat Sheet
description: Based on best SEO, social, and web practices, get all of the page meta data you need in the right spot.
layout: post
tags:
  - SEO
  - Open Graph
  - Front-matter
  - YAML
date: 5-7-15
---

We'd all just like to get down to writing the content but in reality we need some meta data for every page in order to make our content more useful to people finding it in search engines or social sites. So we have to learn to love SEO and [Open Graph](http://ogp.me/) tags.

## Typical Usage
Typically you would use the following. Note that you don't need `layout` if it's a Jade file.

```yaml
title: 50-55 characters
description: 150-160 characters
layout: post
tags:
  - fun
date: 1-2-15
og-title: 70 characters
og-description: 200 characters
og-image: 1200x627.jpg
```

## Minimal Meta
At the minimum you should use a `title` and `description` (and `layout` if it's markdown). Posts in collections are sorted by date (newest first) so you might also want `date`.

```yaml
title: Title
description: Meta description
layout: post # only for markdown
date: 1-2-15 # if document is in a collection
```

## All the Meta
Here's a cheat sheet of them all.

### title
Title of The Page Here (50-55 characters).

### meta_title
An Alternate Title to Use for the page's `<title>` tag.

### og-title
The Open Graph Title, else we use the Title (60-90 characters).

### twitter-title
Limit to 70 characters, else og-title, else title.

### description
The meta description often found on search engine result pages (150-160 
characters).

### og-description
The Open Graph description, else we use the meta description (200 characters).

### twitter-description
Limit to 200 characters, else, og-description, else description.

### layout
If it's markdown this is the Jade template to render with.

### tags
\- not currently used
\- but could be useful
\- especially for search

### date
In this format, month-day-2digityear... 1-2-15.

### image
The absolute path for a feautred image for the page. Else we use the first image from the page. Can be used when designing a collection index for instance.

### intro
The map function will scrape the first paragraph or you can override it with your own if you want. Can be used in designing a post list index.

### og-image
The open graph image should ideally be 1.91/1 ratio 1200px x 627px.

### twitter-type
Twitter cards can be summary, photo, video, product, app, gallery, and “large 
version” summary. If blank we assume summary

## Need More Help?
[This article](https://blog.kissmetrics.com/open-graph-meta-tags/) was very helpful for me when I set up the open graph template.


---
title: How To Use Gulp As A Static Site Generator
description: There are a million static site generators out there but you don't need them. Just use Gulp with this handy data mapping script.
layout: post
tags:
  - Gulp
  - CLI
  - map
date: 5-5-15
---

There are a million static site generators out there but you don't need themI wrote a file called `map.coffee` that does all the heavy lifting of building all of your site's content into a structured data object.

After you have run the default gulp task take a look at `site.json` in the root of your project. Here's an example for this site...

```json
{
    "site": {
        "name": "Site Lightning",
        "url": "http://sitelightning.co",
        "title": "Site Lightning: Rapid Website Development",
        "description": "Site Lightning is the wicked fast way to design and build a static website. Try it out now. It's fun!"
    },
    "pages": {
        "/contact/": {
            "url": "/contact/",
            "title": "Get in Touch",
            "description": "Fill out the contact form to reach the maintainer of Site Lightning."
        },
        "/license/": {
            "url": "/license/",
            "title": "License",
            "intro": "Site Lightning is <a href=\"http://github.com/abstracthat/sitelightning\">open source</a> and contributions are welcome. The source code is under the MIT license."
        },
        "/terms/": {
            "url": "/terms/",
            "title": "Terms of Service",
            "intro": "By accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law."
        },
        "/thanks/": {
            "url": "/thanks/",
            "title": "Thanks!",
            "intro": "Your message has been sent. We&#x2019;ll be in touch with you as soon as we can. Cheers!"
        }
    },
    "collections": {
        "/documentation/": {
            "url": "/documentation/",
            "pages": [{
                "url": "/documentation/front-matter-meta-data/",
                "title": "Front-Matter Meta Data Cheat Sheet",
                "description": "Based on best SEO, social, and web practices, get all of the page meta data you need in the right spot.",
                "tags": ["SEO", "Open Graph", "Front-matter", "YAML"],
                "datetime": "2015-05-07T00:00:00-04:00",
                "date": "May 7th, 2015",
                "intro": "We&#x2019;d all just like to get down to writing the content but in reality we need some meta data for every page in order to make our content more useful to people finding it in search engines or social sites. So we have to learn to love SEO and <a href=\"http://ogp.me/\">Open Graph</a> tags. <a href=\"https://blog.kissmetrics.com/open-graph-meta-tags/\">This article</a> is also very helpful."
            }, {
                "url": "/documentation/gulp-commands/",
                "title": "Take Control of Your Project With Gulp",
                "description": "Gulp makes running tasks for your static site project easy. Get and overview of what's available to you.",
                "tags": ["Gulp", "CLI"],
                "datetime": "2015-05-06T00:00:00-04:00",
                "date": "May 6th, 2015",
                "intro": "Everything is in <code>gulpfile.coffee</code>. Basically you just use <code>gulp</code> to develop and <code>gulp deploy</code> to deploy production ready files to your server. To view the production ready files before deploying you can use <code>gulp preview</code>. Another useful one is <code>gulp clean</code> if you need to banish some old files while developing."
            }, {
                "url": "/documentation/gulp-static-site-generator/",
                "title": "Learn How To Use Gulp As A Static Site Generator",
                "description": "There are a million static site generators out there but you don't need them. Just use Gulp with this handy data mapping script.",
                "tags": ["Gulp", "CLI", "map"],
                "datetime": "2015-05-05T00:00:00-04:00",
                "date": "May 5th, 2015",
                "intro": "There are a million static site generators out there but you don&#x2019;t need them. Content explaining <code>map.coffee</code> coming soon."
            }],
            "title": "Documentation",
            "description": "Learn how to use Site Lightning from the structure to adding libraries and building your own style guide."
        }
    },
    "header": [{
        "name": "Documentation",
        "url": "/documentation/"
    }, {
        "name": "Contact",
        "url": "/contact/"
    }],
    "footer": [{
        "name": "Terms of Service",
        "url": "/terms/"
    }, {
        "name": "License",
        "url": "/license/"
    }],
    "social": [{
        "github": "http://github.com/abstracthat"
    }, {
        "twitter": "@abstracthat"
    }],
    "mailchimp": {
        "submit": "http://marketfurther.us10.list-manage.com/subscribe/post",
        "user": "aa52d5e1b14f1c50429ce9c39"
    }
}
```

This is what enables us to loop through collections for index pages or find the url and title for the "next" or "previous" page in a collection. All of this data is available in your templates as variables. For instance `h1= site.name` will render the site's name. Easy peasy.

More details coming soon...

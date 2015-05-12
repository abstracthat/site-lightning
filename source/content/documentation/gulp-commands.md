---
title: Take Control of Your Project With Gulp
description: Gulp makes running tasks for your static site project easy. Get and overview of what's available to you.
layout: post
tags:
  - Gulp
  - CLI
date: 5-6-15
---

Everything is in `gulpfile.coffee`. Basically you just use `gulp` to develop and `gulp deploy` to deploy production ready files to your server. To view the production ready files before deploying you can use `gulp preview`. Another useful one is `gulp clean` if you need to banish some old files while developing.

Full documentation coming soon (or see the well-commented source file). Here is a list of all of the tasks:
- map
- markdown
- jade
- stylus
- coffee
- js
- installBower
- bower
- compile
- optimize
- cacheref
- cachebust
- images
- move
- clear
- clean
- browser
- previewBrowser
- rsync
- develop
- default
- build
- preview
- deploy

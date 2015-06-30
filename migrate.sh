#!/usr/bin/env bash
# This script migrates v1.0.0 to 2.0.0

echo -n 'Type the full path to the folder that you want to migrate and press return: '
read -e DEST

rm -rf "$DEST"/production "$DEST"/development "$DEST"/site.json
cp -R ./email "$DEST"/email
mv "$DEST"/source "$DEST"/site
mv "$DEST"/site.yml "$DEST"/site
cp ./package.json "$DEST"/package.json
cp ./gulpfile.js "$DEST"/gulpfile.js
cp ./.gitignore "$DEST"/.gitignore
cp ./config.yml "$DEST"./config.yml
cp ./secrets-copy.yml "$DEST"/secrets.yml
mkdir "$DEST"/site/root
mv "$DEST"/site/robots.txt "$DEST"/site/root/robots.txt
touch "$DEST"/site/root/.redirects.conf
cp ./site/content/contact.jade "$DEST"/site/content/contact.jade
cp ./site/templates/terms.jade "$DEST"/site/templates/terms.jade

echo """
Migration complete!

* Now your site source is in the /site directory.
* You have an /email directory for designing and creating MailChimp campaigns.
* You have an rss feed at yoursite.com/rss.xml

Your To Do List...
------------------
1. Add server to config.yml (it's no longer defined in gulpfile.js)
2. Add your MailChimp api key to secrets.yml
3. Add your name and email address to site/site.yml.
   * Required for contact form, RSS, and for sending MailChimp campaigns.
4. Setup Mailchimp:
   * Make a folder in campaigns named for your site
   * and a folder in autoresponders named for your site
5. Customize email/email.yml with your MailChimp list ID and Folder ID's
6. Add an autoresponder sequence. Customize your email styles.

New gulp tasks...
-----------------

# Run the email server and watch content and styles
gulp email

# Sync your campaigns with MailChimp
gulp mailchimp

# Other helpful tasks
gulp mailchimp:lists
gulp mailchimp:folders
gulp mailchimp:campaigns
gulp mailchimp:autoresponders
gulp mailchimp:vars
gulp mailchimp:segments

Thank you for using Site Lightning. You rock!
"""

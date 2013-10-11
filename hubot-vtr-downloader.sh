#! /urs/bin/bash

echo "Hubot VTR: Downloading Hubot Community Scripts from github.com/github/hubot-scripts"

# Useful
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/announce.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/availability.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/deadline.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/http-info.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/isup.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/news.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/pypi.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/sms.coffee
echo " - Useful Scripts: Downloaded"

# Admin
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/heroku-status.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/ip.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/reload.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/update.coffee
echo " - Administrative Scripts: Downloaded"

# Encoding
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/base36.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/base58.coffee
wget -q https://raw.github.com/github/hubot-scripts/master/src/scripts/base64.coffee
echo " - Encoding Scripts: Downloaded"

echo "Download Completed"

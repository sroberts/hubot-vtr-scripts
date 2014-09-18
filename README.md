hubot-vtr-scripts
=================

[![Build Status](https://travis-ci.org/sroberts/hubot-vtr-scripts.svg?branch=master)](https://travis-ci.org/sroberts/hubot-vtr-scripts)

This is Hubot VTR, a series of Hubot actions for making Hubot a Computer Network Defense badass. The goal of this project is to create a series of Hubot actions for OSINT collection, Network Forensics, System Forensics, Reverse Engineering and other Network Defense tasks.

I gave a presentation about Hubot VTR at BSidesDFW. Check out my [slides](https://speakerdeck.com/sroberts/using-robots-to-fight-bad-guys).

## Setup

First things first you'll need [Node.js and NPM installed](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager), after that setting up [Hubot VTR using NPM](https://npmjs.org/package/hubot-vtr-scripts) is easy.

1. ```npm install hubot-vtr-scripts```

2. Add ```"hubot-vtr-scripts": ">= 1.0.7"``` to the dependences list in your Hubot `package.json`.

3. Add ```"hubot-vtr-scripts"``` into your `external-dependencies.json` script between the brackets.

__You're done! Restart Hubot and you're good to go!__

### Environment Variables
Certain scripts require use of private APIs and these require API authentication keys. You set those as environment variables.

* `MYWOT_API_KEY` - http://www.mywot.com/
* `PIPL_API_KEY` - http://dev.pipl.com/
* `SHODAN_API_KEY` - http://www.shodanhq.com/api_doc
* `VIRUSTOTAL_API_KEY` - https://www.virustotal.com/en/documentation/public-api/
* `GOOGLE_SAFEBROWSING_API_KEY` - https://developers.google.com/safe-browsing/key_signup
* `OPENDNS_KEY` - https://sgraph.opendns.com/tokens-view

How you set these up may vary on your deployment method and operating system. For most Linux/OSX systems, you would do something like this from the command line:

`export MYWOT_API_KEY=XXXXXXXXXXXXXX`

If you're running your Hubot on Heroku, you would run this from your local command line where the Heroku tools are installed:

`heroku config:add MYWOT_API_KEY='XXXXXXXXXXXXXXXXXXXXXXXX'`


### Community Scripts

Getting the recommended community scripts necessary requires adding the following lines into ```hubot-scripts.json```:

	"announce.coffee",
	"availability.coffee",
	"deadline.coffee",
	"http-info.coffee",
	"isup.coffee",
	"news.coffee",
	"pypi.coffee",
	"sms.coffee",
	"heroku-status.coffee",
	"ip.coffee",
	"reload.coffee",
	"update.coffee",
	"base36.coffee",
	"base58.coffee",
	"base64.coffee"

## VTR Scripts

| Script | Description |
| ------ | ----------- |
| [Code Name Generator](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/code-name-generator.coffee) | Generates code names for being spooky
| [Geolocate IP](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/geolocate-ip.coffee) | Identify the physical location of an IP address
| [MyWOT](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/mywot.coffee) | Look up the reputation of a website
| [Pipl](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/pipl.coffee) | Look up OSINT on a users email address
| [Google Safebrowsing](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/google-safebrowsing.coffee) | Look up Safebrowsing status of a URL |
| [Reputation Links](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/reputation-links.coffee) | Generate links for Robtext, IP/URLVoid, etc
| [Reverse DNS](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/reverse-dns.coffee) | Get the urls associated with an IP address
| [Shodan](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/shodan.coffee) | Search engine for server strings. |
| [Short URL Expander](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/short-url-expander.coffee) | Take a shortened URL and find out where it redirects to. |
| [VirusTotal](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/virustotal.coffee) | Hash, URLs, IP Addresses |
| [Yara](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/yara.coffee) | Generates template for creating Yara rules. |
| [OpenDNS](https://github.com/sroberts/hubot-vtr-scripts/blob/master/src/scripts/opendns-umbrella.coffee) | Accesses the OpenDNS Investigation graph. |

### Additional Optional Community Scripts

These scripts are not required, but you may find them useful for your team. They may require their own configuration.

#### Core
| Script | Description |
| ------ | ----------- |
| [announce.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/announce.coffee) | Send messages to all chat rooms. |
| [availability.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/availability.coffee) | Set your availability status so people know whether they're able to come over and chat with you or ping you over IM. |
| [deadline.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/deadline.coffee) | Tracks when stuff is due. |
| [http-info.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/http-info.coffee) | Returns title and description when links are posted. |
| [isup.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/isup.coffee) | Uses downforeveryoneorjustme.com to check if a site is up. |
| [news.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/news.coffee) | Returns the latest news headlines from Google. |
| [pypi.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/pypi.coffee) | Simple Python Package Index querying using XMLRPC API. |
| [sms.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/sms.coffee) | Allows Hubot to send text messages using Twilio API. |

#### Administrative Scripts
| Script | Description |
| ------ | ----------- |
| [heroku-status.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/heroku-status.coffee) | Show current Heroku status and issues. |
| [ip.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/ip.coffee) | Return Hubot's external IP address (via jsonip.com). |
| [reload.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/reload.coffee) | Allows Hubot to (re)load scripts without restart. |
| [update.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/update.coffee) | Allows hubot to update itself using git pull and npm update. |

#### Encoding
| Script | Description |
| ------ | ----------- |
| [base36.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/base36.coffee) | Base36 encoding and decoding. |
| [base58.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/base58.coffee) | Base58 encoding and decoding. |
| [base64.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/base64.coffee) | Base64 encoding and decoding. |

## Testing
From the root project directory run:

`npm test`

## Special Thanks
* [@technoskald](https://github.com/technoskald) - Constant sounding board
* [@technicalpickels](https://github.com/technicalpickels) - For my endless stupid questions about Hubot!
* [@mattjay](https://github.com/mattjay) - Tests: We needed those
* [@jnewland](https://github.com/jnewland) - For driving this whole ChatOps idea
* [@jcran](https://github.com/jcran)
* [@snipe](https://github.com/snipe) - Bug Fix Awesomeness

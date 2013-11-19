hubot-vtr-scripts
=================

This is Hubot VTR, a series of Hubot actions for making Hubot a Computer Network Defense badass. The goal of this project is to create a series of Hubot actions for OSINT collection, Network Forensics, System Forensics, Reverse Engineering and other Network Defense tasks.

I gave a presentation about Hubot VTR at BSidesDFW. Check out my [slides](https://speakerdeck.com/sroberts/using-robots-to-fight-bad-guys).

## Setup

Setting up Hubot VTR using NPM is easy.

1. ```npm install hubot-vtr-scripts```

2. Add ```"hubot-vtr-scripts": ">= 1.0.3"``` to the dependences list in your Hubot package.json.

3. Add ```"hubot-vtr-scripts"``` into your external-dependencies.json script between the brackets.

You're done! Restart Hubot and you're good to go!

### Environment Variables
Certain scripts require use of private APIs and these require API authentication keys. You set those as environment variables.

* MYWOT_API_KEY
* PIPL_API_KEY
* SHODAN_API_KEY
* VIRUSTOTAL_API_KEY

How you set these up may vary on your deployment.

### Community Scripts

Getting the recommended community scripts necessary requires adding the following lines into ```hubot-scripts.json```:

```"announce.coffee", "availability.coffee", "deadline.coffee", "http-info.coffee", "isup.coffee", "news.coffee", "pypi.coffee", "sms.coffee", "heroku-status.coffee", "ip.coffee", "reload.coffee", "update.coffee", "base36.coffee", "base58.coffee", "base64.coffee"```

## VTR Scripts

| Script | Description |
| ------ | ----------- |
| Code Name Generator | Generates code names for being spooky
| Geolocate IP | Identify the physical location of an IP address
| MyWOT | Look up the reputation of a website
| Pipl | Look up OSINT on a users email address
| Reputation Links | Generate links for Robtext, IP/URLVoid, etc
| Reverse DNS | Get the urls associated with an IP address
| Shodan | Search engine for server strings. |
| Short URL Expander | Take a shortened URL and find out where it redirects to. |
| VirusTotal | Hash, URLs, IP Addresses |
| Yara | Generates template for creating Yara rules. |

### Additional Scripts
Included is the ```hubot-vtr-downloader.sh``` shell script which downloads the following community developed Hubot scripts that may be useful for DFIR.

These may require their own configuration.

#### Core
| Script | Description |
| ------ | ----------- |
| announce.coffee | Send messages to all chat rooms. |
| availability.coffee | Set your availability status so people know whether they're able to come over and chat with you or ping you over IM. |
| deadline.coffee | Tracks when stuff is due. |
| http-info.coffee | Returns title and description when links are posted. |
| isup.coffee | Uses downforeveryoneorjustme.com to check if a site is up. |
| news.coffee | Returns the latest news headlines from Google. |
| pypi.coffee | Simple Python Package Index querying using XMLRPC API. |
| sms.coffee | Allows Hubot to send text messages using Twilio API. |

#### Administrative Scripts
| Script | Description |
| ------ | ----------- |
| heroku-status.coffee | Show current Heroku status and issues. |
| ip.coffee | Return Hubot's external IP address (via jsonip.com). |
| reload.coffee | Allows Hubot to (re)load scripts without restart. |
| update.coffee | Allows hubot to update itself using git pull and npm update. |

#### Encoding
| Script | Description |
| ------ | ----------- |
| base36.coffee | Base36 encoding and decoding. |
| base58.coffee | Base58 encoding and decoding. |
| base64.coffee | Base64 encoding and decoding. |

## Special Thanks
* @technoskald - Constant sounding board
* @technicalpickels - For my endless stupid questions about Hubot!
* @mattjay - Tests: We needed those
* @jnewland - For driving this whole ChatOps idea

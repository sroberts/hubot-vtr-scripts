## Scripts
### Code Name Generator
Hubot generates some basic codenames for you

```
Hubot> hubot codename
Hubot> Codewords:
- pasture nimble
- chum shogun
- ivy mammoth
- pigstick sheepskin
- trash medic
```

### Geolocate IP
Figures out where in the world an IP address using [HostIP](http://www.hostip.info)
```
Hubot> hubot geolocate 1.1.1.1
Hubot> 1.1.1.1 is from Sexau, GERMANY.
```
### MyWOT
Get reputation of a url based on [My Web of Trust](http://www.mywot.com/)
```
Hubot> hubot mywot github.com
Hubot> MyWot Result for github.com
---------------------------
- Trustworthiness: Excellent (Confidence: 84%)
- Child Safety:    Excellent (Confidence: 81%)
- Categories:
  - Good site (Confidence: 97%)
```
### Pipl
```
Hubot> hubot pipl email example@example.com
Hubot> Pipl Profile for Email: example@example.com
------------------------------------------------
Total Records: 127

Person:
 - No information found.

Records:
 - Personal Profile - Bebo: http://www.bebo.com/Profile.jsp?MemberId=18365306
 - Social Entertainment Personal Profile - hi5: http://www.hi5.com/friend/p78381293--Profile--html
 - comersus.org: http://www.comersus.org/displayMessage.asp?mid=50902
 - help.yahoo.co.jp: http://help.yahoo.co.jp/help/us/bizmail/spam/spam-24.html
 - answers.yahoo.com: http://answers.yahoo.com/question/index?qid=20090128165209AAeKhvO
```
> Records field cut down for brevity.

### Reputation Links
There are a number of common sites used when researching a URL or IP. This generates links for them easily.

#### IP
```
Hubot> hubot reputation ip 8.8.4.4
Hubot> 8.8.4.4 IP Reputation:
- Robtext:    https://ip.robtex.com/8.8.4.4.html
- CentralOps: http://centralops.net/co/DomainDossier.aspx?addr=8.8.4.4&dom_dns=1&dom_whois=1&net_whois=1
- IPVoid:     http://www.ipvoid.com/scan/8.8.4.4/
```
#### URL
```
Hubot> hubot reputation url google.com
Hubot> google.com URL Reputation:
- Robtext:    https://pop.robtex.com/google.com.html
- CentralOps: http://centralops.net/co/DomainDossier.aspx?addr=google.com&dom_whois=true&dom_dns=true&net_whois=true
- URLVoid:    http://www.urlvoid.com/scan/google.com/
```

### Reverse DNS
Find out what sites are hosted at an IP address
```
Hubot> hubot reverse dns 8.8.4.4
Hubot> Reverse DNS: 8.8.4.4 google-public-dns-b.google.com
```
### Shodan
Look up an item, most likely an IP address, on [Shodan](http://www.shodanhq.com/)

```
Hubot> hubot shodan 198.199.77.139
Hubot> Shodan Result for 198.199.77.139
--------------------------------------------
- IP:  198.199.77.139
- Geo: New York, NY, United States

~ 198.199.77.139
------
- Hostname:     198.199.77.139
- Organization: null
- Port:         80
- Banner:
 - HTTP/1.0 200 OK
 - Server: nginx/1.2.1
 - Date: Mon, 06 May 2013 18:39:17 GMT
 - Content-Type: text/html
 - Content-Length: 151
 - Last-Modified: Mon, 04 Oct 2004 15:04:06 GMT
 - Connection: keep-alive
 - Accept-Ranges: bytes

~ 198.199.77.139
------
- Hostname:     198.199.77.139
- Organization: ServerStack
- Port:         80
- Banner:
 - HTTP/1.0 200 OK
 - Server: nginx/1.2.1
 - Date: Sun, 12 May 2013 08:10:05 GMT
 - Content-Type: text/html
 - Content-Length: 151
 - Last-Modified: Mon, 04 Oct 2004 15:04:06 GMT
 - Connection: keep-alive
 - Accept-Ranges: bytes
```

> Cut off some of the banners returned for brevity

### Short URL Expander
Find out where a shorted URL actually points to without just dropping it into your borwser

```
Hubot> hubot expand url http://bit.ly/16SbMmZ
Hubot> Title: http://www.google.com/
URL: http://www.google.com/
```
### VirusTotal
Look up file hashes, urls, & ip addresses on VirusTotal

#### Hash
```
Hubot> hubot virustotal hash 07f0b2cf98ebcd20dec6b4c6869ee2ad2ee80b1bf12809688d62b60b85bff89b
Hubot> VirusTotal Result: 07f0b2cf98ebcd20dec6b4c6869ee2ad2ee80b1bf12809688d62b60b85bff89b
- Scanned at: 2013-08-18 08:40:52
- Results:    38/45
- Link:       https://www.virustotal.com/file/07f0b2cf98ebcd20dec6b4c6869ee2ad2ee80b1bf12809688d62b60b85bff89b/analysis/1376815252/
```
#### URLs
```
Hubot> hubot virustotal url google.com
Hubot> VirusTotal URL Result: http://google.com/
- Scanned at: 2013-10-10 20:13:58
- Results:    0/37
- Link:       https://www.virustotal.com/url/cf4b367e49bf0b22041c6f065f4aa19f3cfe39c8d5abc0617343d1a66c6a26f5/analysis/1381436038/
```
#### IP Addresses
```
Hubot> hubot virustotal ip 8.8.4.4
Hubot> VirusTotal IP Result: 8.8.4.4
- Detected Communicating Samples: 100
- Detected URLs:                  100
- Link:                           https://www.virustotal.com/en/ip-address/8.8.4.4/information/
```

### Yara
Automatically generates [Yara](https://code.google.com/p/yara-project/) rules

```
Hubot> hubot yara template
Hubot> rule rule_name : category
{
  meta:
    author = 'Hubot'
    date = '2013-01-01'
    description = 'Default Rule Template'
  strings:
    $string0 = "foo"
    $string1 = "bar"
    $string2 = "baz" wide
condition:
    3 of them
}
```
> At this point this command only creates a template for writing your own rules by hand.

### Google Safebrowsing
Checked the Google Safebrowsing API to see if a url is listed as malware or phishing (or both) in [Google Safebrowsing](https://developers.google.com/safe-browsing).

```
Hubot> hubot gsafe ianfette.org
Hubot> [SUSPICIOUS] The URL ianfette.org is listed as malware in Google Safebrowsing. More info: at http://www.google.com/safebrowsing/diagnostic?site=ianfette.org
```

```
Hubot> hubot gsafe www.google.com
Hubot> [CLEAN] The URL is NOT curently listed as suspicious in Google Safebrowsing. More info: at http://www.google.com/safebrowsing/diagnostic?site=www.google.com
```

### Additional Scripts
Included is the ```hubot-vtr-downloader.sh``` shell script which downloads the following community developed Hubot scripts that may be useful for DFIR.

These may require their own configuration.

* Core
  * announce.coffee - Send messages to all chat rooms.
  * availability.coffee - Set your availability status so people know whether they're able to come over and chat with you or ping you over IM.
  * deadline.coffee - Tracks when stuff is due.
  * http-info.coffee - Returns title and description when links are posted.
  * isup.coffee - Uses downforeveryoneorjustme.com to check if a site is up.
  * news.coffee - Returns the latest news headlines from Google.
  * pypi.coffee - Simple Python Package Index querying using XMLRPC API.
  * sms.coffee - Allows Hubot to send text messages using Twilio API.
* Administrative Scripts
  * heroku-status.coffee - Show current Heroku status and issues.
  * ip.coffee - Return Hubot's external IP address (via jsonip.com).
  * reload.coffee - Allows Hubot to (re)load scripts without restart.
  * update.coffee - Allows hubot to update itself using git pull and npm update.
* Encoding
  * base36.coffee - Base36 encoding and decoding.
  * base58.coffee - Base58 encoding and decoding.
  * base64.coffee - Base64 encoding and decoding.

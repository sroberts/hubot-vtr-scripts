# Description:
#   Lookup SSL/TLS information for a given website.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot ssl - Looks up some SSL configuration information.
#
# Author:
#   Matt Johansen (@mattjay)

module.exports = (robot) ->
  robot.respond /ssl (.*)/i, (msg) ->

    url = msg.match[1].toLowerCase()
    lookup_url = "https://www.ssllabs.com/ssltest/analyze.html?d=#{encodeURIComponent(url)}&hideResults=on"

    msg.send "SSL Tester: #{lookup_url}"

# TODO: actually send a request and parse out some useful info to dump into the chat. Potentially use Rhodey.

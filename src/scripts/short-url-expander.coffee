# Description:
#   Expands short URLs
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot expand url <url> - Expands URL
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /expand url (.*)/i, (msg) ->
    short_url = msg.match[1].toLowerCase()

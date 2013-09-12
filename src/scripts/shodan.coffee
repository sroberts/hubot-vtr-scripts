# Description:
#   Search Shodan for a string
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shodan <string> - Search Shodan for any information about string
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /shodan (.*)/i, (msg) ->
    shodan_term = msg.match[1].toLowerCase()

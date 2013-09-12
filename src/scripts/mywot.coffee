# Description:
#   Get Website Reputation from MyWot (www.mywot.com)
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot mywot <url> - Gets MyWot Report for URL
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /mywot/i, (msg) ->
    # If there's strings generate rule with strings

    # If there aren't then just generate a template

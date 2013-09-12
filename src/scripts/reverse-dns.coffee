# Description:
#   Get domains associated with a specific IP Address
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot reverse dns <ip> - Gets domains associated with an IP
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /reverse dns (.*)/i, (msg) ->
    # Get reverse dns

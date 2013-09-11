# Description:
#   Generate Yara Rule with strings
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot yara - Generates default rule template
#   hubot yara "string1" "string2" ... - Generates rule with given strings
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /yara/i, (msg) ->
    # If there's strings generate rule with strings

    # If there aren't then just generate a template

# Description:
#   Check VirusTotal for Malware
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot virustotal <hash> - Searches VirusTotal for a hash
#
# Author:
#   Scott J Roberts - @sroberts

VIRUS_TOTAL_API_KEY = process.env.VIRUS_TOTAL_API_KEY

module.exports = (robot) ->
  robot.respond /virustotal (.*)/i, (msg) ->
    # If there's strings generate rule with strings

    # If there aren't then just generate a template

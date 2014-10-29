# Description:
#   PassiveTotal
#
# Dependencies:
#   None
#
# Configuration:
#   PASSIVETOTAL_KEY - Sign up at https://investigate.opendns.com
#
# Commands:
#   hubot ptotal <value> - Gets PassiveTotal Information for a given IP or domain
#
# Author:
#   Scott J Roberts - @sroberts

PASSIVETOTAL_KEY = process.env.PASSIVETOTAL_KEY

PASSIVETOTAL_API = "https://www.passivetotal.org"
PT_PASSIVE_URL =  PASSIVETOTAL_API + "/api/passive"


module.exports = (robot) ->
  robot.respond /ptotal (.*)/i, (msg) ->

    if PASSIVETOTAL_KEY?
      value = msg.match[1].toLowerCase()
      data = "apikey=#{encodeURIComponent PASSIVETOTAL_KEY}&value=#{encodeURIComponent value}"

      robot.http(PT_PASSIVE_URL)
        .post(data) (err, res, body) ->
          if res.statusCode is 200
            pt_json = JSON.parse(body)

            pt = pt_json.results

            response = "I checked out #{pt.type} #{pt.value}. Here's what I found:\n"
            response += "- Seen from #{pt.firstSeen} to #{pt.lastSeen}\n" if pt.firstSeen != "N/A" and pt.lastSeen != "N/A"
            response += "- It's in ASN #{pt.asn}\n" if +pt.asn > 0
            response += "- The ISP is #{pt.isp}\n" if pt.isp

            resolution = ""
            resolution += "  - #{res.resolve} #{res.tags}\n" for res in pt.resolutions

            response += "- Resolutions: \n" if resolution
            response += resolution

            response += "- Wow... that was a lot of resolutions!\n" if pt.resolutions > 10
            response += "- Users tagged this as #{pt.userTags}\n" if pt.userTags.length > 0
            response += "- #{res.value} is classifed as #{pt.classified}\n" if pt.classified
            response += "- Pretty sure it's a sinkhole though...\n" if pt.sinkhole is true
            response += "\nFor full results see https://www.passivetotal.org/passive/#{pt.value}"

            response = "No joy sparky, PassiveTotal didn't find any resolutions but feel free to check https://www.passivetotal.org/passive/#{pt.value}.\n" if pt.resolutions.length == 0

            msg.send response
          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "PassiveTotal API key not configured."

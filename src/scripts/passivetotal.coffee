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
#   hubot ptotal search <value> - Gets PassiveTotal Information for a given IP or domain
#   hubot ptotal classify <targeted|crime|multiple|benign> <value> - Classifies value
#   hubot ptotal tag add <tag> <value> - Adds tag to value
#   hubot ptotal tag remove <tag> <value> - Removes tag to value
#   hubot ptotal tag search <tag> - Returns all values with tag
#
# Author:
#   Scott J Roberts - @sroberts

PASSIVETOTAL_KEY = process.env.PASSIVETOTAL_KEY

PASSIVETOTAL_API = "https://www.passivetotal.org"
PT_PASSIVE_URL = PASSIVETOTAL_API + "/api/passive"
PT_CLASSIFY_URL = PASSIVETOTAL_API + "/api/classify"

PT_TAG_ADD_URL = PASSIVETOTAL_API + "/api/tag/add"
PT_TAG_REMOVE_URL = PASSIVETOTAL_API + "/api/tag/remove"
PT_TAG_SEARCH_URL = PASSIVETOTAL_API + "/api/tag/search"

module.exports = (robot) ->
  robot.respond /ptotal search (.*)/i, (msg) ->

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

  robot.respond /ptotal classify (targeted|crime|multiple|benign) (.*)/i, (msg) ->

    if PASSIVETOTAL_KEY?
      classification =  msg.match[1].toLowerCase()
      value = msg.match[2].toLowerCase()
      data = "apikey=#{encodeURIComponent PASSIVETOTAL_KEY}&classification=#{classification}&value=#{encodeURIComponent value}"

      robot.http(PT_CLASSIFY_URL)
        .post(data) (err, res, body) ->
          if res.statusCode is 200

            pt_json = JSON.parse(body)

            response = "Classifying #{value} as #{classification}: "
            response += ":+1:" if pt_json.success
            response += ":-1:" if !pt_json.success
            response += " Check out https://www.passivetotal.org/passive/#{value}."

            msg.send response
          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "PassiveTotal API key not configured."

  robot.respond /ptotal tag add (\w+) (.*)/i, (msg) ->

    if PASSIVETOTAL_KEY?
      tag =  msg.match[1].toLowerCase()
      value = msg.match[2].toLowerCase()
      data = "apikey=#{encodeURIComponent PASSIVETOTAL_KEY}&tag=#{encodeURIComponent tag}&value=#{encodeURIComponent value}"

      robot.http(PT_TAG_ADD_URL)
        .post(data) (err, res, body) ->

          if res.statusCode is 200
            response = "Totally just tagged #{value} as #{tag} in PassiveTotal. :metal: Check out https://www.passivetotal.org/passive/#{value}."

            msg.send response
          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "PassiveTotal API key not configured."

  robot.respond /ptotal tag remove (\w+) (.*)/i, (msg) ->

    if PASSIVETOTAL_KEY?
      tag =  msg.match[1].toLowerCase()
      value = msg.match[2].toLowerCase()
      data = "apikey=#{encodeURIComponent PASSIVETOTAL_KEY}&tag=#{encodeURIComponent tag}&value=#{encodeURIComponent value}"

      robot.http(PT_TAG_REMOVE_URL)
        .post(data) (err, res, body) ->
          if res.statusCode is 200
            response = "Yeah #{value} totally shouldn't be tagged as #{tag}. I removed it. Check out https://www.passivetotal.org/passive/#{value}."

            msg.send response
          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "PassiveTotal API key not configured."

  robot.respond /ptotal tag search (.*)/i, (msg) ->

    if PASSIVETOTAL_KEY?
      tag =  msg.match[1].toLowerCase()
      data = "apikey=#{encodeURIComponent PASSIVETOTAL_KEY}&tag=#{encodeURIComponent tag}"

      robot.http(PT_TAG_SEARCH_URL)
        .post(data) (err, res, body) ->
          if res.statusCode is 200
            pt_json = JSON.parse(body)

            response = "Looks like #{pt_json.results.length} results were tagged with #{tag}:\n"
            response += "- #{result.value}\n" for result in pt_json.results
            response += "\nThere are more details at https://www.passivetotal.org/tag/#{tag}"

            response = "Nothing tagged #{tag} found. But nice try!" if pt_json.results.length == 0

            msg.send response
          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "PassiveTotal API key not configured. You can get one at https://investigate.opendns.com."

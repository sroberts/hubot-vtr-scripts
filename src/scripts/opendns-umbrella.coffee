# Description:
#   OpenDNS Umbrella Passive DNS & Reputation
#
# Dependencies:
#   None
#
# Configuration:
#   OPENDNS_KEY - Sign up at https://investigate.opendns.com
#
# Commands:
#   hubot opendns <url> - Gets OpenDNS Domain Reputation
#   hubot opendns rr <ip> - Gets OpenDNS Resource Record history for a given IP
#   hubot opendns secinfo <domain> - Gets OpenDNS Security Information for a given domain
#
# Author:
#   Scott J Roberts - @sroberts

OPENDNS_KEY = process.env.OPENDNS_KEY
token = OPENDNS_KEY
opendns_base = "https://investigate.api.opendns.com/"

module.exports = (robot) ->
  robot.respond /opendns (.*)/i, (msg) ->

    if OPENDNS_KEY?
      artifact = msg.match[1].toLowerCase()

      msg.http("https://investigate.api.opendns.com/domains/score/#{artifact}")
        .headers('Authorization': 'Bearer ' + token)
        .get() (err, res, body) ->

          if res.statusCode is 200

            opendns_json = JSON.parse body

            for key, value of opendns_json

              switch value
                when "1" then msg.send "Yeah... #{key} seems ok. :+1:"
                when "0" then msg.send "Not sure about that #{key}. Use at your own risk."
                when "-1" then msg.send "That #{key} looks bad. It'll probably own your box. :-1:"
                else
                  "No clue. You're on your own."

          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "OpenDNS API key not configured."

module.exports = (robot) ->
  robot.respond /opendns rr (.*)/i, (msg) ->

    if OPENDNS_KEY?
      artifact = msg.match[1].toLowerCase()

      msg.http("https://investigate.api.opendns.com/dnsdb/ip/a/#{artifact}.json")
        .headers('Authorization': 'Bearer ' + OPENDNS_KEY)
        .get() (err, res, body) ->
          if res.statusCode is 200
            ##msg.send "Body #{body}"
            opendns_json = JSON.parse body

            if opendns_json.features.rr_count is "0"
              msg.send "No records found... "
            else
              response = "So I found #{opendns_json.features.rr_count} records:\n"
              for rrecord in opendns_json.rrs
                response += "- #{rrecord.type} Record: #{rrecord.rr}\n"

              msg.send response

          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "OpenDNS API key not configured."

module.exports = (robot) ->
  robot.respond /opendns secinfo (.*)/i, (msg) ->

    if OPENDNS_KEY?
      artifact = msg.match[1].toLowerCase()

      msg.http("https://investigate.api.opendns.com/security/name/#{artifact}.json")
        .headers('Authorization': 'Bearer ' + OPENDNS_KEY)
        .get() (err, res, body) ->
          if res.statusCode is 200

            opendns_json = JSON.parse body

            if opendns_json.found is true
              response = "Here is the OpenDNS security info about #{artifact}:\n"

              response += "- DGA score of #{opendns_json.dga_score}\," if opendns_json.dga_score is not 0
              response += "- The domain name has #{opendns_json.entropy} entropy\n"
              response += "- Google Pagerank score of #{opendns_json.pagerank}\n"
              response += "- SecureRank2 score of #{opendns_json.securerank2}\n"
              response += "- Popularity score of #{opendns_json.popularity}\n"
              response += "- It looks like it could be a FastFlux domain\n" if opendns_json.fastflux is true
              response += "- It's associate with #{opendns_json.dga_score} attacks\n" if opendns_json.attack
              response += "- The threat type is #{opendns_json.threat_type}\n" if opendns_json.threat_type

              msg.send response
            else
              msg.send "OpenDNS doesn't know about #{artifact}."
        else
          msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "OpenDNS API key not configured."

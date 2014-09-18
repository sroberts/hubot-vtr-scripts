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
              if value is "1"
                msg.send "Yeah... #{key} seems ok."
              if value is "0"
                msg.send "Not sure about that #{key}. Ask again later."
              if value is "-1"
                msg.send "That #{key} looks bad. It'll probably own your box. Probably."

            msg.send "THE END!"
          else
            msg.send "Doh! #{res.statusCode}: Which means that didn't work."
    else
      msg.send "OpenDNS API key not configured."

# Description:
#   Lookup a user on Pipl
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot pipl email <email_address> - Looks up a person on Pipl by email address
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /pipl email (.*)/i, (msg) ->


    target_email = msg.match[1].toLowerCase()

    request_url = "http://api.pipl.com/search/v3/json/?email=#{target_email}&exact_name=0&query_params_mode=and&key=samplekey"
    request_response = robot.http(request_url)

    .get() (err, res, body) ->
      msg.send JSON.parse(body)

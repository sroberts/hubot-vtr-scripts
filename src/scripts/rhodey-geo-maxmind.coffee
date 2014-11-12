# Description:
#   Geolocate an IP using Maxmind through Rhodey
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot maxmind <ip> - Gets MaxMind location associated with an IP
#
# Author:
#   Scott J Roberts - @sroberts

RHODEY_IP = process.env.RHODEY_IP
RHODEY_PORT = process.env.RHODEY_PORT

module.exports = (robot) ->
  robot.respond /maxmind (.*)/i, (msg) ->
    ip = msg.match[1]
    console.log("trying to get: #{RHODEY_IP}:#{RHODEY_PORT}" + "/ip/#{ip}/geo/maxmind.json")
    robot.http("http://#{RHODEY_IP}:#{RHODEY_PORT}" + "/ip/#{ip}/geo/maxmind.json")
      .get() (err, res, body) ->
        if res.statusCode is 200
          ipinfo_json = JSON.parse body
          msg.send "According to MaxMind I'm pretty sure #{ip} is in #{ipinfo_json['city']}, #{ipinfo_json['region']}, #{ipinfo_json['country_name']}."
        else
          msg.send "I couldn't access Rhodey(#{RHODEY_IP}:#{RHODEY_PORT}). Maybe this tells you something? Error Message: #{err}. Status Code: #{res.statusCode}"

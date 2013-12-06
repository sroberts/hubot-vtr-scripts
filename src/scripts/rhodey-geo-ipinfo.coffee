# Description:
#   Geolocate an IP using Ipinfo.io through Rhodey
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot geo <ip> - Gets location associated with an IP
#
# Author:
#   Scott J Roberts - @sroberts

RHODEY_IP = process.env.RHODEY_IP
RHODEY_PORT = process.env.RHODEY_PORT

module.exports = (robot) ->
  robot.respond /geo (.*)/i, (msg) ->
    ip = msg.match[1].toLowerCase()
    robot.http("{RHODEY_IP}:{RHODEY_PORT}" + "/ip/{ip}/geo/ipinfo.json")
      .get() (err, res, body) ->
        if res.statusCode is 200
          ipinfo_json = JSON.parse body
          msg.send "I'm pretty sure #{ip} is in #{ipinfo_json['city']}, #{ipinfo_json['region']}, #{ipinfo_json['country']}."
        else
          msg.send "Error: Couldn't access Rhodey({RHODEY_IP}:{RHODEY_PORT})."

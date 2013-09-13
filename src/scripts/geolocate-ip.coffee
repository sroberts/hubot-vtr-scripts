
# Description:
#   Geolocate an IP Address
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot geolocate <ip> - Geolocates IP
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /geolocate (.+)$/i, (msg) ->
    target_ip = msg.match[1].toLowerCase()
    request_string = robot.http("http://api.hostip.info/get_json.php?ip=#{target_ip}")

    .get() (err, res, body) ->
      msg.send "#{JSON.parse(body).ip} is from #{JSON.parse(body).city}, #{JSON.parse(body).country_name}."

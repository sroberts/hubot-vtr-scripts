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

api_url = "http://api.hostip.info"

module.exports = (robot) ->
  robot.respond /geolocate (.+)$/i, (msg) ->
    target_ip = msg.match[1].toLowerCase()
    request_url = api_url + "/get_json.php?ip=#{target_ip}"

    robot.http(request_url)
      .get() (err, res, body) ->
        if res.statusCode is 200
          geolocation_json = JSON.parse(body)
          msg.send "I'm pretty sure #{geolocation_json.ip} is from #{geolocation_json.city}, #{geolocation_json.country_name}."
        else
          msg.send "Something didn't work trying to geolocate#{target_ip} using #{api_url}. :frowning:"

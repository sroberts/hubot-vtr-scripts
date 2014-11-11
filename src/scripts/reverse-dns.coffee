# Description:
#   Get domains associated with a specific IP Address based on http://hackertarget.com/reverse-dns-lookup/
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot reverse dns <ip> - Gets domains associated with an IP
#
# Author:
#   Scott J Roberts - @sroberts

api_url = "http://api.hackertarget.com"

module.exports = (robot) ->
  robot.respond /reverse dns (.*)/i, (msg) ->
    ip = msg.match[1].toLowerCase()
    robot.http(api_url + "/reversedns/?q=#{ip}")
      .get() (err, res, body) ->
        if res.statusCode is 200
          msg.send "The Reverse DNS for #{ip} is #{body}"
        else
          msg.send "Error: Couldn't access #{api_url}. Error Message: #{err}. Status Code: #{res.statusCode}"

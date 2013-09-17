# Description:
#   Search Shodan based on https://developers.shodan.io/shodan-rest.html
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shodan <string> - Search Shodan for any information about string
#
# Author:
#   Scott J Roberts - @sroberts

SHODAN_KEY = process.env.SHODAN_KEY

shodan_url = "http://www.shodanhq.com/api/"

module.exports = (robot) ->
  robot.respond /shodan (.*)/i, (msg) ->
    shodan_term = msg.match[1].toLowerCase()

    robot.http(shodan_url + "/api/host?key=#{SHODAN_KEY}&ip=#{shodan_term}")
      #.query('ip': shodan_term, 'key': SHODAN_KEY)
      .get() (err, res, body) ->
        msg.send body
        msg.send res
        msg.send err

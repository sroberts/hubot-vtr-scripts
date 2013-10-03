# Description:
#   Expands short URLs based on http://longurl.org/api
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot expand url <url> - Expands URL
#
# Author:
#   Scott J Roberts - @sroberts

long_url = "http://api.longurl.org/v2/expand?format=json&all-redirects=1&title=1&url="

module.exports = (robot) ->
  robot.respond /expand url (.*)/i, (msg) ->
    short_url = msg.match[1]
    short_url_encoded = "#{encodeURIComponent short_url}"

    request_url = long_url + short_url_encoded
    msg.send request_url

    robot.http(request_url)
      .get() (err, res, body) ->
        longurl_json = JSON.parse body
        msg.send body

        long_url = longurl_json.longurl

        longurl_profile = """
        Title: #{longurl_json.title}
        URL: #{longurl_json["long-url"]}
        """

        msg.send longurl_profile

# Description:
#   Generate code names for things
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot codename - Generates a few potential codenames for you
#
# Author:
#   Scott J Roberts - @sroberts

api_url = "https://gist.githubusercontent.com"
request_url = api_url + "/sroberts/6529712/raw/1e979071f6a9e8747d2c44cf5af7c4998e068d49/wordlist"

module.exports = (robot) ->
  robot.respond /codename/i, (msg) ->
    robot.http(request_url)
      .get() (err, res, body) ->
        if res.statusCode is 200
          wordlist = body.split(",")
          msg.send """Codewords:
          - #{msg.random wordlist} #{msg.random wordlist}
          - #{msg.random wordlist} #{msg.random wordlist}
          - #{msg.random wordlist} #{msg.random wordlist}
          - #{msg.random wordlist} #{msg.random wordlist}
          - #{msg.random wordlist} #{msg.random wordlist}
          """
        else
          msg.send "Error: Couldn't access #{api_url}. Error Message: #{err}. Status Code: #{res.statusCode}"

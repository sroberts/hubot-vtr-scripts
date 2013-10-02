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
#   hubot yara - Generates default rule template
#   hubot yara "string1" "string2" ... - Generates rule with given strings
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /codename/i, (msg) ->
    robot.http("https://gist.github.com/sroberts/6529712/raw/1e979071f6a9e8747d2c44cf5af7c4998e068d49/wordlist")
      .get() (err, res, body) ->
        wordlist = body.split(",")
        msg.send """Codewords: \n
        - #{msg.random wordlist} #{msg.random wordlist}
        - #{msg.random wordlist} #{msg.random wordlist}
        - #{msg.random wordlist} #{msg.random wordlist}
        - #{msg.random wordlist} #{msg.random wordlist}
        - #{msg.random wordlist} #{msg.random wordlist}
        """

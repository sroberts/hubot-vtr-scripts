# Description:
#   Give some information on following Moscow Rules
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot what are the moscow rules - Prints Moscow Rules
#
# Author:
#   Scott J Roberts - @sroberts

moscow_rules = [
  "Any operation can be aborted. If it feels wrong, it is wrong.",
  "Assume nothing.",
  "Build in opportunity, but use it sparingly.",
  "Don't harass the opposition.",
  "Don't look back; you are never completely alone.",
  "Everyone is potentially under opposition control.",
  "Float like a butterfly, sting like a bee.",
  "Go with the flow, blend in.",
  "Keep your options open.",
  "Lull them into a sense of complacency.",
  "Maintain a natural pace.",
  "Murphy is right.",
  "Never go against your gut; it is your operational antenna.",
  "Pick the time and place for action.",
  "There is no limit to a human being's ability to rationalize the truth.",
  "Vary your pattern and stay within your cover.",
  "Once is an accident. Twice is coincidence. Three times is an enemy action."
]

module.exports = (robot) ->
  robot.respond /what are the moscow rules/i, (msg) ->
    msg.send "The Moscow Rules: "
    msg.send "- " + rule for rule in moscow_rules

  robot.respond /moscow rule/i, (msg) ->
    phrase = msg.random moscow_rules
    msg.send "Always remember: " + phrase

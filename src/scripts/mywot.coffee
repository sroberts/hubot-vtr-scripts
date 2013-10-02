# Description:
#   Get Website Reputation from MyWot (www.mywot.com)
#
# Dependencies:
#   None
#
# Configuration:
#   MYWOT_API_KEY -
#
# Commands:
#   hubot mywot <url> - Gets MyWot Report for URL
#
# Author:
#   Scott J Roberts - @sroberts

# mywot_categories = {
#   "101": "Malware or viruses",
#   "102": "Poor customer experience",
#   "103": "Phishing",
#   "104": "Scam",
#   "105": "Potentially illegal",
#   "201": "Misleading claims or unethical",
#   "202": "Privacy risks",
#   "203": "Suspicious",
#   "204": "Hate, discrimination",
#   "205": "Spam",
#   "206": "Potentially unwanted programs",
#   "207": "Ads / pop-ups",
#   "301": "Online tracking",
#   "302": "Alternative or controversial medicine",
#   "303": "Opinions, religion, politics",
#   "304": "Other",
#   "401": "Adult content",
# 	"402": "Incidental nudity",
#   "403": "Gruesome or shocking",
#   "404": "Site for kids",
#   "501": "Good site"
# }

MYWOT_API_KEY = process.env.MYWOT_API_KEY

mywot_url = "http://api.mywot.com/0.4/public_link_json2?key=#{MYWOT_API_KEY}&"

reputation = (number) ->
  rep = switch
    when number >= 80 then "Excellent"
    when number >= 60 then "Good"
    when number >= 40 then "Unsatisfactory"
    when number >= 20 then "Poor"
    when number >= 0 then "Very Poor"

  return rep


module.exports = (robot) ->
  robot.respond /mywot (.*)/i, (msg) ->
    mywot_term = msg.match[1].toLowerCase()

    msg.send "API URL: " + mywot_url + "hosts=#{mywot_term}/"

    robot.http(mywot_url + "hosts=#{mywot_term}/")
      .get() (err, res, body) ->

        mywot_json = JSON.parse body

        msg.send mywot_json[mywot_term][0]

        mywot_trustworthiness = mywot_json[mywot_term][0]
        mywot_childfriendliness = mywot_json[mywot_term][4]

        mywot_profile = "MyWot Result for #{mywot_term}\n---------------------------\n"

        mywot_profile += "- Trustworthiness: #{reputation(mywot_trustworthiness[0])} (Confidence: #{mywot_trustworthiness[1]}%)\n"
        mywot_profile += "- Child Safety:    #{reputation(mywot_childfriendliness[0])} (Confidence: #{mywot_childfriendliness[1]}%)\n"

        msg.send mywot_profile

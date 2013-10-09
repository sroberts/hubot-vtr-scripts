# Description:
#   Get Website Reputation from MyWot (www.mywot.com)
#
# Dependencies:
#   None
#
# Configuration:
#   MYWOT_API_KEY - Sign up at http://www.mywot.com/
#
# Commands:
#   hubot mywot <url> - Gets MyWot Report for URL
#
# Author:
#   Scott J Roberts - @sroberts

mywot_category_mapping = {
  101: "Malware or viruses",
  102: "Poor customer experience",
  103: "Phishing",
  104: "Scam",
  105: "Potentially illegal",
  201: "Misleading claims or unethical",
  202: "Privacy risks",
  203: "Suspicious",
  204: "Hate, discrimination",
  205: "Spam",
  206: "Potentially unwanted programs",
  207: "Ads / pop-ups",
  301: "Online tracking",
  302: "Alternative or controversial medicine",
  303: "Opinions, religion, politics",
  304: "Other",
  401: "Adult content",
  402: "Incidental nudity",
  403: "Gruesome or shocking",
  404: "Site for kids",
  501: "Good site"
}


MYWOT_API_KEY = process.env.MYWOT_API_KEY

api_url = "http://api.mywot.com"
request_url = api_url + "/0.4/public_link_json2?key=#{MYWOT_API_KEY}&"

reputation = (number) ->
  switch
    when number >= 80 then "Excellent"
    when number >= 60 then "Good"
    when number >= 40 then "Unsatisfactory"
    when number >= 20 then "Poor"
    when number >= 0 then "Very Poor"


module.exports = (robot) ->
  robot.respond /mywot (.*)/i, (msg) ->

    if MYWOT_API_KEY?

      mywot_term = msg.match[1].toLowerCase()

      robot.http(request_url + "hosts=#{mywot_term}/")
        .get() (err, res, body) ->

          mywot_json = JSON.parse body

          if mywot_json[mywot_term][0] == undefined
            mywot_profile = "No MyWOT information found for #{mywot_term}"

          else
            mywot_trustworthiness = mywot_json[mywot_term][0]
            mywot_childfriendliness = mywot_json[mywot_term][4]
            mywot_categories = mywot_json[mywot_term]["categories"]

            mywot_profile = """MyWot Result for #{mywot_term}
            ---------------------------
            - Trustworthiness: #{reputation(mywot_trustworthiness[0])} (Confidence: #{mywot_trustworthiness[1]}%)
            - Child Safety:    #{reputation(mywot_childfriendliness[0])} (Confidence: #{mywot_childfriendliness[1]}%)
            - Categories: """

            for key, value of mywot_categories
              mywot_profile += "\n  - #{mywot_category_mapping[key]} (Confidence: #{value}%)"

          msg.send mywot_profile

    else
      msg.send "Error: MyWoT API key not configured. Get one at http://www.mywot.com/"

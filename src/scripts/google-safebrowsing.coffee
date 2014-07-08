# Description:
#   Get Website Report from Google Safebrowsing (https://developers.google.com/safe-browsing)
#
# Dependencies:
#   None
#
# Configuration:
#   GOOGLE_SAFEBROWSING_API_KEY - Sign up at https://developers.google.com/safe-browsing/key_signup
#
# Commands:
#   hubot gsafe <url> - Gets Google Safebrowsing Report for URL
#
# Author:
#   A. Gianotto - @snipe

GOOGLE_SAFEBROWSING_API_KEY = process.env.GOOGLE_SAFEBROWSING_API_KEY

module.exports = (robot) ->
  robot.respond /gsafe (.*)/i, (msg) ->

    if GOOGLE_SAFEBROWSING_API_KEY?
    
      gsafe_term = msg.match[1].toLowerCase()
        
      api_url = "https://sb-ssl.google.com"
      request_url = api_url
      request_url += "/safebrowsing/api/lookup"
      request_url += "?client=api&apikey=#{GOOGLE_SAFEBROWSING_API_KEY}&appver=1.5&pver=3.1&"
      request_url += "url=#{encodeURIComponent gsafe_term}"

      robot.http(request_url)
        .get() (err, res, body) ->
        
          if res.statusCode is 200
            msg.send "[SUSPICIOUS] The URL #{gsafe_term} is listed as #{body} in Google Safebrowsing. More info: at http://www.google.com/safebrowsing/diagnostic?site=#{encodeURIComponent gsafe_term}"
          else
             msg.send "[CLEAN] The URL #{gsafe_term} is NOT curently listed as suspicious in Google Safebrowsing. More info: at http://www.google.com/safebrowsing/diagnostic?site=#{encodeURIComponent gsafe_term}"

    else
    	msg.send "Error: Google SafeBrowsing API key not configured. Get one at https://developers.google.com/safe-browsing/key_signup"

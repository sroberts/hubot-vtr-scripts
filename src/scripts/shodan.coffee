# Description:
#   Search Shodan based on https://developers.shodan.io/shodan-rest.html
#
# Dependencies:
#   None
#
# Configuration:
#   SHODAN_API_KEY - Sign up at http://www.shodanhq.com/api_doc
#
# Commands:
#   hubot shodan <string> - Search Shodan for any information about string
#
# Author:
#   Scott J Roberts - @sroberts

SHODAN_API_KEY = process.env.SHODAN_API_KEY

api_url = "https://api.shodan.io"

module.exports = (robot) ->
  robot.respond /shodan (.*)/i, (msg) ->

    if SHODAN_API_KEY?
      shodan_term = msg.match[1].toLowerCase()

      # request_url = api_url + "/api/host?key=#{SHODAN_API_KEY}&ip=#{shodan_term}"
      request_url = api_url + "/shodan/host/search?key=#{SHODAN_API_KEY}&query=#{shodan_term}" # &facets={facets}"

      robot.http(request_url)
        .get() (err, res, body) ->

          if res.statusCode is 200
            shodan_json = JSON.parse body
            shodan_link = "https://www.shodan.io/search?query=#{shodan_term}"

            if shodan_json.error
              shodan_profile = "No Shodan information found for #{shodan_term}"

            else

              if shodan_json.total > 10
                msg.send "That's gonna be a bunch of data, you might want to go check it out on Shodan.io"
              else

                response = "Yeah ok... here's what Shodan knows about #{shodan_term}:"

                for match in shodan_json.matches
                  response += "\n- #{match.title} (#{match.ip_str}) ASN: #{match.asn}  ISP: #{match.isp}  \n"
                  response += "\t- Hostnames:\n"
                  for hostname in match.hostnames
                    response += "\t\t#{hostname}\n"
                  response += "\t- Domains:\n"
                  for domain in match.domains
                    response += "\t\t#{domain}\n"


                response += "\nOr you can just go to #{shodan_link}"

                msg.send response

          else
            msg.send "Error: Couldn't access #{api_url}. Error Message: #{err}. Status Code: #{res.statusCode}"

    else
        msg.send "Shodan API key not configured. Get one at http://www.shodanhq.com/api_doc"

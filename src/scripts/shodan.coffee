# Description:
#   Search Shodan based on https://developers.shodan.io/shodan-rest.html
#
# Dependencies:
#   None
#
# Configuration:
#   SHODAN_API_KEY
#
# Commands:
#   hubot shodan <string> - Search Shodan for any information about string
#
# Author:
#   Scott J Roberts - @sroberts

SHODAN_KEY = process.env.SHODAN_API_KEY

api_url = "http://www.shodanhq.com"

module.exports = (robot) ->
  robot.respond /shodan (.*)/i, (msg) ->

    if SHODAN_KEY?
      shodan_term = msg.match[1].toLowerCase()

      request_url = api_url + "/api/host?key=#{SHODAN_KEY}&ip=#{shodan_term}"

      robot.http(request_url)
        #.query('ip': shodan_term, 'key': SHODAN_KEY)
        .get() (err, res, body) ->

          if res.statusCode is 200
            shodan_json = JSON.parse body

            if shodan_json.error
              shodan_profile = "No Shodan information found for #{shodan_term}"

            else

              shodan_profile = """Shodan Result for #{shodan_term}
              --------------------------------------------
              - IP:  #{shodan_json.ip}
              - Geo: #{shodan_json.city}, #{shodan_json.region_name}, #{shodan_json.country_name}

              """

              for host in shodan_json.data
                banner_array = host.banner.split "\r\n"

                banner_string = ""
                banner_string += " - #{banner_item}\n" for banner_item in banner_array when banner_item != ''
                shodan_profile += "\n~ #{host.ip}\n------\n- Hostname:     #{host.hostnames.toString()}\n- Organization: #{host.org}\n- Port:         #{host.port}\n- Banner:       \n#{banner_string}"

            msg.send shodan_profile
          else
            msg.send "Error: Couldn't access #{api_url}."

    else
        msg.send "Shodan API key not configured. Get one at http://www.shodanhq.com/api_doc"

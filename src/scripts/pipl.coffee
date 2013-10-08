# Description:
#   Lookup a user on Pipl
#
# Dependencies:
#   None
#
# Configuration:
#   PIPL_API_KEY - Sign up at http://dev.pipl.com/
#
# Commands:
#   hubot pipl email <email_address> - Looks up a person on Pipl by email address
#
# Author:
#   Scott J Roberts - @sroberts

PIPL_API_KEY = process.env.PIPL_API_KEY

api_url = "http://api.pipl.com"

module.exports = (robot) ->
  robot.respond /pipl email (.*)/i, (msg) ->

    if PIPL_API_KEY?
      target_email = msg.match[1].toLowerCase()

      request_url = api_url + "/search/v3/json/?email=#{encodeURIComponent target_email}&exact_name=0&query_params_mode=and&key=#{PIPL_API_KEY}"

      request_response = robot.http(request_url)
        .get() (err, res, body) ->

          if res.statusCode is 200
            pipl_json = JSON.parse(body)

            person_sources = "Person:\n"
            records_source = "Records:\n"

            if pipl_json.error?
              msg.send "Pipl Error: #{pipl_json.error}"
            else
              ## person
              if pipl_json.person.sources?
                person_sources += """ - #{person_source.name}:   #{person_source.url}\n""" for person_source in pipl_json.person.sources
              else
                person_sources += """ - No information found.\n"""


              ## related_urls (really noisy)
              # for related_url in pipl_json.related_urls
              #   msg.send related_url

              ## records
              if pipl_json.records?
                records_source += """ - #{record.source.name}: #{record.source.url}\n""" for record in pipl_json.records
              else
                records_source += """ - No information found.\n"""

              pipl_summary = """
              Pipl Profile for Email: #{target_email}
              ------------------------------------------------
              Total Records: #{pipl_json["@records_count"]}

              #{person_sources}
              #{records_source}
              """

              msg.send pipl_summary
          else
            msg.send "Error: Couldn't access #{api_url}."

    else
      msg.send "Pipl API key not configured. Get one at http://dev.pipl.com/"

# Description:
#   Lookup a user on Pipl
#
# Dependencies:
#   None
#
# Configuration:
#   PIPL_API_KEY
#
# Commands:
#   hubot pipl email <email_address> - Looks up a person on Pipl by email address
#
# Author:
#   Scott J Roberts - @sroberts

PIPL_API_KEY = process.env.PIPL_API_KEY

module.exports = (robot) ->
  robot.respond /pipl email (.*)/i, (msg) ->

    target_email = msg.match[1].toLowerCase()

    request_url = "http://api.pipl.com/search/v3/json/?email=#{encodeURIComponent target_email}&exact_name=0&query_params_mode=and&key=#{PIPL_API_KEY}"

    #msg.send request_url + "&pretty=true" #foar great debugging!

    request_response = robot.http(request_url)

    .get() (err, res, body) ->
      pipl_json = JSON.parse(body)

      person_sources = ""
      records_source = ""

      ## person
      person_sources += """#{person_source.name}:   #{person_source.url}\n""" for person_source in pipl_json.person.sources


      ## related_urls
      # for related_url in pipl_json.related_urls
      #   msg.send related_url

      ## records
      #records_source """#{record.source.name}: #{record.source.url}\n""" for record in pipl_json.records

      pipl_summary = """
      Pipl Profile for Email: #{target_email}
      ------------------------------------------------
      Total Records: #{pipl_json["@records_count"]}

      Person Records:
      #{person_sources}

      """

      msg.send pipl_summary

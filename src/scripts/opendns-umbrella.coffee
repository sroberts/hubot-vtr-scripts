# Description:
#   OpenDNS Umbrella Passive DNS & Reputation
#
# Dependencies:
#   None
#
# Configuration:
#   OPENDNS_KEY - Sign up at https://investigate.opendns.com
#
# Commands:
#   hubot opendns <url> - Gets OpenDNS Domain Reputation
#
# Author:
#   Scott J Roberts - @sroberts

VIRUSTOTAL_API_KEY = process.env.OPENDNS_KEY
opendns_base = "https://investigate.api.opendns.com/"

module.exports = (robot) ->
  robot.respond /opendns (.*)/i, (msg) ->

    if OPENDNSKEY_KEY?
      msg.send "#{OPENDNS_KEY}"
    #   hash = msg.match[1].toLowerCase()
    #   data = "apikey=#{encodeURIComponent VIRUSTOTAL_API_KEY}&resource=#{encodeURIComponent hash}"
    #
    #   robot.http(vt_file_report_url)
    #     .post(data) (err, res, body) ->
    #       if res.statusCode is 200
    #         vt_json = JSON.parse(body)
    #
    #         if vt_json.response_code == 1
    #           summary = """VirusTotal Result: #{vt_json.resource}
    #           - Scanned at: #{vt_json.scan_date}
    #           - Results:    #{vt_json.positives}/#{vt_json.total}
    #           - Link:       #{vt_json.permalink}
    #           """
    #
    #           msg.send summary
    #
    #         else
    #           msg.send "VirusTotal URL Analysis: #{vt_json.verbose_msg}"
    #       else
    #         msg.send "Error: Couldn't access #{vt_url}."
    else
      msg.send "OpenDNS API key not configured."

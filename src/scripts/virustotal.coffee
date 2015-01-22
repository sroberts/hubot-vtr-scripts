# Description:
#   Check VirusTotal for Malware
#
# Dependencies:
#   None
#
# Configuration:
#   VIRUSTOTAL_API_KEY - Sign up at https://www.virustotal.com/en/documentation/public-api/
#
# Commands:
#   hubot virustotal hash <hash> - Searches VirusTotal for a hash
#   hubot virustotal url <url> - Searches VirusTotal for a url
#   hubot virustotal ip <ip> - Searches VirusTotal for a ip address
#
# Author:
#   Scott J Roberts - @sroberts

VIRUSTOTAL_API_KEY = process.env.VIRUSTOTAL_API_KEY
vt_url = "https://www.virustotal.com"

vt_file_report_url = vt_url + "/vtapi/v2/file/report"
vt_url_report_url = vt_url + "/vtapi/v2/url/report"
vt_ip_report_url = vt_url + "/vtapi/v2/ip-address/report"

module.exports = (robot) ->
  robot.respond /virustotal hash (.*)/i, (msg) ->

    if VIRUSTOTAL_API_KEY?
      hash = msg.match[1].toLowerCase()
      data = "apikey=#{encodeURIComponent VIRUSTOTAL_API_KEY}&resource=#{encodeURIComponent hash}"

      robot.http(vt_file_report_url)
        .post(data) (err, res, body) ->
          if res.statusCode is 200
            vt_json = JSON.parse(body)

            if vt_json.response_code == 1
              summary = """Here's what VirusTotal knows about #{hash}:
              - Scanned at: #{vt_json.scan_date}
              - Results:    #{vt_json.positives}/#{vt_json.total}
              - Link:       #{vt_json.permalink}
              """

              msg.send summary

            else
              msg.send "VirusTotal URL Analysis: #{vt_json.verbose_msg}"
          else
            msg.send "Gah, couldn't get to #{vt_url}."
    else
      msg.send "VirusTotal API key not configured. Get one at https://www.virustotal.com/en/user/ in the API tab"

  robot.respond /virustotal url (.*)/i, (msg) ->

    if VIRUSTOTAL_API_KEY?
      url = msg.match[1].toLowerCase()
      data = "apikey=#{encodeURIComponent VIRUSTOTAL_API_KEY}&resource=#{encodeURIComponent url}"

      robot.http(vt_url_report_url)
        .post(data) (err, res, body) ->

          if res.statusCode is 200
            vt_json = JSON.parse(body)

            if vt_json.response_code == 1
              summary = """Here's what VirusTotal knows about #{url}:
              - Scanned at: #{vt_json.scan_date}
              - Results:    #{vt_json.positives}/#{vt_json.total}
              - Link:       #{vt_json.permalink}
              """

              msg.send summary

            else
              msg.send "VirusTotal URL Analysis: #{vt_json.verbose_msg}"

          else
            msg.send "Gah, couldn't get to #{vt_url}. Maybe this helps? Error Message: #{err}. Status Code: #{res.statusCode}"


    else
      msg.send "VirusTotal API key not configured. Get one at https://www.virustotal.com/en/user/ in the API tab"

  robot.respond /virustotal ip (.*)/i, (msg) ->
    if VIRUSTOTAL_API_KEY?
      ip = msg.match[1].toLowerCase()

      robot.http(vt_ip_report_url)
        .query("apikey": VIRUSTOTAL_API_KEY, "ip": ip)
          .get() (err, res, body) ->
            if res.statusCode is 200
              vt_json = JSON.parse(body)

              if vt_json.response_code == 1

                summary = """Here's what VirusTotal knows about #{ip}:
                - Passive DNS replications:       #{vt_json.resolutions.length}
                - Detected URLs:                  #{vt_json.detected_urls.length}
                - Link:                           https://www.virustotal.com/en/ip-address/#{ip}/information/
                """

                msg.send summary

              else
                msg.send vt_json.verbose_msg

            else
              msg.send "Gah, couldn't get to #{vt_url}."
    else
      msg.send "VirusTotal API key not configured. Get one at https://www.virustotal.com/en/user/ in the API tab"

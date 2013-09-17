# Description:
#   Check VirusTotal for Malware
#
# Dependencies:
#   None
#
# Configuration:
#   VIRUS_TOTAL_API_KEY environment variable needs to be set with your API key https://www.virustotal.com/en/documentation/public-api/
#
# Commands:
#   hubot virustotal hash <hash> - Searches VirusTotal for a hash
#   hubot virustotal url <hash> - Searches VirusTotal for a url
#   hubot virustotal ip <hash> - Searches VirusTotal for a ip address
#
# Author:
#   Scott J Roberts - @sroberts

VIRUS_TOTAL_API_KEY = process.env.VIRUS_TOTAL_API_KEY
vt_url = "https://www.virustotal.com"

vt_file_report_url = vt_url + "/vtapi/v2/file/report"
vt_url_report_url = vt_url + "/vtapi/v2/url/report"
vt_ip_report_url = vt_url + "/vtapi/v2/ip-address/report"

module.exports = (robot) ->
  robot.respond /virustotal hash (.*)/i, (msg) ->
    hash = msg.match[1].toLowerCase()
    data = "apikey=#{encodeURIComponent VIRUS_TOTAL_API_KEY}&resource=#{encodeURIComponent hash}"

    robot.http(vt_file_report_url)
      .post(data) (err, res, body) ->
        vt_json = JSON.parse(body)

        if vt_json.response_code == 1
          summary = """ VirusTotal Result: #{vt_json.resource}
          - Scanned at: #{vt_json.scan_date}
          - Results:    #{vt_json.positives}/#{vt_json.total}
          - Link:       #{vt_json.permalink}
          """

          msg.send summary

        else
          msg.send "VirusTotal URL Analysis: #{vt_json.verbose_msg}"

  robot.respond /virustotal url (.*)/i, (msg) ->
    url = msg.match[1].toLowerCase()

    data = "apikey=#{encodeURIComponent VIRUS_TOTAL_API_KEY}&resource=#{encodeURIComponent url}"

    robot.http(vt_url_report_url)
      .post(data) (err, res, body) ->
        vt_json = JSON.parse(body)

        if vt_json.response_code == 1
          summary = """ VirusTotal URL Result: #{vt_json.url}
          - Scanned at: #{vt_json.scan_date}
          - Results:    #{vt_json.positives}/#{vt_json.total}
          - Link:       #{vt_json.permalink}
          """

          msg.send summary

        else
          msg.send "VirusTotal URL Analysis: #{vt_json.verbose_msg}"


  #robot.respond /virustotal ip (.*)/i, (msg) ->
    #ip = msg.match[1].toLowerCase()

    #robot.http(vt_ip_report_url)
      #.query("apikey": VIRUS_TOTAL_API_KEY, "ip": ip)
      #.get() (err, res, body) ->
        #vt_json = JSON.parse(body)

        #if vt_json.response_code == 1

          #console.log(vt_json.resolutions)
          # for resolution in vt_json.resolutions
          #   console.log("#{resolution}")

          #console.log(vt_json.detected_urls)
          # for detected_url in vt_json.detected_urls
          #   console.log("#{detected_url}")

          # summary = """ VirusTotal IP Result: #{ip}
          # - Scanned at: #{vt_json.scan_date}
          # - Results:    #{vt_json.positives}/#{vt_json.total}
          # - Link:       #{vt_json.permalink}
          # """

          #msg.send summary

        #else
          #msg.send vt_json.verbose_msg

# Description:
#   Check VirusTotal for Malware
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot virustotal <hash> - Searches VirusTotal for a hash
#
# Author:
#   Scott J Roberts - @sroberts

VIRUS_TOTAL_API_KEY = process.env.VIRUS_TOTAL_API_KEY
vt_file_report_url = "https://www.virustotal.com/vtapi/v2/file/report"

module.exports = (robot) ->
  robot.respond /virustotal (.*)/i, (msg) ->
    # First paramater is the file hash to look for
    search_resource = msg.match[1].toLowerCase()

    parameters = {
      "apikey": VIRUS_TOTAL_API_KEY,
      "resource": search_resource
    }

    data = "apikey=#{encodeURIComponent VIRUS_TOTAL_API_KEY}&resource=#{encodeURIComponent search_resource}"

    robot.http(vt_file_report_url)
      .post(data) (err, res, body) ->
        vt_json = JSON.parse(body)

        summary = """ VirusTotal Result: #{vt_json.resource}
        - Scanned at: #{vt_json.scan_date}
        - Results:    #{vt_json.positives}/#{vt_json.total}
        - Link:       #{vt_json.permalink}
        """

        msg.send summary

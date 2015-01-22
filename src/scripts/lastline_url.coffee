# Description:
#   Messing around with the Lastline API.
#
# Commands:
#   hubot lastline url <url including http://> - searches or submits a URL to lastline for analysis.
lastline_key = "#{process.env.LASTLINE_KEY}"
lastline_api_token = "#{process.env.LASTLINE_TOKEN}"
lastline_user_domain = "#{process.env.LASTLINE_USER_DOMAIN}"
lastline_analysis_domain = "#{process.env.LASTLINE_ANALYSIS_DOMAIN}"

sleep = (ms) ->
   start = new Date().getTime()
   continue while new Date().getTime() - start < ms

module.exports = (robot) ->
  robot.respond /(lastline) (url) ([^ ]*)?( referer [^ ]*)?( ua [^ ]*)?/i, (msg) ->

    url = msg.match[3]
    referer = if msg.match[4] then msg.match[4].split(" ")[2] else ''
    user_agent = if msg.match[5] then msg.match[5].split(" ")[2] else ''
    stringData = "key=#{encodeURIComponent lastline_key}&api_token=#{encodeURIComponent lastline_api_token}&url=#{encodeURIComponent url}#{if msg.match[4] then msg.match[4].split(' ')[1]+'=' else ''}#{if msg.match[4] then msg.match[4].split(' ')[2] else ''}#{if msg.match[5] then msg.match[5].split(' ')[1]+'=' else ''}#{if msg.match[5] then msg.match[5].split(' ')[2] else ''}"

    robot.http("https://#{lastline_analysis_domain}/analysis/submit/url")
      .headers('Content-Type': 'application/x-www-form-urlencoded')
      .post(stringData) (err, res, body) ->

        results = JSON.parse(body)

        if (results.data.score == undefined) then msg.send "So, Lastline doesn't know about that URL yet. I'll be back to you in about 2 minutes."
        if (results.data.score == undefined) then sleep 120000

        robot.http("https://#{lastline_analysis_domain}/analysis/submit/url")
          .headers('Content-Type': 'application/x-www-form-urlencoded')
          .post(stringData) (err, res, body) ->

            final_result = JSON.parse(body)

            if (results.data.score == undefined) then
              msg.send "Are you sure that domain resolves? Also, we don't support file submissions via url; we're looking for browser exploits."
            else if final_result.data.score < 30 then
              msg.send "No worries, bro, #{url} doesn't seem to have any browser exploits."
            else msg.send "Man, that #{url} is badness. We found #{final_result.data.malicious_activity} in there."

            msg.send "Check out https://#{lastline_user_domain}/malscape/#/task/#{results.data.task_uuid} for details"
            return

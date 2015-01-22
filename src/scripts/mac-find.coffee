# Description:
#   Lookup mac address vendor.
#
# Dependencies:
#   cheerio
#
# Configuration:
#   None
#
# Commands:
#   hubot mac-find - Finds the vendor of a mac address.
#
# Author:
#   Patrick Connolly (@patcon)

module.exports = (robot) ->
  robot.respond /mac-find (([0-9A-F]{2}[:-]){5}[0-9A-F]{2})$/i, (msg) ->
    mac_address = msg.match[1]
    request_url = "http://www.coffer.com/mac_find/?string=#{encodeURIComponent(mac_address)}"

    robot.http(request_url)
      .get() (err, res, body) ->
        if res.statusCode is 200
          cheerio = require 'cheerio'
          $ = cheerio.load body

          vendors = []
          $('table.table2 tr').slice(1).each (i, html) ->
            # Each non-header row.
            vendor = $(html).children().last().text()
            vendors.push vendor if vendors.indexOf(vendor) == -1
          msg.send "So the vendors for that MAC could be #{vendors}."
        else
          msg.send "Error: Couldn't access coffer.com. Error Message: #{err}. Status Code: #{res.statusCode}"

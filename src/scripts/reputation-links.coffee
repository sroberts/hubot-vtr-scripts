# Description:
#   Generate links for doing IP/URL research
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot reputation ip <ip> - Generates links to research an IP
#   hubot reputation url <url> - Generates links to research an URL
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /reputation ip ((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))/i, (msg) ->

    target_ip = msg.match[1].toLowerCase()

    reputation_links = """#{target_ip} IP Reputation:
    - Robtex:     https://ip.robtex.com/#{target_ip}.html
    - CentralOps: http://centralops.net/co/DomainDossier.aspx?addr=#{target_ip}&dom_dns=1&dom_whois=1&net_whois=1
    - IPVoid:     http://www.ipvoid.com/scan/#{target_ip}/
    - HE:         http://bgp.he.net/ip/#{target_ip}#_whois
    - SANS ISC:   https://isc.sans.edu/api/ip/#{target_ip}
    """

    msg.send reputation_links

  robot.respond /reputation url (.*)/i, (msg) ->
    target_url = msg.match[1].toLowerCase()

    reputation_links = """#{target_url} URL Reputation:
    - Robtext:    https://pop.robtex.com/#{target_url}.html
    - CentralOps: http://centralops.net/co/DomainDossier.aspx?addr=#{target_url}&dom_whois=true&dom_dns=true&net_whois=true
    - URLVoid:    http://www.urlvoid.com/scan/#{target_url}/
    - HE:         http://bgp.he.net/dns/#{target_url}#_whois
    """

    msg.send reputation_links

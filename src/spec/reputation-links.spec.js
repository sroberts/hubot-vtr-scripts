/**
 * Created by mattjohansen on 11/19/13.
 */

var reputation = require('../scripts/reputation-links.coffee');

describe('reputation', function() {
  var robot = null;

  beforeEach(function(){
    robot = {
      respond: function(regex, callback){},
    }
    spyOn(robot, 'respond')//.andCallThrough();

    reputation(robot);
  });

  it('should be a function', function(){
    expect(typeof(reputation)).toBe('function');
  });

  it('should respond correctly when passed an IP', function() {
    var msg = {
      match: 'reputation ip 1.2.3.4'.match(robot.respond.calls[0].args[0]),
      send: function() {}
    }
    spyOn(msg, 'send');

    expect(robot.respond).toHaveBeenCalled();
    robot.respond.calls[0].args[1](msg);
    expect(msg.send).toHaveBeenCalled();
    expect(msg.send.mostRecentCall.args[0]).toBeDefined();
    var singleline = msg.send.mostRecentCall.args[0].replace(/\n/g, ' ')
    expect(singleline).toBe('1.2.3.4 IP Reputation: - Robtex:     https://ip.robtex.com/1.2.3.4.html - CentralOps: http://centralops.net/co/DomainDossier.aspx?addr=1.2.3.4&dom_dns=1&dom_whois=1&net_whois=1 - IPVoid:     http://www.ipvoid.com/scan/1.2.3.4/ - HE:         http://bgp.he.net/ip/1.2.3.4#_whois - SANS ISC:   https://isc.sans.edu/api/ip/1.2.3.4')
  });

  it('should respond correctly when passed a URL', function() {
    var msg = {
      match: 'reputation url www.google.com'.match(robot.respond.calls[1].args[0]),
      send: function() {}
    }
    spyOn(msg, 'send');

    expect(robot.respond).toHaveBeenCalled();
    robot.respond.calls[1].args[1](msg);
    expect(msg.send).toHaveBeenCalled();
    expect(msg.send.mostRecentCall.args[0]).toBeDefined();
    var singleline = msg.send.mostRecentCall.args[0].replace(/\n/g, ' ')
    expect(singleline).toBe('www.google.com URL Reputation: - Robtext:    https://pop.robtex.com/www.google.com.html - CentralOps: http://centralops.net/co/DomainDossier.aspx?addr=www.google.com&dom_whois=true&dom_dns=true&net_whois=true - URLVoid:    http://www.urlvoid.com/scan/www.google.com/ - HE:         http://bgp.he.net/dns/www.google.com#_whois')
  });

});
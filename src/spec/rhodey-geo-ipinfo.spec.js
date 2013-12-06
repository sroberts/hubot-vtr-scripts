/**
 * Created by mattjohansen on 12/6/13.
 */

var rhodeyIP = require('../scripts/rhodey-geo-ipinfo.coffee');
var HttpClient = require('scoped-http-client');

describe('Rhodey IPInfo Lookup', function() {
  var robot, msg = null;

  beforeEach(function(){
    robot = {
      respond: function(regex, callback){},
      http: function(url){}
    }
    spyOn(robot, 'respond').andCallThrough();
    spyOn(robot, 'http').andCallFake(function(){
      var url = robot.http.mostRecentCall.args[0];
      var client = HttpClient.create(url);
      spyOn(client, 'get').andReturn(function(){});
      return client
    });
    rhodeyIP(robot);
    msg = {
      match: 'geo 1.2.3.4'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
  });

  it('should be a function', function(){
    expect(typeof(rhodeyIP)).toBe('function');
  });

  it('should generate the correct URL', function() {
    expect(robot.respond).toHaveBeenCalled();
    robot.respond.mostRecentCall.args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('http://'+process.env.RHODEY_IP+':'+process.env.RHODEY_PORT+'/ip/1.2.3.4/geo/ipinfo.json');
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
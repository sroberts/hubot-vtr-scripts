/**
 * Created by mattjohansen on 12/6/13.
 */

var rhodeyMaxMind = require('../scripts/rhodey-geo-maxmind.coffee');
var HttpClient = require('scoped-http-client');

describe('Rhodey MaxMind Lookup', function() {
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
    rhodeyMaxMind(robot);
    msg = {
      match: 'maxmind 1.2.3.4'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
  });

  it('should be a function', function(){
    expect(typeof(rhodeyMaxMind)).toBe('function');
  });

  it('should generate the correct URL', function() {
    expect(robot.respond).toHaveBeenCalled();
    robot.respond.mostRecentCall.args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('http://'+process.env.RHODEY_IP+':'+process.env.RHODEY_PORT+'/ip/1.2.3.4/geo/maxmind.json');
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
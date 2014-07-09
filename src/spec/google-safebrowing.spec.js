/**
 * Created by mattjohansen on 11/19/13.
 */

var gsafe = require('../scripts/google-safebrowsing.coffee');
var HttpClient = require('scoped-http-client');

describe('gsafe', function() {
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
    gsafe(robot);
    msg = {
      match: 'gsafe www.google.com'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
  });

  it('should be a function', function(){
    expect(typeof(gsafe)).toBe('function');
  });

  it('should generate the correct URL', function() {
    expect(robot.respond).toHaveBeenCalled();
    robot.respond.mostRecentCall.args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('http://api.gsafe.com/0.4/public_link_json2?key='+process.env.gsafe_API_KEY+'&hosts=www.google.com/')
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
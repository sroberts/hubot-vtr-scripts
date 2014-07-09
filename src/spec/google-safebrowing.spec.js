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
    expect(robot.http.mostRecentCall.args[0]).toBe('https://sb-ssl.google.com/safebrowsing/api/lookup?client=api&apikey='+process.env.GOOGLE_SAFEBROWSING_API_KEY+'&appver=1.5&pver=3.1&url=www.google.com')
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
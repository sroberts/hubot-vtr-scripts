/**
 * Created by mattjohansen on 11/19/13.
 */

var shodan = require('../scripts/shodan.coffee');
var HttpClient = require('scoped-http-client');

describe('Shodan', function() {
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
    shodan(robot);
    msg = {
      match: 'shodan 1.2.3.4'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
  });

  it('should be a function', function(){
    expect(typeof(shodan)).toBe('function');
  });

  it('should generate the correct URL', function() {
    expect(robot.respond).toHaveBeenCalled();
    robot.respond.mostRecentCall.args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('http://www.shodanhq.com/api/host?key='+process.env.SHODAN_API_KEY+'&ip=1.2.3.4')
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
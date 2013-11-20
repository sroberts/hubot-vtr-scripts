/**
 * Created by mattjohansen on 11/19/13.
 */

var reverse = require('../scripts/reverse-dns.coffee');
var HttpClient = require('scoped-http-client');

describe('reverse dns', function() {
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
    reverse(robot);
    msg = {
      match: 'reverse dns 1.2.3.4'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
  });

  it('should be a function', function(){
    expect(typeof(reverse)).toBe('function');
  });

  it('should generate the correct URL', function() {
    expect(robot.respond).toHaveBeenCalled();
    robot.respond.mostRecentCall.args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('http://api.hackertarget.com/reversedns/?q=1.2.3.4')
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
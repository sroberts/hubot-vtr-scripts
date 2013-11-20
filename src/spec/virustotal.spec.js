/**
 * Created by mattjohansen on 11/19/13.
 */

var virustotal = require('../scripts/virustotal.coffee');
var HttpClient = require('scoped-http-client');

describe('virustotal', function() {
  var robot = null;

  beforeEach(function(){
    robot = {
      respond: function(regex, callback){},
      http: function(url){}
    }
    spyOn(robot, 'respond').andCallThrough();
    spyOn(robot, 'http').andCallFake(function(){
      var url = robot.http.mostRecentCall.args[0];
      var client = HttpClient.create(url);
      spyOn(client, 'post').andReturn(function(){});
      //spyOn(client, 'query').andCallFake(function(){
      //  spyOn(query, 'get').andReturn(function(){});
      //});
      return client
    });
    virustotal(robot);
  });

  it('should be a function', function(){
    expect(typeof(virustotal)).toBe('function');
  });

  //TODO - test the .post() first arg to see if data is being populated properly
  it('should generate the correct URL for a hash', function() {
    var msg = {
      match: 'virustotal hash somehashthing'.match(robot.respond.calls[0].args[0]),
      send: function() {}
    }

    expect(robot.respond).toHaveBeenCalled();
    robot.respond.calls[0].args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('https://www.virustotal.com/vtapi/v2/file/report')
  });

  //TODO - test the .post() first arg to see if data is being populated properly
  it('should generate the correct URL for a url', function() {
    var msg = {
      match: 'virustotal url www.google.com'.match(robot.respond.calls[1].args[0]),
      send: function() {}
    }

    expect(robot.respond).toHaveBeenCalled();
    robot.respond.calls[1].args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('https://www.virustotal.com/vtapi/v2/url/report')
  });

  //TODO - figure out how to test the extra chained .query() then the .get()
  xit('should generate the correct URL for an ip', function() {
    var msg = {
      match: 'virustotal ip 1.2.3.4'.match(robot.respond.calls[2].args[0]),
      send: function() {}
    }

    expect(robot.respond).toHaveBeenCalled();
    robot.respond.calls[2].args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    //expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    //expect(robot.http.mostRecentCall.args[0]).toBe('https://www.virustotal.com/vtapi/v2/ip-address/report')
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails
  //TODO - Get access to the callback to actually test the body and parsing

});
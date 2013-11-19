/**
 * Created by mattjohansen on 11/18/13.
 */
var geoip = require('../scripts/geolocate-ip.coffee');
var HttpClient = require('scoped-http-client');

describe('geolocation', function() {
  var robot, msg = null;

  beforeEach(function(){
    robot = {
      respond: function(regex, callback){},
      http: function(url){
        //HttpClient.create(url);
      }
    }
    spyOn(robot, 'respond').andCallThrough();
    spyOn(robot, 'http').andCallFake(function(){
      var url = robot.http.mostRecentCall.args[0];
      var client = HttpClient.create(url);
      spyOn(client, 'get').andReturn(function(){});
      return client
    });
    geoip(robot);
    msg = {
      match: 'geolocate 1.2.3.4'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
  });

  it('should be a function', function(){
    expect(typeof(geoip)).toBe('function');
  });

  it('should generate the correct URL', function() {
    expect(robot.respond).toHaveBeenCalled();
    console.log(robot.respond.mostRecentCall.args[1]);
    robot.respond.mostRecentCall.args[1](msg);
    expect(robot.http).toHaveBeenCalled();
    expect(robot.http.mostRecentCall.args[0]).toBeDefined();
    expect(robot.http.mostRecentCall.args[0]).toBe('http://api.hostip.info/get_json.php?ip=1.2.3.4')
  });

  //TODO - More verbose tests to make sure this doesn't get called when Regex fails

});
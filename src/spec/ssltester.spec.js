/**
 * Created by mattjohansen on 12/11/13.
 */

var ssl = require('../scripts/ssltester.coffee');

describe('reputation', function() {
  var robot = null;

  beforeEach(function(){
    robot = {
      respond: function(regex, callback){},
    }
    spyOn(robot, 'respond');

    ssl(robot);
  });

  it('should be a function', function(){
    expect(typeof(ssl)).toBe('function');
  });

  it('should respond correctly when passed an IP', function() {
    var msg = {
      match: 'ssl google.com'.match(robot.respond.calls[0].args[0]),
      send: function() {}
    }
    spyOn(msg, 'send');

    expect(robot.respond).toHaveBeenCalled();
    robot.respond.calls[0].args[1](msg);
    expect(msg.send).toHaveBeenCalled();
    expect(msg.send.mostRecentCall.args[0]).toBeDefined();
  });

  it('should not call anything if the regex doesnt match', function() {
    var msg = {
      match: 'reputation url www.google.com'.match(robot.respond.mostRecentCall.args[0]),
      send: function() {}
    }
    spyOn(msg, 'send');

    expect(robot.respond).toHaveBeenCalled();
    expect(msg.send).not.toHaveBeenCalled();
  });

});

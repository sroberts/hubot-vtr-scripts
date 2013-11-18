/**
 * Created by mattjohansen on 11/18/13.
 */
var geoip = require('../scripts/geolocate-ip.coffee');

describe('geolocation', function() {

  it('should be a function', function(){
    expect(typeof(geoip)).toBe('function');
  });

  it('should call respond when called', function() {
    var robot = {
      respond: function(){}
    };

    spyOn(robot, 'respond');
    geoip(robot);
    expect(robot.respond).toHaveBeenCalled();
  });

  //TODO: Need a way to call robot. Not sure how to do this without access to hubot itself.

});
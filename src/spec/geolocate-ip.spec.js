/**
 * Created by mattjohansen on 11/18/13.
 */
var geoip = require('../scripts/geolocate-ip.coffee');

describe('geolocation', function() {

  it('should be a function', function(){
    expect(typeof(geoip)).toBe('function');
  })

});
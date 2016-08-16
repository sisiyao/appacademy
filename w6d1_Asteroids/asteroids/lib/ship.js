const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');

function Ship(game, options){
  options["color"] = 'red';
  options["radius"] = 50;
  options["vel"] = [0, 0];
  MovingObject.call(this, game, options);
};

Util.inherits(Ship, MovingObject);

module.exports = Ship;

const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');

function Asteroid (game, options) {
  options["color"] = 'green';
  options["radius"] = 50;
  options["vel"] = Util.randomVec(10);
  MovingObject.call(this, game, options);
}

Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function(otherObject) {
  if (otherObject.instanceOf(Ship)) {

  }
};

module.exports = Asteroid;

// let options = {"pos": [0, 0]};
// let a = new Asteroid(options);
// console.log(a);


//
// const c = document.getElementById('game-canvas');
// c.height = window.innerHeight;
// c.width = window.innerWidth;
// const ctx = c.getContext("2d");
// ctx.fillStyle = "#FF0000";
// ctx.fillRect(0,0,c.width,c.height);
//
// a.draw(ctx);

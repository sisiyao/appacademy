

function MovingObject (game, options) {
  this.game = game;
  this.pos = options["pos"];
  this.radius = options["radius"];
  this.vel = options["vel"];
  this.color = options["color"];
}

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

MovingObject.prototype.move = function() {
  this.pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]];
  this.pos = this.game.wrap(this.pos);
  return this.pos;
};

MovingObject.prototype.isCollidedWith = function(otherObject) {
  let pos2 = otherObject.pos;
  let pos1 = this.pos;
  let distance = Math.sqrt(Math.pow((pos1[0] - pos2[0]), 2) +
    Math.pow((pos1[1] - pos2[1]), 2));

  if (distance < this.radius + otherObject.radius) {
    return true;
  } else {
    return false;
  }
};

MovingObject.prototype.collideWith = function(otherObject) {
  // this.game.remove(this);
  // this.game.remove(otherObject);
};

module.exports = MovingObject;
//
// let options = {
//   pos: [200,300],
//   radius: 150,
//   vel: [3,4],
//   color: 'grey'
// };
//
// let mo = new MovingObject(options);
//
// const c = document.getElementById('game-canvas');
// c.height = window.innerHeight;
// c.width = window.innerWidth;
// const ctx = c.getContext("2d");
// ctx.fillStyle = "#FF0000";
// ctx.fillRect(0,0,c.width,c.height);
//
// mo.draw(ctx);

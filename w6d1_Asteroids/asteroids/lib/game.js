const Asteroid = require('./asteroid.js');
const Ship = require('./ship.js')

function Game () {
  this.asteroids = [];
  this.addAsteroids();
  this.ship = new Ship(this, {pos: this.randomPosition()});
}

Game.DIM_X = window.innerWidth;
Game.DIM_Y = window.innerHeight;
Game.NUM_ASTEROIDS = 4;

Game.prototype.randomPosition = function() {
  let x = Math.random() * Game.DIM_X;
  let y = Math.random() * Game.DIM_Y;
  return [x, y];
};

Game.prototype.addAsteroids = function() {
  for(let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    let newAsteroid = new Asteroid(this, {pos: this.randomPosition()});
    this.asteroids.push(newAsteroid);
  }
};

Game.prototype.allObjects = function() {
  let objectArray = this.asteroids.concat(this.ship);
  return objectArray;
};

Game.prototype.draw = function(ctx){
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  this.allObjects.forEach(object => object.draw(ctx));

};

Game.prototype.moveObjects = function() {
  this.allObjects.forEach(object => object.move());
};

Game.prototype.wrap = function(pos) {
  let x = pos[0];
  let y = pos[1];
  if (x > Game.DIM_X || y > Game.DIM_Y || x < 0 || y < 0) {
    let newX = x % Game.DIM_X;
    let newY = y % Game.DIM_Y;
    if (newX < 0) {
      newX = newX + Game.DIM_X;
    }
    if (newY < 0) {
      newY = newY + Game.DIM_Y;
    }
    return [newX, newY];
  } else {
    return pos;
  }
};

Game.prototype.checkCollisions = function() {
  for (let i = 0; i < this.allObjects.length; i++) {
    for (let j = i + 1; j < this.allObjects.length; j++) {
      if (this.allObjects[i].isCollidedWith(this.allObjects[j])) {
        this.allObjects[i].collideWith(this.allObjects[j]);
      }
    }
  }
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function (asteroid) {
  this.asteroids = this.asteroids.filter((asteroidEl) => {
    return asteroidEl.pos !== asteroid.pos;
  });
};

// let g = new Game();
// console.log(Game.DIM_X);
// console.log(Game.DIM_Y);

module.exports = Game;

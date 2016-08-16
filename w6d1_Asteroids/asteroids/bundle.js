/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const GameView = __webpack_require__(1);

	document.addEventListener("DOMContentLoaded", function(){
	  const c = document.getElementById('game-canvas');
	  c.height = window.innerHeight;
	  c.width = window.innerWidth;
	  const ctx = c.getContext("2d");
	  const gv = new GameView(ctx);
	  gv.start();
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(2);

	function GameView (ctx) {
	  this.game = new Game();
	  this.ctx = ctx;
	}

	GameView.prototype.start = function () {
	  setInterval(() => {

	    this.game.step();
	    this.game.draw(this.ctx);
	  }, 20);
	};

	module.exports = GameView;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(3);
	const Ship = __webpack_require__(6)

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


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(4);
	const MovingObject = __webpack_require__(5);

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


/***/ },
/* 4 */
/***/ function(module, exports) {

	const Util = {
	  inherits (childClass, parentClass) {
	    function Surrogate () {}
	    Surrogate.prototype = parentClass.prototype;
	    childClass.prototype = new Surrogate();
	    childClass.prototype.constructor = childClass;
	  },

	  randomVec(length) {
	    let sign = Math.floor(Math.random() * 2) === 0 ? 1 : -1;
	    let x = (Math.random() * length) * sign;
	    let y = (Math.random() * length) * sign;
	    return [x, y];
	  }
	};



	module.exports = Util;


/***/ },
/* 5 */
/***/ function(module, exports) {

	

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


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(4);
	const MovingObject = __webpack_require__(5);

	function Ship(game, options){
	  options["color"] = 'red';
	  options["radius"] = 50;
	  options["vel"] = [0, 0];
	  MovingObject.call(this, game, options);
	};

	Util.inherits(Ship, MovingObject);

	module.exports = Ship;


/***/ }
/******/ ]);
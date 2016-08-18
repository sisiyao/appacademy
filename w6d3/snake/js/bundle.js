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

	const Board = __webpack_require__(2);
	const View = __webpack_require__(1);

	$(() => {
	  let board = new Board();
	  let view = new View(board);
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class View {
	  constructor (board) {
	    this.board = board;
	    this.snake = board.snake;
	    this.gridView = $('.container');
	    this.setupGrid();
	    this.render();
	  }

	  setupGrid () {
	    let $ul = $('<ul>').addClass('grid cf');
	    for(let i = 0; i < 15; i++) {
	      for(let j = 0; j < 15; j++) {
	        $('<li>').appendTo($ul).addClass('cell').data("pos", [i, j]);
	      }
	    }
	    this.gridView.append($ul);
	  }

	  render () {
	    this.snake.segments.forEach((coord, idx) => {
	      $('.cell').filter( (i, cell) => {
	        // console.log("Inside filter!");
	        // console.log($(cell).data("pos"));
	        // console.log(`${[coord.x, coord.y]}`);
	        return $(cell).data("pos") == `${[coord.x, coord.y]}`;
	      }).addClass("body");
	      // $(`.cell[data-pos=${[coord.x, coord.y]}]`).addClass('body');
	      // // $('cell').each((i, el) => {
	      //   console.log("here");
	      //   if (el.data("pos") === [coord.x, coord.y].toString()) {
	      //     el.addClass("body");
	      //   }
	      // });
	    });
	  }
	}

	module.exports = View;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Snake = __webpack_require__(3);
	const Coord = __webpack_require__(4);

	class Board {
	  constructor() {
	    this.grid = [];
	    for(let i = 0; i < 15; i++) {
	      let el = new Array(15);
	      this.grid.push(el);
	    }
	    this.snake = new Snake(this.randomCoord());
	  }

	  randomCoord() {
	    this.x = Math.floor(Math.random() * 15);
	    this.y = Math.floor(Math.random() * 15);
	    return (new Coord([this.x, this.y]));
	  }

	}

	module.exports = Board;


/***/ },
/* 3 */
/***/ function(module, exports) {

	class Snake {
	  constructor(start) {
	    this.direction = null;
	    this.segments = [start];
	  }

	  move() {

	  }

	  turn(dir) {

	  }
	}

	module.exports = Snake;


/***/ },
/* 4 */
/***/ function(module, exports) {

	class Coord {
	  constructor(pos) {
	    this.x = pos[0];
	    this.y = pos[1];
	  }


	}


	module.exports = Coord;


/***/ }
/******/ ]);
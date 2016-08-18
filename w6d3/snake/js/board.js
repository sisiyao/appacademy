const Snake = require('./snake.js');
const Coord = require('./coord.js');

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

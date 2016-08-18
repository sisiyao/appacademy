const Board = require('./board.js');
const View = require('./view.js');

$(() => {
  let board = new Board();
  let view = new View(board);
});

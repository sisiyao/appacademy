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

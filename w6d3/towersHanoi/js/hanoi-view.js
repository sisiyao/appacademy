function HanoiView(game, rootel) {
  this.game = game;
  this.rootEl = rootel;
  this.clickedTower = 4;
  this.setupTowers();
  this.render();
  this.clickTower();
}

HanoiView.prototype.setupTowers = function () {
  for (let i = 0; i<3; i++) {
    let $ul = $('<ul>').addClass("tower").data("towerID", i);
    if (i===0) {
      for (let j = 0; j < 3; j++) {
        let $li = $('<li>').addClass('disc').appendTo($ul);
        $li.addClass("disc" + (j + 1));
      }
    }

    this.rootEl.append($ul);
  }
};

HanoiView.prototype.render = function () {
  const towers = this.game.towers;
  $('.tower').children().remove();
  for(let i = 0; i < towers.length; i++ ) {
    for(let j = 0; j < towers[i].length; j++) {
      let $li = $('<li>').addClass('disc').addClass('disc' + towers[i][j]);
      $(`.tower:nth-child(${i + 1})`).prepend($li);
    }
  }
};

HanoiView.prototype.clickTower = function () {
  const $towers = $('.tower');

  $towers.click( e => {
    const $ul = $(e.currentTarget);

    if(this.clickedTower < 0 || this.clickedTower > 2) {
      this.clickedTower = parseInt($ul.data("towerID"));
      this.render();
      console.log("here");
    } else {
      console.log("this");
      this.game.move(this.clickedTower, parseInt($ul.data("towerID")));
      if(this.game.isWon()) {
        $('.hanoi').append($('<h1>').text("You rock!"));
        $('.hanoi').addClass('won');
        $towers.off('click');
      }
      this.clickedTower = 4;
      this.render();
    }
  });
};

module.exports = HanoiView;

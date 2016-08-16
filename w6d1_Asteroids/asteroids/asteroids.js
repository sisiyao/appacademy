const GameView = require('./lib/game_view.js');

document.addEventListener("DOMContentLoaded", function(){
  const c = document.getElementById('game-canvas');
  c.height = window.innerHeight;
  c.width = window.innerWidth;
  const ctx = c.getContext("2d");
  const gv = new GameView(ctx);
  gv.start();
});

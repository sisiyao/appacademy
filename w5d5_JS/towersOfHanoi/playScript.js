const Game = require('./game.js');

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

let g = new Game();

function completion () {
  reader.question('Do you want to start a new game? (y/n)', (res) => {
    if (res === 'y') {
      g = new Game();
      g.run(reader, completion);
    } else {
      reader.close();
    }
  });
}

g.run(reader, completion);

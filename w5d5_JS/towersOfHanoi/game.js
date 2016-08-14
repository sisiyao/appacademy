class HanoiGame {
  constructor () {
    this.stacks = [[1,2,3], [], []];
  }

  promptMove (reader, callback) {
    console.log(this.stacks);
    reader.question('Stack num to move from: ', (start) => {
      reader.question('Stack num to move to: ', (end) => {
        let startIdx = parseInt(start);
        let endIdx = parseInt(end);
        callback(startIdx, endIdx);
      });
    });
  }

  isValidMove (startTowerIdx, endTowerIdx) {
    let startTowerDisc = this.stacks[startTowerIdx][0];
    let endTowerDisc = this.stacks[endTowerIdx][0];
    if (!startTowerDisc || startTowerDisc > endTowerDisc ||
      startTowerIdx === endTowerIdx) {
      return false;
    } else {
      return true;
    }
  }

  move (startTowerIdx, endTowerIdx) {
    if (this.isValidMove(startTowerIdx, endTowerIdx) === true) {
      let discToMove = this.stacks[startTowerIdx].shift();
      this.stacks[endTowerIdx].unshift(discToMove);
      return true;
    } else {
      return false;
    }
  }

  print () {
    console.log(JSON.stringify(this.stacks));
  }

  isWon () {
    if (JSON.stringify(this.stacks[1]) === '[1,2,3]' ||
    JSON.stringify(this.stacks[2]) === '[1,2,3]') {
      return true;
    } else {
      return false;
    }
  }

  run (reader, completionCallback) {
    this.promptMove(reader, (startIdx, endIdx) => {
      if (!this.move(startIdx, endIdx)) {
        console.log('Invalid move, try again!');
      }

      this.print();

      if (!this.isWon()) {
        this.run(reader, completionCallback);
      } else {
        completionCallback();
      }
    });
  }
}

module.exports = HanoiGame;

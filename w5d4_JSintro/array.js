// Array Uniq

function uniq(array) {
  let newArray = [];

  for (let i = 0; i < array.length; i++) {
    if (!newArray.includes(array[i])) {
      newArray.push(array[i]);
    }
  }

  return newArray;
}

// console.log(uniq([1,2,2,5,5,3]));

Array.prototype.uniq = function () {
  let newArray = [];

  for (let i = 0; i < this.length; i++) {
    if (!newArray.includes(this[i])) {
      newArray.push(this[i]);
    }
  }

  return newArray;
};

// console.log([1,2,2,5,5,3].uniq());

// Two Sum

Array.prototype.twoSum = function () {
  let positions = [];

  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        positions.push([i, j]);
      }
    }
  }

  return positions;
};

// console.log([1,2,3,-2,-3].twoSum());

// My Transpose

function myTranspose (array) {
  let transposed = [];

  for (let i = 0; i < array.length; i++) {
    let row = [];
    for (let j = 0; j < array.length; j++) {
      row.push(array[j][i]);
    }
    transposed.push(row);
  }

  return transposed;
}

console.log(myTranspose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]));

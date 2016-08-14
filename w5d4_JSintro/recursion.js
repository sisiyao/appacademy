function exp1 (base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  } else {
    return base * exp1(base, exp - 1);
  }
}

// let result = exp1(2,4);
//
// console.log(result);

function exp2 (base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  } else if (exp % 2 === 0) {
    return exp2(base, exp/2) * exp2(base, exp/2);
  } else {
    return base * exp2(base, (exp-1)/2) * exp2(base, (exp-1)/2);
  }
}
//
// let result = exp2(2, 3);
//
// console.log(result);

function fibIter(number) {
  let fib = [1, 1];
  while (fib.length < number) {
    let last = fib[fib.length-1];
    let secondLast = fib[fib.length -2];
    fib.push(last + secondLast);
  }

  return fib;
}

// let result = fibIter(8);
//
// console.log(result);

function fibRecur(number) {
  if (number === 1) {
    return [1];
  } else if (number === 2) {
    return [1, 1];
  }

  let prevFib = fibRecur(number-1);
  let nextEl = prevFib[prevFib.length-1] + prevFib[prevFib.length-2];
  prevFib.push(nextEl);
  return prevFib;
}

// let result = fibRecur(9);
// console.log(result);

function binarySearch (array, target) {
  if (array.length === 1) {
    if (target === array[0]) {
      return 0;
    } else {
      return null;
    }
  }

  let mid = Math.floor(array.length/2);

  if (target === array[mid]) {
    return mid;
  }

  let lhs = array.slice(0, mid);
  let rhs = array.slice(mid);

  if (target < array[mid]) {
    return binarySearch(lhs, target);
  } else {
    let rhsResult = binarySearch(rhs, target);
    if (rhsResult) {
      return mid + rhsResult;
    }
  }
}

// let result = binarySearch([2,3,4,5,6,7], 6);
// console.log(result);

function makeBadChange (sum, coins) {
  coins.sort((a, b) => b - a);

  if (sum === 0) { return []; }
  if (coins.length === 0) { return null; }
  if (sum < coins[coins.length-1]) { return null; }

  let change = [];
  let numCoins = Math.floor(sum / coins[0]);
  for (let i = 0; i < numCoins; i++) {
    change.push(coins[0]);
  }

  let prevChange = makeBadChange(sum % coins[0], coins.slice(1));
  if (prevChange !== null) {
    return change.concat(prevChange);
  } else {
    return null;
  }
}

// let result = makeBadChange(14, [10, 7, 3]);
//
// console.log(result);

// function makeOkChange (sum, coins) {
//   coins.sort((a, b) => b - a);
//
//   if (sum === 0) { return []; }
//   if (coins.length === 0) { return null; }
//   if (sum < coins[coins.length-1]) { return null; }
//
//   let change = [];
//   let prevChange = null;
//   if (sum >= coins[0]) {
//     change.push(coins[0]);
//     prevChange = makeBetterChange(sum-coins[0], coins);
//   } else {
//     prevChange = makeBetterChange (sum, coins.slice(1));
//   }
//
//   if (prevChange !== null) {
//     return change.concat(prevChange);
//   } else {
//     return null;
//   }
// }

// let result = makeOkChange(14, [10, 7, 3, 1]);
//
// console.log(result);


function makeBetterChange (sum, coins) {
  coins.sort((a, b) => b - a);

  if (sum === 0) { return []; }
  if (coins.length === 0) { return null; }
  if (sum < coins[coins.length-1]) { return null; }

  let bestChange = null;

  for ( let i = 0; i < coins.length; i++) {

    let nextChange = null;
    if (sum >= coins[i]) {
      nextChange = makeBetterChange(sum-coins[i], coins.slice(1));
    }

    if (nextChange !== null) {
      let currChange = [coins[i]].concat(nextChange);

      if (bestChange === null || currChange.length < bestChange.length) {
        bestChange = currChange;
      }
    }
  }

  return bestChange;
}
//
let result = makeBetterChange(14, [10, 9]);

console.log(result);


function mergeSort (array) {
  if (array.length <= 1) {
    return array;
  }

  let mid = Math.floor(array.length/2);

  let lhs = array.slice(0, mid);
  let rhs = array.slice(mid);

  return merge(mergeSort(lhs), mergeSort(rhs));

}

function merge (array1, array2) {
  let sortedArray = [];
  while (array1.length > 0 && array2.length > 0) {
    if (array1[0] > array2[0]) {
      sortedArray.push(array2.shift());
    } else {
      sortedArray.push(array1.shift());
    }
  }

  return sortedArray.concat(array1.concat(array2));
}

// let result = mergeSort([1,2,3,2,4,5]);
//
// console.log(result);

function subsets (array) {
  if (array.length === 0) {
    return [[]];
  }

  let prev = subsets(array.slice(0, array.length - 1));
  return prev.concat(prev.map(el => el.concat(array[array.length - 1])));
}

// let result = subsets([1,2,3]);
//
// console.log(result);

function myEach (array, fun) {
  for(let i = 0; i < array.length; i++) {
    fun(array[i]);
  }
}

// myEach([1,2,3,4], function(el) {
//   console.log(el);
// });

function myMap (array, fun) {
  let newArray = [];
  myEach(array, function (el) {
    newArray.push(fun(el));
  });
  return newArray;
}

// console.log(myMap([1,2,3,4], function(el) {
//   return el+1;
// }));


function myInject (array, fun, acc) {
  if (acc === undefined) {
    acc = array.shift();
  }
  myEach(array, function (el) {
    acc = fun(acc, el);
  });

  return acc;
}

// console.log(myInject([1,2,3], function(acc, el) {
//   return (acc+el);
// }, 10));

function bubbleSort(array) {
  let sorted = false;
  while (sorted === false) {
    sorted = true;
    for (let i = 0; i < array.length; i++) {
      if (array[i] > array[i+1]) {
        [array[i+1], array[i]] = [array[i], array[i+1]];
        sorted = false;
      }

    }

  }

  return array;
}

// let result = bubbleSort([1,2,5,2,3,0,1]);
//
// console.log(result);

function uniq(array) {
  let newArray = [];

  for (let i = 0; i < array.length; i++) {
    if (!newArray.includes(array[i])) {
      newArray.push(array[i]);
    }
  }

  return newArray;
}

function subStrings (array) {
  let subs = [];

  for (let i = 0; i < array.length; i++) {
    for (let j = i + 1; j <= array.length; j++) {

      subs.push(array.slice(i, j));
    }
  }

  return uniq(subs);
}

// let result = subStrings([1,2,3]);
//
// console.log(result);

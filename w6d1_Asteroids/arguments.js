function sumArg() {
  let argArray = Array.from(arguments);
  let total = 0;
  argArray.forEach(function(el){
    total += el;
  });
  return total;
}

function sumRest(...args) {
  let total = 0;
  args.forEach(function(el){
    total += el;
  });
  return total;
}

// console.log(sumRest(1,2,3));

Function.prototype.myBind = function (obj) {
  let argArray = Array.from(arguments);
  let method = this;

  return function () {
    let newArgs = Array.from(arguments);
    argArray = argArray.concat(newArgs);
    method.apply(obj, argArray.slice(1));
  };
};

Function.prototype.restMyBind = function (obj, ...args) {
  let method = this;
  return function (...args2) {
    let allArgs = args.concat(args2);
    method.apply(obj, allArgs);
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

// markov.says.restMyBind(breakfast, "meow", "Kush")();

// markov.says.restMyBind(breakfast)("meow", "a tree");


function curriedSum(numArgs) {
  let numbers = [];
  function _curriedSum(num) {
    numbers = numbers.concat(num);
    if (numbers.length === numArgs) {
      let total = 0;
      numbers.forEach ((num) => total += num);
      return total;
    } else {return _curriedSum;}
  }
  return _curriedSum;
}

// const sum = curriedSum(4);
// console.log(sum(5)(30)(20)(1));

Function.prototype.curry = function (numArgs2) {
  let numbers = [];
  let fun = this;

  function _curried(num) {
    numbers = numbers.concat(num);
    if (numbers.length === numArgs2) {
      return fun.apply(null, numbers);
    } else {return _curried;}
  }
  return _curried;
};


Function.prototype.spreadCurry = function (numArgs3) {
  let numbers = [];
  let fun = this;

  function _curried(num) {
    numbers = numbers.concat(num);
    if (numbers.length === numArgs3) {
      return fun.call(null, ...numbers);
    } else {return _curried;}
  }
  return _curried;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

let f1 = sumThree.spreadCurry(3);
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
// f1 = f1(6); // = 30
console.log(f1(6));

Function.prototype.inherits = function(parent) {
  function Surrogate () {}
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function Animal (name) {
  this.name = name;
}

Animal.prototype.eat = function () {
  console.log(`${this.name} eats`);
};

function Parrot(name) {
  Animal.call(this, name);
}

Parrot.inherits(Animal);

Parrot.prototype.squawk = function () {
  console.log('squawk sqawk');
};

function Monkey(name) {
  Animal.call(this, name);
}

Monkey.inherits(Animal);

Monkey.prototype.grabBanana = function () {
  console.log(`${this.name} grabs a banana`);
};


let m = new Monkey('Fred');

let p = new Parrot('Polly');

m.eat();
m.grabBanana();
p.eat();
p.squawk();
console.log(Object.getPrototypeOf(p));
console.log(Object.getPrototypeOf(m));
console.log(Object.getPrototypeOf(Animal));

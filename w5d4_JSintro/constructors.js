function Cat (name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  console.log(`${this.owner} loves ${this.name}`);
};

let halil = new Cat('halil', 'oksana');

halil.cuteStatement();

Cat.prototype.cuteStatement = function () {
  console.log(`Everyone loves ${this.name}`);
};

halil.cuteStatement();

Cat.prototype.meow = function () {
  console.log(`${this.name} meows`);
};

halil.meow();

halil.meow = function () {
  console.log(`${this.name} goes meow meow`);
};

let sisi = new Cat ("sisi", "charles");

sisi.meow();
halil.meow();

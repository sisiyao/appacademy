const Util = {
  inherits (childClass, parentClass) {
    function Surrogate () {}
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate();
    childClass.prototype.constructor = childClass;
  },

  randomVec(length) {
    let sign = Math.floor(Math.random() * 2) === 0 ? 1 : -1;
    let x = (Math.random() * length) * sign;
    let y = (Math.random() * length) * sign;
    return [x, y];
  }
};



module.exports = Util;

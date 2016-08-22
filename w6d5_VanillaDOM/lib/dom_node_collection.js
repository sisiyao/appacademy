class DOMNodeCollection {
  constructor(arr) {
    this.arr = arr;
  }

  html(str) {
    if (arguments.length === 0) {
      // console.log(typeof this.arr[0]);
      return this.arr[0].innerHTML;
    } else {
      this.arr.forEach((el) => {
        el.innerHTML = str;
      });
    }
  }

  empty () {
    this.arr.forEach(el => {
      el.innerHTML = "";
    });
  }

  append (el) {
    if ( el instanceof String) {
      el = document.createElement(el);
    }
    if (el instanceof Node) {
      el = new DOMNodeCollection([el]);
    }
    this.arr.forEach(elAddTo => {
      el.arr.forEach(elToAdd => {
        elAddTo.innerHTML += elToAdd.outerHTML;
      });
    });
  }

  children () {
    let children = [];
    this.arr.forEach( el => {
      let childrenArray = Array.from(el.children);
      childrenArray.forEach(child => {
        children.push(child);
      });
    });
    return new DOMNodeCollection(children);
  }

  parent () {
    let parents = [];
    this.arr.forEach(el => {
      parents.push(el.parentNode);
    });

    return new DOMNodeCollection(parents);
  }

  find (selector) {
    let found = [];
    this.arr.forEach(el => {
      el.querySelectorAll(selector).forEach(el2 => {
        found.push(el2);
      });
    });

    return new DOMNodeCollection(found);
  }

  remove () {
    this.arr.forEach(el => {
      el.remove();
    });
    this.arr = [];
  }

  on (event, callback) {
    this.arr.forEach(el => {
      el.addEventListener(event, callback);
    });
  }

  off (event, callback) {
    this.arr.forEach(el => {
      el.removeEventListener(event, callback);
    });
  }

}

window.DOMNodeCollection = DOMNodeCollection;

module.exports = DOMNodeCollection;

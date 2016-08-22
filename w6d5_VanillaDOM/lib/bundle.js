/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const DOMNodeCollection = __webpack_require__(1);

	window.$l = function (arg) {
	  if(arg instanceof Function) {
	    let funArray = [];
	    funArray.push(arg);

	    document.addEventListener('DOMContentLoaded', (e) => {
	      funArray.forEach(fn => {
	        fn();
	      });
	    });
	  } else if (typeof arg === 'string') {
	    let nodeList = document.querySelectorAll(arg);
	    // console.log(typeof nodeList);
	    return new DOMNodeCollection(Array.from(nodeList));
	  } else {
	    let arr = [arg];
	    return new DOMNodeCollection(arr);
	  }
	};

	window.$l.extend = function () {
	  let argsArray = Array.from(arguments);
	  let primaryObject = argsArray[0];
	  let mergeObjects = argsArray.slice(1);

	  mergeObjects.forEach(obj => {
	    for (var attrname in obj) {
	      primaryObject[attrname] = obj[attrname];
	    }
	  });
	  return primaryObject;
	};

	window.$l.ajax = function (options) {
	  let defaults = {
	    success: () => {} ,
	    error: () => {},
	    url: window.location.href,
	    method: 'GET',
	    data: "",
	    contentType: 'json'
	  };
	  let request = this.extend(options, defaults);

	  const xhr = new XMLHttpRequest();

	  // step 2 - specify path and verb
	  xhr.open(request["method"], request["url"]);
	  xhr.responseType(request["contentType"]);
	  // step 3 - register a callback
	  xhr.onload = function () {
	    if (xhr.status === 200) {
	      request["success"]();
	    } else {
	      request["error"]();
	    }
	  };

	  // step 4 - send off the request with optional data
	  const optionalData = request["data"];
	  xhr.send(optionalData);
	};

	// window.$l( () => {
	//   console.log("here");
	// });


/***/ },
/* 1 */
/***/ function(module, exports) {

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


/***/ }
/******/ ]);
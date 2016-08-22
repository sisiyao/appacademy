const DOMNodeCollection = require("./dom_node_collection.js");

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

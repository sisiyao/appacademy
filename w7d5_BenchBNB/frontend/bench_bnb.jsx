import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

// testing purposes
// import * as ACTIONS from './actions/bench_actions';
// import * as API from './util/bench_api_util';

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();

  // testing purposes
  window.Store = store;

  const rootEl = document.getElementById("root");
  ReactDOM.render(<Root store={store} />, rootEl);
});

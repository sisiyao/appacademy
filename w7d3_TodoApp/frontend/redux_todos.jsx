import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from './store/store';
import { REQUEST_TODOS, requestTodos } from './actions/todo_actions';
import { Root } from './components/root';
import { createTodo } from './actions/todo_actions';

window.requestTodos = requestTodos;
window.createTodo = createTodo;

const store = configureStore();
window.store = store;


document.addEventListener("DOMContentLoaded", () => {
  const rootEL = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, rootEL );
});

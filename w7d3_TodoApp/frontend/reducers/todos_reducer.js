import { REQUEST_TODOS, RECEIVE_TODOS, RECEIVE_TODO, receiveTodos, requestTodos } from '../actions/todo_actions';
import { merge } from 'lodash';

const defaultState = {
  "1": {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  "2": {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
};

export const TodosReducer = (state = defaultState, action) => {
  switch(action.type) {
    case RECEIVE_TODOS:
      return action.todos;
    case RECEIVE_TODO:
      debugger
      // merge({}, state.todos, {action.todo.id: action.todo});
    default:
      return state;
  }
};

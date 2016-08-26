import { REQUEST_TODOS, RECEIVE_TODOS, CREATE_TODO, RECEIVE_TODO, receiveTodos, requestTodos, receiveTodo } from '../actions/todo_actions';
import { fetchTodos, createTodo } from '../util/todo_api_util';

export const TodoMiddleware = (store) => (next) => (action) => {
  switch (action.type) {
    case REQUEST_TODOS:
      let successRequest = data => {
        let dataObj = {};

        data.forEach(todo => {
          dataObj[todo.id] = todo;
        });

        store.dispatch(receiveTodos(dataObj));
      };
      fetchTodos(successRequest);
      break;
      // return next(action);
    case CREATE_TODO:
      createTodo(action.todo, receiveTodo);
      return next(action);
    default:
      return next(action);
  }
};

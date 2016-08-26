import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from '../../reducers/selectors';
import { requestTodos } from  '../../actions/todo_actions';

const mapStateToProps = (state) => ({
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  requestTodos: () => dispatch(requestTodos())
});

const TodoListContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

export default TodoListContainer;

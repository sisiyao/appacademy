import React from 'react';

class TodoList extends React.Component {
  constructor (props) {
    super(props);
  }

  componentDidMount () {
    this.props.requestTodos();
  }

  render () {
    // debugger
    const list = this.props.todos.map(todo => <li>{todo.title}</li>);
    return (
      <ul>{list}</ul>
    );
  }
}

export default TodoList;

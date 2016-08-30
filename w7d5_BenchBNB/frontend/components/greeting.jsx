import React from 'react';

const Greeting = ({currentUser, logout}) => {
  let action, header;

  if (currentUser) {
    action = (
      <button onClick={this.props.logout}>Logout</button>
    );
    header = `Hi, ${currentUser.username}`;
  } else {
    // action = (
      // <a href='/#/signup'>Signup</a> or <a href='/#/login'>login</a>
    // );
  }

  return (
    <div>
      <h2>{header}</h2>
      {action}
    </div>
  );
};

export default Greeting;

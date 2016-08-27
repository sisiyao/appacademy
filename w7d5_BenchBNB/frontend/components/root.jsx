import React from 'react';
import { Provider } from 'react-redux';
import SearchContainer from './search_container';

const Root = ({store}) => (
  <Provider store={store}>
    <SearchContainer />
  </Provider>
);

export default Root;

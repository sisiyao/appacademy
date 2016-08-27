import { createStore } from 'redux';
import RootReducer from '../reducers/root_reducer';
import RootMiddleware from '../middleware/root_middleware';

const newState = {
  benches: {},
  filters: {
    bounds: {}
  }
};

const configureStore = (preloadedState = newState) => (
  createStore(
   RootReducer,
   preloadedState,
   RootMiddleware
  )
);

export default configureStore;

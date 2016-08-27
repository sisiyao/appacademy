import { combineReducers } from 'redux';
import BenchesReducer from './benches_reducer';
import FilterReducer from './filter_reducer';

const RootReducer = combineReducers({
  benches: BenchesReducer,
  filters: FilterReducer
});

export default RootReducer;

import { FilterConstants } from '../actions/filter_actions';
import merge from 'lodash/merge';

const FilterReducer = (state = {bounds: {}}, action) => {
  switch (action.type) {
    case FilterConstants.UPDATE_BOUNDS:
      return merge({}, state, {bounds: action.bounds});
    default:
      return state;
  }
};

export default FilterReducer;

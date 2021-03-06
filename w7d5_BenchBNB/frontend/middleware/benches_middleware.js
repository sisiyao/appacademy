import { BenchConstants, receiveBenches, requestBenches, receiveBench } from '../actions/bench_actions';
import { fetchBenches, createBench } from '../util/bench_api_util';
import { FilterConstants } from '../actions/filter_actions';

const BenchesMiddleware = ({getState, dispatch}) => next => action => {
  switch(action.type){
    case BenchConstants.REQUEST_BENCHES:
      const benchesSuccess = data => dispatch(receiveBenches(data));
      const filters = getState().filters;
      fetchBenches(filters, benchesSuccess);
      break;
    case BenchConstants.CREATE_BENCH:
      const benchSuccess = data => dispatch(receiveBench(data));
      createBench(action.bench, benchSuccess);
      break;
    case FilterConstants.UPDATE_BOUNDS:
      next(action);
      dispatch(requestBenches());
      break;
    default:
      return next(action);
  }
};

export default BenchesMiddleware;

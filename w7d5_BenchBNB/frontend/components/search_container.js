import { requestBenches } from '../actions/bench_actions';
import { connect } from 'react-redux';
import Search from './search';
import { benchSelector } from '../util/bench_selector';
import { updateBounds } from '../actions/filter_actions';

const mapStateToProps = state => ({
  benches: benchSelector(state)
});

const mapDispatchToProps = dispatch => ({
  requestBenches: () => dispatch(requestBenches()),
  updateBounds: (bounds) => dispatch(updateBounds(bounds))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Search);

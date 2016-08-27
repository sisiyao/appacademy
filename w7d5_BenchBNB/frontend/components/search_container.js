import { requestBenches } from '../actions/bench_actions';
import { connect } from 'react-redux';
import Search from './search';
import { benchSelector } from '../util/bench_selector';

const mapStateToProps = state => ({
  benches: benchSelector(state)
});

const mapDispatchToProps = dispatch => ({
  requestBenches: () => dispatch(requestBenches())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Search);

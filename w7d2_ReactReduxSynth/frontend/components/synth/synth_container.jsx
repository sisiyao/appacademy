import { connect } from 'react-redux';
import Synth from './synth';
import { keyPressed, keyReleased } from '../../actions/note_actions';

const mapStateToProps = (state) => ({
  notes: state.notes
});

const mapDispatchToProps = (dispatch) => ({
  keyPressed: key => dispatch(keyPressed(key)),
  keyReleased: key => dispatch(keyReleased(key))
});

const SynthContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(Synth);

export default SynthContainer;

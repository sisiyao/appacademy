import TracksConstants from '../actions/tracks_actions';

export const isRecordingReducer = (state = false, action) => {
  switch (action.type) {
    case "START_RECORDING":
      return true;
    case "STOP_RECORDING":
      return false;
    default:
      return state;
  }
};

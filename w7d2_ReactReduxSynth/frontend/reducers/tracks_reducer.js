import TracksConstants from '../actions/tracks_actions';
import merge from 'lodash/merge';

let currTrackID = 0;

export const TracksReducer = (state = {}, action) => {
  switch (action.type) {
    case "START_RECORDING":
      currTrackID += 1
      let newTrack = {
        id: currTrackID,
        name: `Track ${currTrackID}`,
        roll: [],
        timeStart: action.timeNow
      }

      return merge({}, state, newTrack);
    case "STOP_RECORDING":
      let newRollLine = {
        notes: [],
        timeSlice: action.timeNow - state[currTrackID].timeStart
      }

      let updatedTrack = merge({}, state[currTrackID]);
      updatedTrack.roll.push(newRollLine);

      return merge({}, state, {updatedTrack})
    case "ADD_NOTES"
    default:
      return state;
  }
}

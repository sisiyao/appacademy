import { SessionConstants } from '../actions/session_actions';
import merge from 'lodash/merge';

const _defaultSession = {
  currentUser: null,
  errors: []
};

const SessionReducer = (state = _defaultSession, action) => {
  switch (action.type) {
    case SessionConstants.RECEIVE_CURRENT_USER:
      return merge({}, _defaultSession, {currentUser: action.user});
    case SessionConstants.RECEIVE_ERRORS:
      return merge({}, _defaultSession, {errors: action.errors});
    case SessionConstants.LOGOUT:
      return _defaultSession;
    default:
      return state;
  }
};

export default SessionReducer;

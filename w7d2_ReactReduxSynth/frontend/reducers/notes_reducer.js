import NotesConstants from '../actions/note_actions';

const validKeys = ['a', 's', 'd', 'f', 'g'];
const keyMap = {
  'a': 'C5',
  's': 'D5',
  'd': 'E5',
  'f': 'F5',
  'g': 'G5'
};

export const NotesReducer = (state = [], action) => {
  if (!validKeys.includes(action.key)) {
    return state;
  }

  let note = keyMap[action.key];

  switch(action.type) {
    case "KEY_PRESSED":
      if (state.includes(note)) {
        return state;
      } else {
        return [...state, note];
      }
    case "KEY_RELEASED":
      if (state.includes(note)) {
        let idx = state.indexOf(note);
        let newState = state.slice(0, idx).concat(state.slice(idx + 1, state.length));
        return newState;
      } else {
        return state;
      }
    default:
      return state;
  }
};

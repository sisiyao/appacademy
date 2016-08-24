import { combineReducers } from 'redux';
import { NotesReducer } from './notes_reducer.js';


const reducer = combineReducers({
  notes: NotesReducer
});

export default reducer;

import React from 'react';
import { NOTE_NAMES, TONES } from '../../util/tones';
import Note from '../../util/note';
import $ from 'jquery';
import NoteKey from './note_key';

class Synth extends React.Component {
  constructor(props) {
    super(props);
    this.notes = NOTE_NAMES.map( name => {
      return new Note(TONES[name]);
    });
    this.playNotes = this.playNotes.bind(this);
  }

  componentDidMount() {
    $(document).on('keydown', e => this.onKeyDown(e));
    $(document).on('keyup', e => this.onKeyUp(e));
  }

  onKeyDown (e) {
    this.props.keyPressed(e.key);
  }

  onKeyUp (e) {
    this.props.keyReleased(e.key);
  }

  playNotes () {
    let pressedNotes = this.props.notes;
    this.notes.forEach((note, idx) => {


      // let freqStore = pressedNotes.map( noteName => {
      //   return TONES[noteName];
      // });

      let noteName = NOTE_NAMES[idx];

      if (pressedNotes.includes(noteName)) {
        note.start();
      } else {
        note.stop();
      }
    });
  }

  render() {
    this.playNotes();

    let noteList = NOTE_NAMES.map( note => {
      return <NoteKey name={note} />;
    });

    return (
      <div>
        {noteList}
      </div>
    );
  }
}

export default Synth;

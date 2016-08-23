import React from 'react';
import Tabs from './tabs';
import Clock from './clock';
import Weather from './weather';
import Autocomplete from './autocomplete';

class Widgets extends React.Component {
  constructor () {
    super();
    this.state = {tabsData: [
      {title: "one", content: "I am the first"},
      {title: "two", content: "I am the second"},
      {title: "three", content: "I am the third"}],

      autocompleteData: [
        "Abba", "Barney", "Barbara", "Jeff",
        "Jenny", "Sarah", "Sally", "Xander"]
    };
  }

  render () {
    return (
      <div>
        <Clock />
        <Weather />
        <Tabs tabsData={this.state.tabsData} />
        <Autocomplete autocompleteData={this.state.autocompleteData} />
      </div>
    );
  }
}

export default Widgets;

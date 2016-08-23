import React from 'react';

class Autocomplete extends React.Component {
  constructor (props) {
    super(props);
    this.state = {value: "", searchResults: props.autocompleteData};
  }

  updateFormInput (e) {
    this.setState({value: e.currentTarget.value});
  }

  search() {
    const value = this.state.value.toLowerCase();
    const result = [];
    this.props.autocompleteData.forEach(item => {
      if (item.toLowerCase().includes(value)) {
        result.push(item);
      }
    });

    if (result.length === 0) {
      result.push("No matches");
    }

    return result;
  }

  liSearch(e) {
    // debugger
    const targetValue = e.currentTarget.textContent;
    this.setState({value: targetValue});
  }

  render () {
    const results = this.search().map(result => <li key={result} onClick={this.liSearch.bind(this)}>{result}</li>);
    return (
      <div className="widget">
        <input className="auto-input" value={this.state.value} placeholder="Search..." onChange={this.updateFormInput.bind(this)}/>
          <ul className="auto-ul">
            {results}
          </ul>
      </div>
    );
  }
}

export default Autocomplete;

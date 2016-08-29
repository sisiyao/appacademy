import React from 'react';
import { withRouter } from 'react-router';

class BenchForm extends React.Component {
  constructor (props) {
    super(props);
    this.lat = this.props.lat;
    this.lng = this.props.lng;
    this.state = {
      description: '',
      seating: null,
      lat: this.lat,
      lng: this.lng
    };
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update (property) {
    return e => this.setState({[property]: e.target.value});
  }

  handleSubmit (e) {
    e.preventDefault();
    this.props.handleSubmit(this.state);
    this.props.router.push({
      pathname: "/",
    });
  }

  render () {
    return (
      <div>
        <h3>Add New Bench</h3>
        <form onSubmit={this.handleSubmit}>
          <label>
            Description
            <input
              type="text"
              onChange={this.update('description')} />
          </label>
          <label>
            Number of Seats
            <input
              type="number"
              onChange={this.update('seating')} />
          </label>
          <label>
            Latitude
            <input
              type="number"
              value={this.lat}
              disabled />
          </label>
          <label>
            Longitude
            <input
              type="number"
              value={this.lng}
              disabled />
          </label>
          <button>Submit</button>
        </form>
      </div>
    );
  }
}

export default withRouter(BenchForm);

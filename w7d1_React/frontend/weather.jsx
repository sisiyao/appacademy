import React from 'react';
import $ from 'jquery';


class Weather extends React.Component {
  constructor () {
    super();
    this.state = {coords: null, locationName: null, locationTemp: null};
    this.getCoords();
  }

  getCoords () {
    function success(pos) {
      this.setState({coords: pos.coords});
      this.getData();
    }

    navigator.geolocation.getCurrentPosition(success.bind(this));
  }

  getData() {
    const latitude = this.state.coords.latitude;
    const longitude = this.state.coords.longitude;
    $.ajax({
      url: `http://api.apixu.com/v1/current.json?key=3a57dff55f514c16b66213308162208&q=${latitude},${longitude}`,
      type: "GET",
      dataType: "json",
      success: function(results) {
        this.setState({locationName: results.location.name});
        this.setState({locationTemp: results.current.temp_f});
      }.bind(this)
    });
  }

  render () {
    return (
      <div className="widget">
        <h2>Weather</h2>
        <h2>{this.state.locationName}</h2>
        <h2>{this.state.locationTemp}</h2>
        <div>Hello</div>
      </div>
    );
  }
}

export default Weather;

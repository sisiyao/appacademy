import React from 'react';

class Clock extends React.Component {
  constructor () {
    super();
    this.state = {initialTime: new Date()};
    this.parseTime = this.parseTime.bind(this);
    this.parseDate = this.parseDate.bind(this);
    this.timerId = 0;
  }

  componentDidMount() {
    const addOneSecond = () => {
      let newSeconds = this.state.initialTime.getSeconds() + 1;
      this.state.initialTime.setSeconds(newSeconds);
      this.setState({initialTime: this.state.initialTime});
    };
    this.timerId = setInterval(addOneSecond.bind(this), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.timerId);
    this.timerId = 0;
  }

  parseTime() {
    // debugger
    let initialTime = this.state.initialTime;
    let hours = initialTime.getHours();
    let minutes = initialTime.getMinutes();
    let seconds = initialTime.getSeconds();
    // let timeZone = initialTime.toString().slice(initialTime.length-5, initialTime.length-1);
    return `${hours}:${minutes}:${seconds}`;
  }

  parseDate() {
    const initialTime = this.state.initialTime;
    const date = initialTime.getDate();
    const month = initialTime.getMonth();
    const dayOfWeek = initialTime.getDay();
    const year = initialTime.getFullYear();
    const days = ["Sun", "Mon", "Tue", "wed", "Thu", "Fri", "Sat"];
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return `${days[dayOfWeek]} ${months[month]} ${date} ${year}`;
  }

  render () {
    return (
      <div className="widget">
        <h2>Clock</h2>
        <div>
          <h2>Time:</h2>
          <h2>{this.parseTime()}</h2>
        </div>
        <div>
          <h2>Date:</h2>
          <h2>{this.parseDate()}</h2>
        </div>
      </div>
    );
  }
}

export default Clock;

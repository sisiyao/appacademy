class Clock {
  constructor() {
    let newDate = new Date();

    this.hour = newDate.getHours();
    this.min = newDate.getMinutes();
    this.sec = newDate.getSeconds();
  }

  printTime() {
    console.log(`${this.hour}:${this.min}:${this.sec}`);
  }

  _tick() {
    this.sec++;

    if (this.sec === 60) {
      this.sec = 0;
      this.min++;
      if (this.min === 60){
        this.min = 0;
        this.hour++;
        if (this.hour === 24) {
          this.hour = 0;
        }
      }
    }

    this.printTime();
  }
}

let clock = new Clock();
setInterval(clock._tick.bind(clock), 1000);

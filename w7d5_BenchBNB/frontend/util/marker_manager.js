class MarkerManager {
  constructor (map){
    this.map = map;
    this.markerPositions = [];
  }

  updateMarkers (benches){
    console.log('time to update');

    let newBenches = this._benchesToAdd(benches);

    newBenches.forEach(bench => {
      this._createMarkerFromBench(bench);
    });

    // uncomment debugger here to check the current array of marker positions for dups
    // debugger
  }

  _benchesToAdd (benches) {
    let newBenches = [];

    benches.forEach(bench => {
      let benchInMarkerArray = false;

      this.markerPositions.forEach(pos => {
        if (pos.lat() === bench.lat
        && pos.lng() === bench.lng) {
          benchInMarkerArray = true;
        }
      });

      if (benchInMarkerArray === false) {
        newBenches.push(bench);
      }
    });

    return newBenches;
  }

  _createMarkerFromBench (bench) {
    let pos = new google.maps.LatLng(bench.lat, bench.lng);
    this.markerPositions.push(pos);
    new google.maps.Marker({position: pos, map: this.map});
  }
}

export default MarkerManager;

class MarkerManager {
  constructor (map){
    this.map = map;
    this.markers = [];
  }

  updateMarkers (benches){
    console.log('time to update');

    let newBenches = this._benchesToAdd(benches);

    newBenches.forEach(bench => {
      let benchMarker = this._createMarkerFromBench(bench);
      this.markers.push(benchMarker);
      //left off here
    });
  }

  _benchesToAdd (benches) {
    let newBenches = [];

    benches.forEach(bench => {
      let benchInMarkerArray = false;

      this.markers.forEach(marker => {
        if (marker.position.lat() === bench.lat
        && marker.position.lng === bench.lng) {
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
    return new google.maps.Marker({position: pos, map: this.map});
  }
}

export default MarkerManager;

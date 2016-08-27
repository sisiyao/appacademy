class MarkerManager {
  constructor (map){
    this.map = map;
    this.markers = [];

    // this._createMarkerFromBench = this._createMarkerFromBench.bind(this);
    // this._removeMarker = this._removeMarker.bind(this);
  }

  updateMarkers (benches){
    // console.log('time to update markers');
    let newBenches = this._benchesToAdd(benches);

    newBenches.forEach(bench => {
      this._createMarkerFromBench(bench);
    });
    //
    let markersToRemove = this._markersToRemove(benches);
    //
    markersToRemove.forEach(marker => {
      this._removeMarker(marker);
    });
  }

  _benchesToAdd (benches) {
    const currBenchIds = this.markers.map(marker => marker.benchId);

    return benches.filter(bench => {
      return !currBenchIds.includes(bench.id);
    });
  }

  _createMarkerFromBench (bench) {
    let pos = new google.maps.LatLng(bench.lat, bench.lng);
    let marker = new google.maps.Marker({
      position: pos,
      map: this.map,
      benchId: bench.id
    });
    this.markers.push(marker);
  }

  _markersToRemove (benches) {
    const newBenchIds = benches.map(bench => bench.id);

    return this.markers.filter(marker => {
      return !newBenchIds.includes(marker.benchId)
    });
  }

  _removeMarker (marker) {
    const idx = this.markers.indexOf(marker);
    this.markers.splice(idx, 1);
    marker.setMap(null);
  }
}

export default MarkerManager;

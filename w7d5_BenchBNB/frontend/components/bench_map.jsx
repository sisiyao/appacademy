import React from 'react';
import MarkerManager from '../util/marker_manager';

class BenchMap extends React.Component {
  constructor (props) {
    super(props);
  }

  componentDidMount () {
    // find the `<map>` node on the DOM
    const mapDOMNode = this.refs.map;

    // set the map to show SF
    const mapOptions = {
      center: {lat: 37.7758, lng: -122.435}, // this is SF
      zoom: 13
    };

    // wrap the mapDOMNode in a Google Map
    this.map = new google.maps.Map(mapDOMNode, mapOptions);
    this.MarkerManager = new MarkerManager(this.map);
    // console.log("update markers after mounting");
    this.MarkerManager.updateMarkers(this.props.benches);
    this.listenForMove();
  }

  componentWillReceiveProps (nextProps) {
    // console.log("receiving props");
    // console.log(nextProps.benches);
    // console.log("update markers after receiving props");
    this.MarkerManager.updateMarkers(nextProps.benches);
  }

  listenForMove () {
    const updateBounds = this.props.updateBounds;

    google.maps.event.addListener(this.map, 'idle', () => {
      const boundsInst = this.map.getBounds();
      const neBounds = boundsInst.getNorthEast();
      const swBounds = boundsInst.getSouthWest();

      const boundsParams = {
        northEast: { lat: neBounds.lat(), lng: neBounds.lng() },
        southWest: { lat: swBounds.lat(), lng: swBounds.lng() }
      };

      updateBounds(boundsParams);
    });
  }

  render () {
    return (
      <div id='map-container' ref='map'>
      </div>
    );
  }
}

export default BenchMap;

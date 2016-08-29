import React from 'react';
import MarkerManager from '../util/marker_manager';
import { withRouter } from 'react-router';

class BenchMap extends React.Component {
  constructor (props) {
    super(props);
  }

  componentDidMount () {
    const mapDOMNode = this.refs.map;

    const mapOptions = {
      center: {lat: 37.7758, lng: -122.435}, // this is SF
      zoom: 13
    };

    this.map = new google.maps.Map(mapDOMNode, mapOptions);

    this.MarkerManager = new MarkerManager(this.map);
    this.MarkerManager.updateMarkers(this.props.benches);

    google.maps.event.addListener(this.map, "click",
      this._inputClickedCoordsInForm.bind(this));

    this.listenForMove();
  }

  componentWillReceiveProps (nextProps) {
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

  _inputClickedCoordsInForm (e) {
    const latClicked = e.latLng.lat();
    const longClicked = e.latLng.lng();
    const coords = {
      lat: latClicked,
      lng: longClicked
    };
    this._handleClick(coords);
  }

  _handleClick (coords) {
    this.props.router.push({
      pathname: "benches/new",
      query: coords
    });
  }

  render () {
    return (
      <div id='map-container' ref='map'>
      </div>
    );
  }
}

export default withRouter(BenchMap);

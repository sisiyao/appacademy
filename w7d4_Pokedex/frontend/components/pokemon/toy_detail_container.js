import { connect } from 'react-redux';
import { ToyDetail } from './toy_detail';

const mapStateToProps = (state, ownProps) => ({
  toy: state.selectedPokemon.toys.find(toy => {
    return toy.id === parseInt(ownProps.params.toyID);
  })
});

export const ToyDetailContainer = connect(
  mapStateToProps
)(ToyDetail);

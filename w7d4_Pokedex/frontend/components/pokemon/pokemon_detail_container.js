import { connect } from 'react-redux';
import PokemonDetail from './pokemon_detail';
import { toySelector } from '../../util/toy_selector';

const mapStateToProps = state => ({
  selectedPokemon: state.selectedPokemon,
  toys: toySelector(state)
});

export const PokemonDetailContainer = connect(
  mapStateToProps
)(PokemonDetail);

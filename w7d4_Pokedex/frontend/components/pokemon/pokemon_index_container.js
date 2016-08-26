import { connect } from 'react-redux';
import PokemonIndex from './pokemon_index';

const mapStateToProps = state => ({
  pokemon: state.pokemon
});

export const PokemonContainer = connect(
  mapStateToProps
)(PokemonIndex);

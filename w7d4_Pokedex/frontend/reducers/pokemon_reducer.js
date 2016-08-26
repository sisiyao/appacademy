import * as ACTIONS from '../actions/pokemon_actions';
import { merge } from 'lodash';

export const pokemonReducer = (state = {pokemon: [], selectedPokemon: {toys: []}}, action) => {
  switch (action.type) {
    case ACTIONS.POKEMON_CONSTANTS.RECEIVE_ALL_POKEMON:
      return merge({}, state, {pokemon: action.pokemonData});

    case ACTIONS.POKEMON_CONSTANTS.RECEIVE_SINGLE_POKEMON:
      return merge({}, state, {selectedPokemon: action.pokemonData});

    default:
      return state;
  }
};

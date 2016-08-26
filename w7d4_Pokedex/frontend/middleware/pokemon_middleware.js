import * as ACTIONS from '../actions/pokemon_actions';
import * as API from '../util/api_util';

export const PokemonMiddleware = ({dispatch}) => next => action => {
    switch (action.type) {
      case ACTIONS.POKEMON_CONSTANTS.REQUEST_ALL_POKEMON:
        API.fetchAllPokemon((data) => dispatch(ACTIONS.receiveAllPokemon(data)));
        break;
      case ACTIONS.POKEMON_CONSTANTS.REQUEST_SINGLE_POKEMON:
        API.fetchSinglePokemon(action.pokemonID,
          (data) => {
            dispatch(ACTIONS.receiveSinglePokemon(data))
          });
        break;
      default:
        next(action);
    }
};

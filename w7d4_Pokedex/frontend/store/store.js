import { createStore } from 'redux';
import { pokemonReducer } from '../reducers/pokemon_reducer';
import { PokemonMiddleware } from '../middleware/pokemon_middleware';
import { applyMiddleware } from 'redux';

const configureStore = () => (
  createStore(
    pokemonReducer,
    applyMiddleware(PokemonMiddleware)
  )
);

export default configureStore;

import React from 'react';
import { Provider } from 'react-redux';
import { PokemonContainer } from './pokemon/pokemon_index_container';
import { PokemonDetailContainer } from './pokemon/pokemon_detail_container';
import { ToyDetailContainer } from './pokemon/toy_detail_container';
import { Router, Route, hashHistory } from 'react-router';
import * as ACTIONS from '../actions/pokemon_actions';


export const Root = ({store}) => {
  const requestPokemon = (nextState, replace) => {
    store.dispatch(ACTIONS.requestAllPokemon());
  };

  const requestSinglePokemon = (nextState, replace) => {
    store.dispatch(ACTIONS.requestSinglePokemon(nextState.params.pokemonID));
  };

  return (
    <Provider store={store}>
      <Router history={hashHistory}>
        <Route path="/" component={PokemonContainer} onEnter={requestPokemon}>
          <Route path="pokemon/:pokemonID" component={PokemonDetailContainer} onEnter={requestSinglePokemon}>
            <Route path="toys/:toyID" component={ToyDetailContainer} />
          </Route>
        </Route>
      </Router>
    </Provider>
  );
};

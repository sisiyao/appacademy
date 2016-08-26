export const POKEMON_CONSTANTS = {
  RECEIVE_ALL_POKEMON: "RECEIVE_ALL_POKEMON",
  REQUEST_ALL_POKEMON: "REQUEST_ALL_POKEMON",
  RECEIVE_SINGLE_POKEMON: "RECEIVE_SINGLE_POKEMON",
  REQUEST_SINGLE_POKEMON: "REQUEST_SINGLE_POKEMON"
};

export const receiveAllPokemon = (pokemonData) => ({
  type: POKEMON_CONSTANTS.RECEIVE_ALL_POKEMON,
  pokemonData
});

export const requestAllPokemon = () => ({
  type: POKEMON_CONSTANTS.REQUEST_ALL_POKEMON
});

export const receiveSinglePokemon = (pokemonData) => ({
  type: POKEMON_CONSTANTS.RECEIVE_SINGLE_POKEMON,
  pokemonData
});

export const requestSinglePokemon = (pokemonID) => ({
  type: POKEMON_CONSTANTS.REQUEST_SINGLE_POKEMON,
  pokemonID
});

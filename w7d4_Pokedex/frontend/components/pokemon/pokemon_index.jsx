import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

const PokemonIndex = ({pokemon, children}) => {
  const pokemonLI = pokemon.map(individualPokemon => {
    return (
      <PokemonIndexItem key={`${individualPokemon.id}${individualPokemon.name}`} individualPokemon={individualPokemon} />
    );
  });

  return (
    <section className="pokedex">
      <ul>
        {pokemonLI}
      </ul>

      {children}
    </section>
  );
};

export default PokemonIndex;

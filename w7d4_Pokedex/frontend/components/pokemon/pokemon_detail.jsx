import React from 'react';
import { withRouter } from 'react-router';

const PokemonDetail = ({selectedPokemon, toys, router, children}) => {
  const clickToy = (url) => {
    router.push(url);
  };

  const toyImgs = toys.map(toy => (
    <li key={`${toy.id}${toy.name}`}>
      <img src={toy.image_url}
        onClick={clickToy.bind(null,
          `/pokemon/${selectedPokemon.id}/toys/${toy.id}`)} />
    </li>
  ));

  return (
    <section className="pokemon-detail">
      <ul>
        <img src={selectedPokemon.image_url} alt=""/>
          <li><h2>{selectedPokemon.name}</h2></li>
          <li>Type: {selectedPokemon.poke_type}</li>
          <li>Attack: {selectedPokemon.attack}</li>
          <li>Defense: {selectedPokemon.defense}</li>
          <li>Moves: &#34;{selectedPokemon.moves}&#34;</li>
        <section className="toys">
            <h3>Toys</h3>
          <ul className="toy-list">
            {toyImgs}
          </ul>
          {children}
        </section>
      </ul>
    </section>
  );
};

export default withRouter(PokemonDetail);

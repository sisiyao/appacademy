import React from 'react';
import { withRouter } from 'react-router';

const PokemonIndexItem = ({individualPokemon, router}) => {
  const _handleClick = (url) => {
    router.push(url);
  };

  return (
    <div>
      <li className="pokemon-index-item"
        onClick={_handleClick.bind(null, `/pokemon/${individualPokemon.id}`)}>

        <span>{individualPokemon.id}</span>
        <img src={individualPokemon.image_url}/>
        <span>{individualPokemon.name}</span>

      </li>
    </div>
  );
};

export default withRouter(PokemonIndexItem);

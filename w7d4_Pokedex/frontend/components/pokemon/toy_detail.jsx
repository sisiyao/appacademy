import React from 'react';

export const ToyDetail = ({toy}) => {
  return (
    <ul>
      <li><h3>{toy.name}</h3></li>
      <li>Happiness: {toy.happiness}</li>
      <li>Price: ${toy.price}</li>
    </ul>
  );
};

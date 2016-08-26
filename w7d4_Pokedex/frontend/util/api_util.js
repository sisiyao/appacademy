export const fetchAllPokemon = (success) => {
  $.ajax({
    url: "/api/pokemon",
    method: "GET",
    success: success
  });
};

export const fetchSinglePokemon = (pokemonID, success) => {
  $.ajax({
    url: `/api/pokemon/${pokemonID}`,
    method: "GET",
    success: success
  });
};

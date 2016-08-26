export const benchSelector = state => {
  const benches = state.benches;

  const benchArray = [];

  Object.keys(benches).forEach(benchID => {
    benchArray.push(benches[benchID]);
  });

  return benchArray;
};

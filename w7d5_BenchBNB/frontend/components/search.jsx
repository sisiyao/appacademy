import BenchMap from './bench_map';
import BenchIndex from './bench_index';
import React from 'react';

const Search = ({benches, requestBenches, updateBounds}) => {
  return (
    <div>
      <h1>BenchBNB</h1>
      <BenchMap benches={benches} updateBounds={updateBounds}/>
      <BenchIndex benches={benches} requestBenches={requestBenches}/>
    </div>
  );
};

export default Search;

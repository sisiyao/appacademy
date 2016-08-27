import BenchMap from './bench_map';
import BenchIndex from './bench_index';
import React from 'react';

const Search = ({benches, requestBenches}) => {
  return (
    <div>
      <BenchMap benches={benches} />
      <BenchIndex benches={benches} requestBenches={requestBenches}/>
    </div>
  );
};

export default Search;
